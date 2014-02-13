<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RecentCategories.ascx.cs" Inherits="Modules_RecentCategories" %>
<!-- Recent Categories -->
<div class="browsebox">
<asp:Image ID="imgRecentHeader" runat="server" SkinID="HeadersRecentCategories" />
<br />   
<asp:Repeater ID="rptRecentCats" runat="server">
    <ItemTemplate>
        <div>
        <a href="<%#Commerce.Common.Utility.GetRewriterUrl("catalog",Eval("itemName").ToString(),"") %>" class="subcategory"><%#Eval("itemName")%></a><br/>
        </div>
    </ItemTemplate>
</asp:Repeater>
</div>
<!-- End Recent Categories -->