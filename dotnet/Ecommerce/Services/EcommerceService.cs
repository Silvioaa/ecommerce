using System.Data;
using Ecommerce.Models;
using Newtonsoft.Json;
using Microsoft.Data.SqlClient;
using MySqlConnector;
using Microsoft.IdentityModel.Tokens;

namespace Ecommerce.Services;

public class EcommerceService
{
    private DatabaseService _databaseService;
    public EcommerceService(DatabaseService databaseService)
    {
        _databaseService = databaseService;
    }

    public int? InsertPurchaseV2(PurchaseAddRequestV2 request)
    {
        int? purchaseId = 0;

        if (request.PurchaseDetail.Count == 0)
        {
            throw new Exception("The purchase must include at least one product");
        }

        string detail = JsonConvert.SerializeObject(request.PurchaseDetail);

        MySqlParameter idParam = CreateOutputParam("Id", DbType.Int32, 0, 5);

        _databaseService.HandleData("ecom.Insert_Purchase", (MySqlParameterCollection paramCollection) =>
        {
            paramCollection.AddWithValue("UserId", request.UserId);
            paramCollection.AddWithValue("TimeOfPurchase", request.TimeOfPurchase);
            paramCollection.AddWithValue("PurchaseDetail", detail);
            paramCollection.AddWithValue("PurchaseTotal", request.PurchaseTotal);
            paramCollection.Add(idParam);
        }, (MySqlParameterCollection returnedParameters) => {
            purchaseId = (int?)returnedParameters["Id"].Value;
        });
        
        return purchaseId;
    }

    public List<ProductV2>? GetProductsV2(int? id, string? name)
    {
        List<ProductV2>? products = null;

        _databaseService.SelectData("ecom.Select_Products", (MySqlParameterCollection collection) => {
            if (id != null)
            {
                collection.AddWithValue("Id", id);
            }
            else
            {
                collection.AddWithValue("Id", null);
            }
            if (name != null)
            {
                collection.AddWithValue("ProductName", name);
            }
            else
            {
                collection.AddWithValue("ProductName", null);
            }
        }, (IDataReader reader) =>
        {
            if (products == null)
            {
                products = new List<ProductV2>();
            }
            ProductV2 product = new ProductV2();
            int index = 0;
            product.Id = reader.GetInt32(index++);
            product.ProductName = reader.GetString(index++);
            product.ProductImage = reader.GetString(index++);
            product.ProductDescription = reader.GetString(index++);
            product.ProductPrice = reader.GetDouble(index++);
            products.Add(product);
        });

        return products;
    }

    public string RegisterUser(UserCreateAddRequest user)
    {

        string responseMessage = "";
        MySqlParameter responseMessageParam = CreateOutputParam("@ResponseMessage", DbType.String, "", 4000);
        _databaseService.HandleData(
        "ecom.Insert_User",
        (MySqlParameterCollection col) => {
            col.AddWithValue("@UserName", user.UserName);
            col.AddWithValue("@Password", user.Password);
            col.AddWithValue("@UserRole", user.UserRole);
            col.Add(responseMessageParam);
        }, (MySqlParameterCollection returnCol) =>
        {
            object responseParameter = returnCol["@ResponseMessage"].Value!;
            responseMessage = responseParameter?.ToString() ?? "";
        }
        );
        return responseMessage;
    }

    public UserLoginReturnValue LoginUser(UserLoginAddRequest user)
    {
        string responseMessage = string.Empty;
        string sessionToken = user.SessionToken!;
        MySqlParameter responseMessageParam = CreateOutputParam("@ResponseMessage", DbType.String, "", 4000);
        MySqlParameter sessionTokenParam = CreateOutputParam("@SessionToken", DbType.String, user.SessionToken!, 4000, false);
        _databaseService.HandleData("ecom.Login_User",
            (MySqlParameterCollection col) => {
                col.AddWithValue("@UserName", user.UserName);
                col.AddWithValue("@Password", user.Password);
                col.Add(sessionTokenParam);
                col.Add(responseMessageParam);
            },
            (MySqlParameterCollection returncol) =>
            {
                responseMessage = returncol["@ResponseMessage"].Value!.ToString()!;
                sessionToken = returncol["@SessionToken"].Value.ToString()!;
            });
        return new UserLoginReturnValue() {
                                                Message = responseMessage,
                                                SessionToken = sessionToken
                                          };
    }

    public string LogoutUser(string sessionToken)
    {
        string responseMessage = string.Empty;
        MySqlParameter responseMessageParam = CreateOutputParam("@ResponseMessage", DbType.String, string.Empty, 4000);
        _databaseService.HandleData(
            "ecom.Logout_User",
            (MySqlParameterCollection col) =>
            {
                col.AddWithValue("@SessionToken", sessionToken);
                col.Add(responseMessageParam);
            },
            (MySqlParameterCollection returnCol) =>
            {
                responseMessage = returnCol["@ResponseMessage"].Value.ToString()!;
            }
        );
        return responseMessage;
    }

    public static MySqlParameter CreateOutputParam(string parameterName, DbType parameterType, object value, int size, bool outParameter = true)
    {
        MySqlParameter outputParam = new MySqlParameter();
        outputParam.ParameterName = parameterName;
        outputParam.Value = value;
        outputParam.DbType = parameterType;
        outputParam.Direction = outParameter ? ParameterDirection.Output : ParameterDirection.InputOutput;
        outputParam.Size = size;
        return outputParam;
    }

}
