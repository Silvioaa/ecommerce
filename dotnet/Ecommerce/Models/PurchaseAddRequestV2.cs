using System.ComponentModel.DataAnnotations;

namespace Ecommerce.Models
{
    public class PurchaseAddRequestV2
    {
        
        [Range (1, int.MaxValue)]
        public int UserId { get; set; }
        [Required]
        public DateTime? TimeOfPurchase { get; set; }
        [Required]
        public List<PurchaseItemV2> PurchaseDetail { get; set; } = null!;
        [Range(0.01,double.MaxValue)]
        public double PurchaseTotal { get; set; }
    }
}
