<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RatingDisplay.ascx.cs" Inherits="Modules_Products_RatingDisplay" %>
<%@ register assembly="MagicAjax" namespace="MagicAjax.UI.Controls" tagprefix="ajax" %>
<%@ Register Assembly="Xpdt.Web.UI.Ratings" Namespace="Xpdt.Web.UI.WebControls" TagPrefix="Xpdt" %>
<center>
<ajax:AjaxPanel ID="Ajaxpanel1" runat="server">
  <Xpdt:Rater id="sr1" runat="server" AutoPostBack="true" 
  OnValueChanged="Product_Rated"  AutoLock="true"
  ></Xpdt:Rater><br />
  <br />
  <asp:Label ID="lblRateMessage" runat="server"></asp:Label>
</ajax:AjaxPanel>
</center>