using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration.Provider;
using System.Data;

namespace Commerce.Providers
{
    public class PaymentProviderCollection : System.Configuration.Provider.ProviderCollection
    {
        public new PaymentProvider this[string name]
        {
            get { return (PaymentProvider)base[name]; }
        }

        public override void Add(ProviderBase provider)
        {
            if (provider == null)
                throw new ArgumentNullException("provider");

            if (!(provider is PaymentProvider))
                throw new ArgumentException
                    (Properties.Resources.InvalidProvider, "provider");

            base.Add(provider);
        }
    }
    public abstract class PaymentProvider : System.Configuration.Provider.ProviderBase
    {


	
        #region Payment Methods

        public abstract Commerce.Common.Transaction Charge(Commerce.Common.Order order);
        public abstract string Refund(Commerce.Common.Order order);

        #endregion

    }


}