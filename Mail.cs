using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Mail;

namespace Test_1_DLL
{
    public class Mail
    {
        string mailSender;
        string clientHostMail; 
        string password;
        public Mail()
        {
            mailSender = "iayvei2018@gmail.com";
            clientHostMail = "smtp.gmail.com";
            password = "IA12345678";
        }
        public void Sendmail(string mailTo, string mailmessage, string topic)
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
            message.BodyEncoding = UTF8Encoding.UTF8;
            message.DeliveryNotificationOptions = DeliveryNotificationOptions.OnFailure;
            client.Send(message);
        }
    }
}
