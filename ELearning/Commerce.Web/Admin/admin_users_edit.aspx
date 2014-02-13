<%@ Page Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="admin_users_edit.aspx.cs" Inherits="admin_user_edit" Title="Edit User" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminPlaceHolder" Runat="Server">

<table cellspacing="0" cellpadding="0" border="0"  width="500">
    <tbody>
    <tr align="left" valign="top">
        <td width="62%" height="100%" class="lbBorders">

            <table class="bodyText" cellspacing="0" width="100%" cellpadding="0" border="0">
                <tr class="callOutStyleLowLeftPadding">
                    <td colspan="4">
                        <h1><asp:literal ID="ActionTitle" runat="server" text="Edit User" meta:resourcekey="ActionTitleResource1" /></h1>
                    </td>                    
                </tr>
                <tr id="trResultRow" runat="server" visible="false">
                    <td colspan="4">
                        <asp:Label ID="lblMessage" runat="server" ForeColor="Red" meta:resourcekey="lblMessageResource1" />
                        <br />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="bodyText" bordercolor="#ccddef">
                            <tr>
                                <td width="2"></td>
                                <td colspan="2">
                                    <h2><asp:label runat="server" id="Label3" text="User Details" meta:resourcekey="Label3Resource1"/></h2>
                                    <br />
                                    <br />                                                                                                
                                </td>
                            </tr>
                            <tr>
                                <td width="2"></td>
                                <td>
                                    <asp:Label ID="Label1" runat="server" AssociatedControlID="UserID" Text="Username:" meta:resourcekey="Label1Resource1"/>
                                </td>
                                <td>
                                    <asp:textbox runat="server" id="UserID" maxlength="255" tabindex="101" Columns="30" meta:resourcekey="UserIDResource1" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserID" Display="Dynamic" meta:resourcekey="RequiredFieldValidator1Resource1">required</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td width="2"></td>
                                <td>
                                    <asp:Label ID="Label2" runat="server" AssociatedControlID="Email" Text="Email Address: " meta:resourcekey="Label2Resource1"/>
                                </td>
                                <td>
                                    <asp:textbox runat="server" id="Email" maxlength="128" tabindex="102" Columns="30" meta:resourcekey="EmailResource1" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Email" Display="Dynamic" meta:resourcekey="RequiredFieldValidator2Resource1">required</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr id="PasswordRow" runat="server" visible="false">
                                <td width="2"></td>
                                <td>
                                    <asp:Label ID="lblPassword" runat="server" AssociatedControlID="Password" Text="Password: " meta:resourcekey="lblPasswordResource1"/>
                                </td>
                                <td>
                                    <asp:textbox runat="server" id="Password" maxlength="50" tabindex="103" Columns="20" TextMode="Password" meta:resourcekey="PasswordResource2" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="Password" Display="Dynamic" meta:resourcekey="RequiredFieldValidator3Resource1">required</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr id="NewPasswordRow" runat="server" visible="false">
                                <td width="2"></td>
                                <td>
                                    <asp:Label ID="lblNewPassword" runat="server" AssociatedControlID="NewPassword" Text="New Password: " meta:resourcekey="lblNewPasswordResource1"/>
                                </td>
                                <td>
                                    <asp:textbox runat="server" id="NewPassword" maxlength="50" tabindex="103" Columns="20" meta:resourcekey="NewPasswordResource2" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="NewPassword" Display="Dynamic" meta:resourcekey="RequiredFieldValidator6Resource1">required</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr id="SecretQuestionRow" runat="server" visible="false">
                                <td width="2"></td>
                                <td>
                                    <asp:Label ID="Label5" runat="server" AssociatedControlID="SecretQuestion" Text="Secret Question: " meta:resourcekey="Label5Resource1"/>
                                </td>
                                <td>
                                    <asp:textbox runat="server" id="SecretQuestion" maxlength="128" tabindex="104" Columns="30" meta:resourcekey="SecretQuestionResource1" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="SecretQuestion" Display="Dynamic" meta:resourcekey="RequiredFieldValidator4Resource1">required</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr id="SecretAnswerRow" runat="server" visible="false">
                                <td width="2"></td>
                                <td>
                                    <asp:Label ID="Label6" runat="server" AssociatedControlID="SecretAnswer" Text="Secret Answer: " meta:resourcekey="Label6Resource1"/>
                                </td>
                                <td>
                                    <asp:textbox runat="server" id="SecretAnswer" maxlength="128" tabindex="105" Columns="30" meta:resourcekey="SecretAnswerResource1" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="SecretAnswer" Display="Dynamic" meta:resourcekey="RequiredFieldValidator5Resource1">required</asp:RequiredFieldValidator>
                                </td>
                            </tr>  
                            <tr>
                                <td width="2"></td>
                                <td colspan="2">
                                    <asp:checkbox runat="server" id="ActiveUser" text="Active User" TabIndex="106" meta:resourcekey="ActiveUserResource1"/>
                                </td>
                            </tr>   
                                                        <tr>
                                <td width="2"></td>
                                <td colspan="2">
                                    <asp:button runat="server" id="ResetPassword" text="Reset Password" TabIndex="107" OnClick="ResetPassword_Click" meta:resourcekey="ResetPasswordResource1"/>
                                    <asp:button runat="server" id="unlockUser" text="Unlock Account" TabIndex="107" OnClick="unlockAccount_Click" meta:resourcekey="unlockUserResource1"/></td>
                            </tr>                                                      
                                                  
                            <tr valign="top">
                                <td width="2"></td>
                                <td  class="userDetailsWithFontSize" height="100%" colspan="2">
                                    <br />
                                    <h2><asp:label runat="server" id="SelectRolesLabel" text="Select User Roles" meta:resourcekey="SelectRolesLabelResource1"/></h2>
                                    <br />
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td width="2"></td>
                                <td colspan="2">
                                    <asp:repeater runat="server" id="CheckBoxRepeater">
                                        <itemtemplate>
                                            <asp:checkbox runat="server" id="checkBox1" text='<%# Container.DataItem.ToString() %>' checked='<%# IsUserInRole(Container.DataItem.ToString()) %>' meta:resourcekey="checkBox1Resource1"/>
                                            <br/>
                                        </itemtemplate>
                                    </asp:repeater>
                                </td>
                            </tr>
                            <tr>                                
                               <td colSpan="3">
                                    <br />
                                    <asp:button runat="server" id="SaveButton" onClick="SaveClick" text="Save" width="100px" meta:resourcekey="SaveButtonResource1"/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <br /><br />
                                    <a href="admin_users.aspx">Regresar a la lista de usuarios</a>
                                </td>
                            </tr>
                        </table>                        
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    </tbody>
</table>

</asp:Content>

