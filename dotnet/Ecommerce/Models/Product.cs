namespace Ecommerce.Models;

public class Product
{
    public int Id { get; set; }
    public string ProductName { get; set; } = null!;
    public string ProductImage { get; set; } = null!;
    public string ProductDescription { get; set; } = null!;
    public int ProductPrice { get; set; }
    
}
