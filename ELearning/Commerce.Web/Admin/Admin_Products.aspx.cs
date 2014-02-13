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
using System.Data.SqlClient;
using Commerce.Common;

public partial class Admin_Admin_Products : System.Web.UI.Page {


    protected void Page_Load(object sender, EventArgs e) {
       
        if (!Page.IsPostBack) {
            //LoadGrid();
        }

    }


    void LoadGrid() {


        DataSet ds = null;
        dg.DataSource = Commerce.Common.Product.FetchAll();
        dg.DataBind();
    }


}


