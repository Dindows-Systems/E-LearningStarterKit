<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Checkout.aspx.cs"
    Inherits="Checkout" Title="Checkout" Culture="auto" meta:resourcekey="PageResource1"
    UICulture="auto" %>

<%@ Register Src="Modules/Checkout/PaymentBox.ascx" TagName="PaymentBox" TagPrefix="uc6" %>
<%@ Register Src="Modules/AddressEntry.ascx" TagName="AddressEntry" TagPrefix="uc2" %>
<%@ Register Src="Modules/ResultMessage.ascx" TagName="ResultMessage" TagPrefix="uc5" %>
<%@ Register Src="Modules/Content/Paragraph.ascx" TagName="Paragraph" TagPrefix="uc5" %>
<%@ Register Src="Modules/AdContainer.ascx" TagName="AdContainer" TagPrefix="uc4" %>
<%@ Register Src="Modules/CatalogList.ascx" TagName="CatalogList" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="leftcontent">
        <div>
            <uc5:Paragraph ID="paraLeft" runat="server" ContentName="CheckoutTopLeft" />
        </div>
    </div>
    <div id="centercontent">
        <%--<atlas:UpdatePanel ID="WizUpdatePanel" runat="server" Mode="Conditional">
            <ContentTemplate>--%>
        <asp:Panel ID="pnlPayPal" runat="server" meta:resourcekey="pnlPayPalResource1">
            <div class="sectionheader">
                <asp:Localize ID="ShortCutPayPalContent" runat="server" meta:resourcekey="ShortCutPayPalContentResource1"
                    Text="Shortcut for PayPal Users"></asp:Localize></div>
            <div class="tenpixspacer">
            </div>
            <table width="500">
                <tr>
                    <td>
                        <asp:ImageButton ID="imgPayPal" runat="server" ImageUrl="~/images/ExpressCheckout.gif"
                            OnClick="imgPayPal_Click" CausesValidation="False" meta:resourcekey="imgPayPalResource1" /></td>
                    <td class="smalltext">
                        <asp:Localize ID="PayWithPayPalContent" runat="server" meta:resourcekey="PayWithPayPalContentResource1"
                            Text="Save Time. Checkout Securely. Pay without sharing your financial information."></asp:Localize></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <br />
                        <asp:Label ID="lblPPErr" runat="server" ForeColor="Maroon" meta:resourcekey="lblPPErrResource1"></asp:Label></td>
                </tr>
            </table>
            <div class="twentypixspacer">
                <table width="500">
                    <tr>
                        <td>
                            <a href="checkoutppstandard.aspx">
                                <img src="images/paypal_logo.gif" /></a></td>
                        <td class="smalltext">
                            <asp:Localize ID="CheckoutSecurelyPayPalContent" runat="server" meta:resourcekey="CheckoutSecurelyPayPalContentResource1"
                                Text="Checkout securely at PayPal. Our site will be notified when payment is received and we will process your order right away."></asp:Localize></td>
                    </tr>
                </table>
            </div>
        </asp:Panel>
        <br />
        <asp:Wizard ID="wizCheckout" runat="server" ActiveStepIndex="0" CancelDestinationPageUrl="basket.aspx"
            DisplaySideBar="False" Width="570px" OnActiveStepChanged="Step_Changed" meta:resourcekey="wizCheckoutResource1">
            <WizardSteps>
                <asp:WizardStep runat="server" Title="Enter Shipping Info" meta:resourcekey="WizardStepResource1">
                    <table cellpadding="4">
                        <tr>
                            <td>
                                <img src="images/ship_selected.gif" id="Step1ShipSelectedImage" runat="server" /></td>
                            <td>
                                <img src="images/bill_notselected.gif" id="Step1BillNotSelectedImage" runat="server" /></td>
                            <td>
                                <img src="images/confirm_notselected.gif" id="Step1ConfirmNotSelectedImage" runat="server" /></td>
                        </tr>
                    </table>
                    <br />
                    <uc2:AddressEntry ID="addShipping" runat="server" UseAddressBook="true" />
                </asp:WizardStep>
                <asp:WizardStep runat="server" Title="Billing" meta:resourcekey="WizardStepResource2">
                    <table cellpadding="4">
                        <tr>
                            <td>
                                <asp:ImageButton ID="imgShip" runat="server" ImageUrl="~/images/ship_notselected.gif"
                                    OnClick="imgShip_Click" meta:resourcekey="imgShipResource1" /></td>
                            <td>
                                <img src="images/bill_selected.gif" id="Step2BillSelectedImage" runat="server" /></td>
                            <td>
                                <img src="images/confirm_notselected.gif" id="Step2ConfirmNotSelectedImage" runat="server" /></td>
                        </tr>
                    </table>
                    <br />
                    <uc6:PaymentBox ID="PaymentBox1" runat="server"></uc6:PaymentBox>
                    <br />
                    <div class="sectionheader">
                        <asp:Localize ID="BillingAddressContent" runat="server" meta:resourcekey="BillingAddressContentResource1"
                            Text="Billing Address"></asp:Localize></div>
                    <uc2:AddressEntry ID="addBilling" runat="server" UseAddressBook="true" />
                    <table>
                        <tr>
                            <td>
                                <asp:CheckBox ID="TermsConditionsCheckBox" runat="server" />
                            </td>
                            <td>
                            Acepto los <a href="TermsConditions.aspx" target="_blank">T&eacute;rminos y Condiciones de Venta</a>
                            </td>
                        </tr>
                    </table>
                </asp:WizardStep>
                <asp:WizardStep ID="wizConfirm" runat="server" Title="Confirm And Submit Your Order"
                    meta:resourcekey="wizConfirmResource1">
                    <asp:Panel ID="pnlFinalHeadNav" runat="server" meta:resourcekey="pnlFinalHeadNavResource1">
                        <table cellpadding="4">
                            <tr>
                                <td>
                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/ship_notselected.gif"
                                        OnClick="ImageButton1_Click" meta:resourcekey="ImageButton1Resource1" /></td>
                                <td>
                                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/bill_notselected.gif"
                                        OnClick="ImageButton2_Click" meta:resourcekey="ImageButton2Resource1" /></td>
                                <td>
                                    <img src="images/confirm_selected.gif" id="Step2ConfirmSelectedImage" runat="server" /></td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:Panel ID="pnlReceipt" runat="server" Visible="False" meta:resourcekey="pnlReceiptResource1">
                        <table width="570">
                            <tr>
                                <td>
                                    <h1>
                                        <asp:Localize ID="OrderContent" runat="server" meta:resourcekey="OrderContentResource1"
                                            Text="Order"></asp:Localize>
                                        <asp:Localize ID="IsCompleteContent" runat="server" meta:resourcekey="IsCompleteContentResource1"
                                            Text="Is Complete"></asp:Localize>!</h1>
                                    <br />
                                    <b><asp:Localize ID="OrderNumberContent" runat="server" meta:resourcekey="OrderNumberContentResource1"
                                        Text="Order Number"></asp:Localize></b>:&nbsp;<asp:Label ID="OrderNumberLabel" runat="server"></asp:Label>
                                    <br />
                                    <b><asp:Localize ID="TransactionCodeContent" runat="server" meta:resourcekey="TransactionCodeContentResource1"
                                        Text="Transaction Code"></asp:Localize></b>:&nbsp;<asp:Label ID="TransactionCodeLabel" runat="server"></asp:Label>
                                    <br />
                                    <b><asp:Localize ID="StatusContent" runat="server" meta:resourcekey="StatusContentResource1"
                                        Text="Status"></asp:Localize></b>:&nbsp;
                                    <asp:Label ID="TransactionStatusLabel" runat="server"></asp:Label>
                                    
                                    <br />
                                    <br />
                                    <asp:Localize ID="KeepReceiptContent" runat="server" meta:resourcekey="KeepReceiptContentResource1"
                                        Text="Please keep this number handy as we'll ask you for it should you need to return your items."></asp:Localize>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <br />
                    <table width="100%">
                        <tr>
                        <%if (!currentOrder.IsDigitalOrder())
                          { %>
                            <td>
                                <div class="sectionheader">
                                    <asp:Localize ID="ShipToContent" runat="server" meta:resourcekey="ShipToContentResource1"
                                        Text="Ship To"></asp:Localize>:</div>
                                <asp:Label ID="lblShipTo" runat="server" meta:resourcekey="lblShipToResource1"></asp:Label>
                            </td>
                             <%} %>
                            <td>
                                <div class="sectionheader">
                                    <asp:Localize ID="BillToContent" runat="server" meta:resourcekey="BillToContentResource1"
                                        Text="Bill To"></asp:Localize>:</div>
                                <asp:Label ID="lblBillTo" runat="server" meta:resourcekey="lblBillToResource1"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <div class="twentypixspacer">
                    </div>
                    <div class="sectionheader">
                        <asp:Localize ID="PaymentSummaryContent" runat="server" meta:resourcekey="PaymentSummaryContentResource1"
                            Text="Payment Summary"></asp:Localize></div>
                    <asp:Label ID="lblPaySummary" runat="server" meta:resourcekey="lblPaySummaryResource1"></asp:Label>
                    <br />
                    <div class="twentypixspacer">
                    </div>
                    <%if (!currentOrder.IsDigitalOrder())
                      { %>
                    <div class="sectionheader">
                        <asp:Localize ID="ShippingOptionsContent" runat="server" meta:resourcekey="ShippingOptionsContentResource1"
                            Text="Shipping Options"></asp:Localize></div>
                    <asp:RadioButtonList ID="radShipChoices" runat="server" AutoPostBack="True" OnSelectedIndexChanged="radShipChoices_SelectedIndexChanged"
                        BorderStyle="None" meta:resourcekey="radShipChoicesResource1">
                    </asp:RadioButtonList>
                     <%} %>
                    <div class="twentypixspacer">
                    </div>
                    <div class="twentypixspacer">
                    </div>
                    <div class="sectionheader">
                        <asp:Localize ID="OrderItemsContent" runat="server" meta:resourcekey="OrderItemsContentResource1"
                            Text="Order Items"></asp:Localize>:</div>
                    <asp:Label ID="lblOrderItems" runat="server" meta:resourcekey="lblOrderItemsResource1"></asp:Label>
                </asp:WizardStep>
            </WizardSteps>
            <FinishNavigationTemplate>
            </FinishNavigationTemplate>
            <StartNavigationTemplate>
            </StartNavigationTemplate>
            <StepNavigationTemplate>
            </StepNavigationTemplate>
        </asp:Wizard>
        <asp:Panel ID="pnlNav" runat="server" meta:resourcekey="pnlNavResource1">
            <br />
            <table width="400">
                <tr>
                    <td align="right">
                        <asp:Button ID="btnPrev" runat="server" Visible="False" OnClick="btnPrev_Click" meta:resourcekey="btnPrevResource1" />
                        <asp:Button ID="btnNext" runat="server" Text="Billing &gt;&gt;" OnClick="btnNext_Click"
                            meta:resourcekey="btnNextResource1" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnlComplete" runat="server" Visible="False" meta:resourcekey="pnlCompleteResource1">
            <table width="570">
                <tr>
                    <td align="right">
                        <asp:Button ID="btnComplete" runat="server" Text="Place Your Order" OnClick="btnComplete_Click"
                            CausesValidation="False" meta:resourcekey="btnCompleteResource1" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <uc5:ResultMessage ID="ResultMessage1" runat="server" Visible="true" />
        <%--</ContentTemplate>
        </atlas:UpdatePanel>--%>
        <%--<atlas:UpdateProgress ID="uProgress" runat="server">
            <ProgressTemplate>
                <div class="loadingbox">
                    <img src="images/spinner.gif" align="absmiddle" />&nbsp;&nbsp;<asp:Label ID="lblProgress"
                        runat="server" meta:resourcekey="lblProgressResource1">
                        <asp:Localize ID="ProcessingContent" runat="server" meta:resourcekey="ProcessingContentResource1"
                            Text="Processing"></asp:Localize>...</asp:Label>
                </div>
            </ProgressTemplate>
        </atlas:UpdateProgress>--%>
    </div>
</asp:Content>
