using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using AlarmsystemLibrary;
using System.Windows.Forms;

namespace Alarmsystem
{
    public class Logg:AlarmType
    {
        
        private string fileName = "TempParameter.txt";
        public int LeseIntervall { get; set; }
        public int LagringsIntervall { get; set; }
        
        public Logg() : base()
        {
            ReadFromFile();
        }
        /// <summary>
        /// Metode for å skrive intervallene til fil.
        /// </summary>
        public void WriteToFile()
        {
            try
            {

                FileStream outputstream = new FileStream(fileName, FileMode.OpenOrCreate, FileAccess.Write);
                StreamWriter sw = new StreamWriter(outputstream);
                sw.WriteLineAsync(LeseIntervall + ";" + LagringsIntervall);
                sw.Close();
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }

        }
        /// <summary>
        /// Metode for å lese intervallene fra fil.
        /// </summary>
        public void ReadFromFile()
        {
            try
            {
                string text = "";
                FileStream inputstream = new FileStream(fileName, FileMode.OpenOrCreate, FileAccess.Read);
                StreamReader sr = new StreamReader(inputstream);
                text = sr.ReadToEnd();
                sr.Close();
                string[] parameter = text.Split(';');
                LeseIntervall = Convert.ToInt32(parameter[0]);
                LagringsIntervall = Convert.ToInt32(parameter[1]);
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }

        }
        /// <summary>
        /// Metode for å vise hva lese intervallet fra arduinoen er.
        /// </summary>
        /// <param name="box"></param>
        public void ReadIntervall(TextBox box)
        {
            box.Text = $"Leser fra arduino hvert {LeseIntervall} sekund.";
        }
        /// <summary>
        /// Metode for å vise hva temperatur lagringsintervallet er.
        /// </summary>
        /// <param name="box"></param>
        public void SaveIntervall(TextBox box)
        {
            box.Text = $"Lagrer temperaturen hvert {LagringsIntervall} sekund.";
        }
    }
}
