<%@ Page language="c#" Culture="auto" meta:resourcekey="PageResource2" UICulture="auto" %>
<script language="C#" runat="server">

// Messages
private string NoFileMessage = Resources.Common.NoFileSelected;
private string UploadSuccessMessage = Resources.Common.UploadedSucess;
private string NoImagesMessage = Resources.Common.NoImages;
private string NoFolderSpecifiedMessage = Resources.Common.Nofolder;
private string NoFileToDeleteMessage = Resources.Common.NoFileToDelete;
private string InvalidFileTypeMessage = Resources.Common.InvalidFileType;
private string[] AcceptedFileTypes = new string[] {"jpg","jpeg","jpe","gif","bmp","png"};

// Configuration
private bool	UploadIsEnabled = true;
private bool	DeleteIsEnabled = true;
private string	DefaultImageFolder = "images";

private void Page_Load(object sender, System.EventArgs e) {
	string isframe = "" + Request["frame"];
	
	if (isframe != "") {
		MainPage.Visible = true;
		iframePanel.Visible = false;
	
		string rif = "" + Request["rif"];
		string cif = "" + Request["cif"];	

		if (cif != "" && rif != "") {
			RootImagesFolder.Value = rif;
			CurrentImagesFolder.Value = cif;
		} else {
			RootImagesFolder.Value = DefaultImageFolder;
			CurrentImagesFolder.Value = DefaultImageFolder;	
		}

		UploadPanel.Visible = UploadIsEnabled;
		DeleteImage.Visible = DeleteIsEnabled;

		string FileErrorMessage = "";
		string ValidationString = ".*(";
		//[\.jpg]|[\.jpeg]|[\.jpe]|[\.gif]|[\.bmp]|[\.png])$"
		for (int i=0;i<AcceptedFileTypes.Length; i++) {
			ValidationString += "[\\." + AcceptedFileTypes[i] + "]";
			if (i < (AcceptedFileTypes.Length-1)) ValidationString += "|";
			FileErrorMessage += AcceptedFileTypes[i];
			if (i < (AcceptedFileTypes.Length-1)) FileErrorMessage += ", ";
		}
		FileValidator.ValidationExpression = ValidationString+")$";
		FileValidator.ErrorMessage=FileErrorMessage;

		if (!IsPostBack) {
			DisplayImages();
		}
	} else {
		
	}
}

public void UploadImage_OnClick(object sender, EventArgs e) {	
	if (Page.IsValid) {
		if (CurrentImagesFolder.Value != "") {
			if (UploadFile.PostedFile.FileName.Trim() != "") {
				if (IsValidFileType(UploadFile.PostedFile.FileName)) {
					try {
						string UploadFileName = "";
						string UploadFileDestination = "";
						UploadFileName = UploadFile.PostedFile.FileName;
						UploadFileName = UploadFileName.Substring(UploadFileName.LastIndexOf("\\")+1);
						UploadFileDestination = HttpContext.Current.Request.PhysicalApplicationPath;
						UploadFileDestination += CurrentImagesFolder.Value;
						UploadFileDestination += "\\";
						UploadFile.PostedFile.SaveAs(UploadFileDestination + UploadFileName);
						ResultsMessage.Text = UploadSuccessMessage;
					} catch(Exception ex) {
						//ResultsMessage.Text = "Your file could not be uploaded: " + ex.Message;
						ResultsMessage.Text = Resources.Common.Error;
					}
				} else {
					ResultsMessage.Text = InvalidFileTypeMessage;
				}
			} else {
				ResultsMessage.Text = NoFileMessage;
			}
		} else {
			ResultsMessage.Text = NoFolderSpecifiedMessage;
		}
	} else {
		ResultsMessage.Text = InvalidFileTypeMessage;
		
	}
	DisplayImages();
}

public void DeleteImage_OnClick(object sender, EventArgs e) {
	if (FileToDelete.Value != "" && FileToDelete.Value != "undefined") {
		try {
			string AppPath = HttpContext.Current.Request.PhysicalApplicationPath;
			System.IO.File.Delete(AppPath  + CurrentImagesFolder.Value + "\\" + FileToDelete.Value);
			ResultsMessage.Text = string.Format(Resources.Common.Deleted, FileToDelete.Value);
		} catch(Exception ex) {			
			ResultsMessage.Text = Resources.Common.Error;
		}
	} else {
		ResultsMessage.Text = NoFileToDeleteMessage;
	}
	DisplayImages();
}

private bool IsValidFileType(string FileName) {
	string ext = FileName.Substring(FileName.LastIndexOf(".")+1,FileName.Length-FileName.LastIndexOf(".")-1);
	for (int i=0; i<AcceptedFileTypes.Length; i++) {		
		if (ext.ToLower() == AcceptedFileTypes[i].ToLower()) {
			return true;
			
		}	
	}
	return false;
}


private string[] ReturnFilesArray() {
	if (CurrentImagesFolder.Value != "") {
		try {
			string AppPath = HttpContext.Current.Request.PhysicalApplicationPath;
			string ImageFolderPath = AppPath + CurrentImagesFolder.Value;
			string[] FilesArray = System.IO.Directory.GetFiles(ImageFolderPath,"*");
			return FilesArray;
			
			
		} catch {
		
			return null;
		}
	} else {
		return null;
	}

}

private string[] ReturnDirectoriesArray() {
	if (CurrentImagesFolder.Value != "") {
		try {
			string AppPath = HttpContext.Current.Request.PhysicalApplicationPath;
			string CurrentFolderPath = AppPath + CurrentImagesFolder.Value;
			string[] DirectoriesArray = System.IO.Directory.GetDirectories(CurrentFolderPath,"*");
			return DirectoriesArray ;
		} catch {
			return null;
		}
	} else {
		return null;
	}
}


public void DisplayImages() {
	string[] FilesArray = ReturnFilesArray();
	string[] DirectoriesArray = ReturnDirectoriesArray();
	string AppPath = HttpContext.Current.Request.PhysicalApplicationPath;
	string AppUrl;
	
	//Get the application's URL
	if (Request.ApplicationPath == "/")
		AppUrl = Request.ApplicationPath;
	else
		AppUrl = Request.ApplicationPath + "/";
	
	GalleryPanel.Controls.Clear();
	if ( (FilesArray == null || FilesArray.Length == 0) && (DirectoriesArray == null || DirectoriesArray.Length == 0) ) {
		gallerymessage.Text = NoImagesMessage + ": " + RootImagesFolder.Value;
	} else {
		string ImageFileName = "";
		string ImageFileLocation = "";

		int thumbWidth = 94;
		int thumbHeight = 94;
		
		if (CurrentImagesFolder.Value != RootImagesFolder.Value) {

			System.Web.UI.HtmlControls.HtmlImage myHtmlImage = new System.Web.UI.HtmlControls.HtmlImage();
			myHtmlImage.Src = Page.ResolveUrl("~/images/ImagePicker/folder.up.gif");
			myHtmlImage.Attributes["unselectable"]="on"; 
			myHtmlImage.Attributes["align"]="absmiddle"; 
			myHtmlImage.Attributes["vspace"]="36"; 

			string ParentFolder = CurrentImagesFolder.Value.Substring(0,CurrentImagesFolder.Value.LastIndexOf("\\"));

			System.Web.UI.WebControls.Panel myImageHolder = new System.Web.UI.WebControls.Panel();					
			myImageHolder.CssClass = "imageholder";
			myImageHolder.Attributes["unselectable"]="on"; 
			myImageHolder.Attributes["onclick"]="divClick(this,'');";  
			myImageHolder.Attributes["ondblclick"]="gotoFolder('" + RootImagesFolder.Value + "','" + ParentFolder.Replace("\\","\\\\") + "');";  
			myImageHolder.Controls.Add(myHtmlImage);

			System.Web.UI.WebControls.Panel myMainHolder = new System.Web.UI.WebControls.Panel();
			myMainHolder.CssClass = "imagespacer";
			myMainHolder.Controls.Add(myImageHolder);

			System.Web.UI.WebControls.Panel myTitleHolder = new System.Web.UI.WebControls.Panel();
			myTitleHolder.CssClass = "titleHolder";
			myTitleHolder.Controls.Add(new LiteralControl(Resources.Common.Up));
			myMainHolder.Controls.Add(myTitleHolder);

			GalleryPanel.Controls.Add(myMainHolder);		
			
		}
		
		foreach (string _Directory in DirectoriesArray) {
			
			try {
				string DirectoryName = _Directory.ToString();
				

				System.Web.UI.HtmlControls.HtmlImage myHtmlImage = new System.Web.UI.HtmlControls.HtmlImage();
                myHtmlImage.Src = Page.ResolveUrl("~/images/ImagePicker/folder.big.gif");
				myHtmlImage.Attributes["unselectable"]="on"; 
				myHtmlImage.Attributes["align"]="absmiddle"; 
				myHtmlImage.Attributes["vspace"]="29"; 

				System.Web.UI.WebControls.Panel myImageHolder = new System.Web.UI.WebControls.Panel();					
				myImageHolder.CssClass = "imageholder";
				myImageHolder.Attributes["unselectable"]="on"; 
				myImageHolder.Attributes["onclick"]="divClick(this);";  
				myImageHolder.Attributes["ondblclick"]="gotoFolder('" + RootImagesFolder.Value + "','" + DirectoryName.Replace(AppPath,"").Replace("\\","\\\\") + "');";  
				myImageHolder.Controls.Add(myHtmlImage);

				System.Web.UI.WebControls.Panel myMainHolder = new System.Web.UI.WebControls.Panel();
				myMainHolder.CssClass = "imagespacer";
				myMainHolder.Controls.Add(myImageHolder);

				System.Web.UI.WebControls.Panel myTitleHolder = new System.Web.UI.WebControls.Panel();
				myTitleHolder.CssClass = "titleHolder";
				myTitleHolder.Controls.Add(new LiteralControl(DirectoryName.Replace(AppPath + CurrentImagesFolder.Value + "\\","")));
				myMainHolder.Controls.Add(myTitleHolder);

				GalleryPanel.Controls.Add(myMainHolder);		
			} catch {
				// nothing for error
			}
		}
		
		foreach (string ImageFile in FilesArray) {

			try {

				ImageFileName = ImageFile.ToString();
				ImageFileName = ImageFileName.Substring(ImageFileName.LastIndexOf("\\")+1);
				ImageFileLocation = AppUrl;
				ImageFileLocation = ImageFileLocation.Substring(ImageFileLocation.LastIndexOf("\\")+1);
				//galleryfilelocation += "/";
				ImageFileLocation += CurrentImagesFolder.Value;
				ImageFileLocation += "/";
				ImageFileLocation += ImageFileName;
				System.Web.UI.HtmlControls.HtmlImage myHtmlImage = new System.Web.UI.HtmlControls.HtmlImage();
				myHtmlImage.Src = ImageFileLocation;
				System.Drawing.Image myImage = System.Drawing.Image.FromFile(ImageFile.ToString());
				myHtmlImage.Attributes["unselectable"]="on";  
				//myHtmlImage.border=0;

				// landscape image
				if (myImage.Width > myImage.Height) {
					if (myImage.Width > thumbWidth) {
						myHtmlImage.Width = thumbWidth;
						myHtmlImage.Height = Convert.ToInt32(myImage.Height * thumbWidth/myImage.Width);						
					} else {
						myHtmlImage.Width = myImage.Width;
						myHtmlImage.Height = myImage.Height;
					}
				// portrait image
				} else {
					if (myImage.Height > thumbHeight) {
						myHtmlImage.Height = thumbHeight;
						myHtmlImage.Width = Convert.ToInt32(myImage.Width * thumbHeight/myImage.Height);
					} else {
						myHtmlImage.Width = myImage.Width;
						myHtmlImage.Height = myImage.Height;
					}
				}
				
				if (myHtmlImage.Height < thumbHeight) {
					myHtmlImage.Attributes["vspace"] = Convert.ToInt32((thumbHeight/2)-(myHtmlImage.Height/2)).ToString(); 
				}


				System.Web.UI.WebControls.Panel myImageHolder = new System.Web.UI.WebControls.Panel();					
				myImageHolder.CssClass = "imageholder";
				myImageHolder.Attributes["onclick"]="divClick(this,'" + ImageFileName + "');";  
				myImageHolder.Attributes["ondblclick"]="returnImage('" + ImageFileLocation.Replace("\\","/") + "','" + myImage.Width.ToString() + "','" + myImage.Height.ToString() + "');";  
				myImageHolder.Controls.Add(myHtmlImage);


				System.Web.UI.WebControls.Panel myMainHolder = new System.Web.UI.WebControls.Panel();
				myMainHolder.CssClass = "imagespacer";
				myMainHolder.Controls.Add(myImageHolder);

				System.Web.UI.WebControls.Panel myTitleHolder = new System.Web.UI.WebControls.Panel();
				myTitleHolder.CssClass = "titleHolder";
				myTitleHolder.Controls.Add(new LiteralControl(ImageFileName + "<BR>" + myImage.Width.ToString() + "x" + myImage.Height.ToString()));
				myMainHolder.Controls.Add(myTitleHolder);

				//GalleryPanel.Controls.Add(myImage);
				GalleryPanel.Controls.Add(myMainHolder);
				
				myImage.Dispose();
			} catch {

			}
		}
		gallerymessage.Text = "";
	}
}
</script>
<asp:panel id="MainPage" runat="server" visible="False" meta:resourcekey="MainPageResource1">
<HTML>
<HEAD runat="server" ID="HEAD1" Title="Insert Image"><title runat="server"></title>

<style>

body {
	margin: 0px 0px 0px 0px;
	padding: 0px 0px 0px 0px;
	background: #ffffff; 
	width: 100%;
	overflow:hidden;
	border: 0;
}

body,tr,td {
	color: #000000;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10pt;
}

div.imagespacer {
	width: 120;
	height: 126;
	text-align: center;			
	float: left;
	font: 10pt verdana;
	margin: 5px;
	overflow: hidden;
}
div.imageholder {
	margin: 0px;
	padding: 0px;
	border: 1 solid #CCCCCC;
	width: 100;
	height: 100;
}

div.titleholder {
	font-family: ms sans serif, arial;
	font-size: 8pt;
	width: 100;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;			
}		

</style>


		
</HEAD>

<script language="javascript">
lastDiv = null;
var returnControl='';
var returnHolder='';
function divClick(theDiv,filename) {
	if (lastDiv) {
		lastDiv.style.border = "1 solid #CCCCCC";
	}
	lastDiv = theDiv;
	theDiv.style.border = "2 solid #316AC5";
	
	document.getElementById("FileToDelete").value = filename;

}
function gotoFolder(rootfolder,newfolder) {
	location.href="ImagePicker.aspx?frame=1&rif=" + rootfolder + "&cif=" + newfolder+"&cn="+returnControl+"&ct="+returnHolder;
}		
function returnImage(imagename,width,height) {
	eval("window.top.document.forms[0]."+returnControl+".src='"+imagename+"'");
	eval("window.top.document.forms[0]."+returnHolder+".value='"+imagename+"'");
	window.top.hidePopWin();
/*	
	var arr = new Array();
	arr["filename"] = imagename;  
	arr["width"] = width;  
	arr["height"] = height;			 
	window.parent.returnValue = arr;
	window.parent.close();	
*/
}		
</script>
<body >
<table width=100% height=100% cellpadding=0 cellspacing=0 border=0>

<form runat="server" ID="FORM1" enctype="multipart/form-data">

<tr><td>
	<div id="galleryarea" style="width=100%; height:100%; overflow: auto;">
		<asp:Label runat="server" ID="gallerymessage" meta:resourcekey="gallerymessageResource1"></asp:Label>

		<asp:Panel runat="server" ID="GalleryPanel" meta:resourcekey="GalleryPanelResource1"></asp:Panel>

	</div>
</td></tr>
<asp:Panel runat="server" ID="UploadPanel" meta:resourcekey="UploadPanelResource1">
<tr><td height=16 style="padding-left:10px;border-top: 1 solid #999999; background-color:#99ccff;">
	
	<table>
	<tr>
		<td valign=top><input runat="server" ID="UploadFile" type="file" style="width:300;"></input>
</td>
		<td valign=top><asp:Button runat="server" ID="UploadImage" Text="Upload" meta:resourcekey="UploadImageResource1" OnClick="UploadImage_OnClick"></asp:Button>
</td>
		<td valign=top><asp:Button runat="server" ID="DeleteImage" Text="Delete" meta:resourcekey="DeleteImageResource1" OnClick="DeleteImage_OnClick"></asp:Button>
</td>
		<td valign=middle>		
	</tr>
	<tr>
		<td colspan=3>
			<asp:RegularExpressionValidator runat="server" ControlToValidate="UploadFile" ID="FileValidator" Display="Dynamic" meta:resourcekey="FileValidatorResource1"></asp:RegularExpressionValidator>

			<asp:Literal runat="server" ID="ResultsMessage" meta:resourcekey="ResultsMessageResource1"></asp:Literal>
		
		</td>		
	</tr></table>	
	<input runat="server" ID="FileToDelete" type="hidden"></input>

	<input runat="server" ID="RootImagesFolder" type="hidden" value="images"></input>

	<input runat="server" ID="CurrentImagesFolder" type="hidden" value="images"></input>

</td></tr>
</asp:Panel>

</form>

</table>
</body>
</HTML>
</asp:panel>
<asp:panel id="iframePanel" runat="server" meta:resourcekey="iframePanelResource1" >
<html> 
<head><title>Insert Image</title></head>
<style>
body {
	margin: 0px 0px 0px 0px;
	padding: 0px 0px 0px 0px;
	background: #ffffff;
	overflow:hidden;
}
</style>
<body>
	<iframe style="width:100%;height:100%;border:0;" border=0 frameborder=0 src="ImagePicker.aspx?frame=1&"></iframe>
</body>
</html>
</asp:panel>

