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
using Commerce.Promotions;

public partial class Modules_ProductSummaryDisplay : System.Web.UI.UserControl
{

    public string ProductName;
    public string SKU;
    public string ProductID;
    public string ShortDescription;
    public string Features;
    public decimal OurPrice;
    public decimal RetailPrice;
    public string ImageFile;
    public string ShippingEstimate;
    public string Rating;
    protected void Page_Load(object sender, EventArgs e)
    {
        sr1.DisplayValue = Convert.ToDouble(Rating);
    }

    protected decimal GetDiscountedPrice()
    {
        decimal dOut=OurPrice;

        if (!string.IsNullOrEmpty(ProductID))
        {
            //get the adjusted price from the Promo service
            ProductDiscount discount = PromotionService.GetProductDiscount(int.Parse(ProductID));

            if (discount != null)
                dOut = discount.DiscountedPrice;
        }

        return dOut;
           
    }
    protected void AddToCart_Click(object sender, ImageClickEventArgs e)
    {
        Commerce.Common.Product prod = new Commerce.Common.Product(ProductID);
        prod.Quantity = 1;
        OrderController.AddItem(prod);
        Response.Redirect("~/AddItemResult.aspx");
    }
}
