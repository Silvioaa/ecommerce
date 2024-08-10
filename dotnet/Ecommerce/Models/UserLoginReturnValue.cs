namespace Ecommerce.Models
{
    public class UserLoginReturnValue
    {
        public string Message { get; set; } = null!;
        public string? SessionToken { get; set; }
    }
}
