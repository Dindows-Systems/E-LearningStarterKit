<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PaymentBox.ascx.cs" Inherits="Modules_Checkout_PaymentBox" %>

<div class="sectionheader">
    <asp:Localize ID="PaymentMethodContent" runat="server" meta:resourcekey="PaymentMethodContentResource1" Text="Payment Method"></asp:Localize></div>
<asp:DropDownList ID="PaymentMethodDropDownList" runat="server" OnSelectedIndexChanged="PaymentMethodDropDownList_SelectedIndexChanged" AutoPostBack="True" meta:resourcekey="PaymentMethodDropDownListResource1">
    <asp:ListItem Value="1" meta:resourcekey="ListItemResource1">Credit Card</asp:ListItem>
    <asp:ListItem Value="2" meta:resourcekey="ListItemResource2">Bank Deposit</asp:ListItem>
</asp:DropDownList>
<br /><br />
<asp:Panel ID="CreditCardPanel" runat="server" Height="50px" Width="125px" meta:resourcekey="CreditCardPanelResource1">
<div class="sectionheader">
        <asp:Localize ID="PayByCreditCardContent" runat="server" meta:resourcekey="PayByCreditCardContentResource1" Text="Pay By Credit Card"></asp:Localize></div>
    <table width="550" cellpadding="2">
        <tr>
            <td class="checkoutlabel" style="width: 150px">
                <asp:Localize ID="CreditCardTypeContent" runat="server" meta:resourcekey="CreditCardTypeContentResource1" Text="Credit Card Type"></asp:Localize></td>
            <td>
                <asp:DropDownList ID="ddlCCType" runat="server" meta:resourcekey="ddlCCTypeResource1">
                    <asp:ListItem Value="1" Selected="True" meta:resourcekey="ListItemResource3">Visa</asp:ListItem>
                    <asp:ListItem Value="2" meta:resourcekey="ListItemResource4">MasterCard</asp:ListItem>
                    <asp:ListItem Value="3" meta:resourcekey="ListItemResource5">AMEX</asp:ListItem>
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td class="checkoutlabel" style="width: 150px; height: 23px;">
                <asp:Localize ID="CreditCardNumberContent" runat="server" meta:resourcekey="CreditCardNumberContentResource1" Text="Credit Card Number"></asp:Localize></td>
            <td style="height: 23px">
                <asp:TextBox runat="server" ID="txtCCNumber" Width="276px" meta:resourcekey="txtCCNumberResource1"></asp:TextBox><asp:RequiredFieldValidator
                    ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtCCNumber" ErrorMessage="Required" meta:resourcekey="RequiredFieldValidator7Resource1"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td class="checkoutlabel" style="width: 150px">
                <asp:Localize ID="SecurityCodeContent" runat="server" meta:resourcekey="SecurityCodeContentResource1" Text="Security Code"></asp:Localize></td>
            <td>
                <asp:TextBox runat="server" ID="txtCCAuthCode" Width="38px" meta:resourcekey="txtCCAuthCodeResource1"></asp:TextBox><asp:RequiredFieldValidator
                    ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtCCAuthCode"
                    ErrorMessage="Required" meta:resourcekey="RequiredFieldValidator8Resource1"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td class="checkoutlabel" style="width: 150px">
                <asp:Localize ID="ExpirationContent" runat="server" meta:resourcekey="ExpirationContentResource1" Text="Expiration"></asp:Localize></td>
            <td>
                <asp:DropDownList ID="ddlExpMonth" runat="server" Width="49px" meta:resourcekey="ddlExpMonthResource1">
                    <asp:ListItem Value="1" meta:resourcekey="ListItemResource6">01</asp:ListItem>
                    <asp:ListItem Value="2" meta:resourcekey="ListItemResource7">02</asp:ListItem>
                    <asp:ListItem Value="3" meta:resourcekey="ListItemResource8">03</asp:ListItem>
                    <asp:ListItem Value="4" meta:resourcekey="ListItemResource9">04</asp:ListItem>
                    <asp:ListItem Value="5" meta:resourcekey="ListItemResource10">05</asp:ListItem>
                    <asp:ListItem Value="6" meta:resourcekey="ListItemResource11">06</asp:ListItem>
                    <asp:ListItem Value="7" meta:resourcekey="ListItemResource12">07</asp:ListItem>
                    <asp:ListItem Value="8" meta:resourcekey="ListItemResource13">08</asp:ListItem>
                    <asp:ListItem Value="9" meta:resourcekey="ListItemResource14">09</asp:ListItem>
                    <asp:ListItem Value="10" meta:resourcekey="ListItemResource15">10</asp:ListItem>
                    <asp:ListItem Value="11" meta:resourcekey="ListItemResource16">11</asp:ListItem>
                    <asp:ListItem Value="12" meta:resourcekey="ListItemResource17">12</asp:ListItem>
                </asp:DropDownList>&nbsp;
                <asp:DropDownList ID="ddlExpYear" runat="server" Width="73px" meta:resourcekey="ddlExpYearResource1">
                </asp:DropDownList></td>
        </tr>
    </table>
</asp:Panel>
    