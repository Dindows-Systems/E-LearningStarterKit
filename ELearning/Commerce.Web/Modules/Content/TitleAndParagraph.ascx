<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TitleAndParagraph.ascx.cs" Inherits="Modules_Content_TitleAndParagraph" %>
<asp:Panel ID=pnlContent Runat=server>
<%if(CanEdit){%>
<div class="contentbox" id="divHolder" runat="server" 
ondblclick="showPopWin('admin/content_editor.aspx?id=<%=ContentName%>', 700, 500, null);"
onmouseover="this.style.cursor='hand'; this.style.backgroundColor='AliceBlue'; this.style.border='1px dashed gainsboro';"
onmouseout="this.style.backgroundColor='White'; this.style.border='1px dashed white';"
title="Double Click to Edit">

<h1><%=Title%></h1>
<%=ContentText%>
</div>

<%}else{%>
<h1><asp:label id="lblTitle" runat="server"></asp:label></h1>
<asp:label id="lblContent" runat="server"></asp:label>

<%}%>

</asp:Panel>
<asp:Panel ID="pnlCommand" Runat="server" Visible=false>
		<asp:linkbutton id="btnEdit" runat="server" CausesValidation="False">
			edit
		</asp:linkbutton>
</asp:Panel>
</div>

<table id="tblEdit" width="100%" runat="server">
	<tr>
		<td><b>Title<br>
				<asp:textbox id="txtTitle" runat="server" Width="424px"></asp:textbox></b></td>
	</tr>
	<tr>
		<td><b>Content<br>
				<asp:TextBox id="txtContent" runat="server" Width="432px" TextMode="MultiLine" Height="192px"></asp:TextBox></b></td>
	</tr>
	<tr>
		<td colspan="2"><asp:button id="btnSave" runat="server" CausesValidation="False" Text="Save" OnClick="btnSave_Click"></asp:button>&nbsp;
			<asp:button id="btnCancel" runat="server" CausesValidation="False" Text="Cancel" OnClick="btnCancel_Click"></asp:button></td>
	</tr>
</table>