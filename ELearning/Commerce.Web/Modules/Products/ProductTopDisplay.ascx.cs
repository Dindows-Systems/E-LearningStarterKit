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

public partial class Modules_Products_ProductTopDisplay : System.Web.UI.UserControl
{

    public Commerce.Common.Product product;
    protected ProductDiscount discount;

    private Commerce.Common.Attributes selectedAttributes;

    public Commerce.Common.Attributes SelectedAttributes
    {
        get { return attList.SelectedAttributes; }
    }
	

    protected void Page_Load(object sender, EventArgs e)
    {
        //attList.ProductAttributes = product.Attributes;
        pRating.DisplayValue = product.Rating;

        if (product != null)
        {
            discount = PromotionService.SetProductPricing(product);
        }
        attList.Product = product;

    }

}
