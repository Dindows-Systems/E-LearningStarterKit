<%@ Page Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="admin_users.aspx.cs" Inherits="Admin_admin_users" Title="User Administration" Trace="false" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>
<%@ Register Namespace="Commerce.Web.UI.Controls" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminPlaceHolder" Runat="Server">

    <h1>
        <asp:Localize ID="UserAdministrationContent" runat="server" meta:resourcekey="UserAdministrationContentResource1" Text="User Administration"></asp:Localize></h1>

    <div style="padding-bottom:5px" >
        <a href="admin_users_edit.aspx">[+] Agregar Usuario</a>
    </div>
    
    <br />
    
    <table cellspacing="0" cellpadding="0" class="lrbBorders" width="500">
        <tr >
            <td class="bodyTextLowTopPadding">
                <asp:Label ID="Label1" runat="server" AssociatedControlID="SearchByDropDown" Text="Search By: " Font-Bold="True" meta:resourcekey="Label1Resource1"/>
                <asp:dropDownList runat="server" id="SearchByDropDown" meta:resourcekey="SearchByDropDownResource1">
                    <asp:listItem text="Username" meta:resourcekey="ListItemResource1" />
                    <asp:listitem text="Email" meta:resourcekey="ListItemResource2" />
                </asp:dropdownlist>
                &nbsp;&nbsp;<asp:Label ID="Label2" runat="server" AssociatedControlID="TextBox1" meta:resourcekey="Label2Resource1"/>
                <asp:textbox runat="server" id="TextBox1" meta:resourcekey="TextBox1Resource1"/>
                <asp:button ID="Button1" runat="server" text="Search for Users" onclick="SearchForUsers" meta:resourcekey="Button1Resource1"/>
                <br/>
            </td>
        </tr>
    </table>

    <br />

    <asp:GridView ID="GridView1" runat="server" 
        AutoGenerateColumns="False" 
        DataSourceID="allUsersDataSource" 
        EmptyDataText="There are no matching users in the system." 
        Font-Italic="False" meta:resourcekey="GridView1Resource1" >
        <Columns>
            <asp:templatefield headertext="Active" meta:resourcekey="TemplateFieldResource1">
                <headerstyle horizontalalign="Center"/>
                <itemstyle horizontalalign="Center" Width="40px"/>
                <itemtemplate>
                    <asp:checkBox runat="server" id="CheckBox1" oncheckedchanged="EnabledChanged" autopostback="True" checked='<%# DataBinder.Eval(Container.DataItem, "IsApproved") %>' meta:resourcekey="CheckBox1Resource1"/>
                </itemtemplate>
            </asp:templatefield>
            <asp:templatefield headertext="User Name" meta:resourcekey="TemplateFieldResource2" >
                <itemtemplate>
                    <a href='admin_users_edit.aspx?username=<%# Eval("UserName") %>'>
                        <%# DataBinder.Eval(Container.DataItem, "UserName") %>
                    </a>
                </itemtemplate>
                <ItemStyle Width="160px" />
            </asp:templatefield>                            
            <asp:TemplateField HeaderText="Email" meta:resourcekey="TemplateFieldResource3">
                <ItemTemplate>
                    <asp:HyperLink ID="EmailLink" runat="server" NavigateUrl='<%# Eval("Email", "mailto:{0}") %>' Text='<%# Eval("Email") %>' meta:resourcekey="EmailLinkResource1"></asp:HyperLink>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Left" Width="180px" />
            </asp:TemplateField>
            <asp:BoundField DataField="CreationDate" HeaderText="Created On" ReadOnly="True" SortExpression="CreationDate" meta:resourcekey="BoundFieldResource1">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="LastLoginDate" HeaderText="Last Login" SortExpression="LastLoginDate" meta:resourcekey="BoundFieldResource2">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:templatefield meta:resourcekey="TemplateFieldResource4">
                <itemtemplate>
                    <asp:linkButton runat="server" id="linkButton2" text="Delete" commandname="delete" commandargument='<%# DataBinder.Eval(Container.DataItem, "UserName") %>' forecolor="Black" oncommand="LinkButtonClick" meta:resourcekey="linkButton2Resource1"/>
                </itemtemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:templatefield>
        </Columns>
        <EmptyDataRowStyle Font-Italic="True" />
    </asp:GridView>

    <div style="margin-top:5px ">
        <cc1:HyperLinkPager ID="Pager1" runat="server" DataSourceID="allUsersDataSource" PageSize="5" CurrentPageStringFormat="P&aacute;gina {0} de {1} ({2} registros) &nbsp;-&nbsp; " FirstPageText="&lt;&lt;" LastPageText="&gt;&gt;" meta:resourcekey="Pager1Resource1" NextPageText="&gt;" PreviousPageText="&lt;" ShowCurrentPage="True" TotalRecords="0" />
    </div>
    
    <br />
           
    <asp:ObjectDataSource ID="allUsersDataSource" runat="server" 
        SelectMethod="GetAllUsers" 
        TypeName="System.Web.Security.Membership" 
        OnSelected="allUsersDataSource_Selected">
        <SelectParameters>
            <asp:ControlParameter ControlID="Pager1" PropertyName="PageIndex" Name="pageIndex" DefaultValue="0" />
            <asp:ControlParameter ControlID="Pager1" PropertyName="PageSize" Name="pageSize" DefaultValue="10" />
            <asp:ControlParameter ControlID="Pager1" PropertyName="TotalRecords" Name="totalRecords" DefaultValue="0" Direction="Output" />
        </SelectParameters>
    </asp:ObjectDataSource>

        
</asp:Content>

