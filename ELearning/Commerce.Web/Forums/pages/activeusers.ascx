<%@ Control language="c#" Inherits="yaf.pages.activeusers" CodeFile="activeusers.ascx.cs" CodeFileBaseClass="yaf.pages.ForumPage" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<table class=content width=100% cellspacing=1 cellpadding=0>
<tr>
	<td class=header1 colspan=6><%= GetText("title") %></td>
</tr>
<tr>
	<td class=header2><%= GetText("username") %></td>
	<td class=header2><%= GetText("logged_in") %></td>
	<td class=header2><%= GetText("last_active") %></td>
	<td class=header2><%= GetText("active") %></td>
	<td class=header2><%= GetText("browser") %></td>
	<td class=header2><%= GetText("platform") %></td>
</tr>

<asp:repeater id=UserList runat=server>
<ItemTemplate>
<tr>
	<td class=post><asp:HyperLink id="Name" NavigateUrl='<%# yaf.Forum.GetLink(yaf.Pages.profile,"u={0}",DataBinder.Eval(Container.DataItem,"UserID")) %>' Text='<%# Server.HtmlEncode(Convert.ToString(DataBinder.Eval(Container.DataItem,"Name"))) %>' runat="server" /></td>
	<td class=post><%# FormatTime((DateTime)((System.Data.DataRowView)Container.DataItem)["Login"]) %></td>
	<td class=post><%# FormatTime((DateTime)((System.Data.DataRowView)Container.DataItem)["LastActive"]) %></td>
	<td class=post><%# String.Format(GetText("minutes"),((System.Data.DataRowView)Container.DataItem)["Active"]) %></td>
	<td class=post><%# DataBinder.Eval(Container.DataItem,"Browser") %></td>
	<td class=post><%# DataBinder.Eval(Container.DataItem,"Platform") %></td>
</tr>
</ItemTemplate>
</asp:repeater>

</table>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />
