<%@ Control language="c#" Inherits="yaf.pages.active" CodeFile="active.ascx.cs" CodeFileBaseClass="yaf.pages.ForumPage" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<table class=command cellspacing=0 cellpadding=0 width="100%">
	<tr>
		<td class=navlinks><yaf:pager runat="server" id="Pager"/></td>
		<td align=right><%= GetText("since") %> <asp:DropDownList id=Since runat="server" AutoPostBack="True" onselectedindexchanged="Since_SelectedIndexChanged" /></td>
	</tr>
</table>

<table class=content cellSpacing=1 cellPadding=0 width="100%">
<tr>
	<td class=header1 width="1%">&nbsp;</td>
	<td class=header1 align=left><%= GetText("topics") %></td>
	<td class=header1 align=left width="20%"><%= GetText("topic_starter") %></td>
	<td class=header1 align=middle width="7%"><%= GetText("replies") %></td>
	<td class=header1 align=middle width="7%"><%= GetText("views") %></td>
	<td class=header1 align=middle width="20%"><%= GetText("lastpost") %></td>
</tr>
<tr>
	<td class=header1 align=right width="100%" colspan="6"><asp:hyperlink id="RssFeed" runat="server" /> ( Last 24 Hours )</td>
</tr>
<asp:repeater id=TopicList runat="server">
<ItemTemplate>
	<%# PrintForumName((System.Data.DataRowView)Container.DataItem) %>
	<yaf:TopicLine runat="server" findunread="true" DataRow=<%# Container.DataItem %>/>
</ItemTemplate>
</asp:repeater>
<tr>
	<td align=middle colSpan=6 class=footer1>&nbsp;</td>
</tr>
</table>

<table class=command width="100%" cellspacing=0 cellpadding=0>
<tr>
	<td class=navlinks><yaf:pager runat="server" linkedpager="Pager"/></td>
</tr>
</table>

<table width=100% cellspacing=0 cellpadding=0>
<tr>
	<td align=right colspan=2>
		<%= GetText("Forum_Jump") %> <yaf:forumjump runat="server"/>
	</td>
</tr>
<tr>
	<td valign=top><yaf:IconLegend runat="server"/></td>
</tr>
</table>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />
