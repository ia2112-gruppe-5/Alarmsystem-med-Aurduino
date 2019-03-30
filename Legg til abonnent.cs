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
using Test_1_DLL;

namespace Test_1
{
    public partial class Legg_til_abonnent : Form
    {
        Database database = new Database(ConfigurationManager.ConnectionStrings["Alarm"].ConnectionString);
        public Legg_til_abonnent()
        {
            InitializeComponent();
            
        }

        private void btnAddAbonnent_Click(object sender, EventArgs e)
        {
            string mailaddresse = "", forNavn = "", etterNavn = "", phoneNumber = "", postAddresse = "";
            bool temperatur, bevegelse, sabotasje, kommunikasjon, mail;
            mailaddresse = txtMail.Text;
            forNavn = txtFname.Text;
            etterNavn = txtLname.Text;
            phoneNumber = txtPhone.Text;
            postAddresse = txtPostNum.Text;
            bevegelse = CheckBoxCheked(checkBoxBevegelse);
            mail = CheckBoxCheked(checkBoxMail);
            sabotasje = CheckBoxCheked(checkBoxSabotasje);
            kommunikasjon = CheckBoxCheked(checkBoxKommunikasjon);
            temperatur = CheckBoxCheked(checkBoxTemp);
            database.AddAbonnent(mailaddresse, forNavn, etterNavn, phoneNumber, postAddresse);
            database.AlarmAbonnering(mailaddresse, 1, temperatur);
            database.AlarmAbonnering(mailaddresse, 2, bevegelse);
            database.AlarmAbonnering(mailaddresse, 3, sabotasje);
            database.AlarmAbonnering(mailaddresse, 4, kommunikasjon);
            database.AlarmAbonnering(mailaddresse, 5, mail);
            txtFname.Clear();
            txtMail.Clear();
            txtLname.Clear();
            txtPhone.Clear();
            txtPostNum.Clear();
            checkBoxBevegelse.Checked = true;
            checkBoxKommunikasjon.Checked = true;
            checkBoxMail.Checked = true;
            checkBoxSabotasje.Checked = true;
            checkBoxTemp.Checked = true;
        }
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

        private void btnClose_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}
