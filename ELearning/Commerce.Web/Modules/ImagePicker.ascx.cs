using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Modules_ImagePicker : System.Web.UI.UserControl
{
    public string ImageFolder = "images";
    private void Page_Load(object sender, System.EventArgs e)
    {
        // Put user code to initialize the page here
        imgPic.Visible = true;
    }

    protected string GetImage()
    {
        string sImage = imgPic.ImageUrl;
        sImage = System.IO.Path.GetFileName(sImage);
        return sImage;

    }
    public string GetSelectedImage()
    {
        string imgName = Request.Form[ClientID + "_bob"].ToString();
        return imgName;
    }
    public void LoadImage(string imageName)
    {
        if (imageName != string.Empty)
        {
            imgPic.ImageUrl = Commerce.Common.Utility.GetSiteRoot() + "/" + ImageFolder + "/" + imageName;
        }
        else
        {
            imgPic.ImageUrl = Commerce.Common.Utility.GetSiteRoot() + "/images/1pix.gif";
        }

    }
}
