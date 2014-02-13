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
using Commerce.Providers;

public partial class Modules_RecentProductsViewed : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //rptRecentProds.DataSource = Profile.RecentlyViewedProducts;
            //rptRecentProds.DataBind();
        }
    }
    public int GetCount()
    {
        return Profile.RecentlyViewedProducts.Count; 
    }
    protected string GetImagePath(object img)
    {
        string sOut = "";
        if (img != null)
            sOut= Page.ResolveUrl("~/"+img.ToString());
        return sOut;
    }

}
