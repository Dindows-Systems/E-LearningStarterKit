using System;
using System.Data;
using System.Data.Common;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using WekeRoad.Tools;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Commerce.Common;

public partial class examenes_RendirExamen : System.Web.UI.Page
{

    int cantidad = 0;
    protected int productoId = 0;
    protected Boolean faltanPreguntas = false;
    protected string nombreProducto = "";

    protected void Page_Load(object sender, EventArgs e)
    {

        string codigoProducto = Request.QueryString["productId"];
        productoId = Int32.Parse(codigoProducto);
        string auxiliar = Request.Params.Get("rendirExamen");        

        int totalPreguntas=0;
        int correctas=0;
        int incorrectas=0;
        decimal totalPuntaje=0;
        

        Boolean vieneRendirExamen = auxiliar!=null && "1".Equals(auxiliar);

        nombreProducto = ProductController.GetProduct(productoId).ProductName;

        if (IsPostBack && vieneRendirExamen)
        {   
            Query q = new Query("elearning_preguntas");
            q.AddWhere("productID", productoId.ToString());
            q.AddWhere("estado", "1");

            IDataReader data=DBHelper.GetReader(q.BuildSelectCommand());

            while (data.Read())
            {
                totalPreguntas=totalPreguntas+1;
                string codigoPregunta = data.GetInt32(data.GetOrdinal("preguntaID")).ToString();                    
                   
                string valor = Request.Params.Get("examenPregunta" + codigoPregunta);

                if (valor == null)
                {
                    faltanPreguntas = true;
                    data.Close();
                    return;
                }

                /*VALIDAR QUE TODO ESTE INGRESADO*/
                q = new Query("elearning_opcion");
                q.AddWhere("productID", productoId.ToString());
                q.AddWhere("preguntaID", codigoPregunta);
                q.AddWhere("opcionID", valor);

                Boolean esRespuesta = true;
                q.AddWhere("esRespuesta", esRespuesta.ToString());
                q.AddAggregate("opcionID", AggregateFunction.Count, "cantidad");
                Int32 cantidadAuxiliar = (Int32)DBHelper.ExecuteScalar(q.BuildSelectCommand());

                if (cantidadAuxiliar > 0)
                    correctas++;
                else
                    incorrectas++;

            }

            data.Close();

            Database db = DatabaseFactory.CreateDatabase();

            using (DbCommand dbCommand = db.GetStoredProcCommand("CSK_Elearning_Guardar_Resultado_Examen"))
            {

                db.AddInParameter(dbCommand, "@usuario", DbType.String, Utility.GetUserName());
                db.AddInParameter(dbCommand, "@productID", DbType.String, productoId);
                db.AddInParameter(dbCommand, "@totalPreguntas", DbType.String, totalPreguntas);
                db.AddInParameter(dbCommand, "@totalRespuestasCorrectas", DbType.String, correctas);
                db.AddInParameter(dbCommand, "@totalRespuestasIncorrectas", DbType.String, incorrectas);                


                //load routine closes the reader if flag is set to true;
                //list.Load(db.ExecuteReader(dbCommand));
                db.ExecuteNonQuery(dbCommand);
            }

            //DBHelper.ExecuteInsertOrUpdate

            Response.Redirect("mostrarUltimoResultado.aspx?productId=" + productoId.ToString());
        }
        else
        {
           
            
            Query q = new Query("elearning_preguntas");
            q.AddWhere("productID", codigoProducto);
            q.AddWhere("estado", "1");

            IDataReader rdr = DBHelper.GetReader(q.BuildSelectCommand());

            rptPreguntas.DataSource = rdr;
            rptPreguntas.DataBind();

        }

    }
    /*
    protected void llenarOpciones(object source, RepeaterItemEventArgs e)
    {
       
        DbDataRecord unItem = (DbDataRecord)e.Item.DataItem;
        int ordinal = unItem.GetOrdinal("preguntaID");
        Int32 preguntaId =unItem.GetInt32(ordinal);

        Query q = new Query("elearning_opcion");
        q.AddWhere("productID", productoId.ToString());
        q.AddWhere("preguntaID", preguntaId.ToString());
        IDataReader rdr = DBHelper.GetReader(q.BuildSelectCommand());
        
        Repeater rptOpciones = (Repeater)e.Item.FindControl("rptOpciones");
        rptOpciones.DataSource = rdr;
        rptOpciones.DataBind();        
       
    }
    */

    protected IDataReader getOpciones(int preguntaId)
    {
        Query q = new Query("elearning_opcion");
        q.AddWhere("productID", productoId.ToString());
        q.AddWhere("preguntaID", preguntaId.ToString());
        IDataReader rdr = DBHelper.GetReader(q.BuildSelectCommand());

        return rdr;
    }
}
