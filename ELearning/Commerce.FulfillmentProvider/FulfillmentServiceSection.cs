using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;


namespace Commerce.Providers
{
    public class FulfillmentServiceSection : ConfigurationSection
    {
        [ConfigurationProperty("providers")]
        public ProviderSettingsCollection Providers
        {
            get { return (ProviderSettingsCollection)base["providers"]; }
        }

        [StringValidator(MinLength = 1)]
        [ConfigurationProperty("defaultProvider",
            DefaultValue = "SqlShippingProvider")]
        public string DefaultProvider
        {
            get { return (string)base["defaultProvider"]; }
            set { base["defaultProvider"] = value; }
        }
        [ConfigurationProperty("useShipping",
        DefaultValue = true)]
        public bool UseShipping
        {
            get { return (bool)base["useShipping"]; }
            set { base["useShipping"] = value; }
        }
        [ConfigurationProperty("dimensionUnit",
        DefaultValue = "inches")]
        public string DimensionUnit
        {
            get { return (string)base["dimensionUnit"]; }
            set { base["dimensionUnit"] = value; }
        }
        [ConfigurationProperty("shipFromZip",
        DefaultValue = "00000")]
        public string ShipFromZip
        {
            get { return (string)base["shipFromZip"]; }
            set { base["shipFromZip"] = value; }
        }
        [ConfigurationProperty("shipFromCountryCode",
        DefaultValue = "US")]
        public string ShipFromCountryCode
        {
            get { return (string)base["shipFromCountryCode"]; }
            set { base["shipFromCountryCode"] = value; }
        }
        [ConfigurationProperty("shipPackagingBuffer",
        DefaultValue = "0")]
        public decimal ShipPackagingBuffer
        {
            get { return (decimal)base["shipPackagingBuffer"]; }
            set { base["shipPackagingBuffer"] = value; }
        }



    }
}