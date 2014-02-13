using System;
using System.Collections.Specialized;
using System.Configuration.Provider;
using System.Data.SqlClient;
using System.Data;
using System.Web.Configuration;
using System.Data.Common;

namespace Commerce.Providers
{
    public class ZeroTaxRateProvider:TaxProvider
    {
        #region Provider specific behaviors
        public override void Initialize(string name, NameValueCollection config)
        {
            if (config == null)
                throw new ArgumentNullException("config");

            base.Initialize(name, config);


        }
        #endregion

        public override decimal GetTaxRate(string zip)
        {

            return 0;

        }

        public override decimal GetTaxRate(Commerce.Common.USState state)
        {
            throw new Exception("The method or operation is not implemented.");
        }
        public override DataSet GetTaxTable(Commerce.Common.USState state)
        {
            throw new Exception("The method or operation is not implemented.");
        }
        public override decimal GetTaxRate()
        {
            throw new Exception("The method or operation is not implemented.");
        }
    }
}
