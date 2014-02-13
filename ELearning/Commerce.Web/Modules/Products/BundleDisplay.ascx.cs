//using System;
//using System.Data;
//using System.Configuration;
//using System.Collections;
//using System.Web;
//using System.Web.Security;
//using System.Web.UI;
//using System.Web.UI.WebControls;
//using System.Web.UI.WebControls.WebParts;
//using System.Web.UI.HtmlControls;
//using Commerce.Promotions;
//using System.Collections.Generic;

//public partial class Modules_Products_BundleDisplay : System.Web.UI.UserControl
//{

//    public Commerce.Common.Product product;
//    protected void Page_Load(object sender, EventArgs e)
//    {
//    }
//    protected void AddBundle(object sender, EventArgs e)
//    {
//        int discount = 0;
//        decimal discountAmount = 0;
//        decimal price = 0;
//        int productID = 0;
//        int bundleID = 0;
//        Commerce.Common.Product prod = null;
//        List<BundleItem> list=PromotionService.GetBundleByProduct(product.ProductID);

//        foreach (Commerce.Promotions.BundleItem bundleItem in list)
//        {
//            discount = bundleItem.DiscountPercent;
//            price = bundleItem.OurPrice;
//            discountAmount = price * discount / 100;
//            productID = bundleItem.ProductID;
//            bundleID = bundleItem.BundleID;
            
//            prod = new Commerce.Common.Product(productID);
//            prod.ImageFile = prod.DefaultImage;
//            prod.Quantity = 1;
//            prod.DiscountAmount = discountAmount;
//            prod.PromoCode = "BUNDLE:" + bundleID.ToString();
//            OrderController.AddItem(prod);
//        }
//        Response.Redirect("additemresult.aspx");

//    }
//    protected List<BundleItem> GetBundle()
//    {
//        //get the bundles from the PromoService
//        return PromotionService.GetBundleByProduct(product.ProductID);
//    }

//}
