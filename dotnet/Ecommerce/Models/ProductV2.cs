namespace Ecommerce.Models
{
    public class ProductV2
    {
        public int Id { get; set; }
        public string ProductName { get; set; } = null!;
        public string ProductImage { get; set; } = null!;
        public string ProductDescription { get; set; } = null!;
        public double ProductPrice { get; set; }
    }
}
