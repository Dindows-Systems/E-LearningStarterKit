<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InlineRichEditor.ascx.cs" Inherits="Modules_Content_InlineRichEditor" %>
    <table width="100%">
        <tr bgcolor="whitesmoke">
            <td><asp:ImageButton ID="imgSave" runat="server" ImageUrl="~/images/icons/edit.gif" /></td>
              <td><%=Title%></td>
            <td align="right"><asp:ImageButton ID="imgDelete" runat="server" ImageUrl="~/images/icons/delete.gif" /></td>
       </tr>
     </table>

<asp:Panel ID="pnlView" runat="server">
      <table width="100%">
        <tr>
            <td>
            <%=Text %>
            </td>
        </tr>
    </table>
</asp:Panel>
<asp:Panel ID="pnlEdit" runat="server">
     <table width="100%">
        <tr>
            <td>
            <asp:TextBox ID="txtContent" runat="server" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Panel>
