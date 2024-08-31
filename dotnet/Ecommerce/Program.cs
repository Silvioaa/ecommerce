using Ecommerce.Services;
using Microsoft.Data.SqlClient;
using System.Security.Authentication;
using Microsoft.AspNetCore.Server.Kestrel.Core;
using Microsoft.AspNetCore.Server.Kestrel.Https;
using Microsoft.AspNetCore.HttpOverrides;
using Microsoft.AspNetCore.Mvc.Infrastructure;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Ecommerce.Middlewares;

var builder = WebApplication.CreateBuilder(args);

string? connectionString = Environment.GetEnvironmentVariable("ConnectionString");

builder.Services.Configure<KestrelServerOptions>(options => {
    options.ConfigureHttpsDefaults(options => {
        options.ClientCertificateMode = ClientCertificateMode.RequireCertificate;
    });
});
builder.Services.Configure<HttpClientHandler>(options =>
{
    options.SslProtocols = SslProtocols.None;
});
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(policy =>
    {
        policy.WithOrigins("http://localhost:3000");
    });
});
builder.Services.AddHttpContextAccessor();
builder.Services.AddControllers();
builder.Services.AddTransient<SqlConnection>(_ => 
    new SqlConnection(connectionString != null ? connectionString : "")
);
builder.Services.AddSingleton<DatabaseService, DatabaseService>();
builder.Services.AddSingleton<EcommerceService, EcommerceService>();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
}
    app.UseForwardedHeaders(new ForwardedHeadersOptions
    {
        ForwardedHeaders = ForwardedHeaders.XForwardedFor | ForwardedHeaders.XForwardedProto
    });
if (!app.Environment.IsDevelopment())
{
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseStaticFiles();

app.UseRouting();

app.UseCors();

app.UseAuthorization();

app.MapControllers();

app.UseMiddleware<CookieCleanerMiddleware>();

app.Run();