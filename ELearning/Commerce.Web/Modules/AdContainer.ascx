<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AdContainer.ascx.cs" Inherits="Modules_AdContainer" %>

<asp:Repeater runat="server" ID="repeater">
	<ItemTemplate>
		<asp:MultiView runat="server" ID="multiView">
			<asp:View runat="server" ID="hasSku">
				<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# FormatSkuURL(DataBinder.Eval(Container.DataItem, "AdID"), DataBinder.Eval(Container.DataItem, "ProductSku")) %>' CssClass="adtext"><%# DataBinder.Eval(Container.DataItem, "AdText") %></asp:HyperLink>
			</asp:View>
			<asp:View runat="server" ID="hasCategoryId">
				<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# FormatCategoryIdURL(DataBinder.Eval(Container.DataItem, "AdID"), DataBinder.Eval(Container.DataItem, "CategoryID")) %>' CssClass="adtext"><%# DataBinder.Eval(Container.DataItem, "AdText") %></asp:HyperLink>
			</asp:View>
			<asp:View runat="server" ID="noSkuOrCategoryId">
				<%# DataBinder.Eval(Container.DataItem, "AdText") %>
			</asp:View>
			<asp:View runat="server" ID="canEdit">
				<div runat="server" class="contentbox" id="divHolder" 
					style="border:1px dashed white"
					ondblclick='<%# FormatDblClick(DataBinder.Eval(Container.DataItem, "AdID"))%>'
					onmouseover="this.style.cursor='hand'; this.style.backgroundColor='AliceBlue'; this.style.border='1px dashed gainsboro';"
					onmouseout="this.style.backgroundColor='White'; this.style.border='1px dashed white';"
					title="Double Click to Edit">
							<%# DataBinder.Eval(Container.DataItem, "AdText") %>
					</div>
			</asp:View>
		</asp:MultiView>
	</ItemTemplate>
</asp:Repeater>
<asp:HyperLink NavigateUrl="" runat="server" id="addAnAd" onclick="" Visible="false">
   <img src="<%=Page.ResolveUrl("~/images/icons/add.gif") %>" alt="Agregar una Publicidad" title="Agregar una Publicidad"/>
</asp:HyperLink>