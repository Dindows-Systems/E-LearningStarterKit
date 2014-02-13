using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Commerce.Common;

public partial class Modules_Products_RatingDisplay : System.Web.UI.UserControl
{
    private double initialRating;

    public double InitialRating
    {
        get { return initialRating; }
        set {
            initialRating = value;
            sr1.DisplayValue = initialRating;
        }
    }
    private int productID;

    public int ProductID
    {
        get { return productID; }
        set { productID = value; }
    }
	
	
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadUserProductRating();
        }
    }

    protected void Product_Rated(object sender, EventArgs e)
    {

        ProductRatingController.AddUserRating(Utility.GetUserName(), productID, sr1.Value);
        lblRateMessage.Text = Resources.Common.ThankYou;
    }
    void LoadUserProductRating()
    {

        int userRating = ProductRatingController.GetUserRating(Utility.GetUserName(), productID);
        if (userRating > -1)
        {
            lblRateMessage.Text = string.Format(Resources.Common.YouRated, userRating.ToString(), sr1.MaxValue.ToString());
            sr1.Value = userRating;

        }

    }
}
