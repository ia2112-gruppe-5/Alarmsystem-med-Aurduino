using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using AlarmsystemLibrary;

namespace Alarmsystem
{
    public partial class Temperaturinterval : Form
    {
        #region Variabler, Objekter og Constructor
        Logg logg = new Logg();
        public Temperaturinterval()
        {
            InitializeComponent();
            logg.ReadFromFile();
            cboIntervall.SelectedIndex = 0;
        }
        #endregion

        #region ButtonEvents
        /// <summary>
        /// Click event for å lukke formet.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnClose_Click(object sender, EventArgs e)
        {
            Close();
        }
        /// <summary>
        /// Click event for endre intervall.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnInterval_Click_1(object sender, EventArgs e)
        {
            int interval;
            if (cboIntervall.SelectedIndex == 0)
            {
                if (int.TryParse(txtInterval.Text, out interval))
                {
                    logg.LeseIntervall = interval;

                }
                else
                {
                    MessageBox.Show($"Verdien {txtInterval.Text} er ikke av typen double.", "Ugyldig verdi", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
                logg.WriteToFile();
                txtInterval.Clear();
                txtCurrentInterval.Text = logg.LeseIntervall.ToString() + " hvert sekund";
            }
            else if (cboIntervall.SelectedIndex == 1)
            {
                if (int.TryParse(txtInterval.Text, out interval))
                {
                    logg.LagringsIntervall = interval;

                }
                else
                {
                    MessageBox.Show($"Verdien {txtInterval.Text} er ikke av typen double.", "Ugyldig verdi", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
                logg.WriteToFile();
                txtInterval.Clear();
                txtCurrentInterval.Text = logg.LagringsIntervall.ToString() + " hvert sekund";
            }
        }
        /// <summary>
        /// Click event for å sette standard intervall.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnDefault_Click_1(object sender, EventArgs e)
        {
            logg.LeseIntervall = 1;
            logg.LagringsIntervall = 20;
            logg.WriteToFile();
            if (cboIntervall.SelectedIndex == 0)
            {
                txtCurrentInterval.Text = logg.LeseIntervall.ToString() + " hvert sekund";
            }
            else if (cboIntervall.SelectedIndex == 1)
            {
                txtCurrentInterval.Text = logg.LagringsIntervall.ToString() + " hvert sekund";
            }
        }
        #endregion

        #region CboEvents
        /// <summary>
        /// Metode som endrer teskten i current intervall tekstboksen 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cboIntervall_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cboIntervall.SelectedIndex == 0)
            {
                txtCurrentInterval.Text = logg.LeseIntervall.ToString() + " hvert sekund";
            }
            else if (cboIntervall.SelectedIndex == 1)
            {
                txtCurrentInterval.Text = logg.LagringsIntervall.ToString() + " hvert sekund";
            }
        }
        #endregion

    }
}
