using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using Tracking.BL.Data;
using Tracking.BL.DTOs;

namespace Tracking.BL.Services
{
    public class AuditEventsService
    {
        private SqlCommand command = null;
        private SqlDataAdapter adapter = null;

        public List<AuditEventsDTO> GetReleases()
        {
            try
            {
                var listAuditEventsDTO = new List<AuditEventsDTO>();

                command = new SqlCommand("GetReleases", TrackingContext.GetConnection())
                {
                    CommandType = CommandType.StoredProcedure
                };

                DataSet dataSet = new DataSet();
                adapter = new SqlDataAdapter(command);
                adapter.Fill(dataSet);

                foreach (DataRow item in dataSet.Tables[0].Rows)
                {
                    listAuditEventsDTO.Add(new AuditEventsDTO
                    {
                        Id = (int)item["Id"],
                        ReleaseName = (string)item["ReleaseName"],
                        SchemaName = (string)item["SchemaName"],
                        ObjectName = (string)item["ObjectName"],
                        ObjectType = (string)item["ObjectType"],
                        EventTime = (DateTime)item["EventTime"],
                        ObjectKey = (string)item["ObjectKey"],
                        ObjectId = (long)item["ObjectId"],
                        CreateDate = (DateTime)item["CreateDate"]
                    });
                }

                return listAuditEventsDTO;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<AuditEventsDTO> GetReleasesHistory()
        {
            try
            {
                var listAuditEventsDTO = new List<AuditEventsDTO>();

                command = new SqlCommand("GetReleases", TrackingContext.GetConnection())
                {
                    CommandType = CommandType.StoredProcedure
                };

                DataSet dataSet = new DataSet();
                adapter = new SqlDataAdapter(command);
                adapter.Fill(dataSet);

                foreach (DataRow item in dataSet.Tables[0].Rows)
                {
                    listAuditEventsDTO.Add(new AuditEventsDTO
                    {
                        Id = (int)item["Id"],
                        ReleaseName = (string)item["ReleaseName"],
                        SchemaName = (string)item["SchemaName"],
                        ObjectName = (string)item["ObjectName"],
                        ObjectType = (string)item["ObjectType"],
                        EventTime = (DateTime)item["EventTime"],
                        ObjectKey = (string)item["ObjectKey"],
                        ObjectId = (long)item["ObjectId"],
                        CreateDate = (DateTime)item["CreateDate"],
                        Color = "success"
                    });
                }

                var listReleases = listAuditEventsDTO.Select(x => x.ReleaseName).Distinct().ToList();

                for (int i = 0; i < listReleases.Count; i++)
                {
                    if (i != 0)
                    {
                        var listReleaseOne = listAuditEventsDTO.Where(x => x.ReleaseName == listReleases[i - 1]).ToList();
                        var listReleaseTwo = listAuditEventsDTO.Where(x => x.ReleaseName == listReleases[i]).ToList();

                        var listObjectsNews = (from q in listReleaseTwo
                                               where !(listReleaseOne.Select(x => x.ObjectId).Contains(q.ObjectId))                                               
                                               select q).ToList();

                        var listObjectsModify = (from q in listReleaseTwo
                                                 join r in listReleaseOne on q.ObjectId equals r.ObjectId
                                                 where !q.ObjectKey.Equals(r.ObjectKey)
                                                 select q).ToList();

                        foreach (var item in listAuditEventsDTO.Where(x => x.ReleaseName == listReleases[i]))
                        {
                            if (listObjectsNews.Any(x => x.ObjectId == item.ObjectId))
                                item.Color = "warning";
                            else if(listObjectsModify.Any(x => x.ObjectId == item.ObjectId))
                                item.Color = "info";                            
                        }
                    }
                }

                return listAuditEventsDTO;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<AuditEventsTmpDTO> CompareRelease(string releaseName)
        {
            try
            {
                var listAuditEventsTmpDTO = new List<AuditEventsTmpDTO>();

                command = new SqlCommand("CompareRelease", TrackingContext.GetConnection())
                {
                    CommandType = CommandType.StoredProcedure
                };

                command.Parameters.AddRange(new SqlParameter[] {
                    new SqlParameter("@ReleaseName", releaseName)
                });

                DataSet dataSet = new DataSet();
                adapter = new SqlDataAdapter(command);
                adapter.Fill(dataSet);

                foreach (DataRow item in dataSet.Tables[0].Rows)
                {
                    var objectKeyCompare = item["ObjectKeyCompare"] != DBNull.Value ? (string)item["ObjectKeyCompare"] : string.Empty;
                    var rename = item["Rename"] != DBNull.Value ? (string)item["Rename"] : string.Empty;

                    listAuditEventsTmpDTO.Add(new AuditEventsTmpDTO
                    {
                        Id = (int)item["Id"],
                        SchemaName = (string)item["SchemaName"],
                        ObjectName = (string)item["ObjectName"],
                        ObjectType = (string)item["ObjectType"],
                        EventTime = (DateTime)item["EventTime"],
                        ObjectKey = (string)item["ObjectKey"],
                        ObjectKeyCompare = objectKeyCompare,
                        Rename = rename,
                        Flag = (bool)item["Flag"],
                        ReleaseName = (string)item["ReleaseName"],
                        ObjectId = (long)item["ObjectId"],
                        CreateDate = (DateTime)item["CreateDate"],
                        Color = (bool)item["Flag"] ? (string.IsNullOrEmpty(objectKeyCompare) && string.IsNullOrEmpty(rename) ? "danger" : "warning") : "success"
                    });
                }

                return listAuditEventsTmpDTO;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string CreateRelease(string releaseName)
        {
            try
            {
                command = new SqlCommand("CreateRelease", TrackingContext.GetConnection())
                {
                    CommandType = CommandType.StoredProcedure
                };

                command.Parameters.AddRange(new SqlParameter[] {
                    new SqlParameter("@ReleaseName", releaseName)
                });

                SqlParameter message = new SqlParameter
                {
                    ParameterName = "@Message",
                    SqlDbType = SqlDbType.VarChar,
                    Direction = ParameterDirection.Output,
                    Size = 50
                };

                command.Parameters.Add(message);

                command.ExecuteNonQuery();

                return message.Value.ToString();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
