using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Mail;
using System.Windows.Forms;

namespace AlarmsystemLibrary
{
    public class Mail:Database
    {
        #region Variabler
        string mailSender;
        string clientHostMail; 
        string password;
        #endregion

        #region Construtors
        public Mail(string config):base(config)
        {
            mailSender = "iayvei2018@gmail.com";
            clientHostMail = "smtp.gmail.com";
            password = "IA12345678";
        }
        #endregion

        #region Metoder
        /// <summary>
        /// Metode for å sende mail uten vedlegg, ikke brukt.
        /// </summary>
        /// <param name="mailTo"></param>
        /// <param name="mailmessage"></param>
        /// <param name="topic"></param>
        public void MailSetup(string mailTo, string mailmessage, string topic)
        {
            try
            {
                SmtpClient client = new SmtpClient();
                client.Port = 587;
                client.Host = clientHostMail;
                client.EnableSsl = true;
                client.Timeout = 10000;
                client.DeliveryMethod = SmtpDeliveryMethod.Network;
                client.UseDefaultCredentials = false;
                client.Credentials = new System.Net.NetworkCredential(mailSender, password);
                MailMessage message = new MailMessage(mailSender, mailTo, topic, mailmessage);
                message.BodyEncoding = Encoding.UTF8;
                message.DeliveryNotificationOptions = DeliveryNotificationOptions.OnFailure;
                client.Send(message);
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
        }
        /// <summary>
        /// Medtode for å sende alarm uten vedlegg til alle som abonnerer på forskjellige alarmer.
        /// </summary>
        /// <param name="message"></param>
        /// <param name="topic"></param>
        /// <param name="typeId"></param>
        public void SendMail(string message, string topic,int typeId)
        {
            for (int i = 0; i < GetAbonneterToMailList(typeId).Count; i++)
            {
                MailSetup(GetAbonneterToMailList(typeId)[i], message, topic);
            }
        }
        /// <summary>
        /// Metode for å sende mail med alarmhistorikk som vedlegg.
        /// </summary>
        /// <param name="mailTo"></param>
        /// <param name="mailmessage"></param>
        /// <param name="topic"></param>
        public void MailSetupWithPdf(string mailTo, string mailmessage, string topic, string file)
        {
            try
            {
                MailMessage mail = new MailMessage();
                SmtpClient smtp = new SmtpClient("smtp.gmail.com");
                mail.From = new MailAddress(mailSender);
                mail.To.Add(mailTo);
                mail.Subject = topic;
                mail.Body = mailmessage;

                Attachment attachment;
                attachment = new Attachment(file);
                mail.Attachments.Add(attachment);

                smtp.Port = 587;
                smtp.Credentials = new System.Net.NetworkCredential(mailSender, password);
                smtp.EnableSsl = true;

                smtp.Send(mail);
                //MessageBox.Show("Mail sendt");
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
        }
        /// <summary>
        /// Metode som sender til alle abonnenter som abonnerer på alarmhistorikk.
        /// </summary>
        public void SendMailWithPdf(string file)
        {
            for (int i = 0; i < GetAbonneterToMailList(5).Count; i++)
            {
                MailSetupWithPdf(GetAbonneterToMailList(5)[i], "Her er alarmhistorikken", "AlarmHistorikk", file);
            }
        }
        /// <summary>
        /// Metode for å sende alarm med siste alarm som pdf vedlegg.
        /// </summary>
        /// <param name="mailTo"></param>
        /// <param name="mailmessage"></param>
        /// <param name="topic"></param>
        public void MailSetupAlarm(string mailTo, string mailmessage, string topic, string file)
        {
            try
            {
                MailMessage mail = new MailMessage();
                SmtpClient smtp = new SmtpClient("smtp.gmail.com");
                mail.From = new MailAddress(mailSender);
                mail.To.Add(mailTo);
                mail.Subject = topic;
                mail.Body = mailmessage;

                Attachment attachment;
                attachment = new Attachment(file);
                mail.Attachments.Add(attachment);

                smtp.Port = 587;
                smtp.Credentials = new System.Net.NetworkCredential(mailSender, password);
                smtp.EnableSsl = true;

                smtp.Send(mail);
                //MessageBox.Show("Mail sendt");
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
        }
        /// <summary>
        /// Metode som sender alarm til alle abonnenter som abonnerer på forskjellig type alarmer.
        /// </summary>
        /// <param name="message"></param>
        /// <param name="topic"></param>
        /// <param name="typeId"></param>
        public void SendAlarmToAbonnent(string message, string topic, int typeId, string file)
        {
            for (int i = 0; i < GetAbonneterToMailList(typeId).Count; i++)
            {
                MailSetupAlarm(GetAbonneterToMailList(typeId)[i], message, topic, file);
            }
        }
        #endregion
    }
}
