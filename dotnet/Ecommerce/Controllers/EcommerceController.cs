

using Microsoft.AspNetCore.Mvc;
using Ecommerce.Services;
using Ecommerce.Models;
using Newtonsoft.Json;

namespace Ecommerce.Controllers {

    [ApiController]
    [Route("api")]
    public class EcommerceController : Controller
    {
        private EcommerceService _ecommerceService;
        public EcommerceController(EcommerceService ecommerceService){
            _ecommerceService = ecommerceService;
        }

        [HttpPost]
        [Route("purchasesV2")]
        public ActionResult<int?> NewPurchaseV2([FromBody] PurchaseAddRequestV2 purchase)
        {
            try
            {
                int? result = _ecommerceService.InsertPurchaseV2(purchase);
                return StatusCode(201, result);
            }
            catch (Exception ex)
            {
                var jsonEx = JsonConvert.SerializeObject(ex)!;
                return StatusCode(500, jsonEx);
            }

        }

        [HttpGet]
        [Route("productsV2")]
        public ActionResult<List<ProductV2>> ProductsV2(int? id, string? name)
        {
            List<ProductV2>? products;

            try
            {
                products = _ecommerceService.GetProductsV2(id, name);
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