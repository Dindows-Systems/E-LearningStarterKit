<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CatalogList.ascx.cs" Inherits="Modules_CatalogList1" %>
<%@ Register Src="AcceptedPayment.ascx" TagName="AcceptedPayment" TagPrefix="uc6" %>
<div class="browsebox">
    <asp:TreeView ID="CatalogTreeView" runat="server" meta:resourcekey="CatalogTreeViewResource1" NodeIndent="10" NodeWrap="True">
    </asp:TreeView>
    <uc6:AcceptedPayment ID="AcceptedPayment1" runat="server" />
</div>
