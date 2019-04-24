using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace AlarmsystemLibrary
{
    public class Sonegrenser:Database
    {
        #region Variabler, properties, Objekter og Constructor
        private double tempHøy;//Høy grense temperatur.
        private double tempLav;//Lav grense temperatur.
        private int batteryCharge;//Minutter uten lading.
        private double batteryPercent;//Lading i prosent.
        public double TempHøy
        {
            get { return tempHøy; }
            set
            {
                if (tempLav < value)
                {
                    tempHøy = value;
                }
                else if (tempLav >= value)
                {
                    MessageBox.Show($"Verdien {value} er mindre eller lik lav grense, verdien må være større enn {tempLav}.");
                }
            }
        }
        public double TempLav
        {
            get { return tempLav; }
            set
            {
                if (tempHøy > value)
                {
                    tempLav = value;
                }
                else if (tempHøy <= value)
                {
                    MessageBox.Show($"{value} er større eller lik øvre grense, verdien må være mindre enn {tempHøy}.");
                }
            }
        }
        public int BatteryCharge {
            get { return batteryCharge; }
            set
            {
                if (value < 60 || value > 1)
                {
                    batteryCharge = value;
                }
                else
                {
                    MessageBox.Show($"Verdien {value} er utenfor alarmområdet.");
                }
            }
        }
        public double BatteryPercent {
            get { return batteryPercent; }
            set
            {
                if (value <=100 || value > 0)
                {
                    batteryPercent = value;
                }
                else
                {
                    MessageBox.Show($"Verdien {value} er utenfor alarmområdet.");
                }
            }
        }
        public Sonegrenser():base((ConfigurationManager.
            ConnectionStrings["Alarm"].ConnectionString))
        {
            tempHøy = GetAlarmGrense(1);
            tempLav = GetAlarmGrense(2);
            batteryPercent = GetAlarmGrense(3);
            batteryCharge = GetAlarmGrense(4);
        }
        #endregion

        #region Metoder
        /// <summary>
        /// Ikke brukt
        /// </summary>
        /// <param name="Verdi"></param>
        /// <returns></returns>
        public int DB3300ohm(double Verdi)
        //Dette er en vanlig dobbel balansert sone type. 3.3Kohm i normaltilstand, 6.6Kohm i aktiv sone tilstand. 
        //Over 9Kohm anser vi som sabotasje og under 3Kohm anser vi som kortslutning

        {
            double Sabotasje = 9000;
            double Aktiv = 6300;
            double Normal = 3000;
            int Resultat;
            if (Verdi >= Sabotasje)
            {
                Resultat = 99;//Sabotasje
            }
            else if (Verdi >= Aktiv)
            {
                Resultat = 1;//Aktiv Sone
            }
            else if (Verdi >= Normal)
            {
                Resultat = 0;//Sone normal
            }
            else
            {
                Resultat = 98;//kortslutning
            }
            return Resultat;
        }
        /// <summary>
        /// Metode for å finne ut av hva slags temp grense som har blitt brutt.
        /// /Dobbelt av topp punkt anser vi som en sabotasje, der man må se hva som fører til at sonen har så høy verdi
        /// </summary>
        /// <param name="Verdi"></param>
        /// <returns></returns>
        public int EgenDefinertReferanseVerdi(double Verdi)
        {
            int Resultat;
            if (Verdi >= tempHøy * 2)
            {
                Resultat = 3;//Sabotasje
            }
            else if (Verdi >= tempHøy)
            {
                Resultat = 1;//Høy
            }
            else if (Verdi <= tempLav)
            {
                Resultat = 2;//Lav
            }
            else
            {
                Resultat = 0;//Normal
            }

            return Resultat;
        }
        /// <summary>
        /// Ikke bruk
        /// </summary>
        /// <param name="Verdi"></param>
        /// <returns></returns>
        public int NO(double Verdi)
        {
            //Denne alarmgrensen defineres som Normaly Open. Det vil si at ved brudd er den normal. Ved lukket krets er den unormal, dvs. aktiv sone.
            double breakPoint = 50.0;
            int resultat;
            if (Verdi >= breakPoint)
            {
                resultat = 0;//Normal
            }
            else
            {
                resultat = 1;//Aktiv sone
            }
            return resultat;
        }
        /// <summary>
        /// Ikke brukt
        /// </summary>
        /// <param name="Verdi"></param>
        /// <returns></returns>
        public int NC(double Verdi)
        {
            //Denne alarmgrensen fungere motsatt av NO, den er Normaly Closed. Det vil si at ved lukket krets er den normal, og ved brudd er den unormal, dvs aktiv sone
            double breakPoint = 50.0;
            int resultat;
            if (Verdi >= breakPoint)
            {
                resultat = 1;//Aktiv sone
            }
            else
            {
                resultat = 0;//Normal
            }
            return resultat;
        }
        /// <summary>
        /// Metode for å bruke standar grense verdier.
        /// </summary>
        /// <param name="box"></param>
        public void Default(ComboBox box)
        {
            if (box.SelectedIndex == 0)
            {
                TempHøy = 25;
                UpdateAlarmGrense(1,25);
            }
            else if (box.SelectedIndex == 1)
            {
                TempLav = 18;
                UpdateAlarmGrense(2, 18);
            }
            else if (box.SelectedIndex == 2)
            {
                BatteryPercent = 30;
                UpdateAlarmGrense(3, 30);
            }
            else if (box.SelectedIndex == 3)
            {
                BatteryCharge = 5;
                UpdateAlarmGrense(4,5);
            }
        }
        /// <summary>
        /// Metode for å sette opp nye grenser.
        /// </summary>
        /// <param name="box"></param>
        /// <param name="val"></param>
        public void NewGrense(ComboBox box, int val)
        {
            if (box.SelectedIndex == 0)
            {
                TempHøy = val;
                UpdateAlarmGrense(1,TempHøy);
            }
            else if (box.SelectedIndex == 1)
            {
                TempLav = val;
                UpdateAlarmGrense(2,TempLav);
            }
            else if (box.SelectedIndex == 2)
            {
                BatteryPercent = val;
                UpdateAlarmGrense(3,BatteryPercent);
            }
            else if (box.SelectedIndex == 3)
            {
                BatteryCharge = val;
               UpdateAlarmGrense(4,BatteryCharge);
            }
        }
        #endregion

    }
}
