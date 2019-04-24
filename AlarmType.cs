using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AlarmsystemLibrary;

namespace Alarmsystem
{
    public class AlarmType:Sonegrenser,IAlarmInterface
    {
        #region Variabler, Eventhandlere, Properties
        private bool SystemOn = false;
        public string Beskrivelse { get; set; }
        public string Alarm { get; set; }
        public AlarmType() : base() { }
        public double TempValue { get { return tempValue; } set { tempValue = value; } }
        public int Percent { get; set; }
        public int Minutes { get; set; }
        private double tempValue;
        private bool tempAlarm;
        private bool movementAlarm;
        private bool sabotageAlarm;
        private bool batteryChargeAlarm;
        private bool batteryPercentAlarm;
        private bool alarmBlink;
        public event EventHandler TempEvent;
        public event EventHandler MovementEvent;
        public event EventHandler SabotageEvent;
        public event EventHandler BatteryPercentEvent;
        public event EventHandler BatteryChargeEvent;
        public bool TempAlarm { get { return tempAlarm; } set { tempAlarm = value; } }
        public bool MovementAlarm { get { return movementAlarm; } set { movementAlarm = value; } }
        public bool SabotageAlarm { get { return sabotageAlarm; } set { sabotageAlarm = value; } }
        public bool BatteryChargeAlarm { get { return batteryChargeAlarm; } set { batteryChargeAlarm = value; } }
        public bool BatteryPercentAlarm { get { return batteryPercentAlarm; } set { batteryPercentAlarm = value; } }
        public bool AlarmBlink { get { return alarmBlink; } set { alarmBlink = value; } }
        #endregion

        #region Metoder
        /// <summary>
        /// Metode for at en alarm skal kunne bli sendt ut, dersom systemet ikke er på
        /// vil det ikke bli sendt ut noen alarmer.
        /// </summary>
        /// <returns></returns>
        public bool SetAlarm()
        {
            return SystemOn == true;
        }
        /// <summary>
        /// Metode for å skru på overvåking.
        /// </summary>
        public void TurnOnSystem()
        {
            SystemOn = true;
        }
        public void TurnOffSystem()
        {
            SystemOn = false;
        }
        /// <summary>
        /// Metode for å sjekke etter temp og sabotasje alarm
        /// </summary>
        /// <param name="tempVal"></param>
        public void CheckTempAndSabotageAlarm(double tempVal)
        {
            if (!tempAlarm)
            {
                TempHøy = GetAlarmGrense(1);
                TempLav = GetAlarmGrense(2);
                tempValue = tempVal;
                if (tempVal >= TempHøy * 2)
                {
                    SabotageEvent(this, new EventArgs());
                    tempAlarm = true;
                    AlarmBlink = true;
                }
                else if (((tempVal < TempLav) || (tempVal > TempHøy)))
                {
                    TempEvent(this, new EventArgs());
                    TempAlarm = true;
                    AlarmBlink = true;
                }
            }
        }
        /// <summary>
        /// Metode for å sjekke etter bevegelses alarm.
        /// </summary>
        /// <param name="movement"></param>
        public void CheckMovementAlarm(bool movement)
        {
            if (!movementAlarm)
            {
                if (movement)
                {
                    MovementEvent(this, new EventArgs());
                    MovementAlarm = true;
                    AlarmBlink = true;
                }
            }
        }
        /// <summary>
        /// Metode for å sjekke etter lavt batteri alarm.
        /// </summary>
        /// <param name="batteryPercent"></param>
        public void CheckBatteryPercentAlarm(double batteryPercent)
        {
            if (!batteryPercentAlarm)
            {
                BatteryPercent = GetAlarmGrense(3);
                if (batteryPercent < (BatteryPercent/100))
                {
                    BatteryPercentEvent(this, new EventArgs());
                    BatteryPercentAlarm = true;
                    AlarmBlink = true;
                }
            }
        }
        /// <summary>
        /// Metode for å sjekke etter manglende lading alarm.
        /// </summary>
        /// <param name="minutes"></param>
        public void CheckBatteryChargeAlarm(int minutes)
        {
            if (!batteryChargeAlarm)
            {
                BatteryCharge = GetAlarmGrense(4);
                if (minutes > BatteryCharge)
                {
                    BatteryChargeEvent(this, new EventArgs());
                    BatteryChargeAlarm = true;
                    AlarmBlink = true;
                }
            }
            
        }
        #endregion
    }
}
