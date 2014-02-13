<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProductModulos.ascx.cs" Inherits="Modules_Products_ProductModulos" %>

<div class="productsection">    
    <asp:HiddenField ID="ProductoIdOculto" runat="server" Visible="False" />       
<center>    
    <h2>M&oacute;dulos del Curso</h2>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
    DataSourceID="SqlDataSource1" ForeColor="#333333" Width="90%" HorizontalAlign="Center" >
    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
    <Columns>
        <asp:BoundField DataField="secuence" SortExpression="secuence" >
            <ItemStyle HorizontalAlign="Left" Width="5%" />
            <HeaderStyle Width="5%" />
        </asp:BoundField>
        <asp:BoundField DataField="nombre" HeaderText="Nombre" SortExpression="nombre" >
            <ItemStyle HorizontalAlign="Left" Width="35%" />
            <HeaderStyle Width="35%" />
        </asp:BoundField>
        <asp:BoundField DataField="descripcion" HeaderText="Contenido" SortExpression="descripcion" >
            <ItemStyle HorizontalAlign="Left" Width="60%" />
            <HeaderStyle Width="60%" />
        </asp:BoundField>
    </Columns>
    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
    <EditRowStyle BackColor="#999999" />
    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
</asp:GridView>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CommerceTemplate %>"
    SelectCommand="SELECT [secuence], [nombre], [descripcion] FROM [CSK_Store_Product_Modulos] WHERE (([borrado] = @borrado) AND ([productID] = @productID)) ORDER BY [secuence]">
    <SelectParameters>        
        <asp:Parameter DefaultValue="false" Name="borrado" Type="Boolean" />
        <asp:ControlParameter ControlID="ProductoIdOculto" Name="productID" PropertyName="Value"
            Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
</center>
</div>
