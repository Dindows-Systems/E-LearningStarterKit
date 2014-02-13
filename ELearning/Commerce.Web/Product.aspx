<%@ Page Trace="false" Language="C#" CodeFile="Product.aspx.cs" Inherits="_Product" MasterPageFile="~/site.master" AutoEventWireup="true" Title="Product Detail" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>
<%@ Register Src="Modules/Products/FeedBackDisplay.ascx" TagName="FeedBackDisplay"
    TagPrefix="uc2" %>

<%@ Register Src="Modules/MainNavigation.ascx" TagName="MainNavigation" TagPrefix="uc1" %>

<%@ Register Src="Modules/Products/ProductDescriptorDisplay.ascx" TagName="ProductDescriptorDisplay"
    TagPrefix="uc8" %>

<%@ Register Src="Modules/Products/RatingDisplay.ascx" TagName="RatingDisplay" TagPrefix="uc7" %>

<%@ Register Src="Modules/Products/ProductTopDisplay.ascx" TagName="ProductTopDisplay"
    TagPrefix="uc6" %>
<%@ Register Src="Modules/Products/ReviewDisplay.ascx" TagName="ReviewDisplay"
    TagPrefix="uc6" %>
<%@ Register Src="Modules/Products/AttributeSelection.ascx" TagName="AttributeSelection"
    TagPrefix="uc5" %>
<%@ Register Src="Modules/Products/ProductModulos.ascx" TagName="ProductModulos"
    TagPrefix="uc9" %>
<%@ Register Namespace="Commerce.Web.UI.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="eWorld.UI" Namespace="eWorld.UI" TagPrefix="ew" %>
<%@ Register Src="Modules/AdContainer.ascx" TagName="AdContainer" TagPrefix="uc4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table width="770px" border="0" >
<tr>
    <td rowspan="2" style="width:25%" >
    <!--left menu-->
    
        <uc2:FeedBackDisplay id="FeedBackDisplay1" runat="server"></uc2:FeedBackDisplay>
        <div class="tenpixspacer"></div>
        <uc1:MainNavigation ID="MainNavigation1" runat="server" />
    
    </td>
    <td style="width:55%"><uc6:ProductTopDisplay id="ProductTopDisplay1" runat="server" ></uc6:ProductTopDisplay>
    </td>
    <td style="width:20%" >
        <br /><br /><br /><br />
        <% if (puedeComprarProducto)
           {%>
        <div class="coreboxtop"></div>
        <div class="coreboxheader">
            <asp:Localize ID="ReadyToBuyContent" runat="server" meta:resourcekey="ReadyToBuyContentResource1" Text="Ready To Buy?"></asp:Localize></div>
        <div class="coreboxbody">
            <asp:Localize ID="TypeOfCheckoutContent" runat="server" meta:resourcekey="TypeOfCheckoutContentResource1" Text="Checkout is fast, easy, ans secure. You have a choice&#13;&#10;            of checking out through this site, or using PayPal's &#13;&#10;            checkout features"></asp:Localize>.
            <div class="tenpixspacer"></div>
            <hr />
            <ew:numericbox id="txtAddQty" runat="server" maxlength="2" text="1" width="15px" meta:resourcekey="txtAddQtyResource1"></ew:numericbox>
            <asp:ImageButton ID="btnAddToCart" runat="server" SkinID="AddToCart" OnClick="AddToCart_Click" ImageAlign="AbsMiddle" meta:resourcekey="btnAddToCartResource1" />                 
        </div>
        <div class="coreboxbottom"></div>
       <%}else{ %>
       <div class="coreboxtop"></div>
          <div class="coreboxheader">Usted ya compr&oacute; este producto.</div>
            <div class="coreboxbody">
                Este producto es digital y descargable y solo se lo puede adquirir una vez. Usted ya compr&oacute; este producto con anterioridad.
                <div class="tenpixspacer"></div>
                <hr />                
            </div>
        <div class="coreboxbottom"></div>
       <%} %>

    <br class="clear" />

    </td>
</tr>
<tr>
    
    <td colspan="2" >
    <!--end left menu-->    		
            
            <uc8:ProductDescriptorDisplay ID="ProductDescriptorDisplay1" runat="server" />
            <uc9:ProductModulos ID="ProductModulos1" runat="server" />
            <uc6:ReviewDisplay id="ReviewDisplay1" runat="server"></uc6:ReviewDisplay>
        
    </td>
    
</tr>
</table>

</asp:Content>

