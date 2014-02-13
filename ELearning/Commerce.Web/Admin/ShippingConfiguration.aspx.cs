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
using System.Web.Configuration;

public partial class Admin_ShippingConfiguration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //ddlShipFromCountry.SelectedValue = "US";
            LoadConfig();
        }
    }
    void LoadConfig()
    {
        System.Configuration.Configuration config = WebConfigurationManager.OpenWebConfiguration(Request.ApplicationPath);
        Commerce.Providers.FulfillmentServiceSection section = (Commerce.Providers.FulfillmentServiceSection)config.GetSection("FulfillmentService");

        try
        {
            if (section != null)
            {

                //txtDimensionUnits.Text = section.DimensionUnit;
                //ddlShipFromCountry.SelectedValue = section.ShipFromCountryCode;
                //txtShipFromZip.Text = section.ShipFromZip;
                //chkUseShipping.Checked = section.UseShipping;

                if (section.Providers["SimpleShippingProvider"] != null)
                {
                    chkUseSimple.Checked = true;

                }
                if (section.Providers["USPostalServiceShippingProvider"] != null)
                {
                    //chkUsePO.Checked = true;
                    //poURL.Text = section.Providers["USPostalServiceShippingProvider"].Parameters["connectionUrl"].ToString();
                    //poUserName.Text = section.Providers["USPostalServiceShippingProvider"].Parameters["uspsUserName"].ToString();
                    //poPassword.Text = section.Providers["USPostalServiceShippingProvider"].Parameters["uspsPassword"].ToString();
                    //poHandling.Text = section.Providers["USPostalServiceShippingProvider"].Parameters["uspsAdditionalHandlingCharge"].ToString();
                }
                if (section.Providers["UpsShippingProvider"] != null)
                {
                    //chkUseUPS.Checked = true;
                    //upsURL.Text = section.Providers["UpsShippingProvider"].Parameters["connectionUrl"].ToString();
                    //upsAccessKey.Text = section.Providers["UpsShippingProvider"].Parameters["upsAccessKey"].ToString(); ;
                    //upsPassword.Text = section.Providers["UpsShippingProvider"].Parameters["upsPassword"].ToString(); ;
                    //upsUserName.Text = section.Providers["UpsShippingProvider"].Parameters["upsUserName"].ToString(); ;
                    //upsPickupTypeCode.Text = section.Providers["UpsShippingProvider"].Parameters["upsPickupTypeCode"].ToString(); ;
                    //upsCustomerClass.Text = section.Providers["UpsShippingProvider"].Parameters["upsCustomerClassification"].ToString(); ;
                    //upsPackTypeCode.Text = section.Providers["UpsShippingProvider"].Parameters["upsPackagingTypeCode"].ToString(); ;
                    //upsHandlingCharge.Text = section.Providers["UpsShippingProvider"].Parameters["upsAdditionalHandlingCharge"].ToString(); ;

                }
            }
        }
        catch
        {
            //do nothing - the web.config may have been changed manually or ... who knows
            //throwing an exception here will prevent the page from loading.
        }


    }
    protected void btnSaveSettings_Click(object sender, EventArgs e)
    {

        try
        {
            //save the config bits down to the web.config
            //get the provider, if there is one, and set the boxes
            System.Configuration.Configuration config = WebConfigurationManager.OpenWebConfiguration(Request.ApplicationPath);
            Commerce.Providers.FulfillmentServiceSection section = (Commerce.Providers.FulfillmentServiceSection)config.GetSection("FulfillmentService");

            section.Providers.Clear();

            if (chkUseSimple.Checked)
            {
                ProviderSettings simpleProvider = new ProviderSettings("SimpleShippingProvider", "Commerce.Providers.SimpleShippingProvider, Commerce.FulfillmentProvider");
                simpleProvider.Parameters.Add("connectionStringName", "CommerceTemplate");
                section.Providers.Add(simpleProvider);
            }

            //if (chkUsePO.Checked)
            //{
            //    ProviderSettings poProvider = new ProviderSettings("USPostalServiceShippingProvider", "Commerce.Providers.USPostalServiceShippingProvider, Commerce.FulfillmentProvider");

            //    poProvider.Parameters.Add("connectionUrl", poURL.Text);
            //    poProvider.Parameters.Add("uspsUserName", poUserName.Text);
            //    poProvider.Parameters.Add("uspsPassword", poPassword.Text);
            //    poProvider.Parameters.Add("uspsAdditionalHandlingCharge", poHandling.Text);

            //    section.Providers.Add(poProvider);
            //}

            //if (chkUseUPS.Checked)
            //{
            //    ProviderSettings upsProvider = new ProviderSettings("UpsShippingProvider", "Commerce.Providers.UpsShippingProvider, Commerce.FulfillmentProvider");
            //    upsProvider.Parameters.Add("connectionUrl", upsURL.Text);
            //    upsProvider.Parameters.Add("upsAccessKey", upsAccessKey.Text);
            //    upsProvider.Parameters.Add("upsUserName", upsUserName.Text);
            //    upsProvider.Parameters.Add("upsPassword", upsPassword.Text);
            //    upsProvider.Parameters.Add("upsPickupTypeCode", upsPickupTypeCode.Text);
            //    upsProvider.Parameters.Add("upsCustomerClassification", upsCustomerClass.Text);
            //    upsProvider.Parameters.Add("upsPackagingTypeCode", upsPackTypeCode.Text);
            //    upsProvider.Parameters.Add("upsAdditionalHandlingCharge", upsHandlingCharge.Text);

            //    section.Providers.Add(upsProvider);

            //}
            //section.UseShipping = chkUseShipping.Checked;
            //section.ShipFromZip = txtShipFromZip.Text;
            //section.ShipFromCountryCode = ddlShipFromCountry.SelectedValue;
            //section.ShipPackagingBuffer = 1;
            //section.DimensionUnit = txtDimensionUnits.Text;

            //config.Save();
            //ResultMessage2.ShowSuccess("Shipping Settings Updated");
        }
        catch (Exception x)
        {
            //ResultMessage2.ShowFail("Your Web.Config must be set to be writable by ASPNET or NETWORK SERVICE - cannot save config");
        }
    }
}
