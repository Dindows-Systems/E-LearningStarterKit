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

public partial class MisExamenesYResultados : System.Web.UI.Page
{
    protected Boolean hayCursosComprados = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        hayCursosComprados = ProductController.GetCantidadProductosCompradosAgrupdos() > 0;
        rptCursosCompradosAgrupados.DataSource = ProductController.GetProductosCompradosAgrupdos();
        rptCursosCompradosAgrupados.DataBind();
    }
}
