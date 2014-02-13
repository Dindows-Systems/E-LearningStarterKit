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
using Commerce.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;

public partial class Modules_Admin_ProductModulos : System.Web.UI.UserControl
{
    private int productID;

    public int ProductID
    {
        get
        {

            return productID;
        }
        set
        {

            productID = value;
        }
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        productID = Utility.GetIntParameter("id");
        //this.EnableViewState = false;
    }
    /*
    protected void Button1_Click(object sender, EventArgs e)
    {
       

        string cmd = "CSK_Store_Product_Modulo_Insert";
       
        Database db = DatabaseFactory.CreateDatabase();
      
        using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
        {
            db.AddInParameter(dbCommand, "@productID", DbType.Int32, productID);
            db.AddInParameter(dbCommand, "@nombre", DbType.String, TextoNombre.Text);
            db.AddInParameter(dbCommand, "@descripcion", DbType.String, TextoDescripcion.Text);
            db.AddInParameter(dbCommand, "@ruta_descarga", DbType.String, TextoRutaDescarga.Text);
            db.AddInParameter(dbCommand, "@ruta_reproduccion", DbType.String, TextoRutaReproduccion.Text);

            db.ExecuteNonQuery(dbCommand);
            
            //db.ExecuteReader(dbCommand);
            
            //Load the reader
            //list.Load(db.ExecuteReader(dbCommand));
            //rdr = db.ExecuteReader(dbCommand);
        }
        TablaGrabarModulo.Visible = false;
        Mensaje.Text = "Grabacion Exitosa";
        Mensaje.Visible = true;
        //GridModulos.r
       // Render();
        //SqlDataSource1.DataBind();
    }
    protected void Agregar_Click(object sender, EventArgs e)
    {
        TablaGrabarModulo.Visible = true;
    }*/
}
