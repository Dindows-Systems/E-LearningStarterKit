using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;
using System.Collections.Specialized;
using System.Globalization;

namespace Commerce.Providers
{
    class CountryTaxRateProvider:TaxProvider
    {
        #region Provider specific behaviors
        public override void Initialize(string name, NameValueCollection config)
        {
            if (config == null)
                throw new ArgumentNullException("config");

            base.Initialize(name, config);


        }
        #endregion

        public override decimal GetTaxRate()
        {
            return decimal.Parse(ConfigurationManager.AppSettings["TaxRate"], CultureInfo.InvariantCulture);
        }
        public override decimal GetTaxRate(Commerce.Common.USState state)
        {
            throw new Exception("The method or operation is not implemented.");
        }
        public override decimal GetTaxRate(string zip)
        {
            throw new Exception("The method or operation is not implemented.");
        }
        public override System.Data.DataSet GetTaxTable(Commerce.Common.USState state)
        {
            throw new Exception("The method or operation is not implemented.");
        }
    }
}
