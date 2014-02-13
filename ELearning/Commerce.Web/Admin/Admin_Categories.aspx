<%@ Page validaterequest="false" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="Admin_Categories.aspx.cs" Inherits="Admin_Admin_Categories" Title="Categories Admin" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>
<%@ Register Src="../Modules/ResultMessage.ascx" TagName="ResultMessage" TagPrefix="uc2" %>
<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>
<%@ Register Src="../Modules/ImageManager.ascx" TagName="ImagePicker" TagPrefix="uc1" %>
<%@ Register TagPrefix="componentart" Namespace="ComponentArt.Web.UI" Assembly="ComponentArt.Web.UI" %>
<%@Register Assembly="eWorld.UI" Namespace="eWorld.UI" TagPrefix="ew" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminPlaceHolder" Runat="Server">


	<h1>
        <asp:Localize ID="CategoryAdministrationContent" runat="server" meta:resourcekey="CategoryAdministrationContentResource1" Text="Category Administration"></asp:Localize></h1>
	<table>
	    <tr>
	        <td valign="top">
	        	<COMPONENTART:TREEVIEW id="TreeView1" runat="server" AutoPostBackOnNodeMove="True" AutoPostBackOnNodeRename="True"
		            SpacerImageUrl="../images/tree/spacer.gif" CollapseImageUrl="../images/tree/exp.gif" ExpandImageUrl="../images/tree/col.gif"
		            ParentNodeImageUrl="../images/tree/folders.gif" LeafNodeImageUrl="../images/tree/folder.gif"
		            DragAndDropEnabled="True" ClientScriptLocation="../js/tree/"
		            LineImagesFolderUrl="../images/tree/lines" ShowLines="True" NodeLabelPadding="3"
		            DefaultImageHeight="16" DefaultImageWidth="16" LineImageHeight="20" LineImageWidth="19" NodeEditCssClass="NodeEdit"
		            HoverNodeCssClass="HoverTreeNode" SelectedNodeCssClass="ourprice" NodeCssClass="TreeNode" CssClass="TreeView" OnNodeSelected="NodeClicked" AllowTextSelection="True" AutoPostBackOnSelect="True" OnNodeMoved="TreeView1_NodeMoved" CausesValidation="False" ClientTarget="Auto" meta:resourcekey="TreeView1Resource1"></COMPONENTART:TREEVIEW><br />
                Nueva:<br/><asp:TextBox ID="txtCatNew" runat="server" meta:resourcekey="txtCatNewResource1" Width="100px" ></asp:TextBox>&nbsp;
                <asp:Button ID="btnAdd" runat="server" Text="Agregar" OnClick="btnAdd_Click" meta:resourcekey="btnAddResource1" />
	        </td>
	        <td>
			<table class="admintable2" cellpadding="5" cellspacing="0" >
                <tr>
                    <td class="adminlabel1" style="width:100px" >
                        ID</td>
                    <td class="adminitem">
                        <asp:Label ID="lblID" runat="server" meta:resourcekey="lblIDResource1"></asp:Label>
                        <uc2:ResultMessage ID="ResultMessage1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="adminlabel1">
                        <asp:Localize ID="ParentIDContent" runat="server" meta:resourcekey="ParentIDContentResource1" Text="ParentID"></asp:Localize></td>
                    <td class="adminitem">
                        <asp:Label ID="lblParentID" runat="server" meta:resourcekey="lblParentIDResource1"></asp:Label></td>
                </tr>
				<tr>
					<td class="adminlabel1">
                        <asp:Localize ID="CategoryNameContent" runat="server" meta:resourcekey="CategoryNameContentResource1" Text="Category Name"></asp:Localize></td>
					<td class="adminitem">
						<asp:textbox id="txtCategoryName" runat="server" meta:resourcekey="txtCategoryNameResource1" ></asp:textbox>
					</td>
				</tr>
				
				<tr>
					<td class="adminlabel1">
                        <asp:Localize ID="ImageContent" runat="server" meta:resourcekey="ImageContentResource1" Text="Image"></asp:Localize></td>
					<td class="adminitem">
                        &nbsp;<uc1:ImagePicker ID="ImagePicker1" runat="server" ImageFolder="images/pageheaders"/>
					</td>
				</tr>
				
				<tr>
					<td class="adminlabel1">
                        <asp:Localize ID="ShortDescriptionContent" runat="server" meta:resourcekey="ShortDescriptionContentResource1" Text="Short Description"></asp:Localize></td>
					<td class="adminitem">
						<asp:textbox id="txtShortDescription" runat="server" TextMode="MultiLine" Height="100px" Width="300px" meta:resourcekey="txtShortDescriptionResource1"></asp:textbox>
					</td>
				</tr>
				
				<tr>
					<td class="adminlabel1">
                        <asp:Localize ID="LongDescriptionContent" runat="server" meta:resourcekey="LongDescriptionContentResource1" Text="Long Description"></asp:Localize></td>
					<td class="adminitem">
		                <FTB:FreeTextBox id="txtLongDescription"  
			                Focus="True"
			                SupportFolder="~/ftb/"
			                JavaScriptLocation="ExternalFile" 
			                ButtonImagesLocation="ExternalFile"
			                ToolbarImagesLocation="ExternalFile"
			                toolbarlayout="ParagraphMenu,FontFacesMenu,FontSizesMenu,FontForeColorsMenu,FontForeColorPicker,FontBackColorsMenu,FontBackColorPicker|Bold,Italic,Underline,Strikethrough,Superscript,Subscript,RemoveFormat|JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent;CreateLink,Unlink,InsertImage|Cut,Copy,Paste,Delete;Undo,Redo,Print,Save|SymbolsMenu,StylesMenu,InsertHtmlMenu|InsertRule,InsertDate,InsertTime|InsertTable,EditTable;InsertTableRowAfter,InsertTableRowBefore,DeleteTableRow;InsertTableColumnAfter,InsertTableColumnBefore,DeleteTableColumn|InsertForm,InsertTextBox,InsertTextArea,InsertRadioButton,InsertCheckBox,InsertDropDownList,InsertButton|InsertDiv,EditStyle,InsertImageFromGallery,Preview,SelectAll,WordClean,NetSpell"
			                runat="Server" AllowHtmlMode="False" AssemblyResourceHandlerPath="" AutoConfigure="" AutoGenerateToolbarsFromString="True" AutoHideToolbar="True" AutoParseStyles="True" BackColor="158, 190, 245" BaseUrl="" BreakMode="Paragraph" ButtonDownImage="False" ButtonFileExtention="gif" ButtonFolder="Images" ButtonHeight="20" ButtonOverImage="False" ButtonPath="" ButtonSet="Office2003" ButtonWidth="21" ClientSideTextChanged="" ConvertHtmlSymbolsToHtmlCodes="False" DesignModeBodyTagCssClass="" DesignModeCss="" DisableIEBackButton="False" DownLevelCols="50" DownLevelMessage="" DownLevelMode="TextArea" DownLevelRows="10" EditorBorderColorDark="128, 128, 128" EditorBorderColorLight="128, 128, 128" EnableHtmlMode="True" EnableSsl="False" EnableToolbars="True" FormatHtmlTagsToXhtml="True" GutterBackColor="129, 169, 226" GutterBorderColorDark="128, 128, 128" GutterBorderColorLight="255, 255, 255" Height="250px" HelperFilesParameters="" HelperFilesPath="" HtmlModeCss="" HtmlModeDefaultsToMonoSpaceFont="True" ImageGalleryPath="~/images/" ImageGalleryUrl="ftb.imagegallery.aspx?rif={0}&cif={0}" InstallationErrorMessage="InlineMessage" Language="en-US" PasteMode="Default" ReadOnly="False" RemoveScriptNameFromBookmarks="True" RemoveServerNameFromUrls="True" RenderMode="NotSet" ScriptMode="External" ShowTagPath="False" SslUrl="/." StartMode="DesignMode" StripAllScripting="False" TabIndex="-1" TabMode="InsertSpaces" Text="" TextDirection="LeftToRight" ToolbarBackColor="Transparent" ToolbarBackgroundImage="True" ToolbarStyleConfiguration="NotSet" UpdateToolbar="True" UseToolbarBackGroundImage="True" Width="300px"
			                /> 
                    </td>
				</tr>
				
				<tr>
					<td class="adminlabel1">
                        <asp:Localize ID="ListOrderContent" runat="server" meta:resourcekey="ListOrderContentResource1" Text="List Order"></asp:Localize></td>
					<td class="adminitem">
						<ew:NumericBox ID="txtListOrder" runat="server" width="24px" meta:resourcekey="txtListOrderResource1"></ew:NumericBox>
					</td>
				</tr>
				
			
					
				<tr>
					<td><asp:Button id="btnSave"  runat="server" Text="Save" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1"></asp:Button>&nbsp;
					</td>
					
					<td align="right">
                        &nbsp;<asp:Button id="btnDelete" runat="server" CausesValidation="False" Text="Delete" OnClick="btnDelete_Click" meta:resourcekey="btnDeleteResource1" ></asp:Button></td>
				</tr>
			</table>
	        
	        </td>
	    
	    </tr>
	
	</table>

	<script type="text/ecmascript">
	function CheckDelete(){
			
		return confirm("¿Eliminar este registro? Esta acción es irreversible...");

	}

	</script>
</asp:Content>

