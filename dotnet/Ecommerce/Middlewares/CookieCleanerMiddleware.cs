namespace Ecommerce.Middlewares
{
    public class CookieCleanerMiddleware
    {
        private RequestDelegate _next;
        public CookieCleanerMiddleware(RequestDelegate next) { 
            _next = next;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            if (context.Request.Path.ToString().ToLower() != "/api/login")
            {
                context.Response.Cookies.Delete("SessionToken");
            }

            await _next(context);
        }
    }
}
