using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AlarmsystemLibrary;

namespace Alarmsystem
{
    public class AlarmSender:AlarmType
    {
        /// <summary>
        /// Metode for å sende temperatur alarm.
        /// </summary>
        public void SendTempAlarm()
        {
            string s = "";
            if (TempHøy < TempValue)
            {
                s = $"Temperatur alarm, den målte verdien {TempValue}, er større enn {TempHøy}.";
            }
            else if (TempLav > TempValue)
            {
                s = $"Temperatur alarm, den målte verdien {TempValue}, er mindre enn {TempLav}.";
            }
            AddAlarmsToDatabase(s, EgenDefinertReferanseVerdi(TempValue), 1, Timestamp);
            AddMålingToDatabase(Timestamp, TempValue);
            AddTempAlarm();
        }
        /// <summary>
        /// Metode for å sende bevegelsese alarm.
        /// </summary>
        public void SendMovementAlarm()
        {
            string s = "RUN BITCH, RUN!!";
            AddAlarmsToDatabase(s, 6, 2, Timestamp);
            
        }
        /// <summary>
        /// Metode for å sende manglende lading alarm.
        /// </summary>
        public void SendBatteryChargerAlarm()
        {
            string s = "GET TO DA CHARGA!!";
            AddAlarmsToDatabase(s, 4, 4, Timestamp);
        }
        /// <summary>
        /// Metode for å sende lavt batteri alarm.
        /// </summary>
        public void SendBatteryPercentAlarm()
        {
            string s = "Master please find the charger, i'm dying over here!";
            AddAlarmsToDatabase(s, 3, 4, Timestamp);
        }
        /// <summary>
        /// Metode fro å sende sabotasje alarm.
        /// </summary>
        public void SendSabotageAlarm()
        {
            string s = "I'm trying to tell you now, it's sabotage.";
            AddAlarmsToDatabase(s, 5, 3, Timestamp);
        }
        
    }
}
