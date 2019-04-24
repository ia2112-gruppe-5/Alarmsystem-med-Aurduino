using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Windows.Forms;
using Alarmsystem;

namespace AlarmsystemLibrary
{
    public class Database:ArduinoComClass
    {
        #region Variabler og Properties
        public string AlarmConfig { get; set; }
        public DateTime Timestamp { get; set; }
        /// <summary>
        /// Property for å mellomlagre data.
        /// </summary>
        public List<string> DataList { get; set; } = new List<string>();
        /// <summary>
        /// Property for å mellomlagre alarmhistorikk.
        /// </summary>
        public List<string> AlarmHistory { get; set; } = new List<string>();
        /// <summary>
        /// Procedure variabel setter denne variablen til den og den proceduren vi skal bruke.
        /// </summary>
        string procedure = "";
        /// <summary>
        /// Event for å oppdatere den grafiske visningen av alarmhistorikk.
        /// </summary>
        public event EventHandler Alarms;
        #endregion

        #region Constuctors
        public Database(string config)
        {
            AlarmConfig = config;
        }
        #endregion

        #region SQLMetoder
        /// <summary>
        /// Metode for å slette data fra databasen
        /// </summary>
        /// <param name="parameter">String som skal bli slettet ifra databasen</param>
        public void DeleteFromDatabase(string parameter)
        {
            try
            {
                procedure = "DeleteAbonnent";
                SqlConnection conAlarm = new SqlConnection(AlarmConfig);
                SqlCommand sql = new SqlCommand(procedure, conAlarm)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                conAlarm.Open();
                sql.Parameters.Add(new SqlParameter("@Mail", parameter));
                sql.ExecuteNonQuery();
                conAlarm.Close();
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
        }
        /// <summary>
        /// Metode for å importere data fra database
        /// </summary>
        public void ImportAbonnentMailFromDatabase()
        {
            try
            {
                procedure = "GetAbonnentMails";
                SQLCommandProcedure(procedure);
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
        }
        /// <summary>
        /// Metode for å legge til abonnenter til databasen.
        /// </summary>
        /// <param name="mail"></param>
        /// <param name="fNavn"></param>
        /// <param name="eNavn"></param>
        /// <param name="phoneNum"></param>
        /// <param name="postalCode"></param>
        public void AddAbonnent(string mail, string fNavn, string eNavn, string phoneNum, string postalCode)
        {
            procedure = "AddAbonnent";
            SqlConnection conAlarm = new SqlConnection(AlarmConfig);
            SqlCommand sql = new SqlCommand(procedure, conAlarm)
            {
                CommandType = System.Data.CommandType.StoredProcedure
            };
            conAlarm.Open();
            sql.Parameters.Add(new SqlParameter("@Mail", mail));
            sql.Parameters.Add(new SqlParameter("@Fornavn", fNavn));
            sql.Parameters.Add(new SqlParameter("@Etternavn", eNavn));
            sql.Parameters.Add(new SqlParameter("@TlfNum", phoneNum));
            sql.Parameters.Add(new SqlParameter("@Postnum", postalCode));
            sql.ExecuteNonQuery();
            conAlarm.Close();
        }
        /// <summary>
        /// Metode for å legge til temperatur måling inn i databasen.
        /// </summary>
        /// <param name="temp"></param>
        public void AddMålingToDatabase(DateTime time, double temp)
        {
            try
            {
                procedure = "AddMåling";
                SqlConnection conAlarm = new SqlConnection(AlarmConfig);
                SqlCommand sql = new SqlCommand(procedure, conAlarm)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                conAlarm.Open();
                sql.Parameters.Add(new SqlParameter("@Time", time));
                sql.Parameters.Add(new SqlParameter("@Temp", temp));
                sql.ExecuteNonQuery();
                conAlarm.Close();
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
        }
        /// <summary>
        /// Metode for å legge til forskjellige alarmgrenser i databasen.
        /// </summary>
        /// <param name="grenseId"></param>
        /// <param name="grenseNavn"></param>
        /// <param name="grenseVerdi"></param>
        public void AddAlarmGrenseToDatabase(int grenseId, string grenseNavn, int grenseVerdi)
        {
            try
            {
                procedure = "AddAlarmGrense";
                SqlConnection conAlarm = new SqlConnection(AlarmConfig);
                SqlCommand sql = new SqlCommand(procedure, conAlarm)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                conAlarm.Open();
                sql.Parameters.Add(new SqlParameter("@grenseId", grenseId));
                sql.Parameters.Add(new SqlParameter("@beskrivelse", grenseNavn));
                sql.Parameters.Add(new SqlParameter("@verdi", grenseVerdi));
                sql.ExecuteNonQuery();
                conAlarm.Close();
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
        }
        /// <summary>
        /// Metode for å oppdatere grenseverdiene i databasen.
        /// </summary>
        /// <param name="grenseId"></param>
        /// <param name="grenseNavn"></param>
        /// <param name="grenseVerdi"></param>
        public void UpdateAlarmGrense(int grenseId,double grenseVerdi)
        {
            try
            {
                procedure = "UpdateAlarmGrense";
                SqlConnection conAlarm = new SqlConnection(AlarmConfig);
                SqlCommand sql = new SqlCommand(procedure, conAlarm)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                conAlarm.Open();
                sql.Parameters.Add(new SqlParameter("@grenseId", grenseId));
                sql.Parameters.Add(new SqlParameter("@verdi", grenseVerdi));
                sql.ExecuteNonQuery();
                conAlarm.Close();
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
        }
        /// <summary>
        /// Metode for å hente grenseverdien fra databasen.
        /// </summary>
        /// <param name="grenseId"></param>
        /// <param name="grenseNavn"></param>
        /// <returns></returns>
        public int GetAlarmGrense(int grenseId)
        {
            int alarmGrense = 0;
            try
            {
                procedure = "GetAlarmGrense";
                SqlConnection conAlarm = new SqlConnection(AlarmConfig);
                SqlCommand sql = new SqlCommand(procedure, conAlarm)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                sql.Parameters.Add(new SqlParameter("@grenseId", grenseId));
                conAlarm.Open();
                SqlDataReader dr = sql.ExecuteReader();
                while (dr.Read())
                {
                    procedure = dr[0].ToString();
                    alarmGrense = Convert.ToInt16(procedure);
                }
                conAlarm.Close();
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
            return alarmGrense;
        }
        /// <summary>
        /// Metode for å legge til alarmer i databasen.
        /// </summary>
        /// <param name="alramId"></param>
        /// <param name="soneType"></param>
        /// <param name="grenseId"></param>
        /// <param name="typeId"></param>
        public void AddAlarmsToDatabase(string soneType, int grenseId,int typeId, DateTime time)
        {
            try
            {
                procedure = "AddAlarm";
                SqlConnection conAlarm = new SqlConnection(AlarmConfig);
                SqlCommand sql = new SqlCommand(procedure, conAlarm)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                conAlarm.Open();
                sql.Parameters.Add(new SqlParameter("@soneType", soneType));
                sql.Parameters.Add(new SqlParameter("@grenseId", grenseId));
                sql.Parameters.Add(new SqlParameter(@"typeId", typeId));
                sql.Parameters.Add(new SqlParameter("@tid", time));
                sql.ExecuteNonQuery();
                conAlarm.Close();
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
            
        }
        /// <summary>
        /// Metode for å legge til alarmtyper i databasen.
        /// Alarmtyper blir bruk for å dele alarmene inn i "grupper".
        /// Alarmer av type 1 er f.eks. sabotasje, da vil alle alarmer som innholder type 1 være av typen sabotasje.
        /// </summary>
        /// <param name="typeId"></param>
        /// <param name="typeNavn"></param>
        public void AddAlarmTyper(int typeId, string typeNavn)
        {
            try
            {
                procedure = "AddAlarmTyper";
                SqlConnection conAlarm = new SqlConnection(AlarmConfig);
                SqlCommand sql = new SqlCommand(procedure, conAlarm)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                conAlarm.Open();
                sql.Parameters.Add(new SqlParameter("@typeId", typeId));
                sql.Parameters.Add(new SqlParameter("@typeNavn", typeNavn));
                sql.ExecuteNonQuery();
                conAlarm.Close();
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
        }
        /// <summary>
        /// Metode for å hente alarmhistorikk.
        /// </summary>
        public void GetAlarmHistory()
        {
            try
            {
                AlarmHistory.Clear();
                procedure = "GetAlarmHistory";
                SqlConnection conAlarm = new SqlConnection(AlarmConfig);
                SqlCommand sql = new SqlCommand(procedure, conAlarm)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                conAlarm.Open();
                SqlDataAdapter da = new SqlDataAdapter(sql);
                DataTable dt = new DataTable();
                da.Fill(dt);
                foreach (DataRow dr in dt.Rows)
                {
                    AlarmHistory.Add("Alarmid "+dr["AlarmId"].ToString() + "\t" +"\t" + dr["Beskrivelse"].ToString()+ "\t" + dr["Tidspunkt"].ToString());

                }
                conAlarm.Close();
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
        }
        /// <summary>
        /// Metode for å hente siste alarm fra databasen.
        /// </summary>
        /// <returns></returns>
        public string GetLatestAlarm()
        {
            string s = "";
            try
            {
                procedure = "GetLatestAlarm";
                SqlConnection conAlarm = new SqlConnection(AlarmConfig);
                SqlCommand sql = new SqlCommand(procedure, conAlarm)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                conAlarm.Open();
                SqlDataAdapter da = new SqlDataAdapter(sql);
                DataTable dt = new DataTable();
                da.Fill(dt);
                foreach (DataRow dr in dt.Rows)
                {
                    s = (dr["AlarmId"].ToString() + "\t" + dr["Beskrivelse"].ToString() + "\t" + dr["GrenseNavn"].ToString()
                        + "\t" + dr["TypeNavn"].ToString() + "\t" + dr["Tidspunkt"].ToString());

                }
                conAlarm.Close();
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
            return s;
        }
        /// <summary>
        /// Metode for å hente abonnenter for abonnerer på forskjellige alarmer.
        /// </summary>
        /// <param name="typeId"></param>
        /// <returns></returns>
        public List<string> GetAbonneterToMailList(int typeId)
        {
            List<string> vs = new List<string>();
            try
            {
                procedure = "GetAbonnenterFromAlarmData";
                
                SqlConnection conAlarm = new SqlConnection(AlarmConfig);
                SqlCommand sql = new SqlCommand(procedure, conAlarm)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                conAlarm.Open();
                sql.Parameters.Add(new SqlParameter("@typeId", typeId));
                SqlDataReader dr = sql.ExecuteReader();
                while (dr.Read())
                {
                    procedure = dr[0].ToString();
                    vs.Add(procedure);
                }
                conAlarm.Close();
                
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
            return vs;
        }
        /// <summary>
        /// Metode for å velge hva slags type alarmer en abonnenet vil abonnere på.
        /// </summary>
        /// <param name="mail"></param>
        /// <param name="typeId"></param>
        /// <param name="abonner"></param>
        public void AlarmAbonnering(string mail, int typeId, bool abonner)
        {
            procedure = "Abonner";
            SqlConnection conAlarm = new SqlConnection(AlarmConfig);
            SqlCommand sql = new SqlCommand(procedure, conAlarm)
            {
                CommandType = System.Data.CommandType.StoredProcedure
            };
            conAlarm.Open();
            sql.Parameters.Add(new SqlParameter("@mail", mail));
            sql.Parameters.Add(new SqlParameter("@typeId", typeId));
            sql.Parameters.Add(new SqlParameter("@abonner", abonner));
            sql.ExecuteNonQuery();
            conAlarm.Close();
        }
        /// <summary>
        /// Metode for å hente alle alarmtyper fra databasen
        /// </summary>
        public void GetAlarmTyper()
        {
            try
            {
                procedure = "GetAlarmTyper";
                SQLCommandProcedure(procedure);
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
            
        }
        /// <summary>
        /// Metode for å legge data inn i TempAlarm tabellen.
        /// </summary>
        /// <param name="tempId"></param>
        /// <param name="alarmId"></param>
        /// <param name="type"></param>
        /// <param name="temp"></param>
        public void AddTempAlarm()
        {
            try
            {
                procedure = "AddTempALarm";
                SQLCommandProcedure(procedure);
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
            
        }
        /// <summary>
        /// Metode for å hente alarmId.
        /// </summary>
        public void GetAlarmId()
        {
            try
            {
                procedure = "GetAlarmId";
                SQLCommandProcedure(procedure);
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
            
        }
        /// <summary>
        /// Metode for å hente tempId.
        /// </summary>
        public void GetTempId()
        {
            try
            {
                procedure = "GetTempId";
                SQLCommandProcedure(procedure);
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
            
        }
        /// <summary>
        /// Metode for å slette alarmhistorikk.
        /// </summary>
        public void DeleteAlarmHistory()
        {
            try
            {
                procedure = "DeleteAlarmHistory";
                SQLCommandProcedure(procedure);
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
            
        }
        /// <summary>
        /// En metode for å skrive sql command procedures som skal hente ut en liste med data.
        /// </summary>
        /// <param name="p">den representerer procedure variablen</param>
        private void SQLCommandProcedure(string p)
        {
            DataList.Clear();
            SqlConnection conAlarm = new SqlConnection(AlarmConfig);
            SqlCommand sql = new SqlCommand(p, conAlarm)
            {
                CommandType = System.Data.CommandType.StoredProcedure
            };
            conAlarm.Open();
            SqlDataReader dr = sql.ExecuteReader();
            while (dr.Read())
            {
                p = dr[0].ToString();
                DataList.Add(p);
            }
            conAlarm.Close();
        }
        /// <summary>
        /// Metode for å oppdatere abpnnenter i databasen.
        /// </summary>
        /// <param name="mail"></param>
        /// <param name="fNavn"></param>
        /// <param name="eNavn"></param>
        /// <param name="phoneNum"></param>
        /// <param name="postalCode"></param>
        public void UpdateAbonnenter(string mail, string fNavn, string eNavn, string phoneNum, string postalCode)
        {
            try
            {
                procedure = "UpdateAbonnent";
                SqlConnection conAlarm = new SqlConnection(AlarmConfig);
                SqlCommand sql = new SqlCommand(procedure, conAlarm)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                conAlarm.Open();
                sql.Parameters.Add(new SqlParameter("@Mail", mail));
                sql.Parameters.Add(new SqlParameter("@Fornavn", fNavn));
                sql.Parameters.Add(new SqlParameter("@Etternavn", eNavn));
                sql.Parameters.Add(new SqlParameter("@TlfNum", phoneNum));
                sql.Parameters.Add(new SqlParameter("@Postnum", postalCode));
                sql.ExecuteNonQuery();
                conAlarm.Close();
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
            
        }
        /// <summary>
        /// Metode for å oppdatere abonnent abonnering i databasen.
        /// </summary>
        /// <param name="mail"></param>
        /// <param name="typeId"></param>
        /// <param name="abonner"></param>
        public void UpdateAbonnering(string mail, int typeId, bool abonner)
        {
            try
            {
                procedure = "UpdateAbonnering";
                SqlConnection conAlarm = new SqlConnection(AlarmConfig);
                SqlCommand sql = new SqlCommand(procedure, conAlarm)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                conAlarm.Open();
                sql.Parameters.Add(new SqlParameter("@mail", mail));
                sql.Parameters.Add(new SqlParameter("@typeId", typeId));
                sql.Parameters.Add(new SqlParameter("@abonner", abonner));
                sql.ExecuteNonQuery();
                conAlarm.Close();
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
            
        }
        /// <summary>
        /// Metode for å slette abonnenter fra databasen.
        /// </summary>
        /// <param name="parameter"></param>
        public void DeleteAbonnentFromAlarmData(string parameter)
        {
            try
            {
                procedure = "DeleteAbonnentFromAlarmData";
                SqlConnection conAlarm = new SqlConnection(AlarmConfig);
                SqlCommand sql = new SqlCommand(procedure, conAlarm)
                {
                    CommandType = System.Data.CommandType.StoredProcedure
                };
                conAlarm.Open();
                sql.Parameters.Add(new SqlParameter("@Mail", parameter));
                sql.ExecuteNonQuery();
                conAlarm.Close();
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
            
        }
        /// <summary>
        /// Metode for å legge et view inn i et datatable.
        /// </summary>
        /// <returns></returns>
        public DataTable ViewAlarmHistory()
        {
            DataTable dt = new DataTable();
            try
            {
                AlarmHistory.Clear();
                procedure = "GetAlarmHistoryFromView";
                //List<string> vs = new List<string>();
                SqlConnection conAlarm = new SqlConnection(AlarmConfig);
                SqlCommand sql = new SqlCommand(procedure, conAlarm)
                {
                    CommandType = CommandType.StoredProcedure
                };
                conAlarm.Open();
                //SqlDataAdapter da = new SqlDataAdapter(sql);
                
                dt.Load(sql.ExecuteReader());
                //da.Fill(dt);
                conAlarm.Close();
                
            }
            catch (Exception exce)
            {
                MessageBox.Show(exce.Message);
            }
            return dt;
        }

        #endregion

        #region Andre metoder
        /// <summary>
        /// Metode for å fremkalle Alarms eventet.
        /// </summary>
        public void AlarmHistoryFromDatabase()
        {
            Alarms(this, new EventArgs());
        }
        /// <summary>
        /// Metode for å legge en list til combobox items.
        /// </summary>
        /// <param name="ts"></param>
        /// <param name="cbo"></param>
        public void AddListToComboBox(List<string> ts, ComboBox cbo)
        {
            for (int i = 0; i < ts.Count; i++)
            {
                cbo.Items.Add(ts[i]);
            }
        }
        #endregion
    }
}
    







