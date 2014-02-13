<%@ Page Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="Admin_Product_Add.aspx.cs" Inherits="Admin_Admin_Product_Add" Title="Untitled Page" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>
<%@ Register Src="../Modules/Admin/ProductCrossSells.ascx" TagName="ProductCrossSells"
    TagPrefix="uc6" %>
<%@ Register Src="../Modules/Admin/ProductAttributes.ascx" TagName="ProductAttributes"
    TagPrefix="uc5" %>
<%@ Register Src="../Modules/Admin/ProductCategories.ascx" TagName="ProductCategories"
    TagPrefix="uc4" %>
<%@ Register Src="../Modules/Admin/ProductImages.ascx" TagName="ProductImages" TagPrefix="uc3" %>
<%@ Register Assembly="ComponentArt.Web.UI" Namespace="ComponentArt.Web.UI" TagPrefix="ComponentArt" %>
<%@ Register Src="../Modules/ImageManager.ascx" TagName="ImagePicker" TagPrefix="uc2" %>
<%@ Register Src="../Modules/ResultMessage.ascx" TagName="ResultMessage" TagPrefix="uc1" %>
<%@ Register TagPrefix="ajax" Namespace="MagicAjax.UI.Controls" Assembly="MagicAjax" %>
<%@ Register Assembly="eWorld.UI" Namespace="eWorld.UI" TagPrefix="ew" %>



<asp:Content ID="Content1" ContentPlaceHolderID="AdminPlaceHolder" Runat="Server">


			
			<h1><a href="admin_products.aspx">Productos</a> >>> 
                <asp:Localize ID="AddProductContent" runat="server" meta:resourcekey="AddProductContentResource1" Text="Add a Product"></asp:Localize></h1>
			<table class="admintable">
			    <tr>
			        <td colspan="2" bgcolor="whitesmoke">
			            <h1><asp:Label ID="lblProductName" runat="server" meta:resourcekey="lblProductNameResource1"></asp:Label></h1>
			        
			        </td>
			    </tr>
			    <tr>
			        <td colspan="2">
                        <uc1:ResultMessage ID="ResultMessage1" runat="server" />
			        
			        </td>
			    </tr>
				<tr>
					<td class="adminlabel">Sku</td>
					<td class="adminitem" style="width: 400px">
						<asp:textbox id="txtSku" runat="server" meta:resourcekey="txtSkuResource1" ></asp:textbox>
                        <asp:Label ID="lblID" runat="server" Visible="False" meta:resourcekey="lblIDResource1"></asp:Label></td>
				</tr>
				
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="ProductNameContent" runat="server" meta:resourcekey="ProductNameContentResource1" Text="Product Name"></asp:Localize></td>
					<td class="adminitem" style="width: 400px">
						<asp:textbox id="txtProductName" runat="server" Width="400px" meta:resourcekey="txtProductNameResource1" ></asp:textbox>
					</td>
				</tr>
				
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="ShortDescriptionContent" runat="server" meta:resourcekey="ShortDescriptionContentResource1" Text="Short Description"></asp:Localize></td>
					<td class="adminitem" style="width: 400px">
						<asp:textbox id="txtShortDescription" runat="server" TextMode="MultiLine" Height="60px" Width="400px" meta:resourcekey="txtShortDescriptionResource1"></asp:textbox>
					</td>
				</tr>
				
		
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="OurPriceContent" runat="server" meta:resourcekey="OurPriceContentResource1" Text="Our Price"></asp:Localize></td>
					<td class="adminitem" style="width: 400px">
                        $<ew:NumericBox ID="txtOurPrice" runat="server" width="71px" DecimalPlaces="2" meta:resourcekey="txtOurPriceResource1">0</ew:NumericBox>
					</td>
				</tr>
				
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="RetailPriceContent" runat="server" meta:resourcekey="RetailPriceContentResource1" Text="Retail Price"></asp:Localize></td>
					<td class="adminitem" style="width: 400px">
                        $<ew:NumericBox ID="txtRetailPrice" runat="server" width="71px" DecimalPlaces="2" meta:resourcekey="txtRetailPriceResource1">0</ew:NumericBox>
					</td>
				</tr>
				<ajax:ajaxpanel ID="Ajaxpanel4" runat="server" meta:resourcekey="Ajaxpanel4Resource1">
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="ManufacturerContent" runat="server">Fabricante</asp:Localize></td>
					<td class="adminitem" style="width: 400px">
					    <div>
						<asp:DropDownList id="ddlManufactureID" runat="server"></asp:DropDownList>
                        <asp:TextBox ID="txtQuickMan" runat="server"></asp:TextBox>
                        <asp:Button ID="btnQuickMan" runat="server" OnClick="btnQuickMan_Click" Text="Agregar" />
				        </div>
                        
                        </td>
				</tr>
		        </ajax:ajaxpanel>
				
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="StatusContent" runat="server" meta:resourcekey="StatusContentResource1" Text="Status"></asp:Localize></td>
					<td class="adminitem" style="width: 400px">
						<asp:DropDownList id="ddlStatusID" runat="server" meta:resourcekey="ddlStatusIDResource1"></asp:DropDownList>
					</td>
				</tr>
				
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="ProductTypeContent" runat="server" meta:resourcekey="ProductTypeContentResource1" Text="Product Type"></asp:Localize></td>
					<td class="adminitem" style="width: 400px">
						<asp:DropDownList id="ddlProductTypeID" runat="server" meta:resourcekey="ddlProductTypeIDResource1"></asp:DropDownList>
					</td>
				</tr>
				
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="ShippingTypeContent" runat="server" meta:resourcekey="ShippingTypeContentResource1" Text="Shipping Type"></asp:Localize></td>
					<td class="adminitem" style="width: 400px">
						<asp:DropDownList id="ddlShippingTypeID" runat="server" meta:resourcekey="ddlShippingTypeIDResource1"></asp:DropDownList>
					</td>
				</tr>
				
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="ShipEstimateContent" runat="server" meta:resourcekey="ShipEstimateContentResource1" Text="Ship Estimate"></asp:Localize></td>
					<td class="adminitem" style="width: 400px">
						<asp:DropDownList id="ddlShipEstimateID" runat="server" meta:resourcekey="ddlShipEstimateIDResource1"></asp:DropDownList>
					</td>
				</tr>
				
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="TaxTypeContent" runat="server" meta:resourcekey="TaxTypeContentResource1" Text="Tax Type"></asp:Localize></td>
					<td class="adminitem" style="width: 400px">
						<asp:DropDownList id="ddlTaxTypeID" runat="server" meta:resourcekey="ddlTaxTypeIDResource1"></asp:DropDownList>
					</td>
				</tr>
				
				<tr>
					<td class="adminlabel" style="height: 118px">
                        <asp:Localize ID="StockLocationContent" runat="server" meta:resourcekey="StockLocationContentResource1"></asp:Localize></td>
					<td class="adminitem" style="height: 118px; width: 400px;">
						<asp:textbox id="txtStockLocation" runat="server" Height="100px" TextMode="MultiLine" Width="400px" meta:resourcekey="txtStockLocationResource1" ></asp:textbox>
					</td>
				</tr>
				

				
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="WeightContent" runat="server" meta:resourcekey="WeightContentResource1" Text="Weight"></asp:Localize></td>
					<td class="adminitem" style="width: 400px">
						<ew:NumericBox ID="txtWeight" runat="server" width="41px" DecimalPlaces="2" meta:resourcekey="txtWeightResource1">0</ew:NumericBox>
					</td>
				</tr>
				
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="CurrencyCodeContent" runat="server" meta:resourcekey="CurrencyCodeContentResource1" Text="Currency Code"></asp:Localize></td>
					<td class="adminitem" style="width: 400px">
						<asp:textbox id="txtCurrencyCode" runat="server" Width="41px" Text="USD" meta:resourcekey="txtCurrencyCodeResource1"></asp:textbox>
					</td>
				</tr>
				
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="UnitOfMeasureContent" runat="server" meta:resourcekey="UnitOfMeasureContentResource1" Text="Unit Of Measure"></asp:Localize></td>
					<td class="adminitem" style="width: 400px">
						<asp:textbox id="txtUnitOfMeasure" runat="server" Text="single item" meta:resourcekey="txtUnitOfMeasureResource1"></asp:textbox>
					</td>
				</tr>
				
				<tr>
					<td class="adminlabel" style="height: 29px">
                        <asp:Localize ID="AdminCommentsContent" runat="server" meta:resourcekey="AdminCommentsContentResource1" Text="Admin Comments"></asp:Localize></td>
					<td class="adminitem" style="height: 29px; width: 400px;">
						<asp:textbox id="txtAdminComments" runat="server" TextMode="MultiLine" Height="47px" Width="331px" meta:resourcekey="txtAdminCommentsResource1"></asp:textbox>
					</td>
				</tr>
				
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="DimensionsContent" runat="server" meta:resourcekey="DimensionsContentResource1" Text="Dimensions"></asp:Localize></td>
					<td class="adminitem" style="width: 400px">
                        LO
						<ew:NumericBox ID="txtLength" runat="server" width="24px" meta:resourcekey="txtLengthResource1">0</ew:NumericBox>
                        AL
                        <ew:NumericBox ID="txtHeight" runat="server" Width="24px" meta:resourcekey="txtHeightResource1">0</ew:NumericBox>
                        AN
                        <ew:NumericBox ID="txtWidth" runat="server" Width="24px" meta:resourcekey="txtWidthResource1">0</ew:NumericBox></td>
				</tr>
				
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="DimensionUnitContent" runat="server" meta:resourcekey="DimensionUnitContentResource1" Text="Dimension Unit"></asp:Localize></td>
					<td class="adminitem" style="width: 400px">
						<asp:textbox id="txtDimensionUnit" runat="server" Text="inches" meta:resourcekey="txtDimensionUnitResource1"></asp:textbox>
					</td>
				</tr>
				
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="ListOrderContent" runat="server" meta:resourcekey="ListOrderContentResource1" Text="List Order"></asp:Localize></td>
					<td class="adminitem" style="width: 400px">
						<ew:NumericBox ID="txtListOrder" runat="server" width="24px" meta:resourcekey="txtListOrderResource1">99</ew:NumericBox>
					</td>
				</tr>
				
					
				<Tr>
					<td colspan="2">
					<asp:Button id="btnSave"  runat="server" Text="Save" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1"></asp:Button>&nbsp;
					<input type="button" onclick="location.href='admin_products.aspx'" value="Regresar" />
					
					</td>
				</tr>
			</table>
			

</asp:Content>

