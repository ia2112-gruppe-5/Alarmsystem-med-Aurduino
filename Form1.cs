using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading;
using System.Windows.Forms;
using System.IO.Ports;
using System.Threading.Tasks;
using System.Timers;

namespace Cs_Program_arduinoV1
{
    public partial class Form1 : Form
    {
        static ArduinoComClass ArduinoCom;
        Thread oThreadone;
        public static SerialPort sendToArduino = new SerialPort();
        SensorData liveSensorData;
        private int defaultInterval = 1000;
        

        public Form1()
        {
            
            InitializeComponent();
            liveSensorData = new SensorData();
            ArduinoCom = new ArduinoComClass("COM4", 9600);
            oThreadone = new Thread(endreVerdiArduino);
            oThreadone.Start();
            timer1.Interval = defaultInterval;
            timer1.Start();
            
        }


        delegate void SetTextCallback(string text);

        private void SetText(string text)
        {
            
            // InvokeRequired required compares the thread ID of the
            // calling thread to the thread ID of the creating thread.
            // If these threads are different, it returns true.
            if (this.txtBox.InvokeRequired)
            {
                SetTextCallback d = new SetTextCallback(SetText);
                this.Invoke(d, new object[] { text });
            }
            else
            {
                
                this.txtBox.AppendText("PIR: " + liveSensorData.pir.ToString() + " \tTemp: " + liveSensorData.temp.ToString());
                txtBox.AppendText("\r\n");
                
            }
            
        }

        public void endreVerdiArduino()
        {
            string text = "";
            while (true)
            {
                if (ArduinoCom.DataReady)
                {
                    text = ArduinoCom.receivedData;
                    ArduinoCom.DataReady = false;
                    SetText(text + "\n");
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
                    liveSensorData.temp = Convert.ToSingle(SensorData[1]);
                }
                Application.DoEvents();
                Thread.Sleep(1000);
            }
        }

        

        private void timer1_Tick(object sender, EventArgs e)
        {
            ArduinoCom.Write("1");
            
        }

        class ArduinoComClass : SerialPort
        {
            public string receivedData;
            public bool DataReady;
            public ArduinoComClass(string comport, int baudrate)
            {

                PortName = comport;
                BaudRate = baudrate;
                DataReceived += new SerialDataReceivedEventHandler(dataRecived);
                ReadTimeout = 2000;
                DataReady = false;
                try
                {
                    Open();
                }
                catch (Exception e)
                {
                    MessageBox.Show(e.Message);
                }
            }

            public void dataRecived(object sender, SerialDataReceivedEventArgs earg)
            {
                try
                {

                    receivedData = ReadLine();
                    DataReady = true;

                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                    DataReady = false;
                }
            }

        }
        struct SensorData
        {
            public float temp;
            public bool pir;
        }

        private void cboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            int interval;
            interval = Convert.ToInt32(cboBox.Text);

            switch (interval)
            {

                case 1:
                    interval = 1000;
                    break;
                case 5:
                    interval = 5000;
                    break;
                case 10:
                    interval = 10000;
                    break;
                case 15:
                    interval = 15000;
                    break;
                case 30:
                    interval = 30000;
                    break;
            }
            timer1.Interval = interval;
            
        }
    }
}
