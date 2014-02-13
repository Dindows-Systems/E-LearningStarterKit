using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;
using System.Configuration.Provider;
using System.Web.Configuration;
using System.Web;
using System.Web.Caching;
using System.Data;
using Commerce.Providers;
using System.Text.RegularExpressions;
using Commerce.Common;

namespace Commerce.Providers
{
    public class PaymentService
    {

        #region Provider-specific bits
        private static PaymentProvider _provider = null;
        private static PaymentProviderCollection _providers = null;
        private static object _lock = new object();

        public PaymentProvider Provider
        {
            get { return _provider; }
        }

        public PaymentProviderCollection Providers
        {
            get { return _providers; }
        }
        static PaymentProvider Instance
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
                        // Get a reference to the <PaymentService> section
                        PaymentServiceSection section = (PaymentServiceSection)
                            WebConfigurationManager.GetSection
                            ("PaymentService");

                        // Load registered providers and point _provider
                        // to the default provider
                        _providers = new PaymentProviderCollection();
                        ProvidersHelper.InstantiateProviders
                            (section.Providers, _providers,
                            typeof(PaymentProvider));
                        _provider = _providers[section.DefaultProvider];

                        if (_provider == null)
                            throw new ProviderException
                                (Properties.Resources.CannotLoadDefaultPaymentProvider);
                    }
                }
            }
        }
        #endregion

    #region Methods

        #region Gateway Charger

        public static Commerce.Common.Transaction RunCharge(Commerce.Common.Order order){

            //validations
            //CCNumber
            TestCondition.IsTrue(IsValidCardType(order.CreditCardNumber, order.CreditCardType),Properties.Resources.InvalidCreditCardNumber);

            //current expiration
            DateTime expDate = new DateTime(order.CreditCardExpireYear,order.CreditCardExpireMonth, 28);
            TestCondition.IsTrue(expDate >= DateTime.Today, Properties.Resources.ExpiredCreditCard);
            
            //amount>0
            TestCondition.IsGreaterThanZero(order.OrderTotal, Properties.Resources.AmountCannotBeZero);

            Commerce.Common.Transaction result=Instance.Charge(order);
            result.TransactionDate = DateTime.Now;
            result.Amount = order.OrderTotal;
            
            return result;
        }

        //Many thanks to Paul Ingles for this Code
        //http://www.codeproject.com/aspnet/creditcardvalidator.asp
        //Modified by Spook, 3/2006
        public static bool IsValidCardType(string cardNumber, Commerce.Common.CreditCardType CardType) {
            bool bOut = false;
            
            
            // AMEX -- 34 or 37 -- 15 length
            if ((Regex.IsMatch(cardNumber, "^(34|37)"))
                 && ((CardType==Commerce.Common.CreditCardType.Amex)))
                bOut= 15 == cardNumber.Length;


            // MasterCard -- 51 through 55 -- 16 length
            else if ((Regex.IsMatch(cardNumber, "^(51|52|53|54|55)")) &&
                      ((CardType==Commerce.Common.CreditCardType.MasterCard)))
                bOut= 16 == cardNumber.Length;

            // VISA -- 4 -- 13 and 16 length
            else if ((Regex.IsMatch(cardNumber, "^(4)")) &&
                      ((CardType==Commerce.Common.CreditCardType.VISA)))
                bOut= 13 == cardNumber.Length || 16 == cardNumber.Length;

            // Discover -- 6011 -- 16 length
            else if ((Regex.IsMatch(cardNumber, "^(6011)")) &&
                     ((CardType==Commerce.Common.CreditCardType.Discover)))
                bOut= 16 == cardNumber.Length;

            return bOut;
        }

        /// <summary>
        /// Runs a refund for the passed in order, and returns a verification 
        /// string. An exception will be thrown if there is an error.
        /// </summary>
        /// <param name="order"></param>
        /// <returns></returns>
        public static string Refund(Commerce.Common.Order order)
        {
            //validations

            //there has to be an initial payment
            if (order.Transactions.Count == 0)
                throw new Exception(Properties.Resources.OrderWithNoTransactions);
            

            string sOut = Instance.Refund(order);
            return sOut;
        }

        #endregion

    #endregion
    }


}
