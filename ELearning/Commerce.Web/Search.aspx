<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="Search" Title="Search Results" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>
<%@ Register Src="Modules/ResultMessage.ascx" TagName="ResultMessage" TagPrefix="uc7" %>
<%@ Register Src="Modules/MainNavigation.ascx" TagName="MainNavigation" TagPrefix="uc6" %>
<%@ Register Src="Modules/Content/Paragraph.ascx" TagName="Paragraph" TagPrefix="uc5" %>
<%@ Register Src="Modules/AdContainer.ascx" TagName="AdContainer" TagPrefix="uc4" %>
<%@ Register Assembly="Xpdt.Web.UI.Ratings" Namespace="Xpdt.Web.UI.WebControls" TagPrefix="Xpdt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="leftcontent">
        <uc6:MainNavigation ID="MainNavigation1" runat="server" />
    </div>
    <div id="centercontent">
<h1>
    <asp:Localize ID="SearchResultsContent" runat="server" meta:resourcekey="SearchResultsContentResource1" Text="Search Results"></asp:Localize><asp:Label ID="lblQuery" runat="server" meta:resourcekey="lblQueryResource1"></asp:Label></h1>
    <table width="700">
        <asp:Repeater ID="rptSearch" runat="server" >
            <ItemTemplate>
                <tr>
                    <td>
                    <a href='product.aspx?id=<%# Eval("productID") %>'>
						<img src='<%# Eval("ProductImage") %>' height="70px">
					</a>
					</td>
                    <td>
                        <div>
                            <a href='product.aspx?id=<%# Eval("productID") %>'>
                                <%# Eval("productName") %>
                            </a>
                            <br />
                            <div>
                                <%# Eval("shortDescription") %>
                            </div>
                            
                            
                            <div class="ourprice">
                                <%# decimal.Parse(Eval("ourPrice").ToString()).ToString("C") %>
                            </div>
                            <div class="usuallyships">
                                <Xpdt:Rater ID="pRating" runat="server" 
                                      DisplayOnly="True"
                                      ToolTipFormat="Average Rating is {0} over {1}"
                                      DisplayValue='<%# Convert.ToDouble(Eval("Rating").ToString()) %>'

                                      ></Xpdt:Rater>
                                
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <div class="sectionseparator">
                        </div>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
    <uc7:ResultMessage ID="ResultMessage1" runat="server" />
</div>
</asp:Content>

