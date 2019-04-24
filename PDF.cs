using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;
using AlarmsystemLibrary;
using System.Windows.Forms;

namespace Alarmsystem
{
   public class PDF:Mail
    {
        public string FileName { get; set; }
        int alarmhistoryCount;
        int alarmCount;
        public PDF(string config):base(config)
        {
            alarmhistoryCount = 1;
            alarmCount = 1;
        }
       /// <summary>
       /// Metode for å oprette alarmhistorikk pdf.
       /// </summary>
        public void CreateAndAppendAlarmHistory()
        {
            try
            {
                FileName = $"AlarmHistory{alarmhistoryCount}.pdf";
                Document doc = new Document();

                PdfWriter.GetInstance(doc, new FileStream(FileName, FileMode.Create));
                doc.Open();
                Paragraph pl;
                GetAlarmHistory();
                for (int i = 0; i < AlarmHistory.Count; i++)
                {
                    pl = new Paragraph(AlarmHistory[i]);
                    doc.Add(pl);
                }
                doc.Close();
                alarmhistoryCount++;
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
            

        }
        /// <summary>
        /// Metode for å lage pdf ut av siste alarm.
        /// </summary>
        /// <param name="alarmTopic"></param>
        public void LatestAlarmPdf(string alarmTopic)
        {
            try
            {
                FileName = $"Alarm{alarmCount}.pdf";
                Document doc = new Document();
                PdfWriter.GetInstance(doc, new FileStream(FileName, FileMode.Create));
                doc.Open();
                Paragraph pl = new Paragraph(alarmTopic + "\r\n" + GetLatestAlarm());
                doc.Add(pl);
                doc.Close();
                alarmCount++;
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
            
        }
    }
}
