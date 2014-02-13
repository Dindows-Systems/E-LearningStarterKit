<%@ Control language="c#" Inherits="yaf.pages.admin.eventlog" CodeFile="eventlog.ascx.cs" CodeFileBaseClass="yaf.AdminPage" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<yaf:adminmenu runat="server">

<table class=content width="100%" cellspacing=1 cellpadding=0>
<tr>
	<td class=header1 colspan="8">Event Log</td>
</tr>

<asp:repeater runat="server" id="List">
	<HeaderTemplate>
		<tr class="header2">
			<td>User</td>
			<td>Time</td>
			<td>Source</td>
			<td>&nbsp;</td>
		</tr>
	</HeaderTemplate>
	<ItemTemplate>
		<tr class=postheader>
			<td><%# DataBinder.Eval(Container.DataItem, "Name") %></td>
			<td><%# DataBinder.Eval(Container.DataItem, "EventTime") %></td>
			<td><%# DataBinder.Eval(Container.DataItem, "Source") %></td>
			<td>
				<asp:linkbutton runat="server" id="showbutton" commandname="show">Show</asp:linkbutton>
				|
				<asp:linkbutton runat="server" onload="Delete_Load" commandname="delete" commandargument='<%# DataBinder.Eval(Container.DataItem, "EventLogID") %>'>Delete</asp:linkbutton>
			</td>
		</tr>
		<tr class="post" runat="server" visible="false" id="details">
			<td colspan="4"><pre style="overflow:scroll"><%# DataBinder.Eval(Container.DataItem, "Description") %></pre></td>
		</tr>
	</ItemTemplate>
</asp:repeater>

</table>

</yaf:adminmenu>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />
