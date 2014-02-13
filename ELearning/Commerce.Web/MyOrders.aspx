<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="MyOrders.aspx.cs" Inherits="MyOrders" Title="Your Orders" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<%@ Register Src="Modules/MainNavigation.ascx" TagName="MainNavigation" TagPrefix="uc6" %>
<%@ Register Src="Modules/AdContainer.ascx" TagName="AdContainer" TagPrefix="uc4" %>
<%@ Register Src="Modules/Content/Paragraph.ascx" TagName="Paragraph" TagPrefix="uc5" %>
<%@ Register Src="Modules/RecentCategories.ascx" TagName="RecentCategories" TagPrefix="uc2" %>
<%@ Register Src="Modules/RecentProductsViewed.ascx" TagName="RecentProductsViewed"
    TagPrefix="uc3" %>

<%@ Register Src="Modules/CatalogList.ascx" TagName="CatalogList" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table style="width:770px" border="0">
<tr>
    <td style="width:25%"><uc6:MainNavigation ID="MainNavigation1" runat="server" /></td>        
    <td style="width:75%">
        <h1>
            <asp:Localize ID="YourOrdersContent" runat="server" meta:resourcekey="YourOrdersContentResource1" Text="Your Orders"></asp:Localize></h1>
        <uc5:Paragraph ID="Paragraph1" runat="server" ContentName="MyOrdersTop"/>
        <br />
        <table >
            <tr class="sectionheader">
                <td>
                    <asp:Localize ID="OrderNumberContent" runat="server" meta:resourcekey="OrderNumberContentResource1" Text="Order Number"></asp:Localize></td>
                <td>
                    <asp:Localize ID="DateContent" runat="server" meta:resourcekey="DateContentResource1" Text="Date"></asp:Localize></td>
                <td>
                    <asp:Localize ID="SubtotalContent" runat="server" meta:resourcekey="SubtotalContentResource1" Text="Subtotal"></asp:Localize></td>
                <td>
                    <asp:Localize ID="TaxContent" runat="server" meta:resourcekey="TaxContentResource1" Text="Tax"></asp:Localize></td>
                <td>
                    <asp:Localize ID="ShippingContent" runat="server" meta:resourcekey="ShippingContentResource1" Text="Shipping"></asp:Localize></td>
                <td>Total</td>
            </tr>
            <asp:Repeater ID="rptMyOrders" runat="server">
                <ItemTemplate>
            <tr class="plainbox">
                <td><a class="sidemenulink" href="receipt.aspx?t=<%# Eval("orderGUID") %>">
                    <%# Eval("orderNumber") %>
                </a></td>
                <td><%# Eval("orderDate") %></td>
                <td>
                    <%# Convert.ToDecimal(Eval("subtotalAmount")).ToString("c") %>
                </td>
                <td>
                    <%# Convert.ToDecimal(Eval("taxAmount")).ToString("c") %>
                </td>
                <td>
                    <%# Convert.ToDecimal(Eval("shippingAmount")).ToString("c") %>
                </td>
                <td>
                    <%# Convert.ToDecimal(Eval("orderTotal")).ToString("c") %>
                </td>
              
            </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
    </td>
    </tr>
    </table>   
</asp:Content>

