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
using WekeRoad.Tools;

/// <summary>
/// Controller for business logic relating to Products
/// </summary>
public static class ProductRatingController
{

    static int UserHasRating(string userName, int productID)
    {
        int iOut = 0;
        Query q = new Query(ProductRating.GetTableSchema());
        q.AddWhere("userName", userName);
        q.AddWhere("productID", productID);
        q.SelectList = "ratingID";
        q.Top = "1";

        object result = DBHelper.ExecuteScalar(q.BuildSelectCommand());
        if (result != null)
            iOut = (int)result;


        return iOut;
    }

    public static void AddUserRating(string userName, int productID, int rating)
    {
        int userRatingID = UserHasRating(userName, productID);
        ProductRating pr = null;
        if (userRatingID == 0)
        {
            //no rating
            pr = new ProductRating();
        }
        else
        {
            //they have a rating - update it
            pr = new ProductRating(userRatingID);
        }
        pr.ProductID = productID;
        pr.Rating = rating;
        pr.UserName = userName;
        pr.Save(Utility.GetUserName());
    }

    public static int GetUserRating(string userName, int productID)
    {
        int iOut = -1;
        ProductRating rating = new ProductRating();
        rating.UserName = Utility.GetUserName();
        rating.ProductID = productID;
        IDataReader rdr = ProductRating.Find(rating);
        ProductRatingCollection coll = new ProductRatingCollection();
        coll.Load(rdr);
        rdr.Close();
        if (coll.Count > 0)
        {
            iOut = coll[0].Rating;
        }
        return iOut;

    }


}
