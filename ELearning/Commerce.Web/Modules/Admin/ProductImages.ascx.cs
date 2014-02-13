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
using Commerce.Common;

public partial class Modules_Admin_ProductImages : System.Web.UI.UserControl {
    
    protected void Page_Load(object sender, EventArgs e) {

    }
    protected void btnSaveImage_Click(object sender, EventArgs e) {
        string imageName = ImagePicker1.GetSelectedImage();
        //a little cleanup here
        //want to remove the path to the images folder
        
        string appRoot = Request.ApplicationPath;
        //if on the root, appRoot will be "/"
        //if it's a virtual, appRoot will be "/virtual so we need to scrape off the virtual path";
        if (appRoot.Length > 1) {
            imageName = imageName.Replace(appRoot+"/", "");
        }
        Commerce.Common.Image image= new Commerce.Common.Image();
        image.ImageFile = imageName;
        image.ListOrder=int.Parse(txtNewImageListOrder.Text);
        image.Caption=txtNewImageCaption.Text;
        image.ProductID=int.Parse(lblProductID.Text);

        image.Save(Page.User.Identity.Name);



        LoadImages(int.Parse(lblProductID.Text));

        if (rptImages.Items.Count == 1)
        {
            //this is the first image - 
            //set the defaultImage of the product
            SetProductDefault(image.ImageFile);

        }

    }
    void SetProductDefault(string imgFile)
    {
        ProductController.SetProductDefaultImage(int.Parse(lblProductID.Text),imgFile);
    }
    public void LoadImages(int productID) {
        lblProductID.Text = productID.ToString();
        rptImages.DataSource = ProductController.GetImages(productID);
        rptImages.DataBind();
    }
    protected void DeleteImage(object source, RepeaterCommandEventArgs e) {
        Label lbl = (Label)e.Item.FindControl("lblImageID");
        if (lbl != null) {
            Commerce.Common.Image.Delete(int.Parse(lbl.Text));
            LoadImages(int.Parse(lblProductID.Text));

        }

        //reset the defaultImage property
        if (rptImages.Items.Count == 0)
        {
            //no images, so set the default to 0
            SetProductDefault("");
        }
    }
}
