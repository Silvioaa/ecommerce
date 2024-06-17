using System.Data;
using Ecommerce.Models;
using Newtonsoft.Json;
using Microsoft.IdentityModel.Tokens;
using Microsoft.Data.SqlClient;
using MySqlConnector;

namespace Ecommerce.Services;

public class EcommerceService
{
    private SqlConnection _connection;
    public EcommerceService(SqlConnection connection){
        _connection = connection;
    }

    public int? InsertPurchase(PurchaseAddRequest request)
    {
        int? purchaseId = 0;
        try
        {
            string detailString = JsonConvert.SerializeObject(request.PurchaseDetail);
            SqlParameter idParam = new SqlParameter();
            idParam.ParameterName = "Id";
            idParam.Value = 0;
            idParam.DbType = DbType.Int32;
            idParam.Direction = ParameterDirection.Output;
            using (SqlCommand command = new SqlCommand("ecom.Insert_Purchase",_connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("TimeOfPurchase", request.TimeOfPurchase);
                command.Parameters.AddWithValue("PurchaseDetail", detailString);
                command.Parameters.AddWithValue("PurchaseTotal", request.PurchaseTotal);
                command.Parameters.Add(idParam);
                _connection.Open();
                command.ExecuteNonQuery();
                purchaseId = (int?)command.Parameters["Id"].Value;
                _connection.Close();
                return purchaseId;
            }
        }
        catch
        {
            if (_connection.State == ConnectionState.Open)
            {
                _connection.Close();
            }
            throw;
        }
            
    }

    public List<Product>? GetProducts(int? id, string? name)
    {
        List<Product>? products = null;

        try
        {
            using (SqlCommand command = new SqlCommand())
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Connection = _connection;
                command.CommandText = "dbo.Select_Products";
                if (id != null)
                {
                    command.Parameters.AddWithValue("Id", id);
                }
                else if (name != null)
                {
                    command.Parameters.AddWithValue("ProductName", name);
                }
                _connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    if (products == null)
                    {
                        products = new List<Product>();
                    }
                    Product product = new Product();
                    product.Id = reader.GetInt32("Id");
                    product.ProductName = reader.GetString("ProductName");
                    product.ProductImage = reader.GetString("ProductImage");
                    product.ProductDescription = reader.GetString("ProductDescription");
                    product.ProductPrice = reader.GetInt32("ProductPrice");
                    products.Add(product);
                }
                _connection.Close();

                return products;
            }
            
        }
        catch
        {
            if (_connection.State == ConnectionState.Open)
            {
                _connection.Close();
            }
            throw;
        }

    }

}
