using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Commerce.Providers;
using System.Web.Configuration;
using Commerce.Common;
using System.Globalization;
using System.Threading;

/// <summary>
/// Summary description for SiteConfig
/// </summary>
public static class SiteConfig
{
    static GeneralSettings generalSettings;
    static PayPalProSettings ppProSettings;
    static PayPalStandardSettings ppStandardSettings;
    public static PaymentServiceSection CreditCardSettings;
    public static TaxServiceSection TaxServiceSettings;
    static FulfillmentServiceSection shippingSettings;

    public static void Load()
    {
        // Get the current configuration file.
        System.Configuration.Configuration config = WebConfigurationManager.OpenWebConfiguration(HttpContext.Current.Request.ApplicationPath);
        generalSettings = (GeneralSettings)config.GetSection("GeneralSettings");
        ppProSettings = (PayPalProSettings)config.GetSection("PayPalProSettings");
        ppStandardSettings = (PayPalStandardSettings)config.GetSection("PayPalStandardSettings");
        CreditCardSettings = (PaymentServiceSection)config.GetSection("PaymentService");
        TaxServiceSettings = (TaxServiceSection)config.GetSection("TaxService");
        shippingSettings = (FulfillmentServiceSection)config.GetSection("FulfillmentService");
    }

    public static void SetupCurrency()
    {
        CultureInfo newCulture = CultureInfo.CurrentCulture.Clone() as CultureInfo;
        newCulture.NumberFormat.CurrencySymbol = ConfigurationManager.AppSettings["CurrencySymbol"];
        Thread.CurrentThread.CurrentCulture = newCulture;
    }


    #region Publics
    public static bool AcceptCreditCards
    {
        get { return CreditCardSettings.AcceptCreditCards; }
    }

    public static string DimensionUnit
    {
        get { return shippingSettings.DimensionUnit; }
    }
    
    public static string BusinessEmail
    {
        get { return ppStandardSettings.BusinessEmail; }
    }
    public static bool RequireShipping
    {
        get { return shippingSettings.UseShipping; }
    }
    public static string RequireLogin
    {
        get { return generalSettings.LoginRequirement; }
    }
    public static string ShipFromZip
    {
        get { return shippingSettings.ShipFromZip; }
    }

    public static bool UsePPStandardSandbox
    {
        get { return ppStandardSettings.UseSandbox; }
    }
    public static bool UsePPProSandbox
    {
        get { return ppProSettings.UseSandbox; }
    }

    public static bool UsePayPalPaymentsStandard
    {
        get { return ppStandardSettings.IsActive; }
    }
    public static CurrencyCode CurrencyCode
    {
        get { return (CurrencyCode)Utility.StringToEnum(typeof(Commerce.Common.CurrencyCode),generalSettings.CurrencyCode); }
    }
    public static string PayPalAPIAccountName
    {
        get { return ppProSettings.APIUserName; }
    }
    public static string PayPalAPIAccountPassword
    {
        get { return ppProSettings.APIPassword; }
    }
    public static string PayPalAPICertificate
    {
        get { return ppProSettings.CertificateName; }
    }
    public static string PayPalAPICertificationPassword
    {
        get { return ppProSettings.CertificatePassword; }
    }
    public static string PayPalPDTID
    {
        get { return ppStandardSettings.PDTID; }
    }

    public static decimal ShipPackagingBuffer
    {
        get { return shippingSettings.ShipPackagingBuffer; }
    }
    public static string ShipFromCountryCode
    {
        get { return shippingSettings.ShipFromCountryCode; }
    }

    public static bool AuthorizeSaleOnly
    {
        get { return generalSettings.AuthorizeSaleOnly; }
    }
    public static bool UsePayPalExpressCheckout
    {
        get { return ppProSettings.IsActive; }
    }

    #endregion
}
