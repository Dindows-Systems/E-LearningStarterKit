<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Paragraph.ascx.cs" Inherits="Modules_Content_Paragraph" %>
<%if(CanEdit){%>
    <div class=contentbox id=divHolder 
    style="border:1px dashed white"
    ondblclick="showPopWin('admin/content_editor.aspx?id=<%=ContentName%>', 650, 610, null);"
    onmouseover="this.style.cursor='hand'; this.style.backgroundColor='AliceBlue'; this.style.border='1px dashed gainsboro';"
    onmouseout="this.style.backgroundColor='White'; this.style.border='1px dashed white';"
    title="Double Click to Edit">
    <%if (ContentText.Trim() == string.Empty) { %>
        <asp:Localize ID="Localize1" runat="server" meta:resourcekey="Localize1Resource1" Text="Double click to add text"></asp:Localize>...
    <%} %>
<%}else{ %>
    <div style="border:1px solid white;">
<%}%>
    <%=ContentText %>
</div>

