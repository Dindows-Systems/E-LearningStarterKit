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
using System.Data.Common;
using WekeRoad.Tools;

public partial class MyCourses : System.Web.UI.Page
{
    public Int32 cantidadProductosComprados = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        cantidadProductosComprados = ProductController.GetByOrderUserCount();
        rptCursosUsuario.DataSource = ProductController.GetByOrderUser();
        rptCursosUsuario.DataBind();

    }

    protected string getValidacionModulos(int productID)
    {
        //<a href="ModuloCurso.aspx?idProducto=<%#Eval("productID") %>">Detalle Curso</a>
        string resultado = "";

        Int32 cantidad = 0;

        Query q = new Query("csk_store_product_modulos");
        q.AddWhere("productID", productID.ToString());
        //q.AddAggregate("secuence", AggregateFunction.Count, "cantidad");
        IDataReader rdr = DBHelper.GetReader(q.BuildSelectCommand());

        if (rdr.Read())
            cantidad = 1;
        else
            cantidad = 0;

        rdr.Close();

        if (cantidad == 0)
            resultado = "&nbsp;";
        else
            resultado = "<a href=\"ModuloCurso.aspx?idProducto=" + productID .ToString()+ "\">Detalle Curso</a>";


        return resultado;
    }

}
