<%@ Page validaterequest="false" Language="C#" AutoEventWireup="true" CodeFile="ProductReview.aspx.cs" Inherits="Members_ProductReview" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<%@ Register Src="../Modules/ResultMessage.ascx" TagName="ResultMessage" TagPrefix="uc1" %>
<%@ Register Assembly="Xpdt.Web.UI.Ratings" Namespace="Xpdt.Web.UI.WebControls" TagPrefix="Xpdt" %>
<%@ register assembly="MagicAjax" namespace="MagicAjax.UI.Controls" tagprefix="ajax" %>
<%@ Register Assembly="MagicAjax" Namespace="MagicAjax.UI.Controls" TagPrefix="ajax" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Product Review</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <ajax:AjaxPanel ID="Ajaxpanel1" runat="server" meta:resourcekey="Ajaxpanel1Resource1" Height="20%" Width="279px">
        <asp:Panel ID="pnlReview" runat="server" meta:resourcekey="pnlReviewResource1">
        <table width="550" align="center">
            <tr><td align="center"><h1></h1></td></tr>
        </table>
        <table width="550" align="center">
            <tr>
                <td style="width: 399px"><b>
                    <asp:Localize ID="YourRatingContent" runat="server" meta:resourcekey="YourRatingContentResource1" Text="Your Rating"></asp:Localize>:</b>
                    <asp:DropDownList ID="ddlRating" runat="server" meta:resourcekey="ddlRatingResource1">
                        <asp:ListItem Value="1" meta:resourcekey="ListItemResource1">1 - Horrible</asp:ListItem>
                        <asp:ListItem Value="2" meta:resourcekey="ListItemResource2">2 - Not so good</asp:ListItem>
                        <asp:ListItem  Value="3" meta:resourcekey="ListItemResource3">3 - OK, not great</asp:ListItem>
                        <asp:ListItem Selected="True" Value="4" meta:resourcekey="ListItemResource4">4 - Good</asp:ListItem>
                        <asp:ListItem Value="5" meta:resourcekey="ListItemResource5">5 - Excellent</asp:ListItem>
                    </asp:DropDownList>
                   </td>
            </tr>
            <tr>
                <td >
                    <b>
                        <asp:Localize ID="TitleContent" runat="server" meta:resourcekey="TitleContentResource1" Text="Title"></asp:Localize></b><br />
                    <asp:TextBox ID="txtTitle" runat="server" Width="386px" meta:resourcekey="txtTitleResource1"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtTitle"
                        ErrorMessage="Required" meta:resourcekey="RequiredFieldValidator2Resource1"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td style="width: 400px">
                    <b>
                        <asp:Localize ID="ReviewContent" runat="server" meta:resourcekey="ReviewContentResource1" Text="Review"></asp:Localize></b><br />
                    <span class="smalltext">
                        <asp:Localize ID="ReviewDescription" runat="server" meta:resourcekey="ReviewDescriptionResource1" Text="A review should focus on the things you consider both positive and negative about
                    a product. A good tip is to support every thought you have with a concrete example, 
                    such as &quot;I found the phone very hard use as I could not see the buttons clearly
                    when the phone was held at arm's-length&quot;. Your review will itself be graded by our users
                    who find it helpful. The higher the &quot;grade&quot;, the better positioning this review 
                    will receive.
                    
                    Your review will be moderated by our 
                    staff and posted once approved"></asp:Localize>.</span>
                    <asp:TextBox ID="txtReview" runat="server" TextMode="MultiLine" Height="67px" Width="418px" meta:resourcekey="txtReviewResource1"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtReview"
                        ErrorMessage="Required" meta:resourcekey="RequiredFieldValidator1Resource1"></asp:RequiredFieldValidator></td>
            
            </tr>
            <tr>
                <td >
                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1"/>
                <input type="button" value="Close" onclick="window.top.hidePopWin();" />
                </td>
            </tr>
        </table>
        </asp:Panel>
        <asp:Panel ID="pnlFinished" runat="server" meta:resourcekey="pnlFinishedResource1" Height="156px" Width="533px">
        <table width="400px" align="center">
            <tr><td><h2>
                <asp:Localize ID="ThankYouContent" runat="server" meta:resourcekey="ThankYouContentResource1" Text="Thank You"></asp:Localize>!</h2></td></tr>
            <tr><td>
                <asp:Localize ID="ReviewSubmitedContent" runat="server" meta:resourcekey="ReviewSubmitedContentResource1" Text="Your review has been submitted and will be read by one of our staff. If approved, your
               review will appear along with the other reviews from our loyal customers. This usually
               takes up to 2 weeks. Thank you again for your submission"></asp:Localize>.
            </td></tr>
        </table>
        <table width="400px">
            <tr><td align="center" style="height: 15px"><uc1:ResultMessage ID="ResultMessage1" runat="server" /></td></tr>
            <tr><td height="20" align="center"><input type="button" value="Close" onclick="window.top.hidePopWin();" /></td></tr>
        </table>
        </asp:Panel>
        <asp:Panel ID="pnlReviewed" runat="server" Visible="False" meta:resourcekey="pnlReviewedResource1">
          <table width="400px" align="center">
            <tr><td><h2>
                <asp:Localize ID="ReviewReceivedContent" runat="server" meta:resourcekey="ReviewReceivedContentResource1" Text="Your review was already received"></asp:Localize>...</h2></td></tr>
            <tr><td>
                <asp:Localize ID="AlreadyReviewedContent" runat="server" meta:resourcekey="AlreadyReviewedContentResource1" Text="Our records currently indicate that you have already reviewed this product and
               currently we only allow one review per user. If you would like to modify your review, 
               please contact us and let us know"></asp:Localize>.
            </td></tr>
        </table>      
        
        </asp:Panel>
        </ajax:AjaxPanel>
    </form>
</body>
</html>
