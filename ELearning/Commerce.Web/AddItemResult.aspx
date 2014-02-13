<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="AddItemResult.aspx.cs" Inherits="AddItemResult" Title="Item Agregado" %>

<%@ Register Src="Modules/Products/ProductSummaryDisplay.ascx" TagName="ProductSummaryDisplay"
    TagPrefix="uc6" %>

<%@ Register Src="Modules/Content/Paragraph.ascx" TagName="Paragraph" TagPrefix="uc5" %>
<%@ Register Src="Modules/AdContainer.ascx" TagName="AdContainer" TagPrefix="uc4" %>

<%@ Register Src="Modules/MiniCart.ascx" TagName="MiniCart" TagPrefix="uc1" %>
<%@ Register Src="Modules/CatalogList.ascx" TagName="CatalogList" TagPrefix="uc2" %>
<%@ Register Src="Modules/RecentCategories.ascx" TagName="RecentCategories" TagPrefix="uc2" %>
<%@ Register Src="Modules/RecentProductsViewed.ascx" TagName="RecentProductsViewed" TagPrefix="uc3" %>



<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table width="770px" border="0" >
<tr>
    <td style="width:25%" >
            <%if (RecentCategories1.GetCount() > 0 && RecentProductsViewed1.GetCount() > 0)  { %>
            <uc3:RecentProductsViewed ID="RecentProductsViewed1" runat="server" />
            <uc2:RecentCategories ID="RecentCategories1" runat="server" />
            <%} %>
            <uc2:CatalogList ID="CatalogList1" runat="server" />
        <br />

    </td>
<td style="width:55%">
    <%
        if (drLastAdded != null)
        {
    %>
    <h1>Recientemente Agregado a su Carrito:</h1>
    <Table>
        <tr>
            <td width="100">
            <asp:Image ID="imgJustAdded" runat="server" />
            </td>
            <td>
                <h2><asp:Label ID="lblJustAddedName" runat="server"></asp:Label></h2>
                <div class="retailPrice">Precio Normal:<asp:Label ID="lblJustAddedRetail" runat="server"></asp:Label></div>
                <div class="ourPrice">Nuestro Prercio:<asp:Label ID="lblJustAddedOurPrice" runat="server"></asp:Label></div>
                <div>Cantidad: <asp:Label ID="lblJustAddedQuantity" runat="server"></asp:Label></div>
                <asp:Label ID="lblSelectedAtts" runat="server" Text='<%#Eval("attributes") %>'></asp:Label>
                <div>Total: <b><asp:Label ID="lblJustAddedLineTotal" runat="server"></asp:Label></b></div>
          </td>
        </tr>

    </Table>
    <%
        }else{
    %>
        <h1>Su carrito está vacío</h1>

    <%
        }
    %>
    <br />
    <%
        if (ds.Tables[2].Rows.Count > 0)
        {
    %>
    <div  class="productsection">
    <h1>Ud. puede estar también interesado en...</h1>
    <br />
    <asp:DataList ID="dtCrossProducts" runat="server"  RepeatColumns="3" RepeatDirection="Horizontal" OnItemCommand="lnkAddCross" RepeatLayout="Table">
        <ItemTemplate>
        <uc6:ProductSummaryDisplay ID="ProductSummaryDisplay1" runat="server" 
        ProductID='<%#Eval("ProductID")%>'
        ProductName='<%#Eval("ProductName")%>'
        RetailPrice='<%#Eval("RetailPrice")%>'
        OurPrice='<%#Eval("OurPrice")%>'
        ImageFile='<%#Eval("DefaultImage")%>'
        Rating='<%#Eval("Rating")%>'
       />
        <asp:Label ID="lblProductID" runat="server" Text='<%#Eval("productID")%>' Visible="false"></asp:Label>
       </ItemTemplate>

    </asp:DataList>
    <br />
    </div>
    <%
        }
        if (ds.Tables[1].Rows.Count > 0) {
    %>
    <div  class="productsection">
    <h1>Items Recientemente Vistos</h1>
    <asp:DataList ID="dtRecent" runat="server"  RepeatColumns="1" RepeatDirection="Horizontal" OnItemCommand="lnkAddRecent">
        <ItemTemplate>
        <uc6:ProductSummaryDisplay ID="ProductSummaryDisplay1" runat="server" 
        ProductID='<%#Eval("ProductID")%>'
        ProductName='<%#Eval("ProductName")%>'
        ShippingEstimate='<%#Eval("ShippingEstimate")%>'
        RetailPrice='<%#Eval("RetailPrice")%>'
        OurPrice='<%#Eval("OurPrice")%>'
        ImageFile='<%#Eval("ImageFile")%>'
         Rating='<%#Eval("Rating")%>'
         SKU='<%#Eval("SKU")%>'
       />
        </ItemTemplate>


    </asp:DataList>
    </div>
    <%}%>
</td>
<td style="width:20%">
            <br /><br />
            <uc1:MiniCart id="MiniCart1" runat="server">
            </uc1:MiniCart>
</td>            
</tr>
</table>    
</asp:Content>

