<%@ Page validaterequest="false" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="Admin_Mailers.aspx.cs" Inherits="Admin_Admin_Mailers" Title="Mailers Admin" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>
<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>
<%@ Register Src="../Modules/ResultMessage.ascx" TagName="ResultMessage" TagPrefix="uc1"%>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminPlaceHolder" Runat="Server">

        <h1>
            <asp:Localize ID="MailersContent" runat="server" meta:resourcekey="MailersContentResource1" Text="Mailers"></asp:Localize></h1>
    <asp:Localize ID="MailersDescriptionContent" runat="server" meta:resourcekey="MailersDescriptionContentResource1" Text="These mailers are automatically mailed out at certain times (order processing, etc). You can edit the text of&#13;&#10;        the mailers, their subject, etc here. You can use HTML if you like"></asp:Localize>.
        <br />
		<asp:panel id="pnlGrid" runat="server" meta:resourcekey="pnlGridResource1">

		<asp:datagrid id="dg" runat="server" Width="100%" CellPadding="3" GridLines="None"
			BorderColor="White" BorderWidth="0px" BorderStyle="Solid" BackColor="White" AutoGenerateColumns="False"
			AllowSorting="True" ForeColor="Black" Font-Names="Verdana" Font-Size="8pt"  OnEditCommand="GridEdit" meta:resourcekey="dgResource1">
			<FooterStyle ForeColor="Black" BackColor="#C6C3C6"></FooterStyle>
			<SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="Gainsboro"></SelectedItemStyle>
			<AlternatingItemStyle ForeColor="Black" BackColor="WhiteSmoke"></AlternatingItemStyle>
			<ItemStyle ForeColor="Black" BackColor="White"></ItemStyle>
			<HeaderStyle Font-Size="8pt" Font-Names="Verdana" Font-Bold="True" ForeColor="Black" BackColor="LightSteelBlue"></HeaderStyle>
			<Columns>
					<asp:EditCommandColumn UpdateText="Update" CancelText="Cancel" EditText="Edit" meta:resourcekey="EditCommandColumnResource1"></asp:EditCommandColumn>
						<asp:BoundColumn DataField="MailerID" HeaderText="ID del Enviador de Email&#241;"  Visible=False></asp:BoundColumn>
						<asp:BoundColumn DataField="MailerName" HeaderText="Nombre del Enviador de Correo" ></asp:BoundColumn>
						<asp:BoundColumn DataField="ToList" HeaderText="Lista de Receptores" ></asp:BoundColumn>
						<asp:BoundColumn DataField="CcList" HeaderText="Lista Cc" ></asp:BoundColumn>
					</Columns>
					<PagerStyle HorizontalAlign="Right" ForeColor="Black" BackColor="#C6C3C6"></PagerStyle>
				</asp:datagrid>
				<br />
				<asp:button id="cmdAdd"  runat="server" OnClick="btnAdd_Click" CausesValidation="False" Text="Add" meta:resourcekey="cmdAddResource1"></asp:button>
			</asp:panel>
			<asp:panel id="pnlEdit" Runat="server" meta:resourcekey="pnlEditResource1">
			
			<table class="admintable" cellpadding="5" cellspacing="0">
				<tr id="trID" runat="server">
					<td class="adminlabel" runat="server">ID</td>
					<td class="adminitem" runat="server"><asp:label id="lblID" runat="server" /></td>
				</tr>
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="MailerNameContent" runat="server" meta:resourcekey="MailerNameContentResource1" Text="Mailer Name"></asp:Localize></td>
					<td class="adminitem">
						<asp:textbox id="txtMailerName" runat="server" Width="373px" meta:resourcekey="txtMailerNameResource1" ></asp:textbox>
					</td>
				</tr>
				
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="ToListContent" runat="server" meta:resourcekey="ToListContentResource1" Text="To List"></asp:Localize></td>
					<td class="adminitem">
						<asp:textbox id="txtToList" runat="server" TextMode="MultiLine" Height="100px" Width="400px" meta:resourcekey="txtToListResource1"></asp:textbox><br />
                        <asp:Localize ID="SeparateMailsContent" runat="server" meta:resourcekey="SeparateMailsContentResource1" Text="Separate the emails with a semi-colon &quot;;&quot;&#160;Leave this blank if it's going to a customer">Separate the emails with a semi-colon ";"&nbsp;Leave this blank if it's going
                        to a customer</asp:Localize>.</td>
				</tr>
				
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="CcListContent" runat="server" meta:resourcekey="CcListContentResource1" Text="Cc List"></asp:Localize></td>
					<td class="adminitem">
						<asp:textbox id="txtCcList" runat="server" TextMode="MultiLine" Height="100px" Width="400px" meta:resourcekey="txtCcListResource1"></asp:textbox><br />
                        <asp:Localize ID="SeparateMailsContent2" runat="server" meta:resourcekey="SeparateMailsContent2Resource1" Text="Separate the emails with a semi-colon &quot;;&quot;&#160;">Separate the emails with a semi-colon ";"&nbsp;</asp:Localize>
					</td>
				</tr>
				
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="FromNameContent" runat="server" meta:resourcekey="FromNameContentResource1" Text="From Name"></asp:Localize></td>
					<td class="adminitem">
						<asp:textbox id="txtFromName" runat="server" Width="309px" meta:resourcekey="txtFromNameResource1" ></asp:textbox>
					</td>
				</tr>
				
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="FromEmailContent" runat="server" meta:resourcekey="FromEmailContentResource1" Text="From Email"></asp:Localize></td>
					<td class="adminitem">
						<asp:textbox id="txtFromEmail" runat="server" Width="309px" meta:resourcekey="txtFromEmailResource1" ></asp:textbox>
					</td>
				</tr>
				
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="SubjectContent" runat="server" meta:resourcekey="SubjectContentResource1" Text="Subject"></asp:Localize></td>
					<td class="adminitem">
						<asp:textbox id="txtSubject" runat="server" Width="309px" meta:resourcekey="txtSubjectResource1" ></asp:textbox>
					</td>
				</tr>
				
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="MessageBodyContent" runat="server" meta:resourcekey="MessageBodyContentResource1" Text="Message Body"></asp:Localize></td>
					<td class="adminitem">
                        &nbsp;<FTB:FreeTextBox id="txtMessageBody" runat="server" SupportFolder="~/ftb/" AllowHtmlMode="False" AssemblyResourceHandlerPath="" AutoConfigure="" AutoGenerateToolbarsFromString="True" AutoHideToolbar="True" AutoParseStyles="True" BackColor="158, 190, 245" BaseUrl="" BreakMode="Paragraph" ButtonDownImage="False" ButtonFileExtention="gif" ButtonFolder="Images" ButtonHeight="20" ButtonImagesLocation="InternalResource" ButtonOverImage="False" ButtonPath="" ButtonSet="Office2003" ButtonWidth="21" ClientSideTextChanged="" ConvertHtmlSymbolsToHtmlCodes="False" DesignModeBodyTagCssClass="" DesignModeCss="" DisableIEBackButton="False" DownLevelCols="50" DownLevelMessage="" DownLevelMode="TextArea" DownLevelRows="10" EditorBorderColorDark="128, 128, 128" EditorBorderColorLight="128, 128, 128" EnableHtmlMode="True" EnableSsl="False" EnableToolbars="True" Focus="False" FormatHtmlTagsToXhtml="True" GutterBackColor="129, 169, 226" GutterBorderColorDark="128, 128, 128" GutterBorderColorLight="255, 255, 255" Height="350px" HelperFilesParameters="" HelperFilesPath="" HtmlModeCss="" HtmlModeDefaultsToMonoSpaceFont="True" ImageGalleryPath="~/images/" ImageGalleryUrl="ftb.imagegallery.aspx?rif={0}&amp;cif={0}" InstallationErrorMessage="InlineMessage" JavaScriptLocation="InternalResource" Language="en-US" PasteMode="Default" ReadOnly="False" RemoveScriptNameFromBookmarks="True" RemoveServerNameFromUrls="True" RenderMode="NotSet" ScriptMode="External" ShowTagPath="False" SslUrl="/." StartMode="DesignMode" StripAllScripting="False" TabIndex="-1" TabMode="InsertSpaces" Text="" TextDirection="LeftToRight" ToolbarBackColor="Transparent" ToolbarBackgroundImage="True" ToolbarImagesLocation="InternalResource" ToolbarLayout="ParagraphMenu,FontFacesMenu,FontSizesMenu,FontForeColorsMenu|Bold,Italic,Underline,Strikethrough;Superscript,Subscript,RemoveFormat|JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent;CreateLink,Unlink,InsertImage,InsertRule|Cut,Copy,Paste;Undo,Redo,Print" ToolbarStyleConfiguration="NotSet" UpdateToolbar="True" UseToolbarBackGroundImage="True" Width="600px"></FTB:FreeTextBox></td>
				</tr>
				
				<tr>
					<td class="adminlabel">
                        <asp:Localize ID="IsHTMLContent" runat="server" meta:resourcekey="IsHTMLContentResource1" Text="Is HTML"></asp:Localize></td>
					<td class="adminitem">
						<asp:CheckBox id="chkIsHTML" runat="server" meta:resourcekey="chkIsHTMLResource1" />
					</td>
				</tr>
				
					
				<tr>
					<td>
					<asp:Button id="btnSave"  runat="server" Text="Save" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1"></asp:Button>&nbsp;
					<input type=button onclick="location.href=''" value="Regresar">
					<uc1:ResultMessage ID="uResult" runat="server" EnableViewState="False" />	
					</td>
					
					<td align="right"><asp:Button id="btnDelete" runat="server" CausesValidation="False" Text="Delete" OnClick="btnDelete_Click" meta:resourcekey="btnDeleteResource1"></asp:Button></td>
				</tr>
			</table>
			</asp:panel>

			<script>
			function CheckDelete(){
					
				return confirm("¿Eliminar este registro? Esta acción es irreversible...");

			}

			</script>
			

</asp:Content>

