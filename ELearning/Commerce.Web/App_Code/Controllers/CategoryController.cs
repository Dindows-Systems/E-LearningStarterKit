using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Commerce.Common;
using System.Collections.Generic;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;
using WekeRoad.Tools;

/// <summary>
/// Summary description for SiteCategory
/// </summary>
public static class CategoryController
{
    private static CategoryCollection catList;

    public static CategoryCollection CategoryList
    {
        get { return catList; }
        set { catList = value; }
    }
	
    public static void Load()
    {
        catList = new CategoryCollection();
        IDataReader rdr = Category.FetchAll();
        catList.Load(rdr);
        rdr.Close();
    }

    public static Category Find(int categoryID)
    {
        Category cOut = null;
        foreach (Category cat in catList)
        {
            if (cat.CategoryID == categoryID)
            {
                cOut = cat;
                break;
            }
        }
        return cOut;
    }
    public static Category FindByName(string categoryName)
    {
        Category cOut = null;
        foreach (Category cat in catList)
        {
            if (cat.CategoryName.ToLower().Equals(categoryName))
            {
                cOut = cat;
                break;
            }
        }
        return cOut;
    }

    /// <summary>
    /// Returns all categories in a dataset; used by the
    /// menuing controls
    /// </summary>
    /// <returns></returns>
    public static DataSet GetDataSetList()
    {
        Query q = new Query(Category.GetTableSchema());
        return DBHelper.GetDataSet(q.BuildSelectCommand());
    }

    public static CategoryCollection GetByProductID(int productID)
    {
        Query q = new Query(Category.GetTableSchema());
        q.AddWhere("CSK_Store_Product_Category_Map", "productID", productID);
        q.AddInnerJoin("CSK_Store_Product_Category_Map");
        CategoryCollection list = new CategoryCollection();
        list.Load(DBHelper.GetReader(q.BuildSelectCommand()));
        return list;
    }

    /// <summary>
    /// Executes "CSK_Store_Category_GetPageByNameMulti" and returns the results in a multi-result DataSet 
    /// </summary>
    /// <returns>System.Data.DataSet</returns>	
    public static DataSet GetPageByName(string categoryName)
    {
        DataSet ds = null;
        Database db = DatabaseFactory.CreateDatabase();
        //specify the SP
        string cmd = "CSK_Store_Category_GetPageByNameMulti";
        using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
        {
            db.AddInParameter(dbCommand, "@categoryName", DbType.String, categoryName);


            ds = db.ExecuteDataSet(dbCommand);
        }

        return ds;
    }
    /// <summary>
    /// Executes "CSK_Store_Category_GetPageMulti" and returns the results in a multi-result DataSet 
    /// </summary>
    /// <returns>System.Data.DataSet</returns>	
    public static DataSet GetPageByID(int categoryID)
    {
        DataSet ds = null;
        Database db = DatabaseFactory.CreateDatabase();
        //specify the SP
        string cmd = "CSK_Store_Category_GetPageMulti";
        using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
        {
            db.AddInParameter(dbCommand, "@categoryID", DbType.Int32, categoryID);
            ds = db.ExecuteDataSet(dbCommand);
        }

        return ds;
    }
}
