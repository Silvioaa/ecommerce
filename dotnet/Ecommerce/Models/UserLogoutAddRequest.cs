using System.ComponentModel.DataAnnotations;

namespace Ecommerce.Models
{
    public class UserLogoutAddRequest
    {
        [Required]
        public string UserName { get; set; } = null!;
        public string? SessionToken { get; set; }
    }
}
