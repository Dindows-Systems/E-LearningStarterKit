<%@ Page Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="Admin_Logs.aspx.cs" Inherits="Admin_Admin_Logs" Title="View Site Logs" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminPlaceHolder" Runat="Server">


        <h1>
            <asp:Localize ID="SiteLogsContent" runat="server" meta:resourcekey="SiteLogsContentResource1" Text="Site Logs"></asp:Localize></h1>
        <asp:Localize ID="SiteLogsDescriptionContent" runat="server" meta:resourcekey="SiteLogsDescriptionContentResource1" Text="These logs represent all user activity on the site. For Application Logs, check the Event Viewer (or whichever&#13;&#10;        Log Source is specified in the site configuration)"></asp:Localize>.
        <br />
        
        <br />
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataSourceID="SqlDataSource1" PageSize="20" Width="500px" meta:resourcekey="GridView1Resource1">
            <Columns>
                <asp:BoundField DataField="createdOn" HeaderText="Date" SortExpression="createdOn" 
                DataFormatString="{0:d}" HtmlEncode="False" meta:resourcekey="BoundFieldResource1"/>
                <asp:BoundField DataField="userName" HeaderText="User" SortExpression="userName" meta:resourcekey="BoundFieldResource2" />
                <asp:BoundField DataField="behavior" HeaderText="Behavior" SortExpression="behavior" meta:resourcekey="BoundFieldResource3" />
                <asp:BoundField DataField="pageURL" HeaderText="Page" SortExpression="pageURL" meta:resourcekey="BoundFieldResource4" />
                <asp:BoundField DataField="productName" HeaderText="Product" SortExpression="productName" meta:resourcekey="BoundFieldResource6" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CommerceTemplate %>"
            SelectCommand="SELECT CSK_Stats_Tracker.createdOn, CSK_Stats_Tracker.userName, 
            CSK_Stats_Behavior.behavior, CSK_Stats_Tracker.pageURL, 
            CSK_Store_Category.categoryName, 
            CSK_Store_Product.productName 
            FROM CSK_Stats_Tracker 
            INNER JOIN CSK_Stats_Behavior 
            ON CSK_Stats_Tracker.behaviorID = CSK_Stats_Behavior.behaviorID 
            LEFT OUTER JOIN CSK_Store_Category 
            ON CSK_Stats_Tracker.categoryID = 
            CSK_Store_Category.categoryID 
            LEFT OUTER JOIN CSK_Store_Product ON 
            CSK_Stats_Tracker.productSKU = 
            CSK_Store_Product.sku ORDER BY 
            CSK_Stats_Tracker.createdOn DESC">
        </asp:SqlDataSource>
        <br />
        


</asp:Content>

