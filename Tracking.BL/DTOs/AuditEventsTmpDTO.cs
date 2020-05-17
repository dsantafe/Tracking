using System;

namespace Tracking.BL.DTOs
{
    public class AuditEventsTmpDTO
    {   
        public int Id { get; set; }
        public string SchemaName { get; set; }
        public string ObjectName { get; set; }
        public string ObjectType { get; set; }
        public DateTime EventTime { get; set; }
        public string ObjectKey { get; set; }
        public string ObjectKeyCompare { get; set; }
        public string Rename { get; set; }
        public bool Flag { get; set; }
        public string ReleaseName { get; set; }
        public DateTime CreateDate { get; set; }
        public DateTime ModifyDate { get; set; }
        public long ObjectId { get; set; }
        public string Color { get; set; }
    }
}
