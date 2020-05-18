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

        [Display(Name = "Schema Name")]
        public string SchemaName { get; set; }

        [Display(Name = "Object Name")]
        public string ObjectName { get; set; }

        [Display(Name = "Object Type")]
        public string ObjectType { get; set; }

        [Display(Name = "Event Time")]
        public DateTime EventTime { get; set; }

        [Display(Name = "Object Key")]
        public string ObjectKey { get; set; }

        [Display(Name = "Create Date")]
        public DateTime CreateDate { get; set; }
        
        public DateTime ModifyDate { get; set; }        
        public long ObjectId { get; set; }        
        public string Color { get; set; }
    }
}
