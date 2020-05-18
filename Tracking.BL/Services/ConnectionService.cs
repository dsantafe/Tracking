using System;
using Tracking.BL.Data;

namespace Tracking.BL.Services
{
    public class ConnectionService
    {
        public void CreateConnection(string server,
            string database,
            string user,
            string password)
        {
            try
            {
                string cnx = string.Format("Server={0};Initial Catalog={1};User Id={2};Password={3}", server,
                    database,
                    user,
                    password);

                TrackingContext.GetConnection(true, cnx);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
