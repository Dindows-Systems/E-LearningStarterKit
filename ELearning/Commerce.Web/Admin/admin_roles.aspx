<%@ Page Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="admin_roles.aspx.cs" Inherits="AdminUsers_admin_roles" Title="Untitled Page" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminPlaceHolder" Runat="Server">

    <h1>
        <asp:Localize ID="RoleAdministrationContent" runat="server" meta:resourcekey="RoleAdministrationContentResource1" Text="Role Administration"></asp:Localize></h1>

    <asp:GridView ID="GridView1" runat="server" 
        AutoGenerateColumns="False" 
        DataSourceID="allRolesDataSource" 
        EmptyDataText="There are no matching roles in the system." 
        Font-Italic="False" meta:resourcekey="GridView1Resource1">
        <Columns>
            <asp:TemplateField HeaderText="Role Name" meta:resourcekey="TemplateFieldResource1">
                <ItemTemplate>
                    <%# Container.DataItem %>
                </ItemTemplate>
                <ItemStyle Width="200px" />
            </asp:TemplateField>
            <asp:TemplateField meta:resourcekey="TemplateFieldResource2">
                <ItemTemplate>
                    <asp:LinkButton runat="server" id="linkButton1" text="Delete" commandname="delete" CommandArgument='<%# Container.DataItem %>' forecolor="Black" oncommand="LinkButtonClick" meta:resourcekey="linkButton1Resource1" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataRowStyle Font-Italic="True" />
    </asp:GridView>
    
    <br />
    
    <div>
        <table>
            <tr>
                <td>
                    <asp:TextBox ID="txtRoleName" runat="server" ValidationGroup="new" meta:resourcekey="txtRoleNameResource1" />
                    <asp:Button runat="server" id="linkButton2" text="Add" commandname="add" forecolor="Black" oncommand="LinkButtonClick" ValidationGroup="new" meta:resourcekey="linkButton2Resource1" />
                    <asp:RequiredFieldValidator ID="RoleNameRequiredFieldValidator" runat="server" ControlToValidate="txtRoleName" Display="Dynamic" ValidationGroup="new" meta:resourcekey="RoleNameRequiredFieldValidatorResource1">required</asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
    </div>
    
    <asp:ObjectDataSource ID="allRolesDataSource" runat="server"
        SelectMethod="GetAllRoles"
        TypeName="System.Web.Security.Roles" >
    </asp:ObjectDataSource>


</asp:Content>

