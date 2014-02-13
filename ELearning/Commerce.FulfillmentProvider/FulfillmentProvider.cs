using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration.Provider;
using System.Configuration;

namespace Commerce.Providers
{

    public class FulfillmentProviderCollection :ProviderCollection
    {

    }
    public abstract class FulfillmentProvider:ProviderBase
    {
        public abstract DeliveryOptionCollection GetDeliveryOptions(PackageInfo package, int additionalItems);
        public abstract DeliveryOptionCollection GetDeliveryOptions(PackageInfo package, DeliveryRestrictions restrictions);

    }
}
