<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MainNavigation.ascx.cs" Inherits="Modules_MainNavigation" %>
<%@ Register Src="RecentCategories.ascx" TagName="RecentCategories" TagPrefix="uc2" %>
<%@ Register Src="RecentProductsViewed.ascx" TagName="RecentProductsViewed" TagPrefix="uc3" %>
<%@ Register Src="CatalogList.ascx" TagName="CatalogList" TagPrefix="uc1" %>
<div>      
<%if (RecentProductsViewed1.GetCount() > 0)  { %>
<uc3:RecentProductsViewed ID="RecentProductsViewed1" runat="server" />
<div class="twentypixspacer"></div>
<%} %>
<uc1:CatalogList id="CatalogList1" runat="server" />
</div> 