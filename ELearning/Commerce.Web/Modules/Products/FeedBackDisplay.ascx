<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FeedBackDisplay.ascx.cs" Inherits="Modules_Products_FeedBackDisplay" %>
<%@ Register Src="RatingDisplay.ascx" TagName="RatingDisplay" TagPrefix="uc7" %>
    <fieldset>
        <legend><b>
            <asp:Localize ID="TellUsWhatYouThinkContent" runat="server" meta:resourcekey="TellUsWhatYouThinkContentResource1" Text="Tell us what you think"></asp:Localize></b></legend>
         <div class="tenpixspacer"></div>
         <uc7:RatingDisplay ID="RatingDisplay1" runat="server" />
        <div class="twentypixspacer"></div>
        <hr />
        <asp:Localize ID="AddYourReviewContent" runat="server" meta:resourcekey="AddYourReviewContentResource1" Text="Please take a moment to add you review"></asp:Localize>.
        <div class="tenpixspacer"></div>
        <%if (Page.User.Identity.IsAuthenticated) { %>
        <a href="#" onclick="showPopWin('<%=Page.ResolveUrl("~/members/productreview.aspx")%>?id=<%=ProductID.ToString() %>&pn=<%=ProductName.Replace("\"","").Replace("'","") %>',500,300,null)"><b>
            <asp:Localize ID="ReviewItContent1" runat="server" meta:resourcekey="ReviewItContent1Resource1" Text="Review it"></asp:Localize>!</b></a>
        <%} else { %>
        <a href="<%=Page.ResolveUrl("~/login.aspx") %>?ReturnUrl=product.aspx?id=<%=ProductID.ToString() %>"><b>
            <asp:Localize ID="ReviewItContent2" runat="server" meta:resourcekey="ReviewItContent2Resource1" Text="Review it"></asp:Localize>!</b></a>
        <%} %>
        
    </fieldset>