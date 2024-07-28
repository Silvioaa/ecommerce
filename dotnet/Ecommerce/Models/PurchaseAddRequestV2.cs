using System.ComponentModel.DataAnnotations;

namespace Ecommerce.Models
{
    public class PurchaseAddRequestV2 : PurchaseAddRequest
    {
        [Range (1, int.MaxValue)]
        public int UserId { get; set; }
        [Required]
        public new List<PurchaseItemV2> PurchaseDetail { get; set; } = null!;
        [Range(0.01,double.MaxValue)]
        public new double PurchaseTotal { get; set; }
    }
}
