<%@ Page Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="Admin_Products.aspx.cs" Inherits="Admin_Admin_Products" Title="Product Administration" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>
<%@ Register Src="../Modules/ImageManager.ascx" TagName="ImagePicker" TagPrefix="uc2" %>
<%@ Register Src="../Modules/ResultMessage.ascx" TagName="ResultMessage" TagPrefix="uc1" %>
<%@ Register TagPrefix="ajax" Namespace="MagicAjax.UI.Controls" Assembly="MagicAjax" %>
<%@ Register Assembly="eWorld.UI" Namespace="eWorld.UI" TagPrefix="ew" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminPlaceHolder" Runat="Server">

        <h1>
            <asp:Localize ID="Localize1" runat="server" meta:resourcekey="Localize1Resource1" Text="Products"></asp:Localize></h1>
		<asp:GridView id="dg" runat="server" DataSourceID="ObjectDataSource1"  AutoGenerateColumns="False" AllowPaging="True" PageSize="50" Width="500px" meta:resourcekey="dgResource1">
			<Columns>

			<asp:BoundField DataField="ProductID" SortExpression="ProductID" HeaderText="ID Producto"  Visible="False" meta:resourcekey="BoundFieldResource1"></asp:BoundField>
            <asp:TemplateField HeaderText="Producto" meta:resourcekey="TemplateFieldResource1">
            
                <ItemTemplate>
                    <a href='admin_product_details.aspx?id=<%# Eval("productID") %>'>
                        <%# Eval("ProductName") %>
                    </a>
                </ItemTemplate>
            
            </asp:TemplateField>
			<asp:BoundField DataField="SKU" SortExpression="SKU" HeaderText="SKU" meta:resourcekey="BoundFieldResource2" ></asp:BoundField>
			<asp:BoundField DataField="ProductType" HeaderText="Tipo de Producto" meta:resourcekey="BoundFieldResource4" ></asp:BoundField>
			<asp:BoundField DataField="OurPrice" SortExpression="OurPrice" HeaderText="Nuestro Precio" meta:resourcekey="BoundFieldResource5" ></asp:BoundField>
		</Columns>
		<PagerStyle HorizontalAlign="Right" ForeColor="Black" BackColor="#C6C3C6"></PagerStyle>
	</asp:GridView>
	<BR>
	
	<input type="button" onclick="location.href='admin_product_add.aspx'" value="Agregar" id="Button1" />
    <br />
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetAll"
        TypeName="ProductController"></asp:ObjectDataSource>
    <br />


</asp:Content>

