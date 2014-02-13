using System;
using System.Collections.Specialized;
using System.Configuration.Provider;
using System.Data.SqlClient;
using System.Data;
using System.Web.Configuration;
using System.Data.Common;

namespace Commerce.Providers {
    public class FlatRateTaxProvider : TaxProvider
    {

        string _connectionString = "";
        string _connectionStringName = "";

        #region Provider specific behaviors
        public override void Initialize(string name, NameValueCollection config){
            if (config == null)
                throw new ArgumentNullException("config");

            base.Initialize(name, config);

            _connectionStringName = config["connectionStringName"].ToString();

            if (String.IsNullOrEmpty(_connectionStringName))
                throw new ProviderException("Empty or missing connectionStringName");

            config.Remove("connectionStringName");

            if (WebConfigurationManager.ConnectionStrings[_connectionStringName] == null)
                throw new ProviderException("Missing connection string");

            _connectionString = WebConfigurationManager.ConnectionStrings[_connectionStringName].ConnectionString;

            if (String.IsNullOrEmpty(_connectionString))
                throw new ProviderException("Empty connection string");


        }
        #endregion

        public override decimal GetTaxRate(string zip)
        {
            decimal dOut = 0;
                      //load the default db from the base class
                Microsoft.Practices.EnterpriseLibrary.Data.Database db = Microsoft.Practices.EnterpriseLibrary.Data.DatabaseFactory.CreateDatabase();
                //specify the SP
                string cmd = "CSK_Tax_GetTaxRate";
                using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
                {

                    db.AddInParameter(dbCommand, "@zip", DbType.String, zip);

                    //return a reader using the Ent Blocks
                    using (IDataReader rdr = db.ExecuteReader(dbCommand))
                    {
                        if (rdr.Read())
                        {
                            dOut = (decimal)rdr["rate"];
                        }
                    }
                    //load routine closes the reader if flag is set to true;
                    return dOut;
                }
         
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
