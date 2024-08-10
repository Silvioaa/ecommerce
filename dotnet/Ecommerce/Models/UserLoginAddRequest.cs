using System.ComponentModel.DataAnnotations;

namespace Ecommerce.Models
{
    public class UserLoginAddRequest : UserLogoutAddRequest
    {
        [Required]
        public string Password { get; set; } = null!;
    }
}
