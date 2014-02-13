<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RecentProductsViewed.ascx.cs" Inherits="Modules_RecentProductsViewed" %>

<!-- Recent Product Viewed -->
<div class="browsebox">
<%--<asp:Image ID="imgRecentHeader" runat="server" SkinID="HeadersRecentProducts" />--%>
<table cellpadding="1" cellspacing="1">
<asp:Repeater ID="rptRecentProds" runat="server">
    <ItemTemplate>
    <tr>
        <td>
            <img src="<%#GetImagePath(Eval("ImagePath")) %>" width="40"/>
        </td>
        <td>
            <div><a class="smalltext" href="<%#Commerce.Common.Utility.GetRewriterUrl("product",Eval("itemNumber").ToString(),"") %>">
            <%#Eval("itemName") %></a></div>
        </td>
    </tr>
    </ItemTemplate>
</asp:Repeater>
</table>
</div>
<!-- End Recent Product Viewed -->