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
using Test_1_DLL;


namespace Test_1
{
    public partial class Hovedmeny : Form
    {
        Database database = new Database(ConfigurationManager.
            ConnectionStrings["Alarm"].ConnectionString);
        Mail mail = new Mail();
        public Hovedmeny()
        {
            InitializeComponent();
            InitializeGraph();
            addDataToChart();
            AddAlarmsToListBox();
            Thread thread1 = new Thread(new ThreadStart(this.addDataToChart));
            thread1.Start();
            
        }
        #region Chart
        public void InitializeGraph()
        {
            chartTemp.ChartAreas[0].AxisX.MajorGrid.LineColor = Color.Blue;
            chartTemp.ChartAreas[0].AxisY.MajorGrid.LineColor = Color.Red;
            chartTemp.ChartAreas[0].AxisY.Interval = 5.0;
            chartTemp.ChartAreas[0].AxisY.Minimum = 0;
            chartTemp.ChartAreas[0].AxisY.Maximum = 100;
            chartTemp.Series["Temperatur"].Color = Color.Black;
            chartTemp.ChartAreas[0].AxisX.IntervalType = System.Windows.Forms.DataVisualization.Charting.DateTimeIntervalType.Auto;
            chartTemp.ChartAreas[0].AxisX.LabelStyle.Format = "dd-MM-yyyy hh:mm:ss";
            
            //chartTemp.ChartAreas[0].AxisX.Minimum = new DateTime(2019, 3, 25, 15, 39, 0).ToOADate();
            //chartTemp.ChartAreas[0].AxisX.Maximum = new DateTime(2019, 3, 25, 15, 40, 0).ToOADate();
        }
        public void addDataToChart()
        {
            addMaxMinValToChart(10);
            double valueY;
            DateTime valueX;
            SqlConnection conAlarm = new SqlConnection(database.AlarmConfig);
            string sqlQuerry = "SELECT * FROM TempData";
            SqlCommand sql = new SqlCommand(sqlQuerry, conAlarm);
            conAlarm.Open();
            SqlDataReader dr = sql.ExecuteReader();
            while (dr.Read())
            {
                valueX = Convert.ToDateTime(dr[1]);
                valueY = Convert.ToDouble(dr[2]);
                chartTemp.Series["Temperatur"].Points.AddXY(valueX, valueY);
            }
            conAlarm.Close();
        }
        public void addMaxMinValToChart(double interval)
        {
            DateTime max = new DateTime();
            DateTime min = new DateTime();
            SqlConnection conAlarm = new SqlConnection(database.AlarmConfig);
            string sqlQuerry = "SELECT TOP 1 * FROM TempData ORDER BY TempId DESC";
            SqlCommand sql = new SqlCommand(sqlQuerry, conAlarm);
            conAlarm.Open();
            SqlDataReader dr = sql.ExecuteReader();
            while (dr.Read())
            {
                max = Convert.ToDateTime(dr[1]);
                min = max;
                min = min.AddMinutes(-interval);
            }
            chartTemp.ChartAreas[0].AxisX.Minimum = min.ToOADate();
            chartTemp.ChartAreas[0].AxisX.Maximum = max.ToOADate();
            conAlarm.Close();
        }
        #endregion
        #region Buttonevents
        public void AddAlarmsToListBox()
        {
            listBoxAlarmHistory.Items.Clear();
            
            for (int i = 0; i < database.GetAlarmHistory().Count; i++)
            {
                listBoxAlarmHistory.Items.Add(database.GetAlarmHistory()[i]);
            }
        }
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
                Close();
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
        #endregion

    }

}
