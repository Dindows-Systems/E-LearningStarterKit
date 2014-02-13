<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProductAttributes.ascx.cs" Inherits="Modules_Admin_ProductAttributes" %>
<%@ Register Assembly="eWorld.UI" Namespace="eWorld.UI" TagPrefix="ew" %>
 <h1>
     <asp:Localize ID="AttributesContent" runat="server" meta:resourcekey="AttributesContentResource1" Text="Attributes"></asp:Localize></h1>

&nbsp;<b><asp:Localize ID="LoadListFromTemplateContent" runat="server" meta:resourcekey="LoadListFromTemplateContentResource1" Text="Load this list from a template"></asp:Localize>:</b>                 
<asp:DropDownList ID="ddlAttTemplates" runat="server" meta:resourcekey="ddlAttTemplatesResource1">
</asp:DropDownList>
<asp:Button ID="btnSetTemplate" runat="server" OnClick="btnSetTemplate_Click" Text="Set" meta:resourcekey="btnSetTemplateResource1" />

     <table class="admintable1">
         <tr>
             <td>
                 <asp:Label ID="lblID" runat="server" Visible="False" meta:resourcekey="lblIDResource1"></asp:Label>
                 <table width="500" cellspacing="0">
                     <tr>
                         <td class="adminlabel">
                             <asp:Localize ID="AttributeNameContent" runat="server" meta:resourcekey="AttributeNameContentResource1" Text="Attribute Name"></asp:Localize></td>
                         <td class="adminitem">
                             <asp:TextBox ID="txtAttributeNew" runat="server" Width="174px" meta:resourcekey="txtAttributeNewResource1"></asp:TextBox>
                             <asp:Button ID="btnSaveAttTemplate" runat="server" OnClick="btnSaveAttTemplate_Click"
                                 Text="Save As Template" meta:resourcekey="btnSaveAttTemplateResource1" /><asp:Label ID="lblTemplateSaved" runat="server" meta:resourcekey="lblTemplateSavedResource1"></asp:Label>
                         </td>
                     </tr>
                      <tr>
                         <td class="adminlabel">
                             <asp:Localize ID="SelectionTypeContent" runat="server" meta:resourcekey="SelectionTypeContentResource1" Text="Selection Type"></asp:Localize>
                         </td>
                         <td class="adminitem">
                             <asp:DropDownList ID="ddlAttNewSelectionType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlAttNewSelectionType_SelectedIndexChanged" meta:resourcekey="ddlAttNewSelectionTypeResource1">
                                 <asp:ListItem Value="0" meta:resourcekey="ListItemResource1">Single Selection List</asp:ListItem>
                                 <asp:ListItem Value="1" meta:resourcekey="ListItemResource2">Multi-Select</asp:ListItem>
                                 <asp:ListItem Value="2" meta:resourcekey="ListItemResource3">User Input</asp:ListItem>
                             </asp:DropDownList></td>
                     </tr>                  
                      <tr>
                         <td class="adminlabel">
                             <asp:Localize ID="DescriptionContent" runat="server" meta:resourcekey="DescriptionContentResource1" Text="Description"></asp:Localize></td>
                         <td class="adminitem">
                             <asp:TextBox ID="txtAttNewDesc" runat="server" Height="46px" TextMode="MultiLine"
                                 Width="174px" meta:resourcekey="txtAttNewDescResource1"></asp:TextBox></td>
                     </tr>
                     <tr>
                         <td class="adminlabel">
                             <asp:Localize ID="SelectionsContent" runat="server" meta:resourcekey="SelectionsContentResource1" Text="Selections"></asp:Localize><br />
                             <br />
                             <asp:Localize ID="AdjustPriceContent" runat="server" meta:resourcekey="AdjustPriceContentResource1" Text="You can adjust the price based on the selection. Make sure it's negative for a discount!"></asp:Localize></td>
                         <td class="adminitem">
                             <asp:Panel ID="pnlSelections" runat="server" meta:resourcekey="pnlSelectionsResource1">
                             <br />
                             <table style="border: 1px dashed gray">
                                 <tr>
                                     <td>
                                         <asp:DataGrid ID="dgSells" runat="server" AutoGenerateColumns="False" OnDeleteCommand="removeSelection"
                                             Width="302px" meta:resourcekey="dgSellsResource1">
                                             <Columns>
                                                 <asp:ButtonColumn CommandName="Delete" Text="Eliminar" meta:resourcekey="ButtonColumnResource1"></asp:ButtonColumn>
                                                 <asp:BoundColumn DataField="Value" HeaderText="Selecci&#243;n"></asp:BoundColumn>
                                                 <asp:BoundColumn DataField="priceAdjustment" DataFormatString="{0:c}" HeaderText="Ajuste">
                                                 </asp:BoundColumn>
                                             </Columns>
                                         </asp:DataGrid>
                                     </td>
                                 </tr>
                                 <tr>
                                     <td>
                                         <asp:Localize ID="SelectionNameContent" runat="server" meta:resourcekey="SelectionNameContentResource1" Text="Selection Name"></asp:Localize><br />
                                         <asp:TextBox ID="txtSelectionAdd" runat="server" meta:resourcekey="txtSelectionAddResource1"></asp:TextBox>
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtSelectionAdd"
                                             Display="Dynamic" ErrorMessage="Required" meta:resourcekey="RequiredFieldValidator2Resource1"></asp:RequiredFieldValidator></td>
                                 </tr>
                                 <tr>
                                     <td>
                                         <asp:Localize ID="PriceAdjustmentContent" runat="server" meta:resourcekey="PriceAdjustmentContentResource1" Text="Price Adjustment"></asp:Localize><br />
                                         <asp:TextBox ID="txtPriceAdjustment" runat="server" Width="82px" meta:resourcekey="txtPriceAdjustmentResource1">0</asp:TextBox>
                                         <asp:Button ID="btnAddAtt" runat="server" Text="Add" OnClick="btnAddAtt_Click" meta:resourcekey="btnAddAttResource1" />
                                         <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtPriceAdjustment"
                                             ErrorMessage="Must be a number" MaximumValue="9999999999" MinimumValue="-99999999"
                                             SetFocusOnError="True" Type="Currency" Display="Dynamic" meta:resourcekey="RangeValidator1Resource1"></asp:RangeValidator>
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtPriceAdjustment"
                                             Display="Dynamic" ErrorMessage="Required" meta:resourcekey="RequiredFieldValidator1Resource1"></asp:RequiredFieldValidator></td>
                                 </tr>
                             </table>
                             </asp:Panel>
                             <br />
                         </td>
                     </tr>

                 </table>
                 <asp:Button ID="btnAddAttribute" runat="server" Text="Add" OnClick="btnAddAttribute_Click" meta:resourcekey="btnAddAttributeResource1" />
                 <br />
                 <br />
                 <asp:DataGrid ID="dgAtts" runat="server" Width="650px" AutoGenerateColumns="False"
                     OnDeleteCommand="DeleteAtt" meta:resourcekey="dgAttsResource1">
                     <Columns>
                         <asp:BoundColumn DataField="Name" HeaderText="Atributo"></asp:BoundColumn>
                         <asp:BoundColumn DataField="SelectionList" HeaderText="Selecciones"></asp:BoundColumn>
                         <asp:BoundColumn DataField="SelectionType" HeaderText="Tipo"></asp:BoundColumn>
                         <asp:ButtonColumn ButtonType="PushButton" CommandName="Delete" Text="Eliminar" meta:resourcekey="ButtonColumnResource2"></asp:ButtonColumn>
                     </Columns>
                 </asp:DataGrid>
</td> </tr> </table> 
