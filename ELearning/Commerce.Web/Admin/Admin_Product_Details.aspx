<%@ Page ValidateRequest="false" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="Admin_Product_Details.aspx.cs" Inherits="Admin_Admin_Product_Details" Title="Product Administration" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<%@ Register Src="../Modules/Admin/ProductDescriptors.ascx" TagName="ProductDescriptors"
    TagPrefix="uc7" %>
<%@ Register Src="../Modules/Admin/ProductCrossSells.ascx" TagName="ProductCrossSells"
    TagPrefix="uc6" %>
<%@ Register Src="../Modules/Admin/ProductAttributes.ascx" TagName="ProductAttributes"
    TagPrefix="uc5" %>
<%@ Register Src="../Modules/Admin/ProductCategories.ascx" TagName="ProductCategories"
    TagPrefix="uc4" %>
    <%@ Register Src="../Modules/Admin/ProductModulos.ascx" TagName="ProductModulos"
    TagPrefix="uc7" %>
<%@ Register Src="../Modules/Admin/ProductImages.ascx" TagName="ProductImages" TagPrefix="uc3" %>
<%@ Register Src="../Modules/ImageManager.ascx" TagName="ImagePicker" TagPrefix="uc2" %>
<%@ Register Src="../Modules/ResultMessage.ascx" TagName="ResultMessage" TagPrefix="uc1" %>
<%@ Register Assembly="eWorld.UI" Namespace="eWorld.UI" TagPrefix="ew" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminPlaceHolder" Runat="Server">		

     <atlas:UpdateProgress ID="uProgress" runat="server">
        <ProgressTemplate>
        <div class="loadingbox">
            <img src="../images/spinner.gif" align="absmiddle"/>&nbsp;&nbsp;<asp:Localize ID="ProcessingContent"
                runat="server" meta:resourcekey="ProcessingContentResource1" Text="Processing"></asp:Localize>...
        </div>
        </ProgressTemplate>
     </atlas:UpdateProgress> 
   
    <h1><a href="admin_products.aspx">Productos</a> >>> 
        <asp:Localize ID="ProductDetailsContent" runat="server" meta:resourcekey="ProductDetailsContentResource1" Text="Product Details"></asp:Localize> >>> <asp:Label ID="lblProductName" runat="server" meta:resourcekey="lblProductNameResource1"></asp:Label></h1>
      <atlas:UpdatePanel ID="WizUpdatePanel" runat="server" Mode="Conditional" >
      <ContentTemplate>    

    <uc1:ResultMessage ID="ResultMessage1" runat="server" />
    
    <table width="400px" >
        <tr>
            <td>
                <br />
                <table cellpadding="4" cellspacing="1" style="background-color:lightsteelblue">
                    <tr><td style="background-color:whitesmoke"><asp:LinkButton ID="lnkMain" runat="server" OnClick="lnkMain_Click" CausesValidation="False" meta:resourcekey="lnkMainResource1">Main</asp:LinkButton></td></tr>
                    <tr><td style="background-color: whitesmoke"><asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="false" OnClick="lnkModulos_Click">M&oacute;dulos</asp:LinkButton></td></tr>
                    <tr><td style="background-color:whitesmoke"><asp:LinkButton ID="lnkDesc" runat="server" OnClick="lnkDesc_Click"  CausesValidation="False" meta:resourcekey="lnkDescResource1">Descriptive Sections</asp:LinkButton></td></tr>
                    <tr><td style="background-color:whitesmoke"><asp:LinkButton ID="LinkButton1" runat="server" OnClick="lnkCat_Click" CausesValidation="False" meta:resourcekey="LinkButton1Resource1">Categories</asp:LinkButton></td></tr>
                    <tr><td style="background-color:whitesmoke"><asp:LinkButton ID="lnkAtt" runat="server" OnClick="lnkAtt_Click" CausesValidation="False" meta:resourcekey="lnkAttResource1">Attributes</asp:LinkButton></td></tr>
                    <tr><td style="background-color:whitesmoke"><asp:LinkButton ID="lnkImages" runat="server" OnClick="lnkImages_Click" CausesValidation="False" meta:resourcekey="lnkImagesResource1">Images</asp:LinkButton></td></tr>
                    <tr><td style="background-color:whitesmoke"><asp:LinkButton ID="lnkCross" runat="server" OnClick="lnkCross_Click" CausesValidation="False" meta:resourcekey="lnkCrossResource1">Cross-Sells</asp:LinkButton></td></tr>
                </table>
           
            </td>
            <td>
                    <asp:Panel ID="pnlMain" runat="server" meta:resourcekey="pnlMainResource1">
			            
			            <h1>
                            <asp:Localize ID="MainInfoContent" runat="server" meta:resourcekey="MainInfoContentResource1" Text="Main Info"></asp:Localize></h1>
			            <table class="admintable1" >
				            <tr>
					            <td class="adminlabel">Sku</td>
					            <td class="adminitem" >
						            <asp:textbox id="txtSku" runat="server" meta:resourcekey="txtSkuResource1" ></asp:textbox>
                                    <asp:Label ID="lblID" runat="server" Visible="False" meta:resourcekey="lblIDResource1"></asp:Label></td>
				            </tr>
            				
				            <tr>
					            <td class="adminlabel">
                                    <asp:Localize ID="ProductNameContent" runat="server" meta:resourcekey="ProductNameContentResource1" Text="Product Name"></asp:Localize></td>
					            <td class="adminitem" >
						            <asp:textbox id="txtProductName" runat="server" Width="400px" meta:resourcekey="txtProductNameResource1" ></asp:textbox>
					            </td>
				            </tr>
            				
				            <tr>
					            <td class="adminlabel">
                                    <asp:Localize ID="ShortDescriptionContent" runat="server" meta:resourcekey="ShortDescriptionContentResource1" Text="Short Description"></asp:Localize></td>
					            <td class="adminitem" >
						            <asp:textbox id="txtShortDescription" runat="server" TextMode="MultiLine" Height="60px" Width="400px" meta:resourcekey="txtShortDescriptionResource1"></asp:textbox>
					            </td>
				            </tr>

            				
				            <tr>
					            <td class="adminlabel">
                                    <asp:Localize ID="OurPriceContent" runat="server" meta:resourcekey="OurPriceContentResource1" Text="Our Price"></asp:Localize></td>
					            <td class="adminitem" >
                                    $<ew:NumericBox ID="txtOurPrice" runat="server" width="71px" DecimalPlaces="2" meta:resourcekey="txtOurPriceResource1">0</ew:NumericBox>
					            </td>
				            </tr>
            				
				            <tr>
					            <td class="adminlabel">
                                    <asp:Localize ID="RetailPriceContent" runat="server" meta:resourcekey="RetailPriceContentResource1" Text="Retail Price"></asp:Localize></td>
					            <td class="adminitem" >
                                    $<ew:NumericBox ID="txtRetailPrice" runat="server" width="71px" DecimalPlaces="2" meta:resourcekey="txtRetailPriceResource1">0</ew:NumericBox>
					            </td>
				            </tr>
				            <tr>
					            <td class="adminlabel">
                                    <asp:Localize ID="ManufacturerContent" runat="server" meta:resourcekey="ManufacturerContentResource1" Text="Manufacturer"></asp:Localize></td>
					            <td class="adminitem" >
					              
						            <asp:DropDownList id="ddlManufactureID" runat="server" meta:resourcekey="ddlManufactureIDResource1"></asp:DropDownList>
                                    <asp:TextBox ID="txtQuickMan" runat="server" meta:resourcekey="txtQuickManResource1"></asp:TextBox>
                                    <asp:Button ID="btnQuickMan" runat="server" OnClick="btnQuickMan_Click" Text="Quick Add" meta:resourcekey="btnQuickManResource1" />
				                    
                                    
                                    </td>
				            </tr>
            				
				            <tr>
					            <td class="adminlabel">
                                    <asp:Localize ID="StatusContent" runat="server" meta:resourcekey="StatusContentResource1" Text="Status"></asp:Localize></td>
					            <td class="adminitem" >
						            <asp:DropDownList id="ddlStatusID" runat="server" meta:resourcekey="ddlStatusIDResource1"></asp:DropDownList>
					            </td>
				            </tr>
            				
				            <tr>
					            <td class="adminlabel">
                                    <asp:Localize ID="ProductTypeContent" runat="server" meta:resourcekey="ProductTypeContentResource1" Text="Product Type"></asp:Localize></td>
					            <td class="adminitem" >
						            <asp:DropDownList id="ddlProductTypeID" runat="server" meta:resourcekey="ddlProductTypeIDResource1"></asp:DropDownList>
					            </td>
				            </tr>
            				
				            <tr>
					            <td class="adminlabel">
                                    <asp:Localize ID="ShippingTypeContent" runat="server" meta:resourcekey="ShippingTypeContentResource1" Text="Shipping Type"></asp:Localize></td>
					            <td class="adminitem" >
						            <asp:DropDownList id="ddlShippingTypeID" runat="server" meta:resourcekey="ddlShippingTypeIDResource1"></asp:DropDownList>
					            </td>
				            </tr>
            				
				            <tr>
					            <td class="adminlabel">
                                    <asp:Localize ID="ShipEstimateContent" runat="server" meta:resourcekey="ShipEstimateContentResource1" Text="Ship Estimate"></asp:Localize></td>
					            <td class="adminitem" >
						            <asp:DropDownList id="ddlShipEstimateID" runat="server" meta:resourcekey="ddlShipEstimateIDResource1"></asp:DropDownList>
					            </td>
				            </tr>
            				
				            <tr>
					            <td class="adminlabel">
                                    <asp:Localize ID="TaxTypeContent" runat="server" meta:resourcekey="TaxTypeContentResource1" Text="Tax Type"></asp:Localize></td>
					            <td class="adminitem" >
						            <asp:DropDownList id="ddlTaxTypeID" runat="server" meta:resourcekey="ddlTaxTypeIDResource1"></asp:DropDownList>
					            </td>
				            </tr>
            				
				            <tr>
					            <td class="adminlabel" style="height: 118px">
                                    <asp:Localize ID="StockLocationContent" runat="server" meta:resourcekey="StockLocationContentResource1" Text="Stock Location"></asp:Localize></td>
					            <td class="adminitem" style="height: 118px;">
						            <asp:textbox id="txtStockLocation" runat="server" Height="100px" TextMode="MultiLine" Width="400px" meta:resourcekey="txtStockLocationResource1" ></asp:textbox>
					            </td>
				            </tr>
            				

            				
				            <tr>
					            <td class="adminlabel">
                                    <asp:Localize ID="WeightContent" runat="server" meta:resourcekey="WeightContentResource1" Text="Weight"></asp:Localize></td>
					            <td class="adminitem" >
						            <ew:NumericBox ID="txtWeight" runat="server" width="41px" DecimalPlaces="2" meta:resourcekey="txtWeightResource1">0</ew:NumericBox>
					            </td>
				            </tr>
            				
				            <tr>
					            <td class="adminlabel">
                                    <asp:Localize ID="CurrencyCodeContent" runat="server" meta:resourcekey="CurrencyCodeContentResource1" Text="Currency Code"></asp:Localize></td>
					            <td class="adminitem" >
						            <asp:textbox id="txtCurrencyCode" runat="server" Width="41px" Text="USD" meta:resourcekey="txtCurrencyCodeResource1"></asp:textbox>
					            </td>
				            </tr>
            				
				            <tr>
					            <td class="adminlabel">
                                    <asp:Localize ID="UnitOfMeasureContent" runat="server" meta:resourcekey="UnitOfMeasureContentResource1" Text="Unit Of Measure"></asp:Localize></td>
					            <td class="adminitem" >
						            <asp:textbox id="txtUnitOfMeasure" runat="server" Text="single item" meta:resourcekey="txtUnitOfMeasureResource1"></asp:textbox>
					            </td>
				            </tr>
            				
				            <tr>
					            <td class="adminlabel" style="height: 29px">
                                    <asp:Localize ID="AdminCommentsContent" runat="server" meta:resourcekey="AdminCommentsContentResource1" Text="Admin Comments"></asp:Localize></td>
					            <td class="adminitem" style="height: 29px;">
						            <asp:textbox id="txtAdminComments" runat="server" TextMode="MultiLine" Height="47px" Width="331px" meta:resourcekey="txtAdminCommentsResource1"></asp:textbox>
					            </td>
				            </tr>
            				
				            <tr>
					            <td class="adminlabel">
                                    <asp:Localize ID="DimensionsContent" runat="server" meta:resourcekey="DimensionsContentResource1" Text="Dimensions"></asp:Localize></td>
					            <td class="adminitem" >
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
					            <td class="adminitem">
						            <asp:textbox id="txtDimensionUnit" runat="server" Text="inches" meta:resourcekey="txtDimensionUnitResource1"></asp:textbox>
					            </td>
				            </tr>
            				
				            <tr>
					            <td class="adminlabel">
                                    <asp:Localize ID="ListOrderContent" runat="server" meta:resourcekey="ListOrderContentResource1" Text="List Order"></asp:Localize></td>
					            <td class="adminitem" >
						            <ew:NumericBox ID="txtListOrder" runat="server" width="24px" meta:resourcekey="txtListOrderResource1">99</ew:NumericBox>
					            </td>
				            </tr>
            				
            					
				            <Tr>
					            <td colspan="2">
					            <asp:Button id="btnSave"  runat="server" Text="Save" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1"></asp:Button>&nbsp;
					            <input type="button" onclick="location.href='admin_products.aspx'" value="Retornar" />&nbsp;
					            <asp:Button id="btnDelete" runat="server" CausesValidation="False" Text="Delete" OnClick="btnDelete_Click" meta:resourcekey="btnDeleteResource1" ></asp:Button></td>
				            </tr>
			            </table>
			           
                    
                    </asp:Panel>
                    
                    <asp:Panel ID="pnlDescriptions" runat="server" meta:resourcekey="pnlDescriptionsResource1">
				         
                        <uc7:ProductDescriptors id="ProductDescriptors1" runat="server">
                        </uc7:ProductDescriptors>
                    </asp:Panel>
                     <!-- Alex Armijos: Inicio -->
                    <asp:Panel ID="pnlModulos" runat="server">                    
                        <uc7:ProductModulos id="ProductModulos1" runat="server">
                        </uc7:ProductModulos>                    
                    </asp:Panel>
                   <!-- Alex Armijos: Fin -->

                    <asp:Panel ID="pnlImages" runat="server" meta:resourcekey="pnlImagesResource1">
			            <div id="divImages">
                            <uc3:ProductImages id="ProductImages1" runat="server">
                            </uc3:ProductImages>
                        </div>
                    
                    </asp:Panel>
                    
                    <asp:Panel ID="pnlCategories" runat="server" meta:resourcekey="pnlCategoriesResource1">
			            
                            <uc4:ProductCategories ID="ProductCategories1" runat="server" />
                        
                    </asp:Panel>       
                    <asp:Panel ID="pnlAtts" runat="server" meta:resourcekey="pnlAttsResource1">
                        
                            <uc5:ProductAttributes id="ProductAttributes1" runat="server">
                            </uc5:ProductAttributes>
                         
                         
                    </asp:Panel>
                    
                    <asp:Panel ID="pnlCross" runat="server" meta:resourcekey="pnlCrossResource1">
                        
                             <uc6:ProductCrossSells id="ProductCrossSells1" runat="server">
                             </uc6:ProductCrossSells>
                         
                    
                    </asp:Panel>
            </td>
        </tr>
    </table>
</ContentTemplate>
</atlas:UpdatePanel>


          
			<script type="text/javascript">
			function CheckDelete(){
					
				return confirm("¿Eliminar este registro? Esta acción es irreversible...");

			}


			</script>


</asp:Content>

