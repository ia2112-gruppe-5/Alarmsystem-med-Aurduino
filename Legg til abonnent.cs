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
    public partial class Legg_til_abonnent : Form
    {
        #region Variabler, Objekter og Constructor
        Abonnent abonnent = new Abonnent();
        public Legg_til_abonnent()
        {
            InitializeComponent();
        }
        #endregion

        #region ButtonEvents
        /// <summary>
        /// Click event for å legge til en ny abonnent.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnAddAbonnent_Click(object sender, EventArgs e)
        {
            string mailaddresse = "", forNavn = "", etterNavn = "", phoneNumber = "", postAddresse = "";
            bool temperatur, bevegelse, sabotasje, batteri,pdf;
            mailaddresse = txtMail.Text;
            forNavn = txtFname.Text;
            etterNavn = txtLname.Text;
            phoneNumber = txtPhone.Text;
            postAddresse = txtPostNum.Text;
            bevegelse = abonnent.CheckBoxCheked(checkBoxBevegelse);
            batteri = abonnent.CheckBoxCheked(checkBoxBatteri);
            sabotasje = abonnent.CheckBoxCheked(checkBoxSabotasje);
            temperatur = abonnent.CheckBoxCheked(checkBoxTemp);
            pdf = abonnent.CheckBoxCheked(checkBoxPDF);
            abonnent.NewAbonnent(mailaddresse, forNavn, etterNavn, phoneNumber, postAddresse, temperatur, bevegelse, sabotasje, batteri, pdf);
            txtFname.Clear();
            txtMail.Clear();
            txtLname.Clear();
            txtPhone.Clear();
            txtPostNum.Clear();
            checkBoxBevegelse.Checked = true;
            checkBoxBatteri.Checked = true;
            checkBoxSabotasje.Checked = true;
            checkBoxTemp.Checked = true;
            checkBoxPDF.Checked = true;
        }
        /// <summary>
        /// Click event for å lukke formet.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnClose_Click(object sender, EventArgs e)
        {
            Close();
        }
        #endregion
    }
}
