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
using Commerce.Stats;
using System.Threading;

public partial class site : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //btnSearch.Attributes.Add("onclick", "location.href="+Page.ResolveUrl("~/search.aspx")+"?q='+txtSearch.value");

        if (!Page.IsPostBack)
        {
            Head1.Controls.Add(new LiteralControl("<script type='text/javascript' src='" + Page.ResolveUrl("~/js/modal/common.js") + "'></script>"));
            Head1.Controls.Add(new LiteralControl("<script type='text/javascript' src='" + Page.ResolveUrl("~/js/modal/subModal.js") + "'></script>"));
        }
    }


    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        //forget the user
        if (Request.Cookies["shopperID"] != null)
        {
            Request.Cookies["shopperID"].Expires = DateTime.Now.AddDays(-1d);
            Response.Cookies["shopperID"].Value = "";
            Response.Cookies.Add(Request.Cookies["shopperID"]);
        }        
        //Log it
        Tracker.Add(BehaviorType.LoggingOut);
        FormsAuthentication.SignOut();
		Response.Redirect("default.aspx");
    }


    public void SynchMyCart()
    {
        if (Page.User.Identity.IsAuthenticated)
        {
            //synch the basket items
        }
    }
    protected string GetItemCount()
    {
        string sOut = "0";
        sOut = OrderController.GetCartItemCount().ToString();
        return sOut;
    }
    protected bool ShowBasket()
    {
        bool bOut = true;
        if (!Thread.CurrentPrincipal.Identity.IsAuthenticated)
            bOut = false;
        /*
        if (Profile.CurrentOrder != null)
        {
            if (Profile.CurrentOrder.Items != null)
            {
                bOut = true;
            }
        }
         * */
        return bOut;
    }

    protected void QuickLogin_LoginError(object sender, EventArgs e)
    {
        Response.Redirect("~/Login.aspx?ComeFromErrorLogin=true");
    }
}
