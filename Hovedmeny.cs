using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using AlarmsystemLibrary;
using System.IO.Ports;
using System.Windows.Forms.DataVisualization.Charting;

namespace Alarmsystem
{
    public partial class Hovedmeny : Form
    {
        #region Objekter og variabler
        /// <summary>
        /// Objekt av typen mail, for å kunne sende mail.
        /// </summary>
        Mail mail = new Mail(ConfigurationManager.
            ConnectionStrings["Alarm"].ConnectionString);
        /// <summary>
        /// Objekt av typen Logg.
        /// </summary>
        Logg logg = new Logg();
        /// <summary>
        /// Objekt av typen alarmSender.
        /// </summary>
        AlarmSender alarmSender = new AlarmSender();
        PDF pdf = new PDF(ConfigurationManager.
                ConnectionStrings["Alarm"].ConnectionString);
        /// <summary>
        /// Variabler og objekter knyttet til arduino.
        /// </summary>
        static ArduinoComClass Arduino;
        Thread oThreadone;
        public static SerialPort sendToArduino = new SerialPort();
        SensorData liveSensorData;
        /// <summary>
        /// Tråder knyttet til lading og innleging av data.
        /// </summary>
        Thread oThreadBatteryChargeTime;
        Thread oThreadAddData;
        /// <summary>
        /// Disse variablene brukes for å få chartet til å fungere optimalt.
        /// </summary>
        int count = 0,interval = 0;
        private bool flag;
        private bool start = true;
        /// <summary>
        /// Alarm variabler
        /// </summary>
        int minuteCount = 0;
        private bool blink;
        #endregion

        #region Hovedmeny Constructor
        public Hovedmeny()
        {
            InitializeComponent();
            liveSensorData = new SensorData();
            Arduino = new ArduinoComClass("COM7", 9600);
            oThreadone = new Thread(EndreVerdiArduino);
            oThreadone.Start();
            oThreadBatteryChargeTime = new Thread(TimeWithoutCharger);
            oThreadBatteryChargeTime.Start();
            oThreadAddData = new Thread(AddData);
            InitializeGraph();
            alarmSender.Alarms += new EventHandler(UpdateAlarmHistory);
            alarmSender.TempEvent += new EventHandler(TempObjekt);
            alarmSender.SabotageEvent += new EventHandler(SabotageObjekt);
            alarmSender.MovementEvent += new EventHandler(MovementObjekt);
            alarmSender.BatteryChargeEvent += new EventHandler(BatteryChargeObjekt);
            alarmSender.BatteryPercentEvent += new EventHandler(BatteryPercentObjekt);
            alarmSender.AlarmHistoryFromDatabase();
            tmrBlink.Start();
            tmrBlink.Enabled = true;
            tmrBatteryTime.Interval = alarmSender.BatteryCharge*30000;
            btnStart.Enabled = false;
            tmrTemp.Interval = logg.LeseIntervall * 1000;
            tmrTemp.Start();
            tmrTempLogg.Start();
            //Må ha denne til slutt.
            oThreadAddData.Start();
            logg.ReadIntervall(txtReadIntervall);
            logg.SaveIntervall(txtSaveIntervall);
            
        }
        #endregion

        #region Chart data
        /// <summary>
        /// Metode for å sette opp graphen.
        /// </summary>
        public void InitializeGraph()
        {
            chartTemp.ChartAreas[0].AxisX.MajorGrid.LineColor = Color.Blue;
            chartTemp.ChartAreas[0].AxisY.MajorGrid.LineColor = Color.Red;
            chartTemp.ChartAreas[0].AxisY.Interval = 5.0;
            chartTemp.ChartAreas[0].AxisX.Interval = 1;
            chartTemp.ChartAreas[0].AxisY.Minimum = -25;
            chartTemp.ChartAreas[0].AxisY.Maximum = 50;
            chartTemp.Series[0].Color = Color.Black;
            chartTemp.Series[0].XValueType = ChartValueType.DateTime;
            chartTemp.ChartAreas[0].AxisX.LabelStyle.Format = "dd-MM-yyyy hh:mm:ss";
            chartTemp.ChartAreas[0].AxisX.IntervalType = DateTimeIntervalType.Seconds;
            chartTemp.ChartAreas[0].AxisX.IntervalOffset = 1;
        }
        /// <summary>
        /// Bruke litt av koden fra denne nettsiden https://stackoverflow.com/questions/36685827/how-to-set-minimum-and-maximum-values-for-date-time-chart-using-c
        /// for å få chartet til å bli som jeg ville.
        /// Endret en god del på den for å få den til å fungere slik jeg ville.
        /// </summary>
        public void AddData()
        {
            while (true)
            {
                if (flag)
                {
                    flag = false;
                    alarmSender.Timestamp = DateTime.Now;
                    CheckForAlarms();
                    AddNewPoint(alarmSender.Timestamp, chartTemp.Series[0],liveSensorData.temp, interval);
                    count++;
                    
                }
                Thread.Sleep(1000);
            }
        }
        /// <summary>
        /// Metode for å legge til nye punkter i chartet.
        /// Noe av denne koden er også hentet ifra nedsiden nevnt ovenfor.
        /// </summary>
        /// <param name="timeStamp"></param>
        /// <param name="series"></param>
        /// <param name="temp"></param>
        /// <param name="interval"></param>
        public void AddNewPoint(DateTime timeStamp, Series series, double temp, int interval)
        {
            double max = 0.0;
            if (chartTemp.InvokeRequired)
            {
                BeginInvoke((Action)(() =>
                {
                    chartTemp.Series[0].Points.AddXY(timeStamp.ToOADate(), temp);
                    if (chartTemp.ChartAreas[0].AxisX.Maximum < timeStamp.ToOADate())
                    {
                        chartTemp.ChartAreas[0].AxisX.Minimum = DateTime.FromOADate(series.Points[count - 1].XValue).ToOADate();
                        chartTemp.ChartAreas[0].AxisX.Maximum = DateTime.FromOADate(series.Points[count - 1].XValue).AddMinutes(0.5).ToOADate();
                        max = chartTemp.ChartAreas[0].AxisX.Maximum;
                    }
                    chartTemp.Update();
                    chartTemp.ChartAreas[0].RecalculateAxesScale();

                }));
            }

        }
       
        #endregion

        #region Buttonevents
        
        /// <summary>
        /// Lukker hele programmet dersom man velger yes, velger man no fortsetter programmet som normalt.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnClose_Click(object sender, EventArgs e)
        {
            DialogResult result = MessageBox.Show("Er du sikker på at du vil avslutte?", "Avslutt program", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (result == DialogResult.Yes)
            {
                System.Environment.Exit(0);
            }
        }
        /// <summary>
        /// Click event for å åpne legg til abonnent formet.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private async void btnAddAbonnent_Click(object sender, EventArgs e)
        {
            await Task.Run(() =>
            {
                Legg_til_abonnent abonnent = new Legg_til_abonnent();
                abonnent.ShowDialog();
            });
        }
        /// <summary>
        /// Click event for å åpne endre abonnent formet.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private async void btnAlterAbonnent_ClickAsync(object sender, EventArgs e)
        {
            await Task.Run(() =>
            {
                Endre_abonnenter abonnent = new Endre_abonnenter();
                abonnent.ShowDialog();
            });
        }
        /// <summary>
        /// Click event for å åpne temperatur interval formet, der kan man endre
        /// lese og lagrinsinterval for temperatur.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private async void btnTempIntervals_ClickAsync(object sender, EventArgs e)
        {
            await Task.Run(() =>
            {
                Temperaturinterval temperaturinterval = new Temperaturinterval();
                temperaturinterval.ShowDialog();
            });
        }
        /// <summary>
        /// Click event for å åpne alarm grense formet, her kan man endre alarmgrensene.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private async void btnAlarmGrenser_ClickAsync(object sender, EventArgs e)
        {
            await Task.Run(() =>
            {
                Alarmgrenser alarmgrenser = new Alarmgrenser();
                alarmgrenser.ShowDialog();
            });
        }
        /// <summary>
        /// Click event for å starte inn lesning av data fra arduino.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnStart_Click(object sender, EventArgs e)
        {
            btnStart.Enabled = false;
            btnStopp.Enabled = true;
            tmrTemp.Start();
            if (start)
            {
                chartTemp.ChartAreas[0].AxisX.Minimum = DateTime.Now.ToOADate();
                chartTemp.ChartAreas[0].AxisX.Maximum = DateTime.Now.AddMinutes(0.5).ToOADate();
                start = false;
            }
        }
        /// <summary>
        /// Click event som skrur på sonene.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnActivate_Click(object sender, EventArgs e)
        {
            alarmSender.TurnOnSystem();
            lblSoneOn.BackColor = Color.Green;
        }
        /// <summary>
        /// Click event for å skru av soner.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnDeactivate_Click(object sender, EventArgs e)
        {
            alarmSender.TurnOffSystem();
            lblSoneOn.BackColor = Color.White;
        }
        /// <summary>
        /// Click event som stopper innleseing fra arduino.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnStopp_Click(object sender, EventArgs e)
        {
            tmrTemp.Stop();
            start = true;
            btnStart.Enabled = true;
            btnStopp.Enabled = false;
        }
        /// <summary>
        /// Click event for å annerkjenne alarmer.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnAckAlarm_Click(object sender, EventArgs e)
        {
            
            if (alarmSender.BatteryChargeAlarm) { alarmSender.BatteryChargeAlarm = false; }
            if (alarmSender.BatteryPercentAlarm) { alarmSender.BatteryPercentAlarm = false; }
            if (alarmSender.MovementAlarm) { alarmSender.MovementAlarm = false; }
            if (alarmSender.TempAlarm) { alarmSender.TempAlarm = false; }
            lblAlarmBlink.BackColor = Color.White;
            blink = false;
        }
        /// <summary>
        /// Click event for å oppdatere alarmhistorikken grafisk.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnUpdate_Click(object sender, EventArgs e)
        {
            alarmSender.AlarmHistoryFromDatabase();
        }
        /// <summary>
        /// Click event for å sende ut alarmhistorikk til alle abonnenter som ønsker seg denne.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnMail_Click(object sender, EventArgs e)
        {
            pdf.CreateAndAppendAlarmHistory();
            mail.SendMailWithPdf(pdf.FileName);
        }
        
        #endregion

        #region Timere
        /// <summary>
        /// Timer som styrer innlesing av data fra arduino og grafisk avlesning.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void tmrTemp_Tick(object sender, EventArgs e)
        {
            try
            {
                Arduino.Write("1");

            }
            catch (Exception)
            {
                tmrTemp.Stop();
                DialogResult result = MessageBox.Show("Sett arduinoen i riktig port og start programmet på nytt.?","Arduino.",MessageBoxButtons.OK);
                if (result == DialogResult.OK)
                {
                    Environment.Exit(0);
                }
            }
            flag = true;
            logg.ReadFromFile();
            txtTemp.Text = liveSensorData.temp.ToString();
            txtMovement.Text = liveSensorData.pir.ToString();
            txtBattPercent.Text = (SystemInformation.PowerStatus.BatteryLifePercent * 100).ToString();
            txtCharge.Text = SystemInformation.PowerStatus.PowerLineStatus.ToString();
            if (tmrTemp.Interval != logg.LeseIntervall * 1000)
            {
                tmrTemp.Stop();
                tmrTemp.Interval = logg.LeseIntervall * 1000;
                tmrTemp.Start();
                logg.ReadIntervall(txtReadIntervall);
            }
        }
        /// <summary>
        /// Timer som styrer alarm blink.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void tmrBlink_Tick(object sender, EventArgs e)
        {
            if (blink)
            {
                if (lblAlarmBlink.BackColor == Color.White)
                {
                    lblAlarmBlink.BackColor = Color.Red;
                }
                else if (lblAlarmBlink.BackColor == Color.Red)
                {
                    lblAlarmBlink.BackColor = Color.White;
                }
            }
        }
        /// <summary>
        /// Timer som teller opp antall min uten lading. Blir resatt hver gang laderen blir nappet inn og ut.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void tmrBatteryTime_Tick(object sender, EventArgs e)
        {
            minuteCount++;
        }
        /// <summary>
        /// Timer som logger data til datatabasen.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void tmrTempLogg_Tick(object sender, EventArgs e)
        {
            tmrTempLogg.Interval = logg.LagringsIntervall * 1000;
            alarmSender.AddMålingToDatabase(DateTime.Now, liveSensorData.temp);
            logg.SaveIntervall(txtSaveIntervall);
        }
        #endregion

        #region Metoder
        /// <summary>
        /// Metode som kjører en sjekk etter alarmer, blir kjørt via innlesing av data metoden.
        /// </summary>
        private void CheckForAlarms()
        {
            if (alarmSender.SetAlarm())
            {
                alarmSender.CheckTempAndSabotageAlarm(liveSensorData.temp);
                alarmSender.CheckMovementAlarm(liveSensorData.pir);
                alarmSender.CheckBatteryPercentAlarm(SystemInformation.PowerStatus.BatteryLifePercent);
                alarmSender.CheckBatteryChargeAlarm(minuteCount);
            }
        }
        /// <summary>
        /// Metode som får data fra arduino og legger den inn i livesensorData pir og temp.
        /// </summary>
        public void EndreVerdiArduino()
        {
            string text = "";
            while (true)
            {
                if (Arduino.DataReady)
                {
                    text = Arduino.receivedData;
                    Arduino.DataReady = false;
                    string[] SensorData = text.Split(':');
                    SensorData[1] = SensorData[1].Remove(SensorData[1].Length - 1);
                    SensorData[1] = SensorData[1].Replace('.', ',');
                    if (SensorData[0] == "1")
                    {
                        liveSensorData.pir = true;
                    }
                    else
                    {
                        liveSensorData.pir = false;
                    }
                    liveSensorData.temp = Convert.ToDouble(SensorData[1]);
                    liveSensorData.temp = liveSensorData.temp / 100;
                }
                Application.DoEvents();
                Thread.Sleep(1000);
            }
        }
        /// <summary>
        /// Metode som sjekker om pc lader eller ikke, dersom den ikke lader starter den en timer som teller antall min uten lading.
        /// </summary>
        public void TimeWithoutCharger()
        {
            while (true)
            {
                if (!(SystemInformation.PowerStatus.PowerLineStatus == PowerLineStatus.Online))
                {
                    if (tmrBatteryTime.Enabled == false)
                    {
                        tmrBatteryTime.Start();
                    }
                }
                else
                {
                    tmrBatteryTime.Stop();
                    minuteCount = 0;
                }
                Application.DoEvents();
                Thread.Sleep(1000);
            }
        }
#endregion

        #region Events
        /// <summary>
        /// Event for å oppdatere alarm historikk
        /// </summary>
        /// <param name="o"></param>
        /// <param name="e"></param>
        private void UpdateAlarmHistory(object o, EventArgs e)
        {
            dataGridView1.DataSource = alarmSender.ViewAlarmHistory();
        }
        /// <summary>
        /// Event for å sende ut temperatur alarm.
        /// </summary>
        /// <param name="o"></param>
        /// <param name="e"></param>
        private void TempObjekt(object o, EventArgs e)
        {
            alarmSender.Alarm = "TempAlarm";
            alarmSender.SendTempAlarm();
            blink = true;
            Console.Beep(5000, 2000);
            pdf.LatestAlarmPdf(alarmSender.Alarm);
            mail.SendAlarmToAbonnent(alarmSender.Alarm, alarmSender.Alarm,1,pdf.FileName);
        }
        /// <summary>
        /// Event for å sende ut sabotasje alarm.
        /// </summary>
        /// <param name="o"></param>
        /// <param name="e"></param>
        private void SabotageObjekt(object o, EventArgs e)
        {
            alarmSender.Alarm = "SabotasjeAlarm";
            alarmSender.SendSabotageAlarm();
            blink = true;
            Console.Beep(5000, 2000);
            pdf.LatestAlarmPdf(alarmSender.Alarm);
            mail.SendAlarmToAbonnent(alarmSender.Alarm, alarmSender.Alarm, 3, pdf.FileName);
        }
        /// <summary>
        /// Event for å sende ut bevegelses alarm.
        /// </summary>
        /// <param name="o"></param>
        /// <param name="e"></param>
        private void MovementObjekt(object o, EventArgs e)
        {
            alarmSender.Alarm = "BevegelsesAlarm";
            alarmSender.SendMovementAlarm();
            blink = true;
            Console.Beep(5000, 2000);
            pdf.LatestAlarmPdf(alarmSender.Alarm);
            mail.SendAlarmToAbonnent(alarmSender.Alarm, alarmSender.Alarm, 2, pdf.FileName);
        }
        /// <summary>
        /// Event for å sende ut lavt batteri nivå
        /// </summary>
        /// <param name="o"></param>
        /// <param name="e"></param>
        private void BatteryPercentObjekt(object o, EventArgs e)
        {
            alarmSender.Alarm = "Lavt batteri nivå på pc";
            alarmSender.SendBatteryPercentAlarm();
            blink = true;
            Console.Beep(5000, 2000);
            pdf.LatestAlarmPdf(alarmSender.Alarm);
            mail.SendAlarmToAbonnent(alarmSender.Alarm, alarmSender.Alarm, 4, pdf.FileName);
        }

        



        /// <summary>
        /// Event for å sende ut manglende lading alarm.
        /// </summary>
        /// <param name="o"></param>
        /// <param name="e"></param>
        private void BatteryChargeObjekt(object o, EventArgs e)
        {
            alarmSender.Alarm = "Manglende lading på pc";
            alarmSender.SendBatteryChargerAlarm();
            blink = true;
            Console.Beep(5000, 2000);
            pdf.LatestAlarmPdf(alarmSender.Alarm);
            mail.SendAlarmToAbonnent(alarmSender.GetLatestAlarm(), alarmSender.Alarm, 4, pdf.FileName);
        }
        #endregion

        #region Test region

        #endregion
    }

}
