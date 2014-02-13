<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProductModulos.ascx.cs" Inherits="Modules_Admin_ProductModulos" %>
<script language="javascript" type="text/javascript">
// <!CDATA[

function Button1_onclick() {

}

// ]]>
</script>


<table class="admintable1" >
<tr>
<td>
<table border="0">
    <tr>
        <td style="height:30px"><span style="font-size: 11pt"><strong>M&oacute;dulos del Producto</strong></span></td>
    </tr>
    <tr>
        <td>       
             <asp:GridView AlternatingRowStyle-HorizontalAlign="Center" ID="GridModulos" runat="server" AutoGenerateColumns="False" Width="500px" CellPadding="4"
                DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" BorderColor="ActiveBorder" >
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" EditText="<img src='../images/icons/corregir.gif' title='Corregir' alt='Corregir' />" DeleteText="<img src='../images/icons/borrar.gif' title='Borrar' alt='Borrar' />" UpdateText="<img src='/Commerce.Web/images/icons/icon_disk.gif' title='Grabar' alt='Grabar' />" CancelText="<img src='/Commerce.Web/images/icons/cancelar.gif' title='Cancelar' alt='Cancelar' />" />

                    <asp:BoundField DataField="secuence" HeaderText="C&#243;digo" ReadOnly="True" SortExpression="secuence" >
                        <ItemStyle HorizontalAlign="Left" Width="50px" />
                        <HeaderStyle HorizontalAlign="Left" Width="50px"  />
                    </asp:BoundField>
                    <asp:BoundField DataField="nombre" HeaderText="Nombre" SortExpression="nombre"> 
                        <ItemStyle HorizontalAlign="Left" Width="50px"/>
                        <HeaderStyle HorizontalAlign="Left" Width="50px"/>
                    </asp:BoundField>
                    <asp:BoundField DataField="descripcion" HeaderText="Descripci&#243;n" SortExpression="descripcion" >
                        <ItemStyle HorizontalAlign="Left" Wrap="True" Width="100px" />
                        <HeaderStyle HorizontalAlign="Left" Wrap="True" Width="100px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ruta_descargar" HeaderText="Ruta Descarga" SortExpression="ruta_descargar" >
                        <ItemStyle HorizontalAlign="Left" Wrap="True" Width="100px" />
                        <HeaderStyle HorizontalAlign="Left" Wrap="True" Width="100px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ruta_reproducir" HeaderText="Ruta Reproducci&#243;n" SortExpression="ruta_reproducir" >
                        <ItemStyle HorizontalAlign="Left" Wrap="True" Width="100px" />
                        <HeaderStyle HorizontalAlign="Left" Wrap="True" Width="100px" />
                    </asp:BoundField>
                </Columns>
                <RowStyle BackColor="#EFF3FB" />    
                <EditRowStyle BackColor="#2461BF" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" HorizontalAlign="Center" />
            </asp:GridView>
                &nbsp;
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CommerceTemplate %>"
                SelectCommand="SELECT productID, secuence, nombre, descripcion, dbo.CortarPalabras(ruta_descargar, 10, CHAR(13)) AS ruta_descargar, dbo.CortarPalabras(ruta_reproducir, 15, CHAR(13)) AS ruta_reproducir FROM CSK_Store_Product_Modulos WHERE (productID = @productID) AND (borrado = @borrado) ORDER BY productID, secuence" 
                ConflictDetection="CompareAllValues" 
                DeleteCommand="update CSK_Store_Product_Modulos set borrado=1 WHERE (productID = @original_productID) AND (secuence = @original_secuence)" 
                OldValuesParameterFormatString="original_{0}" 
                UpdateCommand="UPDATE CSK_Store_Product_Modulos SET nombre = @nombre, descripcion = @descripcion, ruta_descargar = @ruta_descargar, ruta_reproducir = @ruta_reproducir WHERE (productID = @original_productID) AND (secuence = @original_secuence)"
                InsertCommand="CSK_Store_Product_Modulo_Insert"                     
                InsertCommandType="StoredProcedure" >

                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="" Name="productID" QueryStringField="id"
                        Type="Int32" />
                    <asp:Parameter DefaultValue="0" Name="borrado" />
                </SelectParameters>
                <DeleteParameters>        
                    <asp:QueryStringParameter DefaultValue="" Name="original_productID" QueryStringField="id" Type="Int32" />
                    <asp:Parameter Name="original_secuence" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="nombre" Type="String" />
                    <asp:Parameter Name="descripcion" Type="String" />
                    <asp:Parameter Name="ruta_descargar" Type="String" />
                    <asp:Parameter Name="ruta_reproducir" Type="String" />        
                    <asp:QueryStringParameter DefaultValue="" Name="original_productID" QueryStringField="id" Type="Int32" />
                    <asp:Parameter Name="original_secuence" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                        <asp:QueryStringParameter DefaultValue="" Name="productID" QueryStringField="id"
                            Type="Int32" />
                </InsertParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td style="height:30px"><br/><strong>Agegar Nuevo M&oacute;dulo</strong></td>
    </tr>
    <tr>
        <td >
             <asp:DetailsView ID="DetailsView1" runat="server" DataSourceID="SqlDataSource1" DefaultMode="Insert"
                Height="50px" Width="300px" AutoGenerateRows="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                <Fields>            
                    <asp:BoundField DataField="nombre" HeaderText="Nombre" >
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="descripcion" HeaderText="Descripci&#243;n" >
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ruta_descargar" HeaderText="Ruta Descarga">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ruta_reproducir" HeaderText="Ruta Reproducci&#243;n">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:CommandField CancelText="Cancelar" InsertText="Guardar" ShowInsertButton="True" >
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:CommandField>
                </Fields>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            </asp:DetailsView>
        </td>
    </tr>
</table>
</td>
</tr>
</table>
