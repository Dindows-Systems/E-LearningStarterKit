using System;
using System.Collections;
using System.Configuration;
using System.Configuration.Provider;
using System.Data;
using System.Web.Caching;
using System.Web.Configuration;

namespace Commerce.Providers {
    public class TaxProviderCollection : System.Configuration.Provider.ProviderCollection
    {
        public new TaxProvider this[string name]
        {
            get { return (TaxProvider)base[name]; }
        }

        public override void Add(ProviderBase provider)
        {
            if (provider == null)
                throw new ArgumentNullException("provider");

            if (!(provider is TaxProvider))
                throw new ArgumentException
                    (Properties.Resources.InvalidProviderType, "provider");

            base.Add(provider);
        }
    }    
    public abstract class TaxProvider : ProviderBase {

        private string serviceLogin;
        /// <summary>
        /// Used for remote service calls
        /// </summary>
        public string ServiceLogin
        {
            get { return serviceLogin; }
            set { serviceLogin = value; }
        }
        private string servicePassword;

        /// <summary>
        /// Used for remote service calls
        /// </summary>
        public string ServicePassword
        {
            get { return servicePassword; }
            set { servicePassword = value; }
        }

        private string serviceKey;

        public string ServiceKey
        {
            get { return serviceKey; }
            set { serviceKey = value; }
        }
	
        private const string _providerType = "CommerceTaxProvider";

        private static volatile TaxProvider _provider = null;
        private static object padLock = new object();

        #region Tax Calls
        public abstract decimal GetTaxRate();
		public abstract decimal GetTaxRate(string zip);
        public abstract decimal GetTaxRate(Commerce.Common.USState state);
        
        /// <summary>
        /// Returns a DataSet containing State, Zip, and Tax Rate info for a 
        /// given state
        /// </summary>
        /// <param name="state"></param>
        /// <returns></returns>
        public abstract DataSet GetTaxTable(Commerce.Common.USState state);
        #endregion

        public override void Initialize(string name, System.Collections.Specialized.NameValueCollection config)
        {
            base.Initialize(name, config);
        }

    }
}
