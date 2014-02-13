<%@ Page Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" Title="Manufacturer Administration" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>
<%@ Register Src="../Modules/ResultMessage.ascx" TagName="ResultMessage" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminPlaceHolder" Runat="Server">

<h1>
    <asp:Localize ID="ManufacturersContent" runat="server" meta:resourcekey="ManufacturersContentResource1" Text="Manufacturers"></asp:Localize></h1>
        <asp:Label ID="lblError" runat="server" meta:resourcekey="lblErrorResource1"></asp:Label>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="manufacturerID"
            DataSourceID="SqlDataSource1" meta:resourcekey="GridView1Resource1">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" meta:resourcekey="CommandFieldResource1" />
                <asp:BoundField DataField="manufacturerID" HeaderText="ID" InsertVisible="False"
                    ReadOnly="True" SortExpression="manufacturerID" meta:resourcekey="BoundFieldResource1" />
                <asp:BoundField DataField="manufacturer" HeaderText="Manufacturer" SortExpression="manufacturer" meta:resourcekey="BoundFieldResource2" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CommerceTemplate %>"
            DeleteCommand="DELETE FROM [CSK_Store_Manufacturer] WHERE [manufacturerID] = @manufacturerID"
            InsertCommand="INSERT INTO [CSK_Store_Manufacturer] ([manufacturer]) VALUES (@manufacturer)"
            ProviderName="System.Data.SqlClient" SelectCommand="SELECT [manufacturerID], [manufacturer] FROM [CSK_Store_Manufacturer]"
            UpdateCommand="UPDATE [CSK_Store_Manufacturer] SET [manufacturer] = @manufacturer WHERE [manufacturerID] = @manufacturerID">
            <DeleteParameters>
                <asp:Parameter Name="manufacturerID" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="manufacturer" Type="String" />
                <asp:Parameter Name="manufacturerID" Type="Int32" />
            </UpdateParameters>
            <InsertParameters>
                <asp:Parameter Name="manufacturer" Type="String" />
            </InsertParameters>
        </asp:SqlDataSource>

<br />
<br />
<h2>
    <asp:Localize ID="AddManufacturerContent" runat="server" meta:resourcekey="AddManufacturerContentResource1" Text="Add a Manufacturer"></asp:Localize></h2>
    <p>
        <asp:TextBox ID="txtNewMan" runat="server" meta:resourcekey="txtNewManResource1"></asp:TextBox>
        <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="AddManufacturer" meta:resourcekey="btnAddResource1" /></p>
        

<script runat="server">
    void AddManufacturer(object sender, System.EventArgs e)
    {
        if (txtNewMan.Text != string.Empty)
        {
            SqlDataSource1.InsertParameters["manufacturer"].DefaultValue = txtNewMan.Text;
            SqlDataSource1.Insert();
            Response.Redirect(Request.Url.PathAndQuery);
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Error += new EventHandler(Page_Error);
    }

    void Page_Error(object sender, EventArgs e)
    {
        Server.Transfer("admin_reference_error.aspx");
    }

</script>
</asp:Content>

