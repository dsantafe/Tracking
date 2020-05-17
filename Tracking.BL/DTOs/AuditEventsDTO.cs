using System;
using System.ComponentModel.DataAnnotations;

namespace Tracking.BL.DTOs
{
    public class AuditEventsDTO
    {
        [Required(ErrorMessage = "The Release Name is required")]
        [Display(Name = "Release Name")]
        public string ReleaseName { get; set; }

        public int Id { get; set; }
        public string SchemaName { get; set; }
        public string ObjectName { get; set; }
        public string ObjectType { get; set; }
        public DateTime EventTime { get; set; }
        public string ObjectKey { get; set; }
        public DateTime CreateDate { get; set; }
        public DateTime ModifyDate { get; set; }
        public long ObjectId { get; set; }
        public string Color { get; set; }
    }
}
