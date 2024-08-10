

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

        [HttpPost]
        [Route("register")]
        public ActionResult<object> Register([FromBody] UserCreateAddRequest user)
        {
            try
            {
                object responseMessage = _ecommerceService.RegisterUser(user);
                if (responseMessage.ToString() == "Success")
                {
                    return StatusCode(201, new { Message = "User created successfully." });
                }
                else
                {
                    return StatusCode(400, new { Message =  responseMessage });
                }
            }
            catch (Exception ex)
            {
                var jsonEx = JsonConvert.SerializeObject(ex)!;
                return StatusCode(500, jsonEx);
            }
        }

        [HttpPost]
        [Route("login")]
        public ActionResult<object> Login([FromBody] UserLoginAddRequest user)
        {
            try
            {
                int status = 200;
                UserLoginReturnValue loginResult = _ecommerceService.LoginUser(user);
                if (loginResult.Message == "Success")
                {
                    return StatusCode(status, loginResult);
                }
                else if (loginResult.Message == "User does not exist")
                {
                    status = 404;
                }
                else if (loginResult.Message == "Incorrect password")
                {
                    status = 400;
                }
                else if(loginResult.Message == "User already logged in")
                {
                    status = 200;
                }
                else
                {
                    throw new Exception("Result of login attempt unknown");
                }
                return StatusCode(status, new { Message = loginResult.Message });
            }
            catch (Exception ex)
            {
                var jsonEx = JsonConvert.SerializeObject(ex)!;
                return StatusCode(500, jsonEx);
            }
        }

        [HttpPost]
        [Route("logout")]
        public ActionResult<object> Logout([FromBody] UserLogoutAddRequest user)
        {
            try
            {
                string logoutStatus = _ecommerceService.LogoutUser(user);
                int status;
                if (logoutStatus == "Success")
                {
                    status = 200;
                }
                else if (logoutStatus == "The user does not exist")
                {
                    status = 404;
                }
                else if (logoutStatus == "Token mismatch" ||
                         logoutStatus == "No user logged in" ||
                         logoutStatus == "Token not provided or invalid")
                {
                    status = 400;
                }
                else
                {
                    throw new Exception("Result of logout attempt unknown");    
                }
                return StatusCode(status, new { Message = logoutStatus });
            }
            catch (Exception ex)
            {
                var jsonEx = JsonConvert.SerializeObject(ex)!;
                return StatusCode(500, jsonEx);
            }
        }
    }
}