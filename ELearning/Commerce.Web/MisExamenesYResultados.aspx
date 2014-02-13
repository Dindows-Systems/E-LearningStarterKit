<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="MisExamenesYResultados.aspx.cs" Inherits="MisExamenesYResultados" Title="Mis Ex&aacute;menes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />

  <table style="width:750px;" border="0">
     <tr><td align="center">  
        <h1>Ex&aacute;menes y Resultados</h1>        
        <p>
            &nbsp;
            <table cellspacing="0" cellpadding="3"  border="1" style="width:80%;border-color:#999999;border-width:1px;border-style:None;border-collapse:collapse;border-right: gainsboro 1px solid;border-top: gainsboro 1px solid; font-size: 8pt; border-left: gainsboro 1px solid; border-bottom: gainsboro 1px solid; font-family: verdana" >
                <tr align="center">
                    <td bgcolor="#0099CC"  colspan="2" style="width:30%; height: 16px;" >
                        <span style="color: white; font-size: 10pt;" ><strong>Producto</strong></span></td>                    
                    <td bgcolor="#0099CC" >&nbsp;&nbsp;</td>
                </tr>
                <asp:Repeater ID="rptCursosCompradosAgrupados" runat="server" >
                <ItemTemplate>
                <tr>
                    <td align="left" width="12%">
                    <img src="<%#Eval("defaultimage") %>" height="40px" width="40px" alt="" />
                    </td>
                    <td align="left" class="letraColorAzul" width="78%">
                        <%#Eval("productName") %>
                    </td>                                        
                    <td style="width:auto" align="center" valign="middle">
                        <table border="0" width="100%">
                         <tr>
                            <td><a href="examenes/RendirExamen.aspx?productId=<%#Eval("productid") %>"><img src="images/icons/testrun.gif" alt="Rendir Examen" title="Rendir Examen" /></a></td>
                            <td><a href="examenes/mostrarUltimoResultado.aspx?productId=<%#Eval("productid") %>"><img src="images/icons/tasks_tsk.gif" alt="Ver resultados" title="Ver últimos resultados"></a></td>
                         </tr> 
                         </table>                       
                     </td>
                </tr>
                </ItemTemplate>
                </asp:Repeater>               
            </table>
            <!-- <br/><img src="images/icons/testrun.gif" />&nbsp;Rendir Examen.&nbsp;&nbsp;<img src="images/icons/tasks_tsk.gif" />&nbsp;Ver Resultado. -->
            
        </p>
     </td></tr>
  </table>
</asp:Content>

