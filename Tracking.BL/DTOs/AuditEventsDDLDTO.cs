using System;
using System.ComponentModel.DataAnnotations;

namespace Tracking.BL.DTOs
{
    public class AuditEventsDDLDTO
    {
        public int Id { get; set; }

        [Display(Name = "Object Name")]
        public string DDLObjectName { get; set; }

        [Display(Name = "Object Type")]
        public string DDLObjectType { get; set; }

        [Display(Name = "Event Time")]
        public DateTime DDLEventTime { get; set; }

        [Display(Name = "Command")]
        public string DDLCommand { get; set; }

        [Display(Name = "Login Name")]
        public string DDLLoginName { get; set; }

        [Display(Name = "User Name")]
        public string DDLUserName { get; set; }

        [Display(Name = "Database Name")]
        public string DDLDatabaseName { get; set; }

        [Display(Name = "Schema Name")]
        public string DDLSchemaName { get; set; }
    }
}
