<%@ Page validaterequest="false"   Language="C#" AutoEventWireup="true" CodeFile="Content_Ad_Editor.aspx.cs" Inherits="Admin_Content_Ad_Editor" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>
<%@ OutputCache  NoStore="true" Location="None"%>
<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>
<%@ Register Src="../Modules/ResultMessage.ascx" TagName="ResultMessage" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Edit Ad</title>
</head>
<body onunload="refreshParent()">
    <form id="form1" runat="server">
       <asp:Label ID="lblID" runat="server" Visible="False" meta:resourcekey="lblIDResource1" ></asp:Label>
    <table cellpadding="3">
        <tr>
            <td><b>
                <asp:Localize ID="AdTextContent" runat="server" meta:resourcekey="AdTextContentResource1" Text="Ad Text"></asp:Localize></b></td>
        </tr>
        <tr>
            <td align="center" colspan="2"><FTB:FreeTextBox ID="txtAdText" runat="server" Height="400px" SupportFolder="~/ftb/" AllowHtmlMode="False" AssemblyResourceHandlerPath="" AutoConfigure="" AutoGenerateToolbarsFromString="True" AutoHideToolbar="True" AutoParseStyles="True" BackColor="158, 190, 245" BaseUrl="" BreakMode="Paragraph" ButtonDownImage="False" ButtonFileExtention="gif" ButtonFolder="Images" ButtonHeight="20" ButtonImagesLocation="InternalResource" ButtonOverImage="False" ButtonPath="" ButtonSet="Office2003" ButtonWidth="21" ClientSideTextChanged="" ConvertHtmlSymbolsToHtmlCodes="False" DesignModeBodyTagCssClass="" DesignModeCss="" DisableIEBackButton="False" DownLevelCols="50" DownLevelMessage="" DownLevelMode="TextArea" DownLevelRows="10" EditorBorderColorDark="128, 128, 128" EditorBorderColorLight="128, 128, 128" EnableHtmlMode="True" EnableSsl="False" EnableToolbars="True" Focus="False" FormatHtmlTagsToXhtml="True" GutterBackColor="129, 169, 226" GutterBorderColorDark="128, 128, 128" GutterBorderColorLight="255, 255, 255" HelperFilesParameters="" HelperFilesPath="" HtmlModeCss="" HtmlModeDefaultsToMonoSpaceFont="True" ImageGalleryPath="~/images/" ImageGalleryUrl="ftb.imagegallery.aspx?rif={0}&cif={0}" InstallationErrorMessage="InlineMessage" JavaScriptLocation="InternalResource" Language="en-US" PasteMode="Default" ReadOnly="False" RemoveScriptNameFromBookmarks="True" RemoveServerNameFromUrls="True" RenderMode="NotSet" ScriptMode="External" ShowTagPath="False" SslUrl="/." StartMode="DesignMode" StripAllScripting="False" TabIndex="-1" TabMode="InsertSpaces" Text="" TextDirection="LeftToRight" ToolbarBackColor="Transparent" ToolbarBackgroundImage="True" ToolbarImagesLocation="InternalResource" ToolbarLayout="ParagraphMenu,FontFacesMenu,FontSizesMenu,FontForeColorsMenu|Bold,Italic,Underline,Strikethrough;Superscript,Subscript,RemoveFormat|JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent;CreateLink,Unlink,InsertImage,InsertRule|Cut,Copy,Paste;Undo,Redo,Print" ToolbarStyleConfiguration="NotSet" UpdateToolbar="True" UseToolbarBackGroundImage="True" Width="600px" ></FTB:FreeTextBox></td>
        </tr>
        <tr>
            <td class="sectionheader">
                <asp:Localize ID="TargetThisAd" runat="server" meta:resourcekey="TargetThisAdResource1" Text="Target this ad"></asp:Localize></td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Localize ID="SelectProductContent" runat="server" meta:resourcekey="SelectProductContentResource1" Text='Select a product or category below for this ad. The ad will then be&#13;&#10;            "clickable" and stats can be compiled about clickthroughs, etc.'></asp:Localize>
            </td>
        </tr>
        <tr>
            <td><b>
                <asp:Localize ID="ProductContent" runat="server" meta:resourcekey="ProductContentResource2" Text="Product"></asp:Localize></b></td>
            <td><asp:DropDownList ID="ddlProductID" runat="server" meta:resourcekey="ddlProductIDResource1"></asp:DropDownList></td>
        </tr>
        <tr><td>--<asp:Localize ID="OrContent" runat="server" meta:resourcekey="OrContentResource1" Text="or"></asp:Localize>--</td></tr>
        <tr>
            <td><b>
                <asp:Localize ID="CategoryContent" runat="server" meta:resourcekey="CategoryContentResource1" Text="Category"></asp:Localize></b></td>
            <td><asp:DropDownList ID="ddlCategoryID" runat="server" meta:resourcekey="ddlCategoryIDResource1"></asp:DropDownList></td>
        </tr>
        <tr>
            <td>
                
                <asp:button id="btnSave" runat="server" CausesValidation="False" Text="Save" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1"></asp:button>&nbsp;
                <input type="button" value="Cerrar" onclick="parent.hidePopWin(false);parent.location.reload();" />&nbsp;
                <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" meta:resourcekey="btnDeleteResource1" />
            </td>
        </tr>
        <tr>
            <td><uc1:ResultMessage ID="ResultMessage1" runat="server" />
            </td>
        </tr>
    </table>
    </form>
</body>
<script>
function CheckDelete(){
		
	return confirm("¿Desea eliminar este registro? Esta acción es irreversible...");

}
//thanks racer94
function refreshParent() {

parent.location.reload(true);

}

</script>