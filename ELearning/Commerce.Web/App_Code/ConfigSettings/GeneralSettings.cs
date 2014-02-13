using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for GeneralSettings
/// </summary>
public class GeneralSettings:ConfigurationSection
{
    [StringValidator(MinLength = 3, MaxLength = 3)]
    [ConfigurationProperty("currencyCode",
        DefaultValue = "USD")]
    public string CurrencyCode
    {
        get { return (string)base["currencyCode"]; }
        set { base["currencyCode"] = value; }
    }
    [StringValidator(MinLength = 1)]
    [ConfigurationProperty("loginRequirement",
       DefaultValue = "checkout")]
    public string LoginRequirement
    {
        get { return (string)base["loginRequirement"]; }
        set { base["loginRequirement"] = value; }
    }
    [ConfigurationProperty("authorizeSaleOnly",
        DefaultValue = false)]
    public bool AuthorizeSaleOnly
    {
        get { return (bool)base["authorizeSaleOnly"]; }
        set { base["authorizeSaleOnly"] = value; }
    }
}
