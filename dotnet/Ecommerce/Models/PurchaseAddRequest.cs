using System.ComponentModel.DataAnnotations;

namespace Ecommerce.Models;

public class PurchaseAddRequest
{
    [Required]
    public DateTime? TimeOfPurchase { get; set; }
    [Required]
    public List<PurchaseItem> PurchaseDetail { get; set; } = null!;
    [Range(1,int.MaxValue)]
    public int PurchaseTotal { get; set;}
}
