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
using Commerce.Providers;
using System.Collections.Generic;

public partial class CheckoutPPStandard : System.Web.UI.Page {

    Order order;
    protected void Page_Load(object sender, EventArgs e) {
        BindOrderInfo();
        if (!Page.IsPostBack) {
            Wizard1.ActiveStepIndex = 0;
            if (Profile.LastShippingAddress != null)
                AddressEntry1.SelectedAddress = Profile.LastShippingAddress;
        }
    }
    void BindOrderInfo() {
        order = OrderController.GetCurrentOrder();
        lblSummary.Text = order.ItemsToString(true);
    }
    protected void radShipChoices_SelectedIndexChanged(object sender, EventArgs e) {
        SetShipping();
    }
    void SetShipping() {

        //set the shipping to the default return
        order.ShippingAmount = decimal.Parse(radShipChoices.SelectedValue);
        order.ShippingMethod = radShipChoices.SelectedItem.Text;
        
        order.Save(Utility.GetUserName());
        lblSummary.Text = order.ItemsToString(true);
    }

    void BindShipping() {

        PackageInfo package = new PackageInfo();
        package.FromZip = SiteConfig.ShipFromZip;
        package.FromCountryCode = SiteConfig.ShipFromCountryCode;
        package.ToZip = AddressEntry1.SelectedAddress.Zip; ;
        package.ToCountryCode = AddressEntry1.SelectedAddress.Country;
        package.Weight = order.GetItemsWeight();
        package.Width = Convert.ToInt16(order.GetTotalWidth());
        package.Height = Convert.ToInt16(order.GetTotalHeight());
        package.Length = Convert.ToInt16(order.GetMaxLength());
        package.DimensionUnit = SiteConfig.DimensionUnit;
        package.PackagingBuffer = SiteConfig.ShipPackagingBuffer;
        //Create Dictionary args for future expansion options
        package.Args = new Dictionary<string, string>();

        Commerce.Providers.DeliveryOptionCollection options = Commerce.Providers.FulfillmentService.GetOptions(package, order.Items.Count);
        radShipChoices.DataSource = options;
        radShipChoices.DataTextField = "Service";
        radShipChoices.DataValueField = "Rate";
        radShipChoices.DataBind();
        radShipChoices.SelectedIndex = 0;

        //check the shipping incentive
        decimal dShipping = decimal.Parse(radShipChoices.SelectedValue);
        //determine if discount is used
        decimal shipDiscount = 0;
        bool haveDiscount = false;

        //localize it using the C formatter for local currency
        double dRate = 0;
        foreach (ListItem l in radShipChoices.Items) {
            decimal dShipCurrent = decimal.Parse(l.Value);

            //the discount is given as a percent, so divide it
            //by 100 to get the rate
            decimal discountRate = shipDiscount / 100;

            if (haveDiscount) {
                //apply it
                decimal dDiscountAmount = dShipCurrent * discountRate;
                decimal dDiscountedPrice = dShipCurrent - dDiscountAmount;

                l.Value = dDiscountedPrice.ToString();
                l.Text += ": " + string.Format(Resources.Common.DiscountedPrice, dDiscountedPrice.ToString("C"), dDiscountAmount.ToString("C"));
            } else {
                l.Text += ": " + dShipCurrent.ToString("C");

            }
        }
    }
    protected void btnContinue_Click(object sender, EventArgs e) {
        //set the order username and IP
        order.UserIP = Request.UserHostAddress;
        order.UserName = Utility.GetUserName();

        //set the billToAddress to something
        order.BillToAddress = Resources.Common.PaidAtPayPal;
        order.ShippingAddress = AddressEntry1.SelectedAddress;
        order.ShipToAddress = AddressEntry1.SelectedAddress.ToHtmlString();

        string orderNumber = "CSK-STD-" + Utility.GetRandomString();
        order.OrderNumber = orderNumber;
        
        order.Save(Utility.GetUserName());

        //if successful, send along the new orderID to PayPal
        string sUrl = PayPalHelper.GetUploadCartUrl(order);
        sUrl += "&custom=" + order.OrderGUID.ToString();

        Response.Redirect(sUrl);
    }
    protected void btnSetZip_Click(object sender, EventArgs e) {
        //set the shipping info
    }
    protected void StepChanged(object sender, EventArgs e) {
        if (Wizard1.ActiveStepIndex == 1) {

            //they have selected the Address, now calculate the shipping
            BindShipping();

        }
    }

}
