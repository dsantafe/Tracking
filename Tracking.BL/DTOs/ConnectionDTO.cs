using System.ComponentModel.DataAnnotations;

namespace Tracking.BL.DTOs
{
    public class ConnectionDTO
    {
        [Required(ErrorMessage = "The Server is required")]
        public string Server { get; set; }

        [Required(ErrorMessage = "The Database is required")]
        public string Database { get; set; }

        [Required(ErrorMessage = "The User is required")]
        public string User { get; set; }

        [Required(ErrorMessage = "The Password is required")]
        [DataType(DataType.Password)]
        public string Password { get; set; }
    }
}
