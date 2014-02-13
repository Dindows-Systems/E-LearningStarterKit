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
using Commerce.Promotions;

public partial class _Product : System.Web.UI.Page
{

    protected int productID = Commerce.Common.Utility.GetIntParameter("id");
    protected string productSku = Utility.GetParameter("n");

    protected Commerce.Common.Product product = null;
    protected ProductDiscount discount;
    private Boolean hayModulos = false;
    protected Boolean puedeComprarProducto = true;

    protected void Page_Load(object sender, EventArgs e) {
        //###############################################################################
        //  Page Validators - these must be implemented or they will be redirected
        //###############################################################################
        try
        {
            if (productID != 0)
            {
                product = ProductController.GetProductDeep(productID);

            }
            else if (productSku != string.Empty)
            {
                product = ProductController.GetProductDeep(productSku);
            }

            //make sure we have a product
            TestCondition.IsTrue(product != null, Resources.Common.InvalidUrlProduct);

            //set the page variables
            productID = product.ProductID;
            productSku = product.Sku;

        }
        catch
        {
            //if they don't have a current order but somehow wandered this way
            //well they can't really do much. So send them back the home page
            Response.Redirect(Page.ResolveUrl("~/404.aspx"));
        }
        //##############################################################################

        if (ProductController.GetCantidadModulos(productID) > 0)
        {
            hayModulos = true;
        }

        if (product.ShippingType == ShippingType.DownloadOnly && product.ProductType == ProductType.DownloadableSoftware)
        {
            txtAddQty.ReadOnly = true;
            txtAddQty.ToolTip = "En productos digitales y descargables la cantidad solo puede ser uno.";
        }


        //  Si el producto es digital y solo descargable y 
        //  lo ha comprado antes, no lo puede volver a comprar.
        if (Page.User.Identity.IsAuthenticated &&
            product.ProductType == ProductType.DownloadableSoftware && product.ShippingType == ShippingType.DownloadOnly &&
            ProductController.GetCantidadProductComprado(productID) > 0)
        {
            puedeComprarProducto = false;
        }

        

        //load the product ratings

        BindProductInfo();
        TickStats();

        if (Session["AddProduct"] != null && (bool)Session["AddProduct"] == true)
            AddToCart();
    }

    void BindProductInfo()
    {
        ProductTopDisplay1.product = product;

        //set the ratings
        //this was passed in 

        ReviewDisplay1.product = product;
        FeedBackDisplay1.ProductID = product.ProductID;
        FeedBackDisplay1.ProductName = product.ProductName;
        FeedBackDisplay1.InitialRating = product.Rating;
        ProductDescriptorDisplay1.DescriptorList = product.Descriptors;

        if (hayModulos)
        {
            ProductModulos1.productID = product.ProductID;
        }
        else
        {
            ProductModulos1.Visible = false;
        }


        this.Title = product.ProductName;

    }
    void TickStats()
    {
        //track this
        Profile.RecentlyViewedProducts.AddProduct(product.Sku, product.ProductName, product.ImageFile);
        Commerce.Stats.Tracker.Add(Commerce.Stats.BehaviorType.BrowsingProduct, product.Sku);

    }

    protected decimal ParseAdjustedPrice(string selection) {
        decimal dOut = 0;
        string sOut = "";

        //This will be redone  for 2.0 Release. It's Kantona's fault.

        if (selection.IndexOf("(add") > 0 || selection.IndexOf("(subtract") > 0) {
            sOut = selection.Substring(selection.IndexOf("("), selection.IndexOf(")") - selection.IndexOf("("));
            sOut = sOut.Replace("(", "").Replace(")", "").Trim().Replace("add", "").Replace("subtract", "");
            
            //strip the currency symbol
            sOut = sOut.Replace(System.Globalization.CultureInfo.CurrentCulture.NumberFormat.CurrencySymbol, "");

            //thanks to Jon_ProLogic for this :)
            decimal.TryParse(sOut, out dOut);
            if (selection.IndexOf("subtract") > 0)
                dOut = 0 - dOut;
        }
        return dOut;
    }


    protected void AddToCart_Click(object sender, EventArgs e) {
        if (txtAddQty.Text != string.Empty)
        {
            int qty = 0;
            int.TryParse(txtAddQty.Text, out qty);
            if (qty > 0)
            {
                Session["ProductSelectedAttributes"] = ProductTopDisplay1.SelectedAttributes;

                //check to see if they require a login
                if (SiteConfig.RequireLogin == "carrito" & !User.Identity.IsAuthenticated)
                {
                    Session["AddProduct"] = true;
                    Response.Redirect("~/login.aspx?ReturnUrl=Product.aspx?" + Request.QueryString);
                }
                else
                    AddToCart();
             }
        }
    }

    private void AddToCart()
    {
        try
        {
            string promoCode = "";

            //add the item to the current order and redirect them to
            //the add page
            product.Quantity = int.Parse(txtAddQty.Text);
            //product.SelectedAttributes=selectedAtts;
            product.PromoCode = promoCode;

            //pull the atribute selection from the User Control "ProductTopDisplay"
            //which in turn pulls the bits from ProductAttributeDisplay.
            product.SelectedAttributes = Session["ProductSelectedAttributes"] as Attributes;

            if (product.SelectedAttributes != null)
            {
                //if there is a price adjustment
                //apply it here. It's possible that they could have chosen multiple adjustments
                //so.... just add them up!
                foreach (Commerce.Common.Attribute att in product.SelectedAttributes)
                {
                    foreach (AttributeSelection sel in att.Selections)
                    {
                        if (sel.PriceAdjustment != 0)
                            product.DiscountAmount = -sel.PriceAdjustment;

                    }
                }
            }
            Session.Remove("AddProduct");
            Session.Remove("ProductSelectedAttributes");

            OrderController.AddItem(product);

            //This behavior is by design 
            //See http://msdn.microsoft.com/library/default.asp?url=/library/en-us/cpref/html/frlrfsystemwebhttpresponseclassendtopic.asp
            Response.Redirect("additemresult.aspx", false);

        }
        catch (Exception x)
        {
            //TODO:Add error trap here.
            Response.Write(x.Message);
        }
    }

}
