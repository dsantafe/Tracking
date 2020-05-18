using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Tracking.BL.Data
{
    public class TrackingContext
    {
        private static SqlConnection connection = null;

        private TrackingContext()
        {

        }

        /// <summary>
        /// METODO QUE ESTABLECE LA CONEXION
        /// </summary>
        /// <returns></returns>
        public static SqlConnection GetConnection(bool flag = false, string cnxNew = "")
        {

            try
            {
                if (connection == null || flag)
                {
                    string cnx = flag ? cnxNew : ConfigurationManager.ConnectionStrings["TrackingContext"].ToString();

                    connection = new SqlConnection(cnx);
                    connection.Open();
                }

                return connection;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// METODO QUE CIERRA LA CONEXION
        /// </summary>
        public static void CloseConnection()
        {
            try
            {
                connection.Close();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
