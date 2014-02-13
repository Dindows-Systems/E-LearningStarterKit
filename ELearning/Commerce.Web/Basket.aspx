<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Basket.aspx.cs" Inherits="Basket" Title="Su Carrito de Compras" %>

<%@ Register Src="Modules/MainNavigation.ascx" TagName="MainNavigation" TagPrefix="uc4" %>
<%@ Register Src="Modules/CatalogList.ascx" TagName="CatalogList" TagPrefix="uc2" %>
<%@ Register Assembly="eWorld.UI" Namespace="eWorld.UI" TagPrefix="ew" %>
<%@ Register Src="Modules/AdContainer.ascx" TagName="AdContainer" TagPrefix="uc1" %>
<%@ Register Src="Modules/RecentCategories.ascx" TagName="RecentCategories" TagPrefix="uc2" %>
<%@ Register Src="Modules/RecentProductsViewed.ascx" TagName="RecentProductsViewed"
    TagPrefix="uc3" %>
<%@ Register Src="Modules/Products/ProductSummaryDisplay.ascx" TagName="ProductSummaryDisplay" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div id="leftcontent">
    <uc4:MainNavigation ID="MainNavigation1" runat="server" />
    <uc1:AdContainer id="AdContainer2" runat="server" BoxPlacement="Left" BoxCssClass="">
    </uc1:AdContainer>
</div>

<div id="centercontent">

<h1>Su Carrito de Compras: <asp:Label ID="lblSubtotal" runat="server"></asp:Label></h1>
<br />
<div>
    <asp:Button ID="btnAdjust" runat="server" Text="Actualizar Carrito" OnClick="AdjustBasket"/>
</div>
<br />
<table width="400" >
<asp:Repeater ID="rptBasket" runat="server" OnItemCommand="DeleteItem" >
    <ItemTemplate>
            <tr>
                <td  colspan="2" style="background-color:whitesmoke;width:400px" align="right" ><asp:LinkButton ID="lnkRemove" runat="server" ><img src="images/icons/delete.gif" /></asp:LinkButton></td>
            </tr>
            <tr>
                <td colspan="2">
                    <h2><a href="product.aspx?id=<%#Eval("productID") %>"><%#Eval("productName") %></a></h2>
                </td>
                </tr>
            <tr>
                <td>
                    <img src='<%#Eval("imageFile")%>' height="80" width="90"/><br />
                     <div class="smalltext">Agregado el <%#DateTime.Parse(Eval("createdOn").ToString()).ToShortDateString() %></div>
                    
                </td>                
                <td>
                    <div>
                        <ew:NumericBox ID="txtQuantity" runat="server" Width="20px" Text='<%#Eval("quantity") %>' ReadOnly=<%#Eval("esCantidadFija")%>  ToolTip='<%#Eval("mensajeCantidadFija")%>' ></ew:NumericBox>
                        X <%#decimal.Parse(Eval("pricePaid").ToString()).ToString("C") %> = <%#decimal.Parse(Eval("lineTotal").ToString()).ToString("C") %></div>
                        <div class="usuallyships">Usualmente enviado en <%#Eval("shippingEstimate") %></div>
                       
                        <asp:Label ID="lblProductID" runat="server" Visible="false" Text='<%#Eval("productID") %>'></asp:Label>
                        <asp:Label ID="lblSelectedAtts" runat="server" Text='<%#Eval("attributes") %>'></asp:Label>
                   
                    </div>
                </td>
            </tr>
            <tr><td><div class="tenpixspacer"></div></td></tr>
    </ItemTemplate>
</asp:Repeater>
</table>
<asp:Panel ID="pnlCheckout" runat="server">
    <div id="rightcontent" style="left: 600px">
    <% if (!tieneDigitalesYaComprados)
       {%>    
        <div class="coreboxtop"></div>
        <div class="coreboxheader">Listo para Comprar?</div>
        <div class="coreboxbody">
                El Checkout es r&aacute;pido y simple!
                <hr />
            <asp:HyperLink ID="lnkCheckout" runat="server" NavigateUrl="~/Checkout.aspx" SkinID="Checkout">[lnkCheckout]</asp:HyperLink>
        </div>
        <div class="coreboxbottom"></div>
    <br class="clear" />    
    <%} else{ %>    
        <div class="coreboxtop"></div>
        <div class="coreboxheader">No puede hacer Checkout!</div>
        <div class="coreboxbody">
                Retire del carrito los productos digitales que ha comprado con anterioridad (Solo se pueden adquirir una vez). <!--<br />Cualquier duda consultar <a href="MyCourses.aspx">Mis Cursos</a>.-->
                <hr />
        </div>
        <div class="coreboxbottom"></div>
    <br class="clear" />    
    <%} %>
    </div>
</asp:Panel>


<asp:Panel ID="pnlNada" runat="server">
    <h1>No hay nada en su carrito !</h1>
    <h2>Tenemos muchos cursos en los que Ud. puede estar interesado....</h2>
    <asp:DataList ID="dtProducts" runat="server"  RepeatColumns="3" RepeatDirection="Horizontal">
    <ItemTemplate>
    <uc1:ProductSummaryDisplay ID="ProductSummaryDisplay1" runat="server" 
        ProductName='<%#Eval("ProductName") %>'
        ImageFile='<%#Eval("ImageFile") %>'
        ProductID='<%#Eval("ProductID") %>'
        OurPrice='<%#Eval("OurPrice") %>'
        RetailPrice='<%#Eval("RetailPrice") %>'
        ShippingEstimate='<%#Eval("ShippingEstimate") %>'
        Rating='<%#Eval("Rating") %>'
        SKU='<%#Eval("SKU") %>'
   />
    </ItemTemplate>
    </asp:DataList>
</asp:Panel>
</div>
</asp:Content>


