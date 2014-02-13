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

public partial class Modules_Products_ProductModulos : System.Web.UI.UserControl
{
    public int productID;

    protected void Page_Load(object sender, EventArgs e)
    {
        //SqlDataSource1.FilterParameters.
        ProductoIdOculto.Value = productID.ToString();        
    }
   
}
