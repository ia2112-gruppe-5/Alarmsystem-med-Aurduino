using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace Test_1_DLL
{
    public class Database
    {
        public string AlarmConfig { get; set; }
        /// <summary>
        /// Property for å mellomlagre data.
        /// </summary>
        public List<string> DataList { get; set; } = new List<string>();
        string procedure = ""; 
        public Database(string config)
        {
            AlarmConfig = config;
        }
        
        #region SQLMetoder
        /// <summary>
        /// Metode for å slette data fra databasen
        /// </summary>
        /// <param name="parameter">String som skal bli slettet ifra databasen</param>
        public void DeleteFromDatabase(string parameter)
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
        /// <summary>
        /// Metode for å importere data fra database
        /// </summary>
        public void ImportAbonnentMailFromDatabase()
        {
            procedure = "GetAbonnentMails";
            SQLCommandProcedure(procedure);

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
        /// <summary>
        /// Metode for å legge til forskjellige alarmgrenser i databasen.
        /// </summary>
        /// <param name="grenseId"></param>
        /// <param name="grenseNavn"></param>
        /// <param name="grenseVerdi"></param>
        public void AddAlarmGrenseToDatabase(int grenseId, string grenseNavn, int grenseVerdi)
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
        /// <summary>
        /// Metode for å oppdatere grenseverdiene i databasen.
        /// </summary>
        /// <param name="grenseId"></param>
        /// <param name="grenseNavn"></param>
        /// <param name="grenseVerdi"></param>
        public void UpdateAlarmGrense(int grenseId, string grenseNavn, double grenseVerdi)
        {
            procedure = "UpdateAlarmGrense";
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
        /// <summary>
        /// Metode for å hente grenseverdien fra databasen.
        /// </summary>
        /// <param name="grenseId"></param>
        /// <param name="grenseNavn"></param>
        /// <returns></returns>
        public double GetAlarmGrense(int grenseId, string grenseNavn)
        {
            procedure = "GetAlarmGrense";
            double alarmGrense = 0;
            SqlConnection conAlarm = new SqlConnection(AlarmConfig);
            SqlCommand sql = new SqlCommand(procedure, conAlarm)
            {
                CommandType = System.Data.CommandType.StoredProcedure
            };
            sql.Parameters.Add(new SqlParameter("@grenseId", grenseId));
            sql.Parameters.Add(new SqlParameter("@beskrivelse", grenseNavn));
            conAlarm.Open();
            SqlDataReader dr = sql.ExecuteReader();
            while (dr.Read())
            {
                procedure = dr[0].ToString();
                alarmGrense = Convert.ToDouble(procedure);
            }
            conAlarm.Close();
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
        /// <summary>
        /// Metode for å legge til alarmtyper i databasen.
        /// Alarmtyper blir bruk for å dele alarmene inn i "grupper".
        /// Alarmer av type 1 er f.eks. sabotasje, da vil alle alarmer som innholder type 1 være av typen sabotasje.
        /// </summary>
        /// <param name="typeId"></param>
        /// <param name="typeNavn"></param>
        public void AddAlarmTyper(int typeId, string typeNavn)
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
        /// <summary>
        /// Metode for å hente alarmhistorikk.
        /// </summary>
        public List<string> GetAlarmHistory()
        {
            procedure = "GetAlarmHistory";
            List<string> vs = new List<string>();
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
                vs.Add(dr["AlarmId"].ToString() +"\t"+ dr["Beskrivelse"].ToString() + "\t" + dr["GrenseVerdi"].ToString()
                    + "\t" + dr["TypeNavn"].ToString() + "\t" + dr["Tidspunkt"].ToString());
                
            }
            conAlarm.Close();
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
            procedure = "GetAlarmTyper";
            SQLCommandProcedure(procedure);
        }
        /// <summary>
        /// Metode for å legge data inn i TempAlarm tabellen.
        /// </summary>
        /// <param name="tempId"></param>
        /// <param name="alarmId"></param>
        /// <param name="type"></param>
        /// <param name="temp"></param>
        public void AddTempAlarm(int tempId,int alarmId,string type,double temp)
        {
            procedure = "AddTempALarm";
            SqlConnection conAlarm = new SqlConnection(AlarmConfig);
            SqlCommand sql = new SqlCommand(procedure, conAlarm)
            {
                CommandType = System.Data.CommandType.StoredProcedure
            };
            conAlarm.Open();
            sql.Parameters.Add(new SqlParameter("@tempId", tempId));
            sql.Parameters.Add(new SqlParameter("@alarmId", alarmId));
            sql.Parameters.Add(new SqlParameter("@type", type));
            sql.Parameters.Add(new SqlParameter("@temp", temp));
            sql.ExecuteNonQuery();
            conAlarm.Close();
        }
        /// <summary>
        /// Metode for å hente alarmId.
        /// </summary>
        public void GetAlarmId()
        {
            procedure = "GetAlarmId";
            SQLCommandProcedure(procedure);
        }
        /// <summary>
        /// Metode for å hente tempId.
        /// </summary>
        public void GetTempId()
        {
            procedure = "GetTempId";
            SQLCommandProcedure(procedure);
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
        
        #endregion
        public int GetAlarmType(string s)
        {
            int i = 0;
            if (s == "Temp")
            {
                i = 1;
            }
            else if (s == "Bevegelse")
            {
                i = 2;
            }
            else if (s == "Sabotasje")
            {
                i = 3;
            }
            else if (s == "Kommunikasjon")
            {
                i = 4;
            }
            else if (s == "Mail")
            {
                i = 5;
            }
            return i;
        }
        
    }
}
    







