<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="mostrarUltimoResultado.aspx.cs" Inherits="examenes_mostrarUltimoResultado" Title="Resultados Ex&aacute;menes."  %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table border="0" style="width:750px" >
<tr><td align="center">
    <br />
    <br />
    <br />
   <h1>Resultados del Examen</h1>
<% if (!haRendidoExamen)
   {%>
    <p>
        <table style="width: 30%" border="1" cellspacing="0" bordercolor="#006699" >
            <tr>
                <td style="width: 81px; text-align: left" class="azulMarcado">
                    Curso:</td>
                <td style="text-align: left">
                    <%=nombreProducto%></td>
            </tr>           
        </table>
    </p>
   
   <p class="ourprice">Usted no ha rendido ning&uacute;n examen para este curso.</p>
<%}
  else
  { %>

    <p>
        <table style="width: 40%" border="1" cellspacing="0" bordercolor="#006699" >
            <tr>
                <td style="width: 30%; text-align: left" class="azulMarcado">
                    Curso:</td>
                <td style="width: 70%;text-align: left" class="azulClaro">
                    <%=nombreProducto%></td>
            </tr>
            <tr>
                <td style="width: 81px; text-align: left" class="azulMarcado">
                    Fecha de Realizacion:</td>
                <td style="text-align: left" class="azulClaro">
                    <%=fechaExamen%></td>
            </tr>
        </table>
    </p>
     <h2>Resumen</h2>    
    <table style="width: 25%" border="1" cellspacing="0" bordercolor="#006699" >
        <tr>
            <td style="width: 70%; text-align: left" class="azulMarcado">
                Total Preguntas</td>
            <td style="width: 30%; text-align: left" class="azulClaro"><%=totalPreguntas%>
            </td>
        </tr>
        <tr>
            <td style="text-align: left" class="azulMarcado">
                Correctas</td>
            <td style="text-align: left" class="azulClaro"><%=correctas%>
            </td>
        </tr>
        <tr>
            <td style="text-align: left" class="azulMarcado">
                Incorrectas</td>
            <td style="text-align: left" class="azulClaro"><%=incorrectas%>
            </td>
        </tr>
        <tr>
            <td style="text-align: left" class="azulMarcado">
                Puntaje Total (*)</td>
            <td style="text-align: left" class="azulClaro"><%=puntajeTotal%></td>
        </tr>
    </table>
    <br />* El puntaje total es sobre diez.
<%} %>
</td></tr>
</table>
</asp:Content>

