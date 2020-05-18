using System;
using System.ComponentModel.DataAnnotations;

namespace Tracking.BL.DTOs
{
    public class AuditEventsTmpDTO
    {
        public int Id { get; set; }

        [Display(Name = "Schema Name")]
        public string SchemaName { get; set; }

        [Display(Name = "Object Name")]
        public string ObjectName { get; set; }

        [Display(Name = "Object Type")]
        public string ObjectType { get; set; }

        [Display(Name = "Event Time")]
        public DateTime EventTime { get; set; }

        public string ObjectKey { get; set; }
        public string ObjectKeyCompare { get; set; }

        [Display(Name = "Rename")]
        public string Rename { get; set; }

        [Display(Name = "Flag")]
        public bool Flag { get; set; }

        [Display(Name = "Release Name")]
        public string ReleaseName { get; set; }

        [Display(Name = "Create Date")]
        public DateTime CreateDate { get; set; }

        public DateTime ModifyDate { get; set; }
        public long ObjectId { get; set; }
        public string Color { get; set; }
    }
}
