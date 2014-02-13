<%@ Page  validaterequest="false" Language="C#" AutoEventWireup="true" CodeFile="Content_Editor.aspx.cs" Inherits="Admin_Content_Editor" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>
<%@ OutputCache  NoStore="true" Location="None"%>
<%@ Register Src="../Modules/ResultMessage.ascx" TagName="ResultMessage" TagPrefix="uc1" %>
<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Edit Content: <%=Request.QueryString["id"].ToString() %></title>
</head>
<body bgcolor="#f5f5f5">
    <form id="form1" runat="server">
        <div style="text-align:center;margin:10px;">
            <div>
                <FTB:FreeTextBox id="txtContent" runat="server" SupportFolder="~/ftb/" AllowHtmlMode="False" AssemblyResourceHandlerPath="" AutoConfigure="" AutoGenerateToolbarsFromString="True" AutoHideToolbar="True" AutoParseStyles="True" BackColor="158, 190, 245" BaseUrl="" BreakMode="Paragraph" ButtonDownImage="False" ButtonFileExtention="gif" ButtonFolder="Images" ButtonHeight="20" ButtonImagesLocation="InternalResource" ButtonOverImage="False" ButtonPath="" ButtonSet="Office2003" ButtonWidth="21" ClientSideTextChanged="" ConvertHtmlSymbolsToHtmlCodes="False" DesignModeBodyTagCssClass="" DesignModeCss="" DisableIEBackButton="False" DownLevelCols="50" DownLevelMessage="" DownLevelMode="TextArea" DownLevelRows="10" EditorBorderColorDark="128, 128, 128" EditorBorderColorLight="128, 128, 128" EnableHtmlMode="True" EnableSsl="False" EnableToolbars="True" Focus="False" FormatHtmlTagsToXhtml="True" GutterBackColor="129, 169, 226" GutterBorderColorDark="128, 128, 128" GutterBorderColorLight="255, 255, 255" Height="350px" HelperFilesParameters="" HelperFilesPath="" HtmlModeCss="" HtmlModeDefaultsToMonoSpaceFont="True" ImageGalleryPath="~/images/" ImageGalleryUrl="ftb.imagegallery.aspx?rif={0}&cif={0}" InstallationErrorMessage="InlineMessage" JavaScriptLocation="InternalResource" Language="en-US" PasteMode="Default" ReadOnly="False" RemoveScriptNameFromBookmarks="True" RemoveServerNameFromUrls="True" RenderMode="NotSet" ScriptMode="External" ShowTagPath="False" SslUrl="/." StartMode="DesignMode" StripAllScripting="False" TabIndex="-1" TabMode="InsertSpaces" Text="" TextDirection="LeftToRight" ToolbarBackColor="Transparent" ToolbarBackgroundImage="True" ToolbarImagesLocation="InternalResource" ToolbarLayout="ParagraphMenu,FontFacesMenu,FontSizesMenu,FontForeColorsMenu|Bold,Italic,Underline,Strikethrough;Superscript,Subscript,RemoveFormat|JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent;CreateLink,Unlink,InsertImage,InsertRule|Cut,Copy,Paste;Undo,Redo,Print" ToolbarStyleConfiguration="NotSet" UpdateToolbar="True" UseToolbarBackGroundImage="True" Width="600px"></FTB:FreeTextBox>
            </div>
            <div>	
                <uc1:ResultMessage ID="ResultMessage1" runat="server" />
                <asp:button id="btnSave" runat="server" CausesValidation="False" Text="Save" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1"></asp:button>&nbsp;
                <input type="button" value="Cerrar" onclick="parent.hidePopWin(false);parent.location.reload();" />
            </div>
        </div> 
    </form>
</body>
</html>
