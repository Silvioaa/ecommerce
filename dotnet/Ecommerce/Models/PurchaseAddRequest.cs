using System.ComponentModel.DataAnnotations;

namespace Ecommerce.Models;

public class PurchaseAddRequest
{
    [Required]
    public DateTime TimeOfPurchase { get; set; }
    [Required]
    public List<PurchaseItem> PurchaseDetail { get; set; } = null!;
    [Required]
    public int PurchaseTotal { get; set;}
}
