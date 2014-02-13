using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;

namespace Commerce.Providers
{
    public class PaymentServiceSection : ConfigurationSection
    {
        [ConfigurationProperty("providers")]
        public ProviderSettingsCollection Providers
        {
            get { return (ProviderSettingsCollection)base["providers"]; }
        }

        [ConfigurationProperty("acceptCreditCards",
        DefaultValue = true)]
        public bool AcceptCreditCards
        {
            get { return (bool)base["acceptCreditCards"]; }
            set { base["acceptCreditCards"] = value; }
        }

        [StringValidator(MinLength = 1)]
        [ConfigurationProperty("defaultProvider",
            DefaultValue = "PayPalPaymentProvider")]
        public string DefaultProvider
        {
            get { return (string)base["defaultProvider"]; }
            set { base["defaultProvider"] = value; }
        }

    }
}
