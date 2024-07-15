using System.Data;
using Ecommerce.Models;
using Newtonsoft.Json;
using Microsoft.IdentityModel.Tokens;
using Microsoft.Data.SqlClient;
using MySqlConnector;

namespace Ecommerce.Services;

public class EcommerceService
{
    private DatabaseService _databaseService;
    public EcommerceService(DatabaseService databaseService)
    {
        _databaseService = databaseService;
    }

    public int? InsertPurchase(PurchaseAddRequest request)
    {
        int? purchaseId = 0;
        string detailString = JsonConvert.SerializeObject(request.PurchaseDetail);

        SqlParameter idParam = new SqlParameter();
        idParam.ParameterName = "Id";
        idParam.Value = 0;
        idParam.DbType = DbType.Int32;
        idParam.Direction = ParameterDirection.Output;

        _databaseService.InsertData("dbo.Insert_Purchase", (SqlParameterCollection paramCollection) =>
        {
            paramCollection.AddWithValue("TimeOfPurchase", request.TimeOfPurchase);
            paramCollection.AddWithValue("PurchaseDetail", detailString);
            paramCollection.AddWithValue("PurchaseTotal", request.PurchaseTotal);
            paramCollection.Add(idParam);
        }, (SqlParameterCollection returnedParameters) => {
            purchaseId = (int?)returnedParameters["Id"].Value;
        });
        
        return purchaseId;
    }

    public List<Product>? GetProducts(int? id, string? name)
    {
        List<Product>? products = null;

        _databaseService.SelectData("dbo.Select_Products", (SqlParameterCollection collection) => {
            if (id != null)
            {
                collection.AddWithValue("Id", id);
            }
            else if (name != null)
            {
                collection.AddWithValue("ProductName", name);
            }
        }, (IDataReader reader) =>
        {
            if (products == null)
            {
                products = new List<Product>();
            }
            Product product = new Product();
            int index = 0;
            product.Id = reader.GetInt32(index++);
            product.ProductName = reader.GetString(index++);
            product.ProductImage = reader.GetString(index++);
            product.ProductDescription = reader.GetString(index++);
            product.ProductPrice = reader.GetInt32(index++);
            products.Add(product);
        });

        return products;
    }

}
