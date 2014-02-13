<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProductImages.ascx.cs" Inherits="Modules_Admin_ProductImages" %>
<%@ Register Assembly="eWorld.UI" Namespace="eWorld.UI" TagPrefix="ew" %>
<%@ Register Src="../ImageManager.ascx" TagName="ImagePicker" TagPrefix="uc2" %>
<h1>
    <asp:Localize ID="ImagesContent" runat="server" meta:resourcekey="ImagesContentResource1" Text="Images"></asp:Localize></h1>
<table class="admintable1">
<tr><td>
	<br />
	   <table>
	        <tr>
	            <td ><b>
                    <asp:Localize ID="SelectAnImageContent" runat="server" meta:resourcekey="SelectAnImageContentResource1" Text="Select an Image"></asp:Localize>:</b></td>
	            <td><uc2:ImagePicker ID="ImagePicker1" runat="server" 
	            ImageFolder="images/productimages"/></td>
	        </tr>
	        <tr>
	            <td >
                    <asp:Localize ID="ImageCaptionContent" runat="server" meta:resourcekey="ImageCaptionContentResource1" Text="Image Caption"></asp:Localize> </td>
	            <td><asp:TextBox ID="txtNewImageCaption" runat="server" Width="350px" Height="60px" TextMode="MultiLine" meta:resourcekey="txtNewImageCaptionResource1"></asp:TextBox></td>
	        </tr>
	        <tr>
	            <td >
                    <asp:Localize ID="ImageListOrderContent" runat="server" meta:resourcekey="ImageListOrderContentResource1" Text="Image List Order"></asp:Localize></td>
	            <td><ew:NumericBox ID="txtNewImageListOrder" runat="server" Width="34px" Text="0" meta:resourcekey="txtNewImageListOrderResource1"></ew:NumericBox></td>
	        </tr>
	        <tr>
	            <td colspan="2"><asp:Button ID="btnSaveImage" runat="server" OnClick="btnSaveImage_Click" Text="Add Image" meta:resourcekey="btnSaveImageResource1" /></td>
	        </tr>
	   </table>
        <br />
        <asp:Label ID="lblProductID" runat="server" Visible="False" meta:resourcekey="lblProductIDResource1"></asp:Label><br />
        <table width="500" cellspacing="0" >
	    <asp:Repeater ID="rptImages" runat="server" OnItemCommand="DeleteImage">
	        <ItemTemplate>
                <tr>
                    <td class="adminlabel" width="15"><b>
                        <%# Eval("listorder") %>
                    </b><asp:Label ID="lblImageID" runat="server" Text='<%# Eval("imageID") %>' Visible="False" meta:resourcekey="lblImageIDResource1"></asp:Label></td>
                    <td align="center">
                        &nbsp;&nbsp;&nbsp;<img src='/<%# Eval("imagefile") %>' alt='<%# Eval("imagefile") %>'/><br />
                        <i>
                            <%# Eval("caption") %>
                        </i>    
                    </td>
                    <td><asp:Button ID="btnDelImage" runat="server" Text="Delete" meta:resourcekey="btnDelImageResource1"/></td>
                </tr>
	        </ItemTemplate>
	    </asp:Repeater>
        </table>
 </td></tr>       
        </table>