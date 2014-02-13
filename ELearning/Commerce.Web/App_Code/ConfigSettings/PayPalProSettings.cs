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
/// Summary description for PayPalProSettings
/// </summary>
public class PayPalProSettings:ConfigurationSection
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

    [ConfigurationProperty("APIUserName",
       DefaultValue = "")]
    public string APIUserName
    {
        get { return (string)base["APIUserName"]; }
        set { base["APIUserName"] = value; }
    }
    [ConfigurationProperty("APIPassword",
       DefaultValue = "")]
    public string APIPassword
    {
        get { return (string)base["APIPassword"]; }
        set { base["APIPassword"] = value; }
    }
    [ConfigurationProperty("certificateName",
       DefaultValue = "")]
    public string CertificateName
    {
        get { return (string)base["certificateName"]; }
        set { base["certificateName"] = value; }
    }
    [ConfigurationProperty("certificatePassword",
    DefaultValue = "")]
    public string CertificatePassword
    {
        get { return (string)base["certificatePassword"]; }
        set { base["certificatePassword"] = value; }
    }

}
