using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration.Provider;
using System.Configuration;
using System.Web.Configuration;

namespace Commerce.Providers
{
    public enum DeliveryRestrictions
    {
        Ground,
        Air,
        Freight,
        Download,
        None

    }

    public class FulfillmentService
    {

        #region Provider-specific bits
        private static FulfillmentProvider _provider = null;
        private static FulfillmentProviderCollection _providers = null;
        private static object _lock = new object();

        public FulfillmentProvider Provider
        {
            get { return _provider; }
        }

        public FulfillmentProviderCollection Providers
        {
            get { return _providers; }
        }
        public static FulfillmentProvider Instance
        {
            get
            {
                LoadProviders();
                return _provider;
            }
        }

        static Commerce.Providers.FulfillmentServiceSection ThisConfig;
        private static void LoadProviders()
        {
            // Avoid claiming lock if providers are already loaded
            if (_provider == null)
            {
                lock (_lock)
                {
                    // Do this again to make sure _provider is still null
                    if (_provider == null)
                    {
                        // Get a reference to the <imageService> section
                        ThisConfig = (Commerce.Providers.FulfillmentServiceSection)
                            WebConfigurationManager.GetSection
                            ("FulfillmentService");
                        
                        // Load registered providers and point _provider
                        // to the default provider
                        _providers = new FulfillmentProviderCollection();
                        ProvidersHelper.InstantiateProviders(ThisConfig.Providers, _providers, typeof(FulfillmentProvider));
                        _provider = (FulfillmentProvider)_providers[ThisConfig.DefaultProvider];

                        if (_provider == null)
                            throw new ProviderException
                                (Properties.Resources.CannotLoadFulfillmentProvider);
                    }
                }
            }
        }
        #endregion

        
        


        public static DeliveryOptionCollection GetOptions(PackageInfo package, int additionalItems)
        {
            LoadProviders();
            DeliveryOptionCollection options = new DeliveryOptionCollection();

            //if there are no restrictions, hit every provider and return the collection
            foreach (FulfillmentProvider provider in _providers)
            {
                options.Combine(provider.GetDeliveryOptions(package, additionalItems));
            }
            return options;
        }

        public static DeliveryOptionCollection GetOptions(PackageInfo package, DeliveryRestrictions restrictions)
        {
            LoadProviders();
            DeliveryOptionCollection options = new DeliveryOptionCollection();

            //if there are no restrictions, hit every provider and return the collection
            foreach (FulfillmentProvider provider in _providers)
            {
                options.Combine(provider.GetDeliveryOptions(package,restrictions));
            }
            return options;
        }

    }
}
