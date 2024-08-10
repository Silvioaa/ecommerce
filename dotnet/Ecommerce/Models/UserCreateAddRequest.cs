using System.ComponentModel.DataAnnotations;

namespace Ecommerce.Models
{
    public class UserCreateAddRequest
    {
        [Required]
        public string UserName { get; set; } = null!;
        [Required]
        public string Password { get; set; } = null!;
        [Range(1, int.MaxValue)]
        public int UserRole { get; set; }
    }
}
