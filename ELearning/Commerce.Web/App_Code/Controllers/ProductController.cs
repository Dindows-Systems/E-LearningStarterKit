using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Commerce.Common;
using WekeRoad.Tools;
using System.Collections;
using Microsoft.Practices.EnterpriseLibrary.Data;

/// <summary>
/// Overrides the Commerce.Common class to add some additional properties and methods
/// we want for the site.
/// </summary>
public static class ProductController{

    public static ProductCollection GetAll()
    {
        ProductCollection list = new ProductCollection();
        IDataReader rdr = Product.FetchAll();
        list.Load(rdr);
        rdr.Close();
        return list;
    }

    public static void SetProductDefaultImage(int productID,string imageFile)
    {
        Query q = new Query(Product.GetTableSchema());
        q.AddWhere("productID", productID);
        Hashtable updates = new Hashtable();
        updates.Add("defaultImage", imageFile);
        DBHelper.ExecuteQuery(q.BuildUpdateCommand(updates));

    }

    /// <summary>
    /// Executes "CSK_Store_Product_GetByCategoryID" and returns the results in an System.Data.IDataReader 
    /// </summary>
    /// <param name="categoryID">Value for the @categoryID parameter</param>
    /// <returns>ProductCollection</returns>	
    public static IDataReader GetByCategoryID(int categoryID)
    {

        Database db = DatabaseFactory.CreateDatabase();
        //ProductCollection list = new ProductCollection();
        //specify the SP
        string cmd = "CSK_Store_Product_GetByCategoryID";
        IDataReader rdr = null; 
        using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
        {

            db.AddInParameter(dbCommand, "@categoryID", DbType.Int32, categoryID);
            //load routine closes the reader if flag is set to true;
            //list.Load(db.ExecuteReader(dbCommand));
            rdr= db.ExecuteReader(dbCommand);
        }

        return rdr;
    }
    public static IDataReader GetByManufacturerID(int categoryID, int manufacturerID)
    {
        Database db = DatabaseFactory.CreateDatabase();
        //ProductCollection list = new ProductCollection();
        IDataReader rdr = null;
        string cmd = "CSK_Store_Product_GetByManufacturerID";
        using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
        {
            db.AddInParameter(dbCommand, "@manufacturerID", DbType.Int32, manufacturerID);
            db.AddInParameter(dbCommand, "@categoryID", DbType.Int32, categoryID);

            //Load the reader
            //list.Load(db.ExecuteReader(dbCommand));
            rdr = db.ExecuteReader(dbCommand);
        }
        return rdr;
    }
    public static IDataReader GetByPriceRange(int categoryID, decimal priceLow, decimal priceHigh)
    {
        Database db = DatabaseFactory.CreateDatabase();
        IDataReader rdr = null;
        string cmd = "CSK_Store_Product_GetByPriceRange";
        using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
        {
            db.AddInParameter(dbCommand, "@categoryID", DbType.Int32, categoryID);
            db.AddInParameter(dbCommand, "@priceStart", DbType.Currency, priceLow);
            db.AddInParameter(dbCommand, "@priceEnd", DbType.Currency, priceHigh);

            //Load the reader
            rdr = db.ExecuteReader(dbCommand);
        }
        return rdr;
    }
    public static ProductReviewCollection GetByProductAndAuthor(int productID,string author)
    {
        ProductReviewCollection list = new ProductReviewCollection();
        Query q = new Query(ProductReview.GetTableSchema());
        q.AddWhere("productID", productID);
        q.AddWhere("Authorname", author);
        list.Load(DBHelper.GetReader(q.BuildSelectCommand()));
        return list;
    }

    public static ProductDescriptorCollection GetDescriptors(int productID)
    {
        ProductDescriptorCollection list = new ProductDescriptorCollection();
        IDataReader rdr = ProductDescriptor.FetchByParameter("productID", productID);
        list.Load(rdr);

        return list;
    }
    //attribute XML updater
    public static void UpdateProductAttributes(int productID, Commerce.Common.Attributes atts)
    {
        Commerce.Common.Product prod = new Commerce.Common.Product(productID);
        prod.Attributes = atts;
        prod.Save(Commerce.Common.Utility.GetUserName());
    }
    
    public static void RemoveFromCategory(int productID, int categoryID){
        Product.DeleteManyToManyRecord("CSK_Store_Product_Category_Map", "productID", "categoryID", productID, categoryID);
        
    }

    public static void AddToCategory(int productID, int categoryID)
    {
        Product.SaveManyToManyRecord("CSK_Store_Product_Category_Map", "productID", "categoryID", productID, categoryID);

    }

    public static ImageCollection GetImages(int productID)
    {
        ImageCollection list = new ImageCollection();
        IDataReader rdr = Commerce.Common.Image.FetchByParameter("productID", productID);
        list.Load(rdr);
        return list;
    }
    public static Product GetProduct(int productID){

        //load up the product
        Product product=Product.FetchByID(productID);

        //set the image
        Query q = new Query(Commerce.Common.Image.GetTableSchema());
        q.AddWhere("productID", productID);
        q.Top = "1";
        q.SelectList = "imageFile";

        string imgFile = DBHelper.ExecuteScalar(q.BuildSelectCommand()).ToString();
        product.ImageFile = imgFile;
        return product;

    }
    static void LoadByDataSet(Product product,DataSet ds)
    {

        //load up the product
        if (ds.Tables[0].Rows.Count > 0)
            product.Load(ds.Tables[0].Rows[0]);

        // and each of the child collections
        //load the collections
        product.Images = new ImageCollection();
        product.Images.Load(ds.Tables[1]);

        if (product.Images.Count > 0)
            product.ImageFile = product.Images[0].ImageFile;

        //reviews
        product.Reviews = new ProductReviewCollection();
        product.Reviews.Load(ds.Tables[2]);


        //descriptors
        product.Descriptors = new ProductDescriptorCollection();
        product.Descriptors.Load(ds.Tables[3]);


    }
    
    public static Commerce.Common.Product GetProductDeep(string sku){
        //load up the product using a multi-return DataSte
        int productID = 0;
        Query q = new Query(Product.GetTableSchema());
        q.AddWhere("sku", sku);

        productID = (int)DBHelper.ExecuteScalar(q.BuildSelectCommand());
        return GetProductDeep(productID);
    }

    public static DataSet GetPostAddPage()
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand cmd = db.GetStoredProcCommand("CSK_Store_Product_GetPostAddMulti");
        db.AddInParameter(cmd, "@userName", DbType.String, Utility.GetUserName());

        return DBHelper.GetDataSet(cmd);
        
    }

    public static Commerce.Common.Product GetProductDeep(int productID)
    {
        //load up the product using a multi-return DataSet
        //for performance, queue up the 4 SQL calls into one
        string sql = "";
        
        //Product Main Info
        Query q = new Query(Product.GetTableSchema());
        q.AddWhere("productID", productID);
        
        //append
        sql += q.GetSelectSql()+";\r\n";

        //Images
        q = new Query(Commerce.Common.Image.GetTableSchema());
        q.AddWhere("productID", productID);

        //append
        sql += q.GetSelectSql() + ";\r\n";

        //Reviews
        q = new Query(ProductReview.GetTableSchema());
        q.AddWhere("productID", productID);
        q.AddWhere("isApproved", true);

        //append
        sql += q.GetSelectSql() + ";\r\n";


        //Descriptors
        q = new Query(ProductDescriptor.GetTableSchema());
        q.AddWhere("productID", productID);

        //append
        sql += q.GetSelectSql() + ";\r\n";

        
        //Build the Command
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand cmd = db.GetSqlStringCommand(sql);
        db.AddInParameter(cmd, "@productID", DbType.Int32, productID);

        //parameter for Reviews
        db.AddInParameter(cmd, "@isApproved", DbType.Boolean, true);

        DataSet ds = db.ExecuteDataSet(cmd); ;
        
        
        Product product = new Product();
        LoadByDataSet(product, ds);
        return product;
    }  
    /// <summary>
    /// This is a semi-smart query that will sort your returns based on word count 
    /// </summary>
    /// <param name="descriptionLength">How long the resulting product description will be</param>
    /// <param name="AllWords">Whether to use all the words in the query, or just the blob</param>

    /// <returns>System.Data.IDataReader</returns>	
    public static IDataReader RunSmartSearch(int descriptionLength,
        string query)
    {

        bool AllWords = true;
        //thanks to Moody for this routine
        //Define the parameters
        int howManyWords = 5;//words which is allowed to take from search text box you can enter to 5 words
        string[] queryparam = new string[howManyWords]; //array to containe the words entered in search text box
        char[] wordSeparators = new char[] { ',', ';', ',', '.', '!', ',', '?', '-', ' ' };//char elemnets is used when to seperat the entered query
        string[] words = query.Split(wordSeparators, StringSplitOptions.RemoveEmptyEntries);
        int index = 1;
        for (int i = 0; i <= words.GetUpperBound(0) && index <= howManyWords; i++)
        {

            //check to see if you entered more than one words
            if (words[i].Length > 2)
            {
                queryparam[i] = words[i];
            }
            index++;
        }
        int bitNum;
        if (AllWords == true) { bitNum = 1; }
        else { bitNum = 0; }



        //load the default db from the base class
        Database db = DatabaseFactory.CreateDatabase();
        //specify the SP
        string cmd = "CSK_Store_Product_SmartSearch";
        using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
        {

            db.AddInParameter(dbCommand, "@DescriptionLength", DbType.Int32, descriptionLength);
            db.AddInParameter(dbCommand, "@AllWords", DbType.Byte, AllWords);
            db.AddInParameter(dbCommand, "@Word1", DbType.String, queryparam[0]);
            db.AddInParameter(dbCommand, "@Word2", DbType.String, queryparam[1]);
            db.AddInParameter(dbCommand, "@Word3", DbType.String, queryparam[2]);
            db.AddInParameter(dbCommand, "@Word4", DbType.String, queryparam[3]);
            db.AddInParameter(dbCommand, "@Word5", DbType.String, queryparam[4]);
            //return a reader using the Ent Blocks
            return db.ExecuteReader(dbCommand);
        }
    }
    /// <summary>
    /// Removes all information from the DB about this product
    /// including all reviews, review feedback, cross-sells, etc.
    /// Does NOT remove any products from checked-out orders, however
    /// all deleted products will be removed from non-checked out carts
    /// </summary>
    /// <param name="productID"></param>
    public static new void DeletePermanent(int productID){
        
        //change as needed
        //currently just removes the product from the DB
        //load the default db from the base class
        Database db = DatabaseFactory.CreateDatabase();
        string cmd = "CSK_Store_Product_DeletePermanent";
        using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
        {

            db.AddInParameter(dbCommand, "@productID", DbType.Int32, productID);
            //return a reader using the Ent Blocks
            db.ExecuteNonQuery(dbCommand);
        }


       
    }
 
    public static IDataReader GetMostPopular()
    {

        DbCommand dbCommand = null;
        IDataReader rdr;
        try
        {
            //load the default db from the base class
            Database db = DatabaseFactory.CreateDatabase();
            //specify the SP
            string cmd = "CSK_Store_Product_GetMostPopular";
            using (dbCommand = db.GetStoredProcCommand(cmd))
            {


                //return a reader using the Ent Blocks
                rdr = db.ExecuteReader(dbCommand);
                //load routine closes the reader if flag is set to true;
            }
        }
        finally
        {
            dbCommand.Dispose();
        }
        return rdr;
    }

    /*
     * Creado por Alex Armijos
     */
    public static IDataReader GetByOrderUser()
    {
        String usuario = Utility.GetUserName();

        Database db = DatabaseFactory.CreateDatabase();
        //ProductCollection list = new ProductCollection();
        //specify the SP
        string cmd = "CSK_Store_Product_GetByOrderUser";
        IDataReader rdr = null;
        using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
        {

            db.AddInParameter(dbCommand, "@user", DbType.String, usuario);
            //load routine closes the reader if flag is set to true;
            //list.Load(db.ExecuteReader(dbCommand));
            rdr = db.ExecuteReader(dbCommand);
        }

        return rdr;

    }

    public static Int32 GetByOrderUserCount()
    {
        String usuario = Utility.GetUserName();
        Int32 cantidad = 0;
        Database db = DatabaseFactory.CreateDatabase();
        //ProductCollection list = new ProductCollection();
        //specify the SP
        string cmd = "CSK_Store_Product_GetByOrderUserCount";
        IDataReader rdr = null;
        using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
        {

            db.AddInParameter(dbCommand, "@user", DbType.String, usuario);
            //load routine closes the reader if flag is set to true;
            //list.Load(db.ExecuteReader(dbCommand));
            rdr = db.ExecuteReader(dbCommand);
            if (rdr.Read())
            {
                cantidad = rdr.GetInt32(0);
            }
            else
            {
                cantidad = 0;
            }

        }

        return cantidad;

    }

    public static Int32 GetCantidadProductComprado(int productID)
    {
        String usuario = Utility.GetUserName();
        Int32 cantidad = 0;
        Database db = DatabaseFactory.CreateDatabase();
        //ProductCollection list = new ProductCollection();
        //specify the SP
        string cmd = "CSK_Store_Product_Comprados";
        IDataReader rdr = null;
        using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
        {

            db.AddInParameter(dbCommand, "@user", DbType.String, usuario);
            db.AddInParameter(dbCommand, "@product_id", DbType.Int32, productID);
            //load routine closes the reader if flag is set to true;
            //list.Load(db.ExecuteReader(dbCommand));
            rdr = db.ExecuteReader(dbCommand);
            if (rdr.Read())
            {
                cantidad = rdr.GetInt32(0);
            }
            else
            {
                cantidad = 0;
            }

        }

        return cantidad;

    }

    public static Int32 GetCantidadModulos(int productID)
    {

        Int32 cantidad = 0;
        Database db = DatabaseFactory.CreateDatabase();
        //ProductCollection list = new ProductCollection();
        //specify the SP
        string cmd = "CSK_Store_Product_Modulos_GetCantidad";
        IDataReader rdr = null;
        using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
        {

            db.AddInParameter(dbCommand, "@product_id", DbType.Int32, productID);
            //load routine closes the reader if flag is set to true;
            //list.Load(db.ExecuteReader(dbCommand));
            rdr = db.ExecuteReader(dbCommand);
            if (rdr.Read())
            {
                cantidad = rdr.GetInt32(0);
            }
            else
            {
                cantidad = 0;
            }

        }

        return cantidad;

    }

    public static Int32 GetCountProductosCarritoCompradosDigitales(int orderID)
    {
        String usuario = Utility.GetUserName();

        Int32 cantidad = 0;
        Database db = DatabaseFactory.CreateDatabase();
        //ProductCollection list = new ProductCollection();
        //specify the SP
        string cmd = "CSK_Store_Product_Digitales_Comprados_Carrito";
        IDataReader rdr = null;
        using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
        {

            db.AddInParameter(dbCommand, "@orderID", DbType.Int32, orderID);
            db.AddInParameter(dbCommand, "@usuario", DbType.String, usuario);
            db.AddInParameter(dbCommand, "@opcion", DbType.String, "1");
            //load routine closes the reader if flag is set to true;
            //list.Load(db.ExecuteReader(dbCommand));
            rdr = db.ExecuteReader(dbCommand);
            if (rdr.Read())
            {
                cantidad = rdr.GetInt32(0);
            }
            else
            {
                cantidad = 0;
            }

        }

        return cantidad;

    }

    public static IDataReader GetProductosCarritoCompradosDigitales(int orderID)
    {
        String usuario = Utility.GetUserName();

        Int32 cantidad = 0;
        Database db = DatabaseFactory.CreateDatabase();
        //ProductCollection list = new ProductCollection();
        //specify the SP
        string cmd = "CSK_Store_Product_Digitales_Comprados_Carrito";
        IDataReader rdr = null;
        using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
        {
            db.AddInParameter(dbCommand, "@orderID", DbType.Int32, orderID);
            db.AddInParameter(dbCommand, "@usuario", DbType.String, usuario);
            db.AddInParameter(dbCommand, "@opcion", DbType.String, "2");
            //load routine closes the reader if flag is set to true;
            //list.Load(db.ExecuteReader(dbCommand));
            rdr = db.ExecuteReader(dbCommand);
        }

        return rdr;

    }

    public static IDataReader GetProductosCompradosAgrupdos()
    {
        String usuario = Utility.GetUserName();

        
        Database db = DatabaseFactory.CreateDatabase();
        
        //ProductCollection list = new ProductCollection();
        //specify the SP
        string cmd = "CSK_Elearning_Productos_Comprados";
        IDataReader rdr = null;
        using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
        {            
            db.AddInParameter(dbCommand, "@usuario", DbType.String, usuario);
            db.AddInParameter(dbCommand, "@opcion", DbType.String, "1");
            
            //load routine closes the reader if flag is set to true;
            //list.Load(db.ExecuteReader(dbCommand));
            rdr = db.ExecuteReader(dbCommand);
        }

        return rdr;

    }

    public static Int32 GetCantidadProductosCompradosAgrupdos()
    {
        String usuario = Utility.GetUserName();

        Int32 cantidad = 0;
        Database db = DatabaseFactory.CreateDatabase();
        //ProductCollection list = new ProductCollection();
        //specify the SP
        string cmd = "CSK_Elearning_Productos_Comprados";
        IDataReader rdr = null;
        using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
        {   
            db.AddInParameter(dbCommand, "@usuario", DbType.String, usuario);
            db.AddInParameter(dbCommand, "@opcion", DbType.String, "2");
            //load routine closes the reader if flag is set to true;
            //list.Load(db.ExecuteReader(dbCommand));
            rdr = db.ExecuteReader(dbCommand);
            if (rdr.Read())
            {
                cantidad = rdr.GetInt32(0);
            }
            else
            {
                cantidad = 0;
            }

        }

        return cantidad;
    }

}


