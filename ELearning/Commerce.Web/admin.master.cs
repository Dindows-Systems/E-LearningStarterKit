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

public partial class adminmaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        HyperLink1.Visible = false;
        HyperLink1.EnableViewState = false;
    }

    protected void cargarAdminPlaceHolder(object sender, EventArgs e)
    {        
        //HyperLink1.Visible = false;
    }

}
