<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="RendirExamen.aspx.cs" Inherits="examenes_RendirExamen" Title="Mis Ex&aacute;menes."  %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<br />
<table border="0" width="750px" >
    <tr><td align="center">
    &nbsp; &nbsp; 
    
        <h1>Ex&aacute;menes</h1>
    </td></tr>  
    <tr><td>
    <% if (faltanPreguntas)
       {%>
       <center><p class="ourprice"> Responda a todas las preguntas</p> </center>
       <br /><br />
    <%} %>
    
    <table style="width:50%" align="center">
    <tr><td align="left" class="negrita" colspan="2"> Curso: <%=nombreProducto%></td></tr>
    <tr><td>&nbsp;</td></tr>
    <asp:Repeater ID="rptPreguntas" runat="server" >
    <ItemTemplate>
    <tr>
        <td class="negrita"><%#Eval("secuencia") %>.-</td>
        <td class="negrita"><%#Eval("descripcion") %></td>
     </tr>
     <tr><td colspan="2"><br/></td></tr>
     <asp:Repeater ID="rptOpciones" DataSource='<%# getOpciones((int) Eval("preguntaID")) %>' runat="server">
        <ItemTemplate>
            <tr>
                <td>&nbsp;</td>
                <td class="negrita"><input type="radio" value="<%#Eval("opcionID") %>" name="examenPregunta<%#Eval("preguntaID") %>" class="inputSinBorde" />&nbsp;<%#Eval("descripcion") %></td>
            </tr>
        </ItemTemplate>
        </asp:Repeater> 
     <tr><td colspan="2"><br/></td></tr>
     </ItemTemplate>
    </asp:Repeater>
    </table>
    <br />
    <br />
    </td></tr>
    <tr><td align="center">
        <input id="Submit1" type="submit" value="Entregar Examen" onclick="validar()" />
    <input type="hidden" value="1" name="rendirExamen" />    
    &nbsp;&nbsp;&nbsp;
</td></tr>
</table>       
</asp:Content>

