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

public partial class AddItemResult : System.Web.UI.Page
{
    protected DataSet ds;
    protected DataRow drLastAdded=null;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack) {
            LoadLists();
        } else {

        }
    }
    void LoadLists()
    {
        ds = ProductController.GetPostAddPage();
        //multi set return
        //0=recently added item 
        //1=recently viewed
        //2=Cross Sells
        if (ds.Tables[0].Rows.Count > 0)
        {
            drLastAdded = ds.Tables[0].Rows[0];
            LoadJustAdded(drLastAdded);
        }
        else
        {
            Response.Redirect("basket.aspx");
        }

        dtCrossProducts.DataSource = ds.Tables[2];
        dtCrossProducts.DataBind();
        dtRecent.DataSource = ds.Tables[1];
        dtRecent.DataBind();

    }

    void LoadJustAdded(DataRow dr)
    {
        OrderItem item = new OrderItem();
        item.Load(dr);
				if((item.ImageFile == null) || (item.ImageFile.Length == 0)) {
					imgJustAdded.ImageUrl = "~/images/ProductImages/no_image_available.gif";
				}
				else {
        imgJustAdded.ImageUrl = item.ImageFile;
				}
        lblJustAddedLineTotal.Text = item.LineTotal.ToString("c");
        lblJustAddedOurPrice.Text = item.PricePaid.ToString("c");
        lblJustAddedRetail.Text = item.OriginalPrice.ToString("c");
        lblJustAddedQuantity.Text = item.Quantity.ToString();
        lblJustAddedName.Text = item.ProductName.ToString();
				lblSelectedAtts.Text = item.Attributes;
    }
    
    protected void lnkAddRecent(object sender, DataListCommandEventArgs e)
    {
        Label lblProductID = (Label)e.Item.FindControl("lblProductID");
        if (lblProductID != null)
        {

            //there's no attribute selection here
            //so if this product is in the basket
            //it will be doubled up
            AddToCart(int.Parse(lblProductID.Text));
            
        }
        Response.Redirect("additemresult.aspx");
    }
    
    protected void lnkAddCross(object sender, DataListCommandEventArgs e)
    {
        Label lblProductID = (Label)e.Item.FindControl("lblProductID");
        if (lblProductID != null)
        {
            AddToCart(int.Parse(lblProductID.Text));
            
        }
        Response.Redirect("additemresult.aspx");

    }
    
    protected void AddToCart(int productID)
    {
        Commerce.Common.Product prod = new Commerce.Common.Product(productID);
        prod.Quantity = 1;
        prod.ImageFile = prod.DefaultImage;
        //prod.SelectedAttributes = "";
        prod.PromoCode = "";
        prod.DiscountAmount = 0;

        OrderController.AddItem(prod);

    }

    protected void lnkCheckout_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("checkout.aspx");
    }
}
