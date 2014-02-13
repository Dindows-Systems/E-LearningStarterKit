<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ReviewDisplay.ascx.cs" Inherits="Modules_Products_ReviewDisplay" %>
 <%@ register assembly="MagicAjax" namespace="MagicAjax.UI.Controls" tagprefix="ajax" %>
<%@ Register Assembly="Xpdt.Web.UI.Ratings" Namespace="Xpdt.Web.UI.WebControls" TagPrefix="Xpdt" %>
        <ajax:AjaxPanel ID="Ajaxpanel2" runat="server" meta:resourcekey="Ajaxpanel2Resource1">
        <div class="productsection">
            <h2>
                <asp:Localize ID="CustomerReviewsContent" runat="server" meta:resourcekey="CustomerReviewsContentResource1" Text="Customer Reviews"></asp:Localize></h2>            
            <asp:Repeater ID="rptReviews" runat="server" OnItemCommand="PostReviewResponse">
                <ItemTemplate>
                <asp:Label ID="lblReviewID" runat="server" Visible="False" Text='<%# Eval("reviewID") %>' meta:resourcekey="lblReviewIDResource1"></asp:Label>
                <table width="600">
                    <tr>
                        <td colspan="2">
                            <Xpdt:Rater ID="rvRating" runat="server" 
                              DisplayOnly="True"
                              DisplayValue='<%# Convert.ToInt16(Eval("rating")) %>'
                              ></Xpdt:Rater>&nbsp;
                              <b>
                                  <%# Eval("title") %>
                              </b>, 
                            <%# Eval("PostDate") %>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                         <b>
                             <asp:Localize ID="ReviewerContent" runat="server" meta:resourcekey="ReviewerContentResource1" Text="Reviewer"></asp:Localize>: 
                             <%# Eval("authorname") %>
                         </b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <%# Eval("Body") %>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                        <h3>
                            <asp:Localize ID="ReviewHelpfulContent" runat="server" meta:resourcekey="ReviewHelpfulContentResource1" Text="Was this review helpful"></asp:Localize>? </h3> 
                        <asp:Button ID="btnYes" CommandName="Yes" runat="server" Text="Yes" meta:resourcekey="btnYesResource1" />&nbsp;
                        <asp:Button ID="btnNo" CommandName="No" runat="server" Text="No" meta:resourcekey="btnNoResource1"/>
                        <b><asp:Label ID="lblThanks" runat="server" meta:resourcekey="lblThanksResource1"></asp:Label></b>
                       </td>
                    </tr>
                </table>

                
                </ItemTemplate>
                
            </asp:Repeater>
        </div>
        </ajax:AjaxPanel>
