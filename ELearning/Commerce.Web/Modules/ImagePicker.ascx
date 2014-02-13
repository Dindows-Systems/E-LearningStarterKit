<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ImagePicker.ascx.cs" Inherits="Modules_ImagePicker" %>
<input type="button" value="..." onclick="load<%=ClientID%>Pix();"/>
<input name="<%=ClientID%>_clear" type="button" value="clear" onclick="clear<%=ClientID%>Pix();" style="display:none"/>
<asp:Image id="imgPic" runat="server" ImageUrl="../images/1pix.gif"></asp:Image><br/>
<input name="<%=ClientID%>_bob" type="hidden" value="<%=GetImage()%>"> 
<br>

<script>
function clear<%=ClientID%>Pix(){
	document.forms[0].<%=ClientID%>_bob.value="1pix.gif";
	document.forms[0].<%=ClientID%>_imgPic.src="<%=Commerce.Common.Utility.GetSiteRoot()%>/images/1pix.gif";
	document.forms[0].<%=ClientID%>_clear.style.display="none";

}
function load<%=ClientID%>Pix(){
	imgArr = showModalDialog("<%=Commerce.Common.Utility.GetSiteRoot()%>/admin/ftb.imagegallery.aspx?rif=<%=ImageFolder%>&cif=<%=ImageFolder%>");

	if (imgArr != null) {
		imagestring = imgArr['filename'];
		lastslash=imagestring.lastIndexOf("/");
		filename=imagestring.substring(lastslash+1,imagestring.length);

		document.forms[0].<%=ClientID%>_bob.value=imagestring;
		document.forms[0].<%=ClientID%>_imgPic.src=imagestring;
		document.forms[0].<%=ClientID%>_clear.style.display="";

	} else {
		//alert("You did not select an image");
	}

}

</script>