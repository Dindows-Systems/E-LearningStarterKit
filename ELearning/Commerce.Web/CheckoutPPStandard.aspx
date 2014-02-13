<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="CheckoutPPStandard.aspx.cs" Inherits="CheckoutPPStandard" Title="PayPal Checkout" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<%@ Register Src="Modules/AddressEntry.ascx" TagName="AddressEntry" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div id="centercontent">
        <img src="images/paypal_logo.gif" />
        <h1>
            <asp:Localize ID="CheckoutPayPalContent" runat="server" meta:resourcekey="CheckoutPayPalContentResource1" Text="Checkout with PayPal"></asp:Localize></h1>
        <asp:Wizard ID="Wizard1" runat="server" DisplaySideBar="False" OnActiveStepChanged="StepChanged" ActiveStepIndex="2" meta:resourcekey="Wizard1Resource1">
            <WizardSteps>
                <asp:WizardStep runat="server" Title="Enter Shipping Info" meta:resourcekey="WizardStepResource1">
                   <div class="sectionheader">
                       <asp:Localize ID="EnterShippingAddressContent" runat="server" meta:resourcekey="EnterShippingAddressContentResource1">Enter Shipping Address</asp:Localize></div><br />
                   <uc1:AddressEntry ID="AddressEntry1" runat="server" />
                </asp:WizardStep>
                <asp:WizardStep runat="server" Title="Select Shipping" meta:resourcekey="WizardStepResource2">
                <div class="sectionheader">
                    <asp:Localize ID="SelectShippingContent" runat="server" meta:resourcekey="SelectShippingContentResource1">Select Shipping</asp:Localize></div><br />
                    <asp:RadioButtonList ID="radShipChoices" runat="server" BorderStyle="None" AutoPostBack="True" OnSelectedIndexChanged="radShipChoices_SelectedIndexChanged" meta:resourcekey="radShipChoicesResource1"></asp:RadioButtonList><br />
                </asp:WizardStep>
                <asp:WizardStep ID="WizardStep1" runat="server" Title="Finalize" meta:resourcekey="WizardStep1Resource1">
                    <div class="sectionheader">
                        <asp:Localize ID="ConfirmYourOrderContent" runat="server" meta:resourcekey="ConfirmYourOrderContentResource1">Confirm Your Order</asp:Localize></div><br />
                   <div class=plainbox>
                       <asp:Localize ID="RedirectToPayPalContent" runat="server" meta:resourcekey="RedirectToPayPalContentResource1">You are about to be redirected to PayPal.com to purchase this order. 
                    Once payment is completed, please be sure to let PayPal redirect you 
                    back to this site. When PayPal redirects you, they send along your transaction 
                    information which we need in order to complete and reconcile your payment.</asp:Localize>
                    </div>
                    <br />
                    <center>
                       <asp:Button ID=btnContinue runat=server Text="Finish" OnClick="btnContinue_Click" meta:resourcekey="btnContinueResource1"/><br />
                    </center>                
        </asp:WizardStep>
            </WizardSteps>
            <FinishNavigationTemplate></FinishNavigationTemplate>
        </asp:Wizard>
        <div class="sectionheader">
            <br />
            <asp:Localize ID="OrderSummaryContent" runat="server" meta:resourcekey="OrderSummaryContentResource1" Text="Order Summary"></asp:Localize></div>
        <br />
        <div>
            <asp:Label ID="lblSummary" runat="server" meta:resourcekey="lblSummaryResource1"></asp:Label>
        </div>
    </div>
</asp:Content>

