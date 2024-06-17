

using Microsoft.AspNetCore.Mvc;
using Ecommerce.Services;
using Ecommerce.Models;
using Microsoft.Identity.Client;
using Newtonsoft.Json;

namespace Ecommerce.Controllers {

    [Route("api")]
    public class EcommerceController : Controller
    {
        private EcommerceService _ecommerceService;
        public EcommerceController(EcommerceService sqlProvider){
            _ecommerceService = sqlProvider;
        }

        [HttpPost]
        [Route("purchases")]
        public ActionResult<int?> NewPurchase([FromBody]PurchaseAddRequest purchase)
        {
            try
            {
                int? result = _ecommerceService.InsertPurchase(purchase);
                return StatusCode(201, result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex);
            }
            
        }

        [HttpGet]
        [Route("products")]
        public ActionResult<List<Product>> Products(int? id, string? name)
        {
            List<Product>? products;

            try
            {
                products = _ecommerceService.GetProducts(id, name);
                return StatusCode(200, products);
            }
            catch (Exception ex)
            {
                var jsonEx = JsonConvert.SerializeObject(ex)!;
                return StatusCode(500, jsonEx);
                
            }
        }
    }
}