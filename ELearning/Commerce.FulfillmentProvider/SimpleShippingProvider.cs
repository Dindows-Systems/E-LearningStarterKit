using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Web.Configuration;
using System.Collections.Specialized;
using System.Configuration.Provider;

namespace Commerce.Providers
{
    public class SimpleShippingProvider:FulfillmentProvider
    {
        string _connectionString = "";
        string _connectionStringName = "";

        #region Provider overrides
        public override void Initialize(string name, NameValueCollection config)
        {
            // Verify that config isn't null
            if (config == null)
                throw new ArgumentNullException("config");

            base.Initialize(name, config);

            _connectionStringName = config["connectionStringName"].ToString();

            if (String.IsNullOrEmpty(_connectionStringName))
                throw new ProviderException(Properties.Resources.EmptyOrMissingConnectionString);

            config.Remove("connectionStringName");

            if (WebConfigurationManager.ConnectionStrings[_connectionStringName] == null)
                throw new ProviderException(Properties.Resources.MissingConnectionString);

            _connectionString = WebConfigurationManager.ConnectionStrings[_connectionStringName].ConnectionString;

            if (String.IsNullOrEmpty(_connectionString))
                throw new ProviderException(Properties.Resources.EmptyConnectionString);

        }
        #endregion

        
        
        public override DeliveryOptionCollection GetDeliveryOptions(PackageInfo package, int additionalItems)
        {
            Database db = DatabaseFactory.CreateDatabase();
            
            using (DbCommand cmd = db.GetStoredProcCommand("CSK_Shipping_GetRates"))
            {
                db.AddInParameter(cmd, "@baseShipping", DbType.Decimal, 3.21);
                db.AddInParameter(cmd, "@constant", DbType.Decimal, 0.07);
                db.AddInParameter(cmd, "@additionalItems", DbType.Decimal, additionalItems);
                IDataReader rdr = db.ExecuteReader(cmd);

                DeliveryOptionCollection coll = new DeliveryOptionCollection();
                coll.Load(rdr);
                rdr.Close();
                return coll;
            }
        }
        public override DeliveryOptionCollection GetDeliveryOptions(PackageInfo package, DeliveryRestrictions restrictions)
        {
            Database db = DatabaseFactory.CreateDatabase();
            string sp = "CSK_Shipping_GetRates";
            if (restrictions == DeliveryRestrictions.Air)
            {
                sp="CSK_Shipping_GetRates_Air";
            }
            else if (restrictions == DeliveryRestrictions.Freight || restrictions == DeliveryRestrictions.Ground)
            {
                sp = "CSK_Shipping_GetRates_Ground";

            }

            using (DbCommand cmd = db.GetStoredProcCommand(sp))
            {
                db.AddInParameter(cmd, "@weight", DbType.Decimal, package.Weight);
                IDataReader rdr = db.ExecuteReader(cmd);

                DeliveryOptionCollection coll = new DeliveryOptionCollection();
                coll.Load(rdr);
                rdr.Close();
                return coll;
            }
        }

    }
}
