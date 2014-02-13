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
using WekeRoad.Tools;
using Commerce.Common;

public partial class examenes_mostrarUltimoResultado : System.Web.UI.Page
{

    protected string nombreProducto = "";
    protected string fechaExamen = "";
    protected string totalPreguntas = "";
    protected string correctas = "";
    protected string incorrectas = "";
    protected string puntajeTotal = "";

    protected Boolean haRendidoExamen = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        string productid=Request.QueryString["productId"];

        nombreProducto=ProductController.GetProduct(Int32.Parse(productid)).ProductName;
        
        Query q = new Query("elearning_examen_rendido");
        q.AddWhere("productID", productid);
        q.AddWhere("userName", Utility.GetUserName());

        IDataReader data=DBHelper.GetReader(q.BuildSelectCommand());

        while (data.Read())
        {
            haRendidoExamen = true;
            totalPreguntas = data.GetInt32(data.GetOrdinal("totalPreguntas")).ToString();
            correctas = data.GetInt32(data.GetOrdinal("totalRespuestasCorrectas")).ToString();
            incorrectas = data.GetInt32(data.GetOrdinal("totalRespuestasIncorrectas")).ToString();
            puntajeTotal = data.GetDecimal(data.GetOrdinal("puntajeTotal")).ToString();
            DateTime fecha = data.GetDateTime(data.GetOrdinal("fecha_actualizacion"));
            fechaExamen = fecha.ToString();
        }

    }
}
