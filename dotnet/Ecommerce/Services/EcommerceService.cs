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

    public int? InsertPurchase(PurchaseAddRequest request)
    {
        int? purchaseId = 0;

        if(request.PurchaseDetail.Count == 0)
        {
            throw new Exception("The purchase must include at least one product");
        }
        
        string detailString = JsonConvert.SerializeObject(request.PurchaseDetail);

        SqlParameter idParam = CreateIdParam();

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

    public int? InsertPurchaseV2(PurchaseAddRequestV2 request)
    {
        int? purchaseId = 0;

        if (request.PurchaseDetail.Count == 0)
        {
            throw new Exception("The purchase must include at least one product");
        }

        DataTable detail = MapPurchaseItemsToTable(request.PurchaseDetail);

        SqlParameter idParam = CreateIdParam();

        _databaseService.InsertData("dbo.Insert_PurchaseV2", (SqlParameterCollection paramCollection) =>
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

    public static SqlParameter CreateIdParam()
    {
        SqlParameter idParam = new SqlParameter();
        idParam.ParameterName = "Id";
        idParam.Value = 0;
        idParam.DbType = DbType.Int32;
        idParam.Direction = ParameterDirection.Output;
        return idParam;
    }

}
