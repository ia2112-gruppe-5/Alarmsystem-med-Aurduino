using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Configuration;
using AlarmsystemLibrary;

namespace Alarmsystem
{
    public partial class Endre_abonnenter : Form
    {
        #region Variabler, Objekter og Constructor
        Abonnent abonnent = new Abonnent();
        public Endre_abonnenter()
        {
            InitializeComponent();
            abonnent.ImportAbonnentMailFromDatabase();
            abonnent.AddListToComboBox(abonnent.DataList, cboMail);
            cboMail.SelectedIndex = 0;
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
        /// Click event for å slette abonnent.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnDeleteAbonnent_Click(object sender, EventArgs e)
        {
            cboMail.Items.Clear();
            abonnent.DeleteAbonnentFromAlarmData(cboMail.Text);
            abonnent.DeleteFromDatabase(cboMail.Text);
            abonnent.ImportAbonnentMailFromDatabase();
            abonnent.AddListToComboBox(abonnent.DataList, cboMail);
            cboMail.SelectedIndex = 0;
        }
        /// <summary>
        /// Click event for å endre abonnent.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnAlterAbonnent_Click(object sender, EventArgs e)
        {
            string mailaddresse = "", forNavn = "", etterNavn = "", phoneNumber = "", postAddresse = "";
            bool temperatur, bevegelse, sabotasje, batteri, pdf;
            mailaddresse = cboMail.Text;
            forNavn = txtFname.Text;
            etterNavn = txtLname.Text;
            phoneNumber = txtPhone.Text;
            postAddresse = txtPostNum.Text;
            bevegelse = abonnent.CheckBoxCheked(checkBoxBevegelse);
            batteri = abonnent.CheckBoxCheked(checkBoxBatteri);
            sabotasje = abonnent.CheckBoxCheked(checkBoxSabotasje);
            temperatur = abonnent.CheckBoxCheked(checkBoxTemp);
            pdf = abonnent.CheckBoxCheked(checkBoxPDF);
            abonnent.AlterAbonnent(mailaddresse, forNavn, etterNavn, phoneNumber, postAddresse, temperatur, bevegelse, sabotasje, batteri, pdf);
            txtFname.Clear();
            txtLname.Clear();
            txtPhone.Clear();
            txtPostNum.Clear();
            checkBoxBevegelse.Checked = true;
            checkBoxBatteri.Checked = true;
            checkBoxSabotasje.Checked = true;
            checkBoxTemp.Checked = true;
            checkBoxPDF.Checked = true;
        }
        #endregion
    }
}
