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

public partial class Modules_Products_FeedBackDisplay : System.Web.UI.UserControl
{

    private int productID;

    public int ProductID
    {
        get { return productID; }
        set { 
            productID = value;
            RatingDisplay1.ProductID = productID;
        }
    }
    private string productName;

    public string ProductName
    {
        get { return productName; }
        set { productName = value; }
    }
    public double InitialRating
    {
        set { RatingDisplay1.InitialRating = value; }
    }
	
    protected void Page_Load(object sender, EventArgs e)
    {

    }
}
