<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProductSummaryDisplay.ascx.cs" Inherits="Modules_ProductSummaryDisplay" %>
<%@ Register Assembly="Xpdt.Web.UI.Ratings" Namespace="Xpdt.Web.UI.WebControls" TagPrefix="Xpdt" %>
<div class="ProductBox">
    <div class="ProductSummaryDisplayWrapper">
        <div class="ProductSummaryImageHolder">
            <a href="<%=Commerce.Common.Utility.GetRewriterUrl("product",SKU,"") %>">
                <img src="<%= String.IsNullOrEmpty(ImageFile)? Page.ResolveUrl("~/images/ProductImages/no_image_available.gif") : Page.ResolveUrl(ImageFile)%>"
                    border="0" class="ProductImage" /></a>
        </div>
        <div class="ProductSummaryText">
            <div class="ProductSummaryProductName">
                <a href="<%=Commerce.Common.Utility.GetRewriterUrl("product",SKU,"") %>">
                    <%=ProductName%>
                </a>
                <br />
            </div>
            <div>
                <span class="RetailPrice">
                    <%=RetailPrice.ToString("c") %>
                </span>&nbsp; <span class="ourprice">
                    <%=GetDiscountedPrice().ToString("C")%>
                </span>
            </div>
            <div class="usuallyships">
                <asp:Localize ID="UsuallyShipsInContent" runat="server" meta:resourcekey="UsuallyShipsInContentResource1" Text="Usually ships in"></asp:Localize>
                <%=ShippingEstimate %>
            </div>
            <div class="smalltext">
                <asp:Localize ID="Localize1" runat="server" meta:resourcekey="Localize1Resource1" Text="Average Rating"></asp:Localize>:
                <Xpdt:Rater ID="sr1" runat="server" AutoLock="True" DisplayOnly="True"></Xpdt:Rater>
                <br />
            </div>
        </div>
    </div>
</div>
