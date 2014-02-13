using System;
using System.Collections.Generic;
using System.Text;

namespace Commerce.Providers {
	public class StrikeIronTaxProvider:TaxProvider {



		/// <summary>
		/// Calls strikeiron and gets rate for a zipcode
		/// </summary>
		/// <param name="zip"></param>
		/// <returns></returns>
		public override decimal GetTaxRate(string zip) {
			decimal dOut = 0;
			//create the service
			StrikeIron.TaxDataBasic tax = new Commerce.Providers.StrikeIron.TaxDataBasic();
			
			//user credentials
			StrikeIron.RegisteredUser user = new Commerce.Providers.StrikeIron.RegisteredUser();
			
			//you can get a free key for testing by registering at
			//strike iron. You can put you user/pass here, or a registration key

            if (this.ServiceKey != string.Empty)
            {
                user.UserID = ServiceKey;

            }
            else
            {
                user.UserID = ServiceLogin;
                user.Password = ServicePassword;
            }
			
            //license holder
			StrikeIron.LicenseInfo license = new Commerce.Providers.StrikeIron.LicenseInfo();
			
			//add the user credentials
			license.RegisteredUser = user;
		
			//add the license info
			tax.LicenseInfoValue = license;

			//call the service, get the rate
			try {
				StrikeIron.TaxRateUSAData rate = tax.GetTaxRateUS(zip);
				dOut=Convert.ToDecimal(rate.total_sales_tax);
			} catch {

			}

			return dOut;
		}

        public override decimal GetTaxRate(Commerce.Common.USState state)
        {
            decimal dOut = 0;
            //create the service
            StrikeIron.TaxDataBasic tax = new Commerce.Providers.StrikeIron.TaxDataBasic();

            //user credentials
            StrikeIron.RegisteredUser user = new Commerce.Providers.StrikeIron.RegisteredUser();

            user.UserID = this.ServiceLogin;

            //license holder
            StrikeIron.LicenseInfo license = new Commerce.Providers.StrikeIron.LicenseInfo();

            //add the user credentials
            license.RegisteredUser = user;

            //add the license info
            tax.LicenseInfoValue = license;

            //call the service, get the rate
            try
            {
                //StrikeIron.TaxRateUSAData rate = tax.GetTaxRateUS(zip);
                //dOut = Convert.ToDecimal(rate.total_sales_tax);
            }
            catch
            {

            }

            return dOut;
        }
        public override decimal GetTaxRate()
        {
            throw new Exception("The method or operation is not implemented.");
        }
        public override System.Data.DataSet GetTaxTable(Commerce.Common.USState state)
        {
            //talk to StrikeIron and get the rate info for a given state
            return null;

        }
        public override void Initialize(string name, System.Collections.Specialized.NameValueCollection config)
        {
            base.Initialize(name, config);
            try
            {
                this.ServiceKey = config["serviceKey"].ToString();
                //this.ServicePassword = config["servicePassword"].ToString();
                //this.ServiceLogin = config["serviceLogin"].ToString();
            }
            catch
            {
                throw new Exception("The Service Key must be set for the StrikeIronTaxProvider to work");
            }

        }
	
	}
}
