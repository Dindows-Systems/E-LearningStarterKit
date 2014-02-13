using System;
using System.Collections.Generic;
using System.Text;
using Commerce.Providers;
using System.Configuration;
using System.Configuration.Provider;
using System.Web.Configuration;
using System.Web;
using System.Web.Caching;
using System.Data;

namespace Commerce.Providers
{
    /// <summary>
    /// The tax calculator uses the TaxProvider to calculate the tax amount on 
    /// a set amount. You should consult your local tax laws before using/implementing.
    /// </summary>
    
    public class TaxService
    {
        #region Provider-specific bits
        private static TaxProvider _provider = null;
        private static TaxProviderCollection _providers = null;
        private static object _lock = new object();

        public TaxProvider Provider
        {
            get { return _provider; }
        }

        public TaxProviderCollection Providers
        {
            get { return _providers; }
        }
        public static TaxProvider Instance
        {
            get
            {
                LoadProviders();
                return _provider;
            }
        }
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
                        // Get a reference to the <TaxServiceSection> section
                        TaxServiceSection section = (TaxServiceSection)
                            WebConfigurationManager.GetSection
                            ("TaxService");

                        // Load registered providers and point _provider
                        // to the default provider
                        _providers = new TaxProviderCollection();
                        ProvidersHelper.InstantiateProviders
                            (section.Providers, _providers,
                            typeof(TaxProvider));
                        _provider = _providers[section.DefaultProvider];

                        
                        if (_provider == null)
                            throw new ProviderException
                                (Properties.Resources.CannotLoadDefaultTaxProvider);
                    }
                }
            }
        }
        #endregion


        public static decimal CalculateAmountByZIP(string zipCode, decimal subTotal) {
            decimal dOut = 0;
			try {
				decimal dRate = Instance.GetTaxRate(zipCode);
				dOut = subTotal * dRate;
			} catch(Exception x) {
				throw new ApplicationException( string.Format(Properties.Resources.TaxCalcFailed, x.Message), x);
			}
            return dOut;
        }
        public static decimal CalculateAmount(decimal subTotal)
        {
            decimal dOut = 0;
            try
            {
                decimal dRate = Instance.GetTaxRate();
                dOut = subTotal * dRate;
            }
            catch (Exception x)
            {
                throw new ApplicationException(string.Format(Properties.Resources.TaxCalcFailed, x.Message), x);
            }
            return dOut;
        }
        public static decimal GetUSTaxRate(string zipCode)
        {
            return Instance.GetTaxRate(zipCode);

        }
        public static decimal GetUSTaxRate(Commerce.Common.USState state)
        {
            return Instance.GetTaxRate(state);
        }
    }
}
