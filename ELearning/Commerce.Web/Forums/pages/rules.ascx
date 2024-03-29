<%@ Control language="c#" Inherits="yaf.pages.rules" CodeFile="rules.ascx.cs" CodeFileBaseClass="yaf.pages.ForumPage" %>
<%@ Register TagPrefix="yaf" Namespace="yaf.controls" %>

<yaf:PageLinks runat="server" id="PageLinks"/>

<table class="content" cellspacing=0 cellpadding=0 width="100%">
	<tr>
		<td class="header1" align="middle">Forum Rules and Policies</td>
	</tr>
	<tr>
		<td><asp:Label id=ForumRules runat="server"/></td>
	</tr>
	<tr>
		<td align="middle">
			<asp:Button id=Accept runat="server" Text="Accept" onclick="Accept_Click" />
			<asp:Button id=Cancel runat="server" Text="Cancel" onclick="Cancel_Click" />
		</td>
	</tr>
</table>

<yaf:SmartScroller id="SmartScroller1" runat = "server" />
