<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProductCategories.ascx.cs" Inherits="Modules_Admin_ProductCategories" %>
<%@ Register Assembly="eWorld.UI" Namespace="eWorld.UI" TagPrefix="ew" %>

<h1>
    <asp:Localize ID="CategoriesContent" runat="server" meta:resourcekey="CategoriesContentResource1" Text="Categories"></asp:Localize></h1>
<table class="admintable1">
<tr><td>

<asp:Label ID="lblID" runat="server" Visible="False" meta:resourcekey="lblIDResource1"></asp:Label>
<asp:DropDownList ID="ddlCats" runat="server" meta:resourcekey="ddlCatsResource1">
</asp:DropDownList>
<asp:Button ID="btnCats" runat="server" Text="Add" OnClick="btnCats_Click" meta:resourcekey="btnCatsResource1" />
<br /><br />
<asp:DataGrid ID="dgCats" runat="server" width="500px" BorderColor="White" BorderWidth="0px" AutoGenerateColumns="False" OnDeleteCommand="DeleteCat" meta:resourcekey="dgCatsResource1">
    <FooterStyle ForeColor="Black" BackColor="#C6C3C6"></FooterStyle>
    <SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="Gainsboro"></SelectedItemStyle>
    <AlternatingItemStyle ForeColor="Black" BackColor="WhiteSmoke"></AlternatingItemStyle>
    <ItemStyle ForeColor="Black" BackColor="White"></ItemStyle>
    <HeaderStyle Font-Size="8pt" Font-Names="Verdana" Font-Bold="True" ForeColor="Black" BackColor="LightSteelBlue"></HeaderStyle>
    <Columns>
        <asp:BoundColumn DataField="categoryID" HeaderText="ID"></asp:BoundColumn>
        <asp:BoundColumn DataField="CategoryName" HeaderText="Categor&#237;a"></asp:BoundColumn>
       <asp:ButtonColumn ButtonType="PushButton" CommandName="Delete" Text="Delete" meta:resourcekey="ButtonColumnResource1"></asp:ButtonColumn>
    </Columns>
</asp:DataGrid>
</td>
</tr>
</table>