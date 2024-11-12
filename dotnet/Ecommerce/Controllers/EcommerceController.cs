

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
        private IHttpContextAccessor _httpContextAccessor;
        public EcommerceController(EcommerceService ecommerceService, IHttpContextAccessor httpContextAccessor)
        {
            _ecommerceService = ecommerceService;
            _httpContextAccessor = httpContextAccessor;
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
        public ActionResult<ResponseObject> Register([FromBody] UserCreateAddRequest user)
        {
            ResponseObject response = new ResponseObject();
            try
            {
                string responseMessage = _ecommerceService.RegisterUser(user);
                if (responseMessage.ToString() == "Success")
                {
                    response.Message = "User created successfully";
                    response.IsSuccess = true;
                    return StatusCode(201, response);
                }
                else
                {
                    response.Message = responseMessage;
                    response.IsSuccess = false;
                    return StatusCode(400, response);
                }
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                response.IsSuccess = false;
                return StatusCode(500, response);
            }
        }

        [HttpPost]
        [Route("login")]
        public ActionResult<ResponseObject> Login([FromBody] UserLoginAddRequest user)
        {
            int status = 200;
            ResponseObject response = new ResponseObject() { IsSuccess = true };
            string key = "SessionToken";
            try
            {  
                Response.Cookies.Delete(key);
                string token = Request.Cookies[key] ?? "";
                user.SessionToken = token;
                UserLoginReturnValue loginResult = _ecommerceService.LoginUser(user);
                if (loginResult.Message == "Success")
                {
                    
                    string value = loginResult.SessionToken!;
                    CookieOptions cookieOptions = GetCookieOptions();
                    Response.Cookies.Append(key, value, cookieOptions);
                }
                else if (loginResult.Message == "User does not exist")
                {
                    response.IsSuccess = false;
                    status = 404;
                }
                else if (loginResult.Message == "Incorrect password")
                {
                    response.IsSuccess = false;
                    status = 400;
                }
                else if (loginResult.Message == "User already logged in") {
                    string value = loginResult.SessionToken!;
                    CookieOptions cookieOptions = GetCookieOptions();
                    Response.Cookies.Append(key, value, cookieOptions);
                }
                else
                {
                    throw new Exception("Result of login attempt:" + loginResult.Message);
                }
                response.Message = loginResult.Message;
                return StatusCode(status, response);
            }
            catch (Exception ex)
            {
                Response.Cookies.Delete(key);
                response.IsSuccess = false;
                response.Message = ex.Message;
                status = 500;
                return StatusCode(status, response);
            }
        }

        [HttpPost]
        [Route("logout")]
        public ActionResult<ResponseObject> Logout()
        {
            ResponseObject response = new ResponseObject() { IsSuccess = true };
            try
            {
                string sessionToken = _httpContextAccessor.HttpContext!.Request.Cookies["SessionToken"]!;
                if (sessionToken == null || sessionToken == string.Empty)
                {
                    throw new Exception("No session token provided");
                }
                string logoutStatus = _ecommerceService.LogoutUser(sessionToken);
                int status;
                if (logoutStatus == "Success")
                {
                    status = 200;
                }
                else if (logoutStatus == "Token mismatch" ||
                         logoutStatus == "Invalid token")
                {
                    response.IsSuccess = false;
                    status = 400;
                }
                else
                {
                    throw new Exception("Result of logout attempt unknown");    
                }
                response.Message = logoutStatus;
                return StatusCode(status, response);
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = ex.Message;
                return StatusCode(500, response);
            }
        }

        static CookieOptions GetCookieOptions()
        {
            return new CookieOptions
            {
                Expires = DateTime.Now.AddDays(1),
                HttpOnly = true
                //Secure = true
            };
        }
    }
}