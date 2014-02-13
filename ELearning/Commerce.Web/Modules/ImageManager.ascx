<%@ Control Language="C#" ClassName="ImageManager" %>
<script runat="server">
    public string ImageFolder = "";
    void Page_Load(object sender, EventArgs e) {
        if (ImageFolder=="") {
            ImageFolder = "images/productimages";
        }
    }
    public string GetSelectedImage() {
        string imgName = Request.Form[ClientID + "_imgHolder"].ToString();
        return imgName;
    }
    public void SetImage(string imageUrl) {
        imgPic.ImageUrl = imageUrl;
    }
    protected string GetImage() {
        string sImage = imgPic.ImageUrl;
        sImage = System.IO.Path.GetFileName(sImage);
        return sImage;

    }
</script>
<input name="<%=ClientID%>_imgHolder" type="hidden" value="<%=GetImage()%>" />
<asp:Image runat="server" ID="imgPic" ImageUrl="~/images/1pix.gif"/><br />
<button onclick="showPopWin('<%=Page.ResolveUrl("~/ImagePicker.aspx")%>?&ct=<%=ClientID%>_imgHolder&cn=<%=imgPic.ClientID%>&rif=<%=ImageFolder%>&cif=<%=ImageFolder%>', 800, 550, null);">...</button>
