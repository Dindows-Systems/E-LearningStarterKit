<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Receipt.aspx.cs" Inherits="Receipt" Title="Receipt" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>
<%@ Register Src="Modules/Content/Paragraph.ascx" TagName="Paragraph" TagPrefix="uc5" %>
<%@ Register Src="Modules/AdContainer.ascx" TagName="AdContainer" TagPrefix="uc4" %>
<%@ Register Src="Modules/RecentCategories.ascx" TagName="RecentCategories" TagPrefix="uc2" %>
<%@ Register Src="Modules/RecentProductsViewed.ascx" TagName="RecentProductsViewed"
    TagPrefix="uc3" %>
<%@ Register Src="Modules/CatalogList.ascx" TagName="CatalogList" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table style="width:770px" border="0">
<tr>        
        <td style="width:25%">
         <%if (RecentCategories1.GetCount() > 0)  { %>
        <uc2:RecentCategories ID="RecentCategories1" runat="server" />
        <%} %>
         <uc1:CatalogList id="CatalogList1" runat="server">
        </uc1:CatalogList>
         <br />
         <uc4:AdContainer id="AdContainer1" runat="server" BoxPlacement="Left" >
        </uc4:AdContainer>
       
        </td>
        <td style="width:75%">

            <asp:Label ID="lblReceipt" runat="server" meta:resourcekey="lblReceiptResource1"></asp:Label>
            <%if (order.PaymentMethodId == Commerce.Common.PaymentMethod.BankDeposit)
              { %>
            <br />
            <table>
                <tr><td colspan="2" style="font-weight:bold">&nbsp;&nbsp;<b><asp:Localize ID="BankDepositContent"
                        runat="server" meta:resourcekey="BankDepositContentResource1" Text="Bank Deposit"></asp:Localize></b></td></tr>
                <tr><td colspan="2" style='border-top:1px solid #cccccc'>&nbsp;</td></tr>
                <tr><td style="padding-right: 10px; padding-left: 10px; padding-bottom: 10px;"><b >
                    <asp:Localize ID="BankDepositNumberContent" runat="server" meta:resourcekey="BankDepositNumberContentResource1" Text="Bank Deposit Number"></asp:Localize>:</b></td>
                <td><asp:TextBox ID="BankDepositNumberTextBox" runat="server" meta:resourcekey="BankDepositNumberTextBoxResource1"/></td></tr>
                <tr>
                    <td style="padding-right: 10px; padding-left: 10px; padding-bottom: 10px;">
                        <asp:Button ID="SaveDepositNumberButton" runat="server" OnClick="PayOrderButton_Click"
                            Text="Save" meta:resourcekey="SaveDepositNumberButtonResource1" /></td>
                    <td>
                        <asp:Label ID="DepositNumberSavedLabel" runat="server" meta:resourcekey="DepositNumberSavedLabelResource1"></asp:Label></td>
                </tr>
            </table>
        <%} %>
        </td>
    </tr>
    </table> 
</asp:Content>

