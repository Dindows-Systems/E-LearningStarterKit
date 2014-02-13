<%--<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BundleDisplay.ascx.cs" Inherits="Modules_Products_BundleDisplay" %>
<%
    
    //a bundle is two or more products. Don't show if there's only one
    System.Collections.Generic.List<Commerce.Promotions.BundleItem> bundle = GetBundle();
    if (bundle.Count > 0)
    {
      decimal dBundleTotal = 0;
%>
<div class="productsection">
      <h2><%=bundle[0].BundleName%></h2>
      <%
          string bundleDescription = bundle[0].Description;
          foreach (Commerce.Promotions.BundleItem bundleItem in bundle)
          {
          dBundleTotal += bundleItem.OurPrice;
            %>
            <img alt="<%=bundleItem.ImageFile.ToString()%>" src="<%=Page.ResolveUrl("~/"+bundleItem.ImageFile)%>" align="middle" height="60" width="65" />&nbsp;
      <%}
        decimal bundleDiscount = bundle[0].DiscountPercent;
        decimal discountAmount = dBundleTotal * (bundleDiscount / 100);
        decimal discountedTotal = dBundleTotal - discountAmount;
      
      %>
      <asp:ImageButton ID="imgAddBundle" runat="server" SkinID="AddToCart" OnClick="AddBundle" ImageAlign="AbsMiddle" />
      <div><%=bundleDescription%>&nbsp;<del class="price"><%=dBundleTotal.ToString("c")%></del>&nbsp;<span class="ourprice"><%=discountedTotal.ToString("c") %></span></div>
</div>
<%} %>--%>