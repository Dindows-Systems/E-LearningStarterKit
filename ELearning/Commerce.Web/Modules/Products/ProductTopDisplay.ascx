<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProductTopDisplay.ascx.cs" Inherits="Modules_Products_ProductTopDisplay" %>
<%@ Register Src="AttributeSelection.ascx" TagName="AttributeSelection" TagPrefix="uc5" %>
<%@ Register Assembly="Xpdt.Web.UI.Ratings" Namespace="Xpdt.Web.UI.WebControls" TagPrefix="Xpdt" %>


<h1><%=product.ProductName %></h1>
<table >
    <tr>
       <%if(product.Images.Count>1) {%>
        <td valign="top" style="width: 66px">
            <table>
                <%foreach(Commerce.Common.Image img in product.Images){ %>
                <tr><td class="smalltext" style="cursor:hand"><img height="30" width="40" src="<%=Page.ResolveUrl("~/"+img.ImageFile)%>" alt="<%=img.ImageFile%>" onmouseover="imgProduct.src='<%=Page.ResolveUrl("~/"+img.ImageFile) %>'"/></td></tr>
                <%} %>
            
            </table>
        </td>
        <%} %> 
        <td valign="top">
            <table width="100%" >
                <tr>
                    <td width="120">
                        <img src="<%=product.ImageFile == null  ? Page.ResolveUrl("~/images/ProductImages/no_image_available.gif") : Page.ResolveUrl("~/" + product.ImageFile) %>" name="imgProduct" id="imgProduct" alt="<%=product.ProductName %>"/>
                    </td>
                    <td>
                        <table >
                            <tr>
                                <td >
                                    <asp:Localize ID="RetailPriceContent" runat="server" meta:resourcekey="RetailPriceContentResource1" Text="Retail Price"></asp:Localize></td>
                                <td class="RetailPrice"><%=product.RetailPrice.ToString("c") %></td>
                            </tr>
                            <tr>
                                <td style="width:100px">
                                    <b><%=discount.Title %></b><br />
                                    <i><%=discount.Description %></i>
                               
                                </td>
                                <td>
                                    <b class="price">
                                        <%=discount.DiscountedPrice.ToString("C")%>
                                    </b>
                                </td>
		                    </tr>
                			<tr>
			                    <td>
                                    <asp:Localize ID="YouSaveContent" runat="server" meta:resourcekey="YouSaveContentResource1" Text="You Save"></asp:Localize>:</td>
			                    <td><%=product.YouSavePrice.ToString("C") %> (<%=product.YouSavePercent.ToString("p") %>)</td>
			                </tr>
			                <%--<tr>
				                <td>
                                    <asp:Localize ID="AvailabilityContent" runat="server" meta:resourcekey="AvailabilityContentResource1" Text="Availability"></asp:Localize>:</td>
				                <td>
                                    <%=product.ShippingEstimate %>
                                    
        			                <%
                                      if (product.Status == Commerce.Common.ProductStatus.Discontinued) {
			                        %>
        			                    <br /><i>
                                            <asp:Localize ID="ProductDiscontinuedContent" runat="server" meta:resourcekey="ProductDiscontinuedContentResource1" Text="This product has been discontinued, however it is still available for &#13;&#10;        &#9;&#9;&#9;                    special purchase. Please allow extra time for delivery"></asp:Localize>.</i>
                        			    
			                        <%}
                                     else if (product.Status == Commerce.Common.ProductStatus.FutureRelease)
                                     {  %>
        			                    <br /><i>
                                            <asp:Localize ID="FutureReleaseContent" runat="server" meta:resourcekey="FutureReleaseContentResource1" Text="This product is set for future release. These dates may change; please&#13;&#10;        &#9;&#9;&#9;                    be aware that the dates shown above are only an estimate"></asp:Localize>.</i>
			                        <%}else if(product.Status == Commerce.Common.ProductStatus.OnBackorder) {  %>
                                        <br /><i>
                                            <asp:Localize ID="OnBackorderContent" runat="server" meta:resourcekey="OnBackorderContentResource1" Text="This product in on backorder and may take extra time to ship"></asp:Localize>.</i>
                                    <%}%>	
                                    
                                    
                                </td>
			                </tr>--%>
			                <tr>
				                <td>
                                    <asp:Localize ID="AvgRatingContent" runat="server" meta:resourcekey="AvgRatingContentResource1" Text="Avg. Rating"></asp:Localize>:</td>
				                <td><Xpdt:Rater ID="pRating" runat="server" 
                                      DisplayOnly="True"
                                      ToolTipFormat="Average Rating is {0} over {1}"
                                      DisplayValue="3"

                                      ></Xpdt:Rater></td>
			                </tr>
			                <%//if (product.Attributes.Count > 0){ %>
                            <tr>
                                <td colspan="2">
                                    <uc5:AttributeSelection id="attList" runat="server"
                                    >
                                    </uc5:AttributeSelection>
                                </td>
                            </tr>
                            <%//} %>

                        </table>
                    </td>
                </tr>

            </table>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="HookLine">
        <%=product.ShortDescription %>
        </td>
        
    </tr>
</table>