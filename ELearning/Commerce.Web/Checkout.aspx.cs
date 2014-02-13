using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Commerce.Common;
using Commerce.Providers;
using Commerce.PayPal;
using WekeRoad.Tools;

public partial class Checkout : System.Web.UI.Page
{
    protected Order currentOrder = null;

    void ValidatePage()
    {
        //Page Validation
        //1) Need items in order to checkout
        try
        {
            TestCondition.IsTrue(currentOrder.Items.Count > 0, "There are not items in your cart");
        }
        catch
        {
            //send them to the basket page
            Response.Redirect("basket.aspx");
        }


        //2) Need to have this page under SSL!
        Utility.TestForSSL();

    }
    protected void Page_Load(object sender, EventArgs e)
    {



        //pull the order from the ViewState or DB as needed
        currentOrder = GetCurrentOrder();
        
        //make sure the page is valid
        ValidatePage();

       

        //turn the submit button off when they submit the order. This prevents double (or more) orders
        this.btnComplete.Attributes.Add("onclick", "this.value='Por favor espere...';this.disabled = true;" + Page.ClientScript.GetPostBackEventReference(this.btnComplete, ""));
        if (!Page.IsPostBack)
        {
            
            //check to see if they require a login
            if (SiteConfig.RequireLogin == "checkout")
            {
                if(!User.Identity.IsAuthenticated)
                    Response.Redirect("~/login.aspx?ReturnUrl=checkout.aspx");
            }
            
            /* Hasta probar la parte de la compra de productos digitales
            int cantidadProductosDigitales = ProductController.GetCountProductosCarritoCompradosDigitales(currentOrder.OrderID);
            
            if (cantidadProductosDigitales > 0)
            {
                Response.Redirect("~/errorPages/errorCart001.aspx");
            }*/

            LoadShippingList();

            //default the addresses
            if (Profile.LastShippingAddress != null)
                SetAddressEntry("addShipping", Profile.LastShippingAddress);
            if (Profile.LastBillingAddress != null)
                SetAddressEntry("addBilling", Profile.LastBillingAddress);

            //this is the package info for UPS/USPS
            PackageInfo package = LoadPackage();
            BindShipping(package);

            //check the URL for a return from PayPal using Express Checkout
            if (Utility.GetParameter("token") != string.Empty)
            {
                //get the info from PayPal about this buyer
                //and populate the addresses,etc
                ProcessExpressReturn(Utility.GetParameter("token"));

                //load the final wizard screen
                wizCheckout.MoveTo(wizCheckout.WizardSteps[2]);
            }

            //Setup Wizard
            SetupWizard();
        }
        SetOrderInfo();

    }

    private void SetupWizard()
    {
        // Enable/disable shipping step
        bool enableShippingStep = false;
        foreach (OrderItem item in currentOrder.Items)
        {
            Product product = Product.FetchByID(item.ProductID);
            if (product.ShippingType == ShippingType.NormalShipping)
            {
                enableShippingStep = true;
                break;
            }
        }
        if (!enableShippingStep)
        {
            wizCheckout.MoveTo(wizCheckout.WizardSteps[1]);
            imgShip.Visible = ImageButton1.Visible = btnPrev.Visible = false;
        }
    }

    

    Order GetCurrentOrder()
    {
        Order result = null;
        if (ViewState["CurrentOrder"] != null)
        {
            result = (Order)ViewState["CurrentOrder"];
        }
        else
        {
            result = OrderController.GetCurrentOrder();
        }
        return result;
    }
    void SetOrderInfo()
    {

        RadioButtonList radShipChoices = (RadioButtonList)wizCheckout.FindControl("radShipChoices");
        if (radShipChoices != null)
        {
            currentOrder.ShippingAmount = Profile.CurrentOrderShipping;
            currentOrder.ShippingMethod = Profile.CurrentOrderShippingMethod;
        }
        //these are set by the wizard in steps 1 & 2
        currentOrder.ShippingAddress = addShipping.SelectedAddress;
        currentOrder.BillingAddress = addBilling.SelectedAddress;

        //put them to HTML string for display to our admins
        currentOrder.ShipToAddress = addShipping.SelectedAddress.ToHtmlString();
        currentOrder.BillToAddress = addBilling.SelectedAddress.ToHtmlString();

        //see if this is an ExpressCheckout order
        //if it is, then we need to put the Checkout Tokens into the Billing Address
        if (ViewState["ppToken"] != null && ViewState["ppID"] != null)
        {
            currentOrder.BillingAddress.PayPalPayerID = ViewState["ppID"].ToString();
            currentOrder.BillingAddress.PayPalToken = ViewState["ppToken"].ToString();

        }



        if (radShipChoices.Items.Count > 0)
        {
            if (!currentOrder.IsDigitalOrder())
                currentOrder.ShippingAmount = decimal.Parse(radShipChoices.SelectedValue);
            else
                currentOrder.ShippingAmount = 0;
            currentOrder.ShippingMethod = radShipChoices.SelectedItem.Text;
        }
        //tax is stored in the Profile for this order
        currentOrder.TaxAmount = Profile.CurrentOrderTax;

        // Payment Method
        currentOrder.PaymentMethodId = PaymentBox1.PaymentMethodId;
        if (currentOrder.PaymentMethodId == PaymentMethod.CreditCard)
        {
            //pull the CC info from the PaymentBox
            currentOrder.CreditCardNumber = PaymentBox1.CCNumber;
            currentOrder.CreditCardExpireMonth = PaymentBox1.ExpirationMonth;
            currentOrder.CreditCardExpireYear = PaymentBox1.ExpirationYear;
            currentOrder.CreditCardSecurityNumber = PaymentBox1.SecurityCode;
            currentOrder.CreditCardType = PaymentBox1.CCType;
        }
        //else
        //{
        //    //Bank deposit
        //    currentOrder.BankDepositNumber = BankDepositTextBox.Text.Trim();
        //}

        if (currentOrder.BillingAddress != null)
        {
            currentOrder.FirstName = currentOrder.BillingAddress.FirstName;
            currentOrder.LastName = currentOrder.BillingAddress.LastName;
            currentOrder.Email = currentOrder.BillingAddress.Email;
        }

        //put the order in the ViewState to spare our DB
        ViewState["CurrentOrder"] = currentOrder;
    }


    #region Addressing
    void SetAddressEntry(string controlName, Address address)
    {
        AddressEntry addBox = (AddressEntry)wizCheckout.FindControl(controlName);
        if (addBox != null)
            addBox.SelectedAddress = address;

    }
    Address GetAddressEntry(string controlName)
    {
        Address add = null;
        AddressEntry addBox = (AddressEntry)wizCheckout.FindControl(controlName);
        if (addBox != null)
            add = addBox.SelectedAddress;
        return add;

    }
    void SaveAddresses()
    {
        //pull the addresses and save them to the DB for the user
        Address billAddress=addBilling.SelectedAddress;
        OrderController.SaveAddress(billAddress);

        //if the billing/shipping are different, save that as well
        Address shipAddress = addShipping.SelectedAddress;
        if (!shipAddress.Equals(billAddress))
        {
            OrderController.SaveAddress(shipAddress);
        }
    }
    #endregion

    #region Shipping Bits
    PackageInfo LoadPackage()
    {

        //Create shipping package
        PackageInfo package = new PackageInfo();
        package.FromZip = SiteConfig.ShipFromZip;
        package.FromCountryCode = SiteConfig.ShipFromCountryCode;
        package.ToZip = Profile.LastShippingAddress.Zip; ;
        package.ToCountryCode = Profile.LastShippingAddress.Country;
        package.Weight = currentOrder.GetItemsWeight();
        package.Width = Convert.ToInt16(currentOrder.GetTotalWidth());
        package.Height = Convert.ToInt16(currentOrder.GetTotalHeight());
        package.Length = Convert.ToInt16(currentOrder.GetMaxLength());
        package.DimensionUnit = SiteConfig.DimensionUnit;
        package.PackagingBuffer = SiteConfig.ShipPackagingBuffer;
        //Create Dictionary args for future expansion options
        package.Args = new Dictionary<string, string>();
        return package;

    }
    
    void BindShipping(PackageInfo package)
    {
        //IDataReader rdr = Commerce.Providers.ShippingService.GetShippingChoices(package);

        Commerce.Providers.DeliveryOptionCollection options = Commerce.Providers.FulfillmentService.GetOptions(package, currentOrder.NonDigitalItemCount - 1);
        radShipChoices.DataSource = options;
        radShipChoices.DataTextField = "Service";
        radShipChoices.DataValueField = "Rate";
        radShipChoices.DataBind();
        radShipChoices.SelectedIndex = 0;

        //localize it using the C formatter for local currency
        decimal dRate = 0;
        foreach (ListItem l in radShipChoices.Items)
        {
            dRate = decimal.Parse(l.Value);
            l.Text += ": " + dRate.ToString("C");

        }

        //set the Profile Shipping Bits
        if (!currentOrder.IsDigitalOrder())
            Profile.CurrentOrderShipping = decimal.Parse(radShipChoices.SelectedValue);
        else
            Profile.CurrentOrderShipping = 0;
        Profile.CurrentOrderShippingMethod = radShipChoices.SelectedItem.Text;
    }

    void LoadShippingList()
    {
        DataList dtAddresses = (DataList)wizCheckout.FindControl("dtAddresses");
        if (dtAddresses != null)
        {
            dtAddresses.DataSource = OrderController.GetUserAddresses();
            dtAddresses.DataBind();
            
        }
    }

    protected decimal GetSelectedShipping()
    {
        decimal dOut = 0;
        decimal.TryParse(radShipChoices.SelectedValue,out dOut);
        return dOut;
    }
    protected string GetShippingAddress()
    {
        return addShipping.SelectedAddress.ToHtmlString();
    }
    protected string GetBillingAddress()
    {
        return addBilling.SelectedAddress.ToHtmlString();
    }
    protected string GetShippingZip()
    {
        string zip = "";
        Address add = GetAddressEntry("addShipping");
        if (add != null)
            zip = add.Zip;

        return zip;
    }


    protected void radShipChoices_SelectedIndexChanged(object sender, EventArgs e)
    {
        //reset the order items
        //the change to the shipping amount happens on page load
        //in SetOrderInfo()
        lblOrderItems.Text = currentOrder.ItemsToString(true);
    }
    #endregion

    #region Checkout
    protected void btnComplete_Click(object sender, EventArgs e)
    {

        //set the final order info
        SetOrderInfo();

        //saving down the addresses is a convenience, if it bombs
        //swallow the exception and let it go.
        try
        {
            SaveAddresses();
        }
        catch
        {

        }

        //if there is a token in the querystring
        //this is a return from PayPal, and is therefore
        //an express checkout
        string transactionID = "";
        if (Request.QueryString["token"] != null)
        {
            transactionID = RunExpressCheckout();

        }
        else
        {
            transactionID = RunCharge();
        }

        //if an error occurred, the transactionId will be null or empty. 
        if (!String.IsNullOrEmpty(transactionID))
        {
            TransactionCodeLabel.Text = transactionID;
            OrderNumberLabel.Text = currentOrder.OrderNumber;
            TransactionStatusLabel.Text = OrderController.GetOrderStatusDescription(currentOrder.OrderStatus);
            radShipChoices.Enabled = false;
            pnlComplete.Visible = false;
            pnlFinalHeadNav.Visible = false;
            pnlReceipt.Visible = true;
        }
    }

    string RunExpressCheckout()
    {

        //InitOrder();

        //this is the PayPal response holder
        string orderID = "";

        string sToken = Utility.GetParameter("token");

        //run the Final Express Checkout
        try
        {
            Transaction trans = OrderController.TransactOrder(currentOrder, TransactionType.PagoPayPal);
            orderID = currentOrder.OrderGUID;
        }
        catch (Exception x)
        {
            ResultMessage1.ShowFail(x.Message);
        }

        return orderID;
    }

    string RunCharge()
    {
        string sOut = "";
        TransactionType transType;
        if (currentOrder.PaymentMethodId == PaymentMethod.CreditCard)
            transType = TransactionType.PagoTarjetaDeCredito;
        else
            transType = TransactionType.DepositoBancario;

        try
        {

            Transaction trans = OrderController.TransactOrder(currentOrder, transType);
            //the orderID is set during the TransactOrder process
            //sOut = currentOrder.OrderGUID;
            sOut = trans.AuthorizationCode;

        }
        catch (Exception x)
        {
            ResultMessage1.ShowFail(x.Message);
        }

        return sOut;
    }

    #endregion

    protected string GetPaymentInfo()
    {
        string result = "";
        if (PaymentBox1.PaymentMethodId == PaymentMethod.CreditCard)
        {
            //this can be one of two things
            //Express Checkout payment
            //or credit card.
            if (Utility.GetParameter("token") != string.Empty)
            {
                result = Resources.PaymentInfo.PayPalExpress;
            }
            else
            {
                result = Resources.PaymentInfo.CreditCard + ": " + Enum.GetName(typeof(CreditCardType), PaymentBox1.CCType) + "<br>" +
                    Utility.MaskCreditCard(PaymentBox1.CCNumber);
            }
            //BankDepositLabel.Visible = false;
            //BankDepositTextBox.Visible = false;
        }
        else
        {
            //Bank Deposit
            result = string.Format(Resources.PaymentInfo.BankDeposit, ConfigurationManager.AppSettings["DepositBank"], ConfigurationManager.AppSettings["DepositAccount"]);
            //BankDepositLabel.Visible = true;
            //BankDepositTextBox.Visible = true;
        }
        return result;
    }

    #region Express Checkout Bits

    void ProcessExpressReturn(string sToken)
    {

        //get the wrapper
        APIWrapper wrapper = GetPPWrapper();
        
        //they have come back from the PayPal site and have a token, so use this token to go get their info
        //and populate the shipping etc.
        Commerce.Common.Address payer = wrapper.GetExpressCheckout(sToken);
        

        //set this address as the BillTo/ShipTo for this order
        Profile.LastShippingAddress=payer;
        Profile.LastBillingAddress=payer;

        //set it as well in the billing/shippig controls
        addBilling.SelectedAddress = payer;
        addShipping.SelectedAddress = payer;

        //save this address for this user
        OrderController.SaveAddress(payer);

        //set the token in the ViewState 
        ViewState.Add("ppToken",payer.PayPalToken);
        ViewState.Add("ppID",payer.PayPalPayerID);

        //need to run the tax calc now that we have an address
        Profile.CurrentOrderTax = OrderController.CalculateTax(payer.Zip, currentOrder.CalculateSubTotal());


        //save down the order to the ViewState so that it can be picked up when Running the Charge
        SetOrderInfo();


    }
    APIWrapper GetPPWrapper()
    {
        string certPath = Server.MapPath("~/App_Data/" + SiteConfig.PayPalAPICertificate);
        APIWrapper wrapper = new Commerce.PayPal.APIWrapper(
            SiteConfig.PayPalAPIAccountName, SiteConfig.PayPalAPIAccountPassword,
            certPath, SiteConfig.PayPalAPICertificationPassword, SiteConfig.CurrencyCode);
        return wrapper;
    }
    protected void imgPayPal_Click(object sender, ImageClickEventArgs e)
    {
        SetExpressOrder();
    }
    void SetExpressOrder()
    {
        //use the API to get the SetCheckout response.
        //Then, redirect to PayPal
        int currencyDecimals = System.Globalization.CultureInfo.CurrentCulture.NumberFormat.CurrencyDecimalDigits;
        //get the wrapper
        APIWrapper wrapper = GetPPWrapper();

        string sEmail = "";
        if (Profile.LastShippingAddress != null)
        {
            if (Profile.LastShippingAddress.Email != string.Empty)
            {
                sEmail = Profile.LastShippingAddress.Email;
            }
            else
            {
                sEmail = "nobody@nowhere.com";
            }
        }

        //send them back here for all occassions
        string successURL = Commerce.Common.Utility.GetSiteRoot() + "/checkout.aspx";
        string failURL = Commerce.Common.Utility.GetSiteRoot() + "/checkout.aspx";


        if (currentOrder.Items.Count > 0)
        {

            string ppToken = wrapper.SetExpressCheckout(sEmail, currentOrder.CalculateSubTotal(), successURL,
                failURL);
            if (ppToken.ToLower().Contains("error"))
            {
                lblPPErr.Text="PayPal has returned an error message: "+ppToken;
            }
            else
            {
                string sUrl = "https://www.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=" + ppToken;

                if (SiteConfig.UsePPProSandbox)
                {
                    sUrl = "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=" + ppToken;
                }

                try
                {
                    Response.Redirect(sUrl);
                }
                catch(Exception x)
                {
                    ResultMessage1.ShowFail(x.Message);
                }
            }

        }
        else
        {
            Response.Redirect("basket.aspx");
        }

    }

    #endregion

    //#region Coupons
    //protected void applyCoupon_Click(object sender, EventArgs e)
    //{
    //    //Get the coupon.  
    //    try
    //    {
    //        Commerce.Promotions.Coupon selectedCoupon = Commerce.Promotions.Coupon.GetCoupon(couponCode.Text);
    //        //we have the coupon .. validate the order.  
    //        Commerce.Promotions.CouponValidationResponse valid =
    //            selectedCoupon.ValidateCouponForOrder(currentOrder);
    //        if (valid.IsValid)
    //        {
    //            //apply the coupon to the order 
    //            selectedCoupon.ApplyCouponToOrder(currentOrder);
    //            couponMessage.Text = "Coupon code " + selectedCoupon.CouponCode + " was applied to your order!";
    //            currentOrder.CouponCodes = selectedCoupon.CouponCode;
    //            currentOrder.CalculateSubTotal();
    //        }
    //        else
    //        {
    //            couponMessage.Text = "The selected coupon could not be applied to your order.  " + valid.ValidationMessage;
    //        }
    //    }
    //    catch (ArgumentException ex)
    //    {
    //        couponMessage.Text = "The code you entered could not be found or verified.";


    //    }
    //    couponMessage.Visible = true;

    //}

    //#endregion

    #region Wizard Event Handlers


    protected void btnBack_Click(object sender, EventArgs e)
    {
        //move to the second step

        wizCheckout.MoveTo(wizCheckout.WizardSteps[1]);
    }
    protected void Step_Changed(object sender, EventArgs e)
    {

        pnlComplete.Visible = false;
        pnlNav.Visible = true;
        pnlPayPal.Visible = false;
        if (wizCheckout.ActiveStepIndex == 0)
        {
            //********************* SHIPPING PAGE ***************************
            btnPrev.Visible = false;
            btnNext.Text = Resources.Common.Billing + " >>" ;

            if (SiteConfig.UsePayPalExpressCheckout)
            {
                pnlPayPal.Visible = true;
            }

        }
        if (wizCheckout.ActiveStepIndex == 1)
        {
            //********************* BILLING PAGE ***************************
            btnPrev.Visible = ImageButton1.Visible;
            btnPrev.Text = "<< " + Resources.Common.Shipping;
            btnNext.Text = Resources.Common.Finalize + " >>";
            
            //default the billing address to the shipping address
            //if they haven't filled it out yet
            if(addBilling.SelectedAddress.FirstName.Trim()==string.Empty)
                addBilling.SelectedAddress = addShipping.SelectedAddress;
            
            //save down the billing address to the Profile
            Profile.LastShippingAddress = addShipping.SelectedAddress;

            //

            //we have the shipping address so we can now calculate tax
            decimal dTax = 0;
            dTax = OrderController.CalculateTax(currentOrder.CalculateSubTotal());
            Profile.CurrentOrderTax = dTax;

        }
        else if (wizCheckout.ActiveStepIndex == 2)
        {
            //********************* FINAL PAGE ***************************
            pnlNav.Visible = false;
            lblShipTo.Text = GetShippingAddress();
            lblBillTo.Text = GetBillingAddress();
            lblPaySummary.Text = GetPaymentInfo();
            lblOrderItems.Text = currentOrder.ItemsToString(true);
            //save down the shipping address
            Profile.LastBillingAddress = addBilling.SelectedAddress;
            pnlComplete.Visible = true;
            //
            
        }


    }
    protected void imgShip_Click(object sender, ImageClickEventArgs e)
    {
        wizCheckout.ActiveStepIndex = 0;
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        wizCheckout.ActiveStepIndex = 0;

    }
    protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
    {
        wizCheckout.ActiveStepIndex = 1;

    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (wizCheckout.ActiveStep.Title == Resources.Common.Billing & TermsConditionsCheckBox.Checked == false)
        {
            ResultMessage1.ShowFail("Debe aceptar los Términos y Condiciones de Venta para poder completar su compra.");
        }
        else
        {
            //this button advances the wizard
            wizCheckout.ActiveStepIndex = wizCheckout.ActiveStepIndex + 1;
        }
    }
    protected void btnPrev_Click(object sender, EventArgs e)
    {
        wizCheckout.ActiveStepIndex = wizCheckout.ActiveStepIndex - 1;

    }
    #endregion

}
