using System.Data;
using Ecommerce.Models;
using Newtonsoft.Json;
using Microsoft.Data.SqlClient;

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

        DataTable detail = MapPurchaseItemsToTable(request.PurchaseDetail);

        SqlParameter idParam = CreateOutputParam("Id", DbType.Int32, 0, 5);

        _databaseService.HandleData("dbo.Insert_PurchaseV2", (SqlParameterCollection paramCollection) =>
        {
            paramCollection.AddWithValue("UserId", request.UserId);
            paramCollection.AddWithValue("TimeOfPurchase", request.TimeOfPurchase);
            paramCollection.AddWithValue("PurchaseDetail", detail);
            paramCollection.AddWithValue("PurchaseTotal", request.PurchaseTotal);
            paramCollection.Add(idParam);
        }, (SqlParameterCollection returnedParameters) => {
            purchaseId = (int?)returnedParameters["Id"].Value;
        });
        
        return purchaseId;
    }

    public List<ProductV2>? GetProductsV2(int? id, string? name)
    {
        List<ProductV2>? products = null;

        _databaseService.SelectData("dbo.Select_ProductsV2", (SqlParameterCollection collection) => {
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

    public object RegisterUser(UserCreateAddRequest user)
    {

        object responseMessage = "";
        SqlParameter responseMessageParam = CreateOutputParam("@ResponseMessage", DbType.String, "", 4000);
        _databaseService.HandleData(
        "dbo.Insert_User",
        (SqlParameterCollection col) => {
            col.AddWithValue("@UserName", user.UserName);
            col.AddWithValue("@Password", user.Password);
            col.AddWithValue("@UserRole", user.UserRole);
            col.Add(responseMessageParam);
        }, (SqlParameterCollection returnCol) =>
        {
            responseMessage = returnCol["@ResponseMessage"].Value;
        }
        );
        return responseMessage;
    }

    public UserLoginReturnValue LoginUser(UserLoginAddRequest user)
    {
        string responseMessage = string.Empty;
        string sessionToken = string.Empty;
        SqlParameter responseMessageParam = CreateOutputParam("@ResponseMessage", DbType.String, "", 4000);
        SqlParameter sessionTokenParam = CreateOutputParam("@SessionToken", DbType.String, string.Empty, 4000);
        _databaseService.HandleData("dbo.Login_User",
            (SqlParameterCollection col) => {
                col.AddWithValue("@UserName", user.UserName);
                col.AddWithValue("@Password", user.Password);
                col.Add(sessionTokenParam);
                col.Add(responseMessageParam);
            },
            (SqlParameterCollection returncol) =>
            {
                responseMessage = returncol["@ResponseMessage"].Value.ToString()!;
                sessionToken = returncol["@SessionToken"].Value.ToString()!;
            });
        return new UserLoginReturnValue() {
                                                Message = responseMessage,
                                                SessionToken = sessionToken
                                          };
    }

    public string LogoutUser(UserLogoutAddRequest user)
    {
        if(user.SessionToken == null || user.SessionToken == string.Empty)
        {
            return "No user logged in";
        }
        string responseMessage = string.Empty;
        Guid sessionToken = Guid.Empty; 
        Guid.TryParse(user.SessionToken, out sessionToken);
        SqlParameter responseMessageParam = CreateOutputParam("@ResponseMessage", DbType.String, string.Empty, 4000);
        _databaseService.HandleData(
            "dbo.Logout_User",
            (SqlParameterCollection col) =>
            {
                col.AddWithValue("@UserName", user.UserName);
                col.AddWithValue("@SessionToken", sessionToken);
                col.Add(responseMessageParam);
            },
            (SqlParameterCollection returnCol) =>
            {
                responseMessage = returnCol["@ResponseMessage"].Value.ToString()!;
            }
        );
        return responseMessage;
    }

    public static DataTable MapPurchaseItemsToTable(List<PurchaseItemV2> items)
    {
        DataTable detail = new DataTable();
        detail.Columns.Add("ProductId", typeof(int));
        detail.Columns.Add("Amount", typeof(int));
        detail.Columns.Add("Price", typeof(double));

        foreach (PurchaseItemV2 item in items)
        {
            DataRow row = detail.NewRow();
            int index = 0;
            row[index++] = item.ProductId;
            row[index++] = item.Amount;
            row[index++] = item.Price;
            detail.Rows.Add(row);
        }

        return detail;
    }

    public static SqlParameter CreateOutputParam(string parameterName, DbType parameterType, object value, int size)
    {
        SqlParameter outputParam = new SqlParameter();
        outputParam.ParameterName = parameterName;
        outputParam.Value = value;
        outputParam.DbType = parameterType;
        outputParam.Direction = ParameterDirection.Output;
        outputParam.Size = size;
        return outputParam;
    }

}
