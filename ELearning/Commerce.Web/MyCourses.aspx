<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="MyCourses.aspx.cs" Inherits="MyCourses" Title="Mis Cursos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">    
<table style="width:750px;" border="0">
     <tr><td align="center">
    <h1>&nbsp;Mis Cursos Adquiridos</h1>
    <br />
    <div style="text-align: center">
        <%if (cantidadProductosComprados > 0)
          { %>          
          <em>* Los cursos aqui listados son digitales.</em>
          <br /><br />
        <table cellspacing="0" cellpadding="3"  border="1" style="width:90%;border-color:#999999;border-width:1px;border-style:None;border-collapse:collapse;border-right: gainsboro 1px solid;border-top: gainsboro 1px solid; font-size: 8pt; border-left: gainsboro 1px solid; border-bottom: gainsboro 1px solid; font-family: verdana" >
            <tr bgcolor="#ADC9CF" class="cabeceraTabla" align="center">
                <td  colspan="2" style="width:30%; height: 16px;">
                    Producto</td>
                <td style="width:45%; height: 16px;">
                    Descripci&oacute;n Breve</td>
                <td style="width:15%; height: 16px;">
                    Fecha Compra</td>
                <td style="width:auto; height: 16px;">&nbsp;
                </td>
            </tr>            
            <asp:Repeater ID="rptCursosUsuario" runat="server" >
            <ItemTemplate>
                <tr>
                    <td align="left">
                    <img src="<%#Eval("imageFile") %>" height="50px" width="50px" alt="" />
                    </td>
                    <td align="left">
                        <%#Eval("productName") %>
                    </td>
                    <td style="width:45%" align="left" >
                        <%#Eval("shortDescription")%>
                    </td>
                    <td style="width:15%" align="center">
                        <%#Eval("orderDate")%>
                    </td>
                    <td style="width:auto" align="center" valign="middle"><%# getValidacionModulos((int)Eval("productID"))%></td>
                </tr>                
            </ItemTemplate>
            </asp:Repeater>
        </table>
        <%}else{ %>
        <br/>
        <br/>
        <p></p> 
        <table border="0" style="width:60%">
            <tr>
                <td style="width:10%"><img src="images/icons/icon_error.gif" height="40px" width="40px" alt="" /></td>
                <td style="width:90%" align="left" class="ourprice">Usted no ha adquirido ning&uacute;n producto o su orden de compra todavia esta pendiente de pago. Revise el estado de sus &oacute;rdenes de compra en <em>&quot;Mis Ordenes&quot;.</em> </td>
            </tr>
        </table>       
        <%} %>
    </div>
 </td></tr>
  </table>
</asp:Content>

