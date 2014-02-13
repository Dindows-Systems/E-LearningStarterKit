<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="PasswordRecover.aspx.cs" Inherits="PasswordRecover" Title="Recover Password" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div id="leftcontent"></div>
<div id="centercontent">
   <h1>
       <asp:Localize ID="RecoverPasswordContent" runat="server" meta:resourcekey="RecoverPasswordContentResource1" Text="Recover Your Password"></asp:Localize></h1>
    <p>
        <asp:PasswordRecovery ID="PasswordRecovery1" runat="server" meta:resourcekey="PasswordRecovery1Resource1">
            <FailureTextStyle CssClass="errorbox" />
            <TitleTextStyle CssClass="sectionheader" />
            <InstructionTextStyle CssClass="plainbox" />
            <LabelStyle CssClass="checkoutlabel" />

        </asp:PasswordRecovery>
        &nbsp;</p>
</div>
<div id="rightcontent"></div>
</asp:Content>

