<%@ Page ValidateRequest="false" EnableViewState="false" Language="C#" MasterPageFile="~/site.master"
    AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" Title="Latino E-Learning" %>

<%@ Register Assembly="RssToolkit" Namespace="RssToolkit" TagPrefix="RssToolkit" %>
<%@ Register Src="Modules/MainNavigation.ascx" TagName="MainNavigation" TagPrefix="uc6" %>
<%@ Register Src="Modules/Content/Paragraph.ascx" TagName="Paragraph" TagPrefix="uc5" %>
<%@ Register Src="Modules/AdContainer.ascx" TagName="AdContainer" TagPrefix="uc4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table cellspacing="0" cellpadding="0">
        <tr>
            <td style="width: 170px">
                <uc6:MainNavigation ID="MainNavigation1" runat="server" />
            </td>
            <td style="width: 420px">
                <uc4:AdContainer ID="AdContainer2" runat="server" BoxPlacement="Center" BoxCssClass="">
                </uc4:AdContainer>
                <br />
                <h1>Actividad Reciente en Foros</h1>
                <asp:DataList ID="ForumsDataList" runat="server" CellPadding="4" DataSourceID="ForumsRssDataSource"
                    ForeColor="#333333">
                    <ItemTemplate>
                        <asp:HyperLink ID="PostHyperLink" runat="server" NavigateUrl='<%# Eval("link") %>' Text='<%# Eval("description") %>'></asp:HyperLink>
                    </ItemTemplate>
                </asp:DataList>
                <RssToolkit:RssDataSource ID="ForumsRssDataSource" runat="server" >
                </RssToolkit:RssDataSource>
            </td>
            <td style="width: 185px">
                <uc4:AdContainer ID="AdContainer1" runat="server" BoxPlacement="Right"></uc4:AdContainer>
            </td>
        </tr>
    </table>
</asp:Content>
