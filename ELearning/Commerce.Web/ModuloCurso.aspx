<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="ModuloCurso.aspx.cs" Inherits="ModuloCurso" Title="M&oacute;dulos del Curso" %>
<%@ Import Namespace="System.Data.Common" %>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table style="width:750px;" border="0">
     <tr><td align="center">
    <div style="text-align: center">
        <h1>&nbsp;Producto</h1>       
        <asp:Repeater ID="rptProducto" runat="server" >
        <ItemTemplate>
           <table cellspacing="0" cellpadding="3"  border="1" style="width:80%;border-color:#999999;border-width:1px;border-style:None;border-collapse:collapse;border-right: gainsboro 1px solid;border-top: gainsboro 1px solid; font-size: 8pt; border-left: gainsboro 1px solid; border-bottom: gainsboro 1px solid; font-family: verdana" >
             <tr>
                <td colspan="2" bgcolor="#ADC9CF" class="cabeceraTabla" align="center"><%#Eval("productName") %></td>           
            </tr>
            <tr>
                <td style="width:20%"><img src="<%=urlImagen%>" height="50px" width="50px" alt="" /></td>
                <td style="width:80%" align="left"><%#Eval("shortDescription")%></td>
            </tr>
           </table>
       </ItemTemplate>
       </asp:Repeater>      
      
       <% if (existenModulos)
          {%>
       <h1>&nbsp;M&oacute;dulos del Producto</h1>
        <table cellspacing="0" cellpadding="3"  border="1" style="width:80%;border-color:#999999;border-width:1px;border-style:None;border-collapse:collapse;border-right: gainsboro 1px solid;border-top: gainsboro 1px solid; font-size: 8pt; border-left: gainsboro 1px solid; border-bottom: gainsboro 1px solid; font-family: verdana" >
            <tr bgcolor="#ADC9CF" class="cabeceraTabla" align="center">
                <td style="width:5%; height: 16px;">
                    M&oacute;dulo</td>
                <td style="width:35%; height: 16px;">
                    Nombre</td>
                <td style="width:45%; height: 16px;">
                    Descripci&oacute;n Breve</td>                
                <td style="width:auto; height: 16px;">&nbsp;
                </td>
            </tr>
            <% while (lista.Read())
               {   
                   if (!lista.IsDBNull(lista.GetOrdinal("ruta_descargar")))
                       rutaDescargar = lista.GetString(lista.GetOrdinal("ruta_descargar"));

                   if (!lista.IsDBNull(lista.GetOrdinal("ruta_reproducir")))
                       rutaReproducir = lista.GetString(lista.GetOrdinal("ruta_reproducir"));

                   rutas = "";

                   if (rutaDescargar != null && rutaDescargar.Length > 0)                   
                       rutas = "<a href=\"" + rutaDescargar + "\"><img src='images/icons/event_next.gif' alt='Descargar Curso' /></a>";
                   else
                       rutas = "<img src='images/icons/event_next_gray.gif' alt='Descarga no disponible.' />";
                   
                   rutas = rutas + "&nbsp;<img src='images/icons/separador.gif' alt=''/>&nbsp;";

                   if (rutaReproducir != null && rutaReproducir.Length > 0)                   
                       rutas = rutas + "<a href=\"javascript:reproducirVideo('" + rutaReproducir + "');\"><img src='images/icons/lrun_obj.gif' alt='Reproducir Curso' /></a>";
                   else
                       rutas = rutas + "<img src='images/icons/lrun_obj_gray.gif' alt='Reproducción no disponible.' />";
                                      
            %>
                <tr>
                    <td align="left"><%=lista.GetInt32(lista.GetOrdinal("secuence"))%></td>
                    <td align="left"><%=lista.GetString(lista.GetOrdinal("nombre")) %></td>
                    <td align="left"><%=lista.GetString(lista.GetOrdinal("descripcion")) %></td>                                                        
                    <td style="width:auto" align="center" valign="middle"><%=rutas %></td>
                </tr>
            <%} %>
        </table>
        <%}else{ %>
        <br/>
        <br/>        
        <br />
        <%} %>
    </div>
 </td></tr>
  </table>
<script type="text/javascript" >
function reproducirVideo(ruta){
    window.open(ruta,"","location=0,status=0,scrollbars=0,resizeble=1,width=800,height=600");
}
</script>
</asp:Content>

