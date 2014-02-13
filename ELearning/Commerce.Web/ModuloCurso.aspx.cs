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
using System.Data.Common;

public partial class ModuloCurso : System.Web.UI.Page
{
    public bool existenModulos = false;
    protected String rutaDescargar = "";
    protected String rutaReproducir = "";
    protected String rutas = "";
    public string urlImagen = "";

    protected IDataReader lista = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        string codigoProducto = Request.QueryString["idProducto"];

        Query q = new Query("csk_store_product");
        q.AddWhere("productID", codigoProducto);
        IDataReader rdr = DBHelper.GetReader(q.BuildSelectCommand());
        rptProducto.DataSource = rdr;
        rptProducto.DataBind();
        rdr.Close();

        q = new Query("csk_store_image");
        q.AddWhere("productID", codigoProducto);
        q.OrderBy = OrderBy.Asc("listOrder");
        q.Top="1";
        rdr = DBHelper.GetReader(q.BuildSelectCommand());
        if (rdr.Read()){
            urlImagen=rdr.GetString(rdr.GetOrdinal("imageFile"));          
        }
        rdr.Close();
        
        q = new Query("csk_store_product_modulos");
        
        q.AddWhere("productID", codigoProducto);
        lista = DBHelper.GetReader(q.BuildSelectCommand());

        

        existenModulos = true;
        /*rptModuloCursos.DataSource = rdr;
        rptModuloCursos.DataBind();
        rdr.Close();*/
       
    }

    
    protected void leerRutasArchivos(object source, RepeaterItemEventArgs e)
    {
       // ruta_descargar ruta_reproducir
        DbDataRecord unItem = (DbDataRecord)e.Item.DataItem;
        /*int ordinal = unItem.GetOrdinal("preguntaID");
        Int32 preguntaId =unItem.GetInt32(ordinal);*/

        int ordinal = unItem.GetOrdinal("ruta_descargar");
        
        String auxiliar = null;

        if (!unItem.IsDBNull(ordinal))
            rutaDescargar = unItem.GetString(ordinal);

        ordinal = unItem.GetOrdinal("ruta_reproducir");

        if (!unItem.IsDBNull(ordinal))
            rutaReproducir = unItem.GetString(ordinal);

        /*
        if (unItem.GetString(ordinal) != null)
            auxiliar = unItem.GetString(ordinal);

        if (auxiliar!=null&&auxiliar.Length>0){rutaDescargar=auxiliar;};

        ordinal = unItem.GetOrdinal("ruta_reproducir");

        if (unItem.GetString(ordinal) != null)
            auxiliar = unItem.GetString(ordinal);

        if (auxiliar != null && auxiliar.Length > 0) { rutaReproducir = auxiliar; };
        */
        rutas = "";

        if (rutaDescargar != null && rutaDescargar.Length > 0) {
            rutas = "<a href='" + rutaDescargar + "'><img src='images/icons/event_next.gif' alt='Descargar Curso' /></a>";        
        }

        if (rutaDescargar != null && rutaDescargar.Length > 0 && rutaReproducir != null && rutaReproducir.Length > 0)
        {
            rutas = rutas + "&nbsp;<img src='images/icons/separador.gif' alt=''/>&nbsp;";        
        }

        if (rutaDescargar != null && rutaDescargar.Length > 0) {
            rutas = rutas + "<a href='javascript:reproducirVideo('" + rutaReproducir + "');'><img src='images/icons/lrun_obj.gif' alt='Reproducir Curso' /></a>";
        }

        /*
        rutas = "<a href='" + rutaDescargar + "'><img src='images/icons/event_next.gif' alt='Descargar Curso' /></a>"
                + "&nbsp;<img src='images/icons/separador.gif' alt=''/>&nbsp;"
                + "<a href='javascript:reproducirVideo('" + rutaReproducir + "');'><img src='images/icons/lrun_obj.gif' alt='Reproducir Curso' /></a>";
        
        */
        
          
         // <a href="<%#Eval("ruta_descargar") %>"><img src="images/icons/event_next.gif" alt="Descargar Curso" /></a>
             //           &nbsp;<img src="images/icons/separador.gif" alt=""/>&nbsp;
         //               <a href="javascript:reproducirVideo('<%#Eval("ruta_reproducir") %>');"><img src="images/icons/lrun_obj.gif" alt="Reproducir Curso" /></a>
         //

    }
    
}
