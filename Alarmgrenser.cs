using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using AlarmsystemLibrary;
using System.Configuration;

namespace Alarmsystem
{
    public partial class Alarmgrenser : Form
    {
        #region Variabler, Objekter og Constructor
        AlarmSender alarmSender = new AlarmSender();
        public Alarmgrenser()
        {
            InitializeComponent();
            cboGrenseType.SelectedIndex = 0;
        }
        #endregion

        #region ButtonEvents
        /// <summary>
        /// Click event som lukker formet.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnClose_Click(object sender, EventArgs e)
        {
            Close();
        }
        /// <summary>
        /// Click event som setter standard verdier.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnDefault_Click(object sender, EventArgs e)
        {
            alarmSender.Default(cboGrenseType);
            SetCurrent(cboGrenseType);
        }
        /// <summary>
        /// Click event som endrer grensene.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnGrense_Click(object sender, EventArgs e)
        {
            int val;
            try
            {
                val = Convert.ToInt16(txtValue.Text);
                alarmSender.NewGrense(cboGrenseType, val);
                SetCurrent(cboGrenseType);
                txtValue.Clear();
            }
            catch (Exception)
            {
                MessageBox.Show("Kan ikke konvertere denne verdien til tall","Ugyldig verdi",MessageBoxButtons.OK,MessageBoxIcon.Exclamation);
            }
            
        }
        #endregion

        #region CboEvents
        /// <summary>
        /// Cbo event som endre teksten i en tekstboks, hver gang man endrer hvilket indeks som er valgt.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cboGrenseType_SelectedIndexChanged(object sender, EventArgs e)
        {
            SetCurrent(cboGrenseType);
        }
        #endregion

        #region Metoder
        /// <summary>
        /// Metode for å endre teksten tekstboksen txtCurrenLimit basert på hvilken grense som er i comboBoxen.
        /// </summary>
        /// <param name="box"></param>
        public void SetCurrent(ComboBox box)
        {
            if (box.SelectedIndex == 0)
            {
                txtCurrentLimit.Text = alarmSender.TempHøy.ToString() + " grader";
            }
            else if (box.SelectedIndex == 1)
            {
                txtCurrentLimit.Text = alarmSender.TempLav.ToString() + " grader";
            }
            else if (box.SelectedIndex == 2)
            {
                txtCurrentLimit.Text = alarmSender.BatteryPercent.ToString() + "%";
            }
            else if (box.SelectedIndex == 3)
            {
                txtCurrentLimit.Text = alarmSender.BatteryCharge.ToString() + "min";
            }
        }
        #endregion
    }
}
