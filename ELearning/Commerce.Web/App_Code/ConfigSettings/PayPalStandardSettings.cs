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
/// Summary description for PayPalStandardSettings
/// </summary>
public class PayPalStandardSettings:ConfigurationSection
{
    [ConfigurationProperty("isActive",
        DefaultValue = false)]
    public bool IsActive
    {
        get { return (bool)base["isActive"]; }
        set { base["isActive"] = value; }
    }
    [ConfigurationProperty("useSandbox",
        DefaultValue = true)]
    public bool UseSandbox
    {
        get { return (bool)base["useSandbox"]; }
        set { base["useSandbox"] = value; }
    }
    [StringValidator(MinLength = 5)]
    [ConfigurationProperty("businessEmail",
       DefaultValue = "me@business.com")]
    public string BusinessEmail
    {
        get { return (string)base["businessEmail"]; }
        set { base["businessEmail"] = value; }
    }
    [ConfigurationProperty("PDTID",
       DefaultValue = "")]
    public string PDTID
    {
        get { return (string)base["PDTID"]; }
        set { base["PDTID"] = value; }
    }

}
