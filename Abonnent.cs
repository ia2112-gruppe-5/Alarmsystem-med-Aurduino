using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AlarmsystemLibrary;
using System.Windows.Forms;
using System.Configuration;

namespace Alarmsystem
{
    public class Abonnent:Database
    {
        public Abonnent():base(ConfigurationManager.
            ConnectionStrings["Alarm"].ConnectionString)
        {

        }

        #region Metoder
        /// <summary>
        /// Metode for å se om checkboxen er huket av eller ikke.
        /// </summary>
        /// <param name="box"></param>
        /// <returns></returns>
        public bool CheckBoxCheked(CheckBox box)
        {
            bool i;
            if (box.Checked)
            {
                i = true;
            }
            else
            {
                i = false;
            }
            return i;
        }
        /// <summary>
        /// Metode for å legge til ny abonnent.
        /// </summary>
        /// <param name="m"></param>
        /// <param name="f"></param>
        /// <param name="e"></param>
        /// <param name="t"></param>
        /// <param name="p"></param>
        /// <param name="tt"></param>
        /// <param name="be"></param>
        /// <param name="s"></param>
        /// <param name="bt"></param>
        /// <param name="pdf"></param>
        public void NewAbonnent(string m, string f,string e, string t, string p, bool tt, bool be, bool s, bool bt, bool pdf)
        {
            try
            {
                AddAbonnent(m, f, e, t, p);
                AlarmAbonnering(m, 1, tt);
                AlarmAbonnering(m, 2, be);
                AlarmAbonnering(m, 3, s);
                AlarmAbonnering(m, 4, bt);
                AlarmAbonnering(m, 5, pdf);
            }
            catch (Exception)
            {
                MessageBox.Show("Abonnenten eksisterer allerede.");
            }
            
        }
        /// <summary>
        /// Metode for å endre abonnent.
        /// </summary>
        /// <param name="m"></param>
        /// <param name="f"></param>
        /// <param name="e"></param>
        /// <param name="t"></param>
        /// <param name="p"></param>
        /// <param name="tt"></param>
        /// <param name="be"></param>
        /// <param name="s"></param>
        /// <param name="bt"></param>
        /// <param name="pdf"></param>
        public void AlterAbonnent(string m, string f, string e, string t, string p, bool tt, bool be, bool s, bool bt, bool pdf)
        {
            try
            {
                UpdateAbonnenter(m, f, e, t, p);
                UpdateAbonnering(m, 1, tt);
                UpdateAbonnering(m, 2, be);
                UpdateAbonnering(m, 3, s);
                UpdateAbonnering(m, 4, bt);
                UpdateAbonnering(m, 5, pdf);
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
        }
    }
    #endregion
}
