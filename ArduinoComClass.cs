using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO.Ports;
using System.Threading.Tasks;
using System.Windows.Forms;
using AlarmsystemLibrary;

namespace Alarmsystem
{
    public class ArduinoComClass : SerialPort
    {
        public string receivedData;
        public bool DataReady;
        /// <summary>
        /// Setup av klassen.
        /// </summary>
        /// <param name="comport"></param>
        /// <param name="baudrate"></param>
        public ArduinoComClass(string comport, int baudrate)
        {
            try
            {
                PortName = comport;
                BaudRate = baudrate;
                DataReceived += new SerialDataReceivedEventHandler(dataRecived);
                ReadTimeout = 2000;
                DataReady = false;
                Open();
            }
            catch (Exception e)
            {
                MessageBox.Show(e.Message);
            }
        }
        public ArduinoComClass()
        {

        }
        /// <summary>
        /// Metode for å sette data ready til true.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="earg"></param>
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
        public double temp;
        public bool pir;
    }
}
