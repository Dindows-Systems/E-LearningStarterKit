using System;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.IO;
using System.Web.Services.Protocols;
using System.Data;
using Commerce.PayPal.PayPalSvc;
using System.Globalization;

namespace Commerce.PayPal {
	/// <summary>
	/// Summary description for APIWrapper.
	/// </summary>
	
	public class APIWrapper {
		
		
		#region Required Properties
		string _APIUserName="";
		string _APIPassword="";
		string _CertLocation="";
        string _CertPassword = "";
        Commerce.Common.CurrencyCode _currencyCode = Commerce.Common.CurrencyCode.USD;
        CurrencyCodeType ppCurrencyType = CurrencyCodeType.USD;


        public Commerce.Common.CurrencyCode CurrencyCode
        {
            get { return _currencyCode; }
        }
		public string APIUserName{
			get{return _APIUserName;}
		}
		public string APIPassword{
			get{return _APIPassword;}
		}
		public string CertLocation{
			get{return _CertLocation;}
		}
        public string CertPassword {
            get { return _CertPassword; }
        }
		#endregion

        PayPalAPISoapBinding service;
        PayPalAPIAASoapBinding service2;
       
        #region .ctor
        public APIWrapper(String apiUserName, string apiPassword, string certLocation, string certPassword, Commerce.Common.CurrencyCode currencyCode)
        {
            _APIUserName = apiUserName;
            _APIPassword = apiPassword;
            _CertLocation = certLocation;
            _CertPassword = certPassword;
            _currencyCode = currencyCode;

            string currCode = Enum.GetName(typeof(Commerce.Common.CurrencyCode), _currencyCode);
            ppCurrencyType = (CurrencyCodeType)Commerce.Common.Utility.StringToEnum(typeof(CurrencyCodeType), currCode);



            service = new PayPalAPISoapBinding();
            service.RequesterCredentials = new CustomSecurityHeaderType();
            service.RequesterCredentials.Credentials = new UserIdPasswordType();
            service.RequesterCredentials.Credentials.Username = _APIUserName;
            service.RequesterCredentials.Credentials.Password = _APIPassword;
            service.RequesterCredentials.Credentials.Subject = "";

            service2 = new PayPalAPIAASoapBinding();
            service2.RequesterCredentials = new CustomSecurityHeaderType();
            service2.RequesterCredentials.Credentials = new UserIdPasswordType();
            service2.RequesterCredentials.Credentials.Username = _APIUserName;
            service2.RequesterCredentials.Credentials.Password = _APIPassword;
            service2.RequesterCredentials.Credentials.Subject = "";

            FileStream fs = File.Open(_CertLocation, FileMode.Open, FileAccess.Read);

            byte[] buffer = new byte[fs.Length];

            int count = fs.Read(buffer, 0, buffer.Length);

            fs.Close();

            X509Certificate2 cert = new X509Certificate2(buffer, _CertPassword,X509KeyStorageFlags.MachineKeySet);
            service2.ClientCertificates.Add(cert);
            service.ClientCertificates.Add(cert);

        }
        #endregion

        #region Info APIs
        public string RefundTransaction(string TransactionID, decimal RefundAmount, string Memo, string currencyCode){

			string sReturn="";
            CurrencyCodeType currType = (CurrencyCodeType)StringToEnum(typeof(CurrencyCodeType), currencyCode);
            // Create the Refund Request
            RefundTransactionRequestType refundRequest = new RefundTransactionRequestType();
            BasicAmountType amount = new BasicAmountType();
            amount.currencyID = currType;
			
            amount.Value=RefundAmount.ToString();
			refundRequest.Memo = Memo;
			refundRequest.Amount=amount;


            refundRequest.RefundType = RefundPurposeTypeCodeType.Partial;
			refundRequest.TransactionID = TransactionID;
			refundRequest.Version = "1.0";

            RefundTransactionReq request = new RefundTransactionReq();
			request.RefundTransactionRequest = refundRequest;


			try{
                RefundTransactionResponseType response = service.RefundTransaction(request);
			
				string ErrorCheck=CheckErrors(response);
				if (ErrorCheck!="") {
					sReturn=(Properties.Resources.TransactionNotSuccessful + ": " + ErrorCheck);
				}
				else {
					sReturn=(Properties.Resources.Success);
				}
			}catch(Exception x){
				sReturn= Properties.Resources.SslFailure + ": "+x.Message;

			}
			return sReturn;

		}
		public string RefundTransaction(string TransactionID, bool DoFullRefund){

			string sReturn="";
			
            // Create the Refund Request
            RefundTransactionRequestType refundRequest = new RefundTransactionRequestType();
            BasicAmountType amount = new BasicAmountType();
            
            CurrencyCodeType currType = (CurrencyCodeType)this._currencyCode;
            amount.currencyID = currType;
          
            if (DoFullRefund) {
                refundRequest.RefundType = RefundPurposeTypeCodeType.Full;
            } else {
                refundRequest.RefundType = RefundPurposeTypeCodeType.Partial;
            }
			refundRequest.TransactionID = TransactionID;
			refundRequest.Version = "1.0";

            RefundTransactionReq request = new RefundTransactionReq();
			request.RefundTransactionRequest = refundRequest;


			try{
                RefundTransactionResponseType response = service.RefundTransaction(request);
				string ErrorCheck=CheckErrors(response);
				if (ErrorCheck!="") {
                    sReturn = ErrorCheck;
				}
				else {
                    sReturn = Properties.Resources.Success;

                }
			}catch(Exception x){
                sReturn = Properties.Resources.SslFailure + ": " + x.Message;

			}
            return sReturn;

        }
		
        //public string GetTransactionDetail(string transactionID, string delimiter){
        //    string sReturn="";
        //        GetTransactionDetailsRequestType detailRequest = new GetTransactionDetailsRequestType();
        //        detailRequest.TransactionID = transactionID;
        //        detailRequest.Version = "1.0";
        //        GetTransactionDetailsReq request = new GetTransactionDetailsReq();
        //        request.GetTransactionDetailsRequest = detailRequest;

        //        GetTransactionDetailsResponseType response = service.GetTransactionDetails(request);

        //        sReturn = response.Ack.ToString() + "\n";

        //        string sErrors = this.CheckErrors(response);
        //        if (sErrors == string.Empty) {
        //            //build out the response
        //            StringBuilder sb = new StringBuilder();
        //            sb.Append("************** Payment Information ******************" + delimiter);

        //            //payment info
        //            PaymentInfoType payment = response.PaymentTransactionDetails.PaymentInfo;
        //            sb.Append("ReceiptID: " + payment.ReceiptID + delimiter);
        //            sb.Append("TransactionID: " + payment.TransactionID + delimiter);
        //            sb.Append("PaymentDate: " + payment.PaymentDate + delimiter);
        //            sb.Append("GrossAmount: " + GetAmountValue(payment.GrossAmount) + delimiter);
        //            sb.Append("SettleAmount: " + GetAmountValue(payment.SettleAmount) + delimiter);
        //            sb.Append("FeeAmount: " + GetAmountValue(payment.FeeAmount) + delimiter);
        //            sb.Append("TaxAmount: " + GetAmountValue(payment.TaxAmount) + delimiter);
        //            sb.Append("PaymentStatus: " + payment.PaymentStatus + delimiter);
        //            sb.Append("PaymentType: " + payment.PaymentType + delimiter);
        //            sb.Append("TransactionType: " + payment.TransactionType + delimiter);
        //            sb.Append(delimiter);
        //            //sReturn+=response.PaymentTransactionDetails.PaymentInfo.ToString();
        //            sb.Append("************** Buyer Information ******************" + delimiter);

        //            //receiver info
        //            ReceiverInfoType receiver = response.PaymentTransactionDetails.ReceiverInfo;
        //            sb.Append("Business: " + receiver.Business + delimiter);
        //            sb.Append("Receiver: " + receiver.Receiver + delimiter);
        //            sb.Append("ReceiverID: " + receiver.ReceiverID + delimiter);

        //            /*
        //             * --- Uncomment this to report Auction and Subscription info
        //            sb.Append("************** Auction Information ******************"+delimiter);

        //            AuctionInfoType auction=new AuctionInfoType();
        //            sb.Append("BuyerID: "+auction.BuyerID+delimiter);
        //            sb.Append("ClosingDate: "+auction.ClosingDate+delimiter);
        //            sb.Append("ClosingDateSpecified: "+auction.ClosingDateSpecified+delimiter);
        //            sb.Append("multiItem: "+auction.multiItem+delimiter);

        //            sb.Append("************** Subscription Information ******************"+delimiter);

        //            SubscriptionInfoType sub=new SubscriptionInfoType();

        //            sb.Append("EffectiveDate: "+sub.EffectiveDate+delimiter);
        //            sb.Append("EffectiveDateSpecified: "+sub.EffectiveDateSpecified+delimiter);
        //            sb.Append("Password: "+sub.Password+delimiter);
        //            sb.Append("reattempt: "+sub.reattempt+delimiter);
        //            sb.Append("Recurrences: "+sub.Recurrences+delimiter);
        //            sb.Append("recurring: "+sub.recurring+delimiter);
        //            sb.Append("RetryTime: "+sub.RetryTime+delimiter);
        //            sb.Append("RetryTimeSpecified: "+sub.RetryTimeSpecified+delimiter);
        //            sb.Append("SubscriptionDate: "+sub.SubscriptionDate+delimiter);
        //            sb.Append("SubscriptionDateSpecified: "+sub.SubscriptionDateSpecified+delimiter);
        //            sb.Append("SubscriptionID: "+sub.SubscriptionID+delimiter);
        //            sb.Append("Terms: "+sub.Terms+delimiter);
        //            sb.Append("Username: "+sub.Username+delimiter);
        //            */
        //            sReturn = sb.ToString();
        //        } else {
        //            sReturn = sErrors;
        //        }

        //    return sReturn;
						
        //}
        //public DataTable GetTransactionSearch(DateTime StartDate,TransactionSearchParam param, string delimiter){
        //    DataTable table=new DataTable("results");
        //    TransactionSearchRequestType transSearch = new TransactionSearchRequestType();

        //    // Set up the TransactionSearch
        //    TransactionSearchReq request = new TransactionSearchReq();
        //    transSearch.StartDate=StartDate;

        //    request.TransactionSearchRequest = new TransactionSearchRequestType();
        //    transSearch.Version = "1.0";
        //    transSearch.CurrencyCodeSpecified = false;
        //    transSearch.EndDateSpecified = false;
        //    transSearch.StatusSpecified = false;

        //    //set the params
        //    transSearch.StartDate=StartDate;
        //    transSearch.EndDate = param.EndDate;
			
        //    #region args list
        //    int args=1;
        //    if(param.TransactionID!=""){
        //        transSearch.TransactionID = param.TransactionID;
        //        args++;
        //    }

        //    if(param.Amount!=""){
        //        transSearch.Amount = new BasicAmountType();
        //        transSearch.Amount.Value = param.Amount;
        //        args++;
        //    }
        //    if(param.PayerEmail!=""){
        //        transSearch.Payer = param.PayerEmail;
        //        args++;
        //    }

        //    if(param.Currency!=""){
        //        transSearch.CurrencyCodeSpecified = true;
        //        args++;
        //    }

        //    if(param.ItemNumber!=""){
        //        transSearch.AuctionItemNumber = param.ItemNumber;
        //        args++;
        //    }

        //    if(param.LastName!=""){
        //        transSearch.PayerName = new PersonNameType();
        //        transSearch.PayerName.LastName = param.LastName;
        //        args++;
        //    }

        //    if(param.FirstName!=""){
        //        transSearch.PayerName = new PersonNameType();
        //        transSearch.PayerName.FirstName = param.FirstName;
        //        args++;
        //    }

        //    if(param.PaymentStatus!=""){
        //        transSearch.StatusSpecified = true;
        //        args++;
        //    }

        //    if(param.PaymentType!=""){
        //        transSearch.TransactionClassSpecified = true;
        //        args++;
        //    }
        //    #endregion

        //    request.TransactionSearchRequest=transSearch;

        //    //if there are more than 0 args set, run the transaction
        //    if(args>0){
        //        //run the transactioon
        //        TransactionSearchResponseType response = service.TransactionSearch(request);

        //        if(response!=null){
        //            if(response.PaymentTransactions!=null){
        //                //build the columns out
        //                DataColumn cTransactionID=new DataColumn("TransactionID");
        //                DataColumn cFeeAmount=new DataColumn("FeeAmount");
        //                DataColumn cGrossAmount=new DataColumn("GrossAmount");
        //                DataColumn cNetAmount=new DataColumn("NetAmount");
        //                DataColumn cPayer=new DataColumn("Payer");
        //                DataColumn cPayerDisplayName=new DataColumn("PayerDisplayName");
        //                DataColumn cStatus=new DataColumn("Status");
        //                DataColumn cTimestamp=new DataColumn("Timestamp");
        //                DataColumn cType=new DataColumn("Type");

        //                table.Columns.Add(cTransactionID);
        //                table.Columns.Add(cFeeAmount);
        //                table.Columns.Add(cGrossAmount);
        //                table.Columns.Add(cNetAmount);
        //                table.Columns.Add(cPayer);
        //                table.Columns.Add(cPayerDisplayName);
        //                table.Columns.Add(cStatus);
        //                table.Columns.Add(cTimestamp);
        //                table.Columns.Add(cType);

        //                DataRow dr;
        //                foreach (PaymentTransactionSearchResultType trans in response.PaymentTransactions) {
        //                    dr=table.NewRow();
        //                    dr["TransactionID"]=trans.TransactionID;			
        //                    dr["FeeAmount"]=GetAmountValue(trans.FeeAmount);			
        //                    dr["GrossAmount"]=GetAmountValue(trans.GrossAmount);			
        //                    dr["NetAmount"]=GetAmountValue(trans.NetAmount);			
        //                    dr["Payer"]=trans.Payer;			
        //                    dr["PayerDisplayName"]=trans.PayerDisplayName;			
        //                    dr["Status"]=trans.Status;			
        //                    dr["Timestamp"]=trans.Timestamp.ToLongDateString();			
        //                    dr["Type"]=trans.Type.ToString();			

        //                    table.Rows.Add(dr);
        //                }	
        //            }
					
        //        }				

        //    }else{

        //        throw new Exception("You must specify at least one search paramater");

        //    }
			
        //    return table;
        //}
        //public string RunTransactionSearch(DateTime StartDate,TransactionSearchParam param, string delimiter){
    	
        //    string sOut="";
        //    TransactionSearchRequestType transSearch = new TransactionSearchRequestType();

        //    // Set up the TransactionSearch
        //    TransactionSearchReq request = new TransactionSearchReq();
        //    transSearch.StartDate=StartDate;

        //    request.TransactionSearchRequest = new TransactionSearchRequestType();
        //    transSearch.Version = "1.0";
        //    transSearch.CurrencyCodeSpecified = false;
        //    transSearch.EndDateSpecified = false;
        //    transSearch.StatusSpecified = false;

        //    //set the params
        //    transSearch.StartDate=StartDate;
        //    transSearch.EndDate = param.EndDate;
    		
        //    #region args list
        //    int args=1;
        //    if(param.TransactionID!=""){
        //        transSearch.TransactionID = param.TransactionID;
        //        args++;
        //    }

        //    if(param.Amount!=""){
        //        transSearch.Amount = new BasicAmountType();
        //        transSearch.Amount.Value = param.Amount;
        //        args++;
        //    }
        //    if(param.PayerEmail!=""){
        //        transSearch.Payer = param.PayerEmail;
        //        args++;
        //    }

        //    if(param.Currency!=""){
        //        transSearch.CurrencyCodeSpecified = true;
        //        args++;
        //    }

        //    if(param.ItemNumber!=""){
        //        transSearch.AuctionItemNumber = param.ItemNumber;
        //        args++;
        //    }

        //    if(param.LastName!=""){
        //        transSearch.PayerName = new PersonNameType();
        //        transSearch.PayerName.LastName = param.LastName;
        //        args++;
        //    }

        //    if(param.FirstName!=""){
        //        transSearch.PayerName = new PersonNameType();
        //        transSearch.PayerName.FirstName = param.FirstName;
        //        args++;
        //    }

        //    if(param.PaymentStatus!=""){
        //        transSearch.StatusSpecified = true;
        //        args++;
        //    }

        //    if(param.PaymentType!=""){
        //        transSearch.TransactionClassSpecified = true;
        //        args++;
        //    }
        //    #endregion

        //    request.TransactionSearchRequest=transSearch;

        //    //if there are more than 0 args set, run the transaction
        //    if(args>0){
        //        //run the transactioon
        //        TransactionSearchResponseType response = service.TransactionSearch(request);

        //        StringBuilder sb=new StringBuilder();
        //        sb.Append("Status: "+response.Ack.ToString()+delimiter);
        //        sb.Append("*********** Results ***************"+delimiter);
        //        if(response!=null){
        //            sb.Append( "Ack"+response.Ack +delimiter);
        //            sb.Append( "Version"+response.Version+delimiter );
        //            sb.Append( "Build"+response.Build +delimiter);
        //            sb.Append( "CorrelationID"+response.CorrelationID+delimiter );
    			
        //            if (response.TimestampSpecified )
        //                sb.Append( "Timestamp"+response.Timestamp+delimiter );
        //            else
        //                sb.Append( "Timestamp Not specified"+delimiter );
    				
        //            //PaymentTransactionSearchResultType[] trans=new PaymentTransactionSearchResultType();
    				
        //            //sb.Append( "PaymentTransactions: "+response.PaymentTransactions.Length.ToString()+delimiter );
        //            if(response.PaymentTransactions!=null){
        //                foreach(PaymentTransactionSearchResultType trans in response.PaymentTransactions){
    										
        //                    sb.Append("TransactionID: "+trans.TransactionID+delimiter);
        //                    sb.Append("FeeAmount: "+GetAmountValue(trans.FeeAmount)+delimiter);
        //                    sb.Append("GrossAmount: "+GetAmountValue(trans.GrossAmount)+delimiter);
        //                    sb.Append("NetAmount: "+GetAmountValue(trans.NetAmount)+delimiter);
        //                    sb.Append("Payer: "+trans.Payer+delimiter);
        //                    sb.Append("PayerDisplayName: "+trans.PayerDisplayName+delimiter);
        //                    sb.Append("Status: "+trans.Status+delimiter);
        //                    sb.Append("Timestamp: "+trans.Timestamp.ToLongDateString()+delimiter);
        //                    sb.Append("Type: "+trans.Type.ToString()+delimiter);
        //                    sb.Append("--"+delimiter+delimiter);


        //                }	
        //            }
    				
        //            sOut=sb.ToString();
        //        }else{
        //            sOut=sb.ToString()+delimiter+"No Results!";
        //        }				

        //    }else{

        //        throw new Exception("You must specify at least one search paramater");

        //    }
    		
        //    return sOut;
        //}
        #endregion

        #region Payment APIs
        public string SetExpressCheckout(string billToEmail, decimal dTotal, string returnUrl, string cancelUrl)
        {
            
            PayPalSvc.SetExpressCheckoutReq setRequest = new SetExpressCheckoutReq();
            PayPalSvc.SetExpressCheckoutRequestDetailsType setDetails = new SetExpressCheckoutRequestDetailsType();
            setRequest.SetExpressCheckoutRequest = new SetExpressCheckoutRequestType();

            setDetails.BuyerEmail = billToEmail;
            setDetails.OrderTotal = GetBasicAmount(dTotal);


            setDetails.ReturnURL = returnUrl;
            setDetails.CancelURL = cancelUrl;
            
            setRequest.SetExpressCheckoutRequest.Version = "1.0";
            setRequest.SetExpressCheckoutRequest.SetExpressCheckoutRequestDetails = setDetails;
            PayPalSvc.SetExpressCheckoutResponseType setResponse=service2.SetExpressCheckout(setRequest);

            string errors = this.CheckErrors(setResponse);
            string sOut = "";
            if (errors == string.Empty) {
                sOut = setResponse.Token;
            } else {
                sOut = errors;
            }
            return sOut;
        }

        public Commerce.Common.Address GetExpressCheckout(string token) {
            //PayerInfo payer = new PayerInfo();
            Commerce.Common.Address payer = new Commerce.Common.Address();

            PayPalSvc.GetExpressCheckoutDetailsReq req = new GetExpressCheckoutDetailsReq();
            PayPalSvc.GetExpressCheckoutDetailsRequestType requestType = new GetExpressCheckoutDetailsRequestType();

           
            requestType.Token=token;
            requestType.Version = "1.0";

            req.GetExpressCheckoutDetailsRequest = requestType;

            PayPalSvc.GetExpressCheckoutDetailsResponseType response= service2.GetExpressCheckoutDetails(req);

            string sOut = "";
            
            string errors = this.CheckErrors(response);
            if (errors == string.Empty) {
                string ack = response.Ack.ToString();
                payer.Email = response.GetExpressCheckoutDetailsResponseDetails.PayerInfo.Payer;
                payer.PayPalPayerID = response.GetExpressCheckoutDetailsResponseDetails.PayerInfo.PayerID;
                payer.FirstName = response.GetExpressCheckoutDetailsResponseDetails.PayerInfo.PayerName.FirstName;
                payer.LastName = response.GetExpressCheckoutDetailsResponseDetails.PayerInfo.PayerName.LastName;
                payer.Address1 = response.GetExpressCheckoutDetailsResponseDetails.PayerInfo.Address.Street1;
                payer.Address2 = response.GetExpressCheckoutDetailsResponseDetails.PayerInfo.Address.Street2;
                payer.City = response.GetExpressCheckoutDetailsResponseDetails.PayerInfo.Address.CityName;
                payer.StateOrRegion = response.GetExpressCheckoutDetailsResponseDetails.PayerInfo.Address.StateOrProvince;
                payer.Zip = response.GetExpressCheckoutDetailsResponseDetails.PayerInfo.Address.PostalCode;
                payer.PayPalToken = response.GetExpressCheckoutDetailsResponseDetails.Token;
                payer.Country = response.GetExpressCheckoutDetailsResponseDetails.PayerInfo.Address.CountryName;
            } else {
                payer.PayPalPayerID = errors;
            }
            return payer;
        }
        //This is TOTAL HACK
        //PayPal should be smarter than this.
        //have to round the digits to 2 decimal places
        //otherwise you get an invalid total error
        decimal RoundIt(decimal dPrice,int roundTo) {
            return Math.Round(dPrice, roundTo);
        }
        public Commerce.Common.Transaction DoExpressCheckout(Commerce.Common.Order order, bool AuthOnly) {
            
            //validate that the token is applied to the BillingAddress
            //same with PayerID
            if(String.IsNullOrEmpty(order.BillingAddress.PayPalPayerID))
                throw new Exception(Properties.Resources.NoPayerIDforBillingAddress);

             if(String.IsNullOrEmpty(order.BillingAddress.PayPalToken))
                throw new Exception(Properties.Resources.NoTokenForBillingAddress);
           
            PayPalSvc.DoExpressCheckoutPaymentReq checkoutRequest = new DoExpressCheckoutPaymentReq();
            DoExpressCheckoutPaymentRequestType checkoutReqType = new DoExpressCheckoutPaymentRequestType();
            DoExpressCheckoutPaymentRequestDetailsType checkoutDetails = new DoExpressCheckoutPaymentRequestDetailsType();
            PaymentDetailsType paymentDetails = new PaymentDetailsType();

            if (!AuthOnly) {
                checkoutDetails.PaymentAction = PaymentActionCodeType.Sale;
            } else {
                checkoutDetails.PaymentAction = PaymentActionCodeType.Authorization;

            }
            int roundTo = System.Globalization.CultureInfo.CurrentCulture.NumberFormat.CurrencyDecimalDigits;
            checkoutDetails.Token = order.BillingAddress.PayPalToken;
            checkoutDetails.PayerID = order.BillingAddress.PayPalPayerID;
            checkoutReqType.Version = "1.0";
            decimal dTotal = order.OrderTotal;

            paymentDetails.OrderTotal = GetBasicAmount(RoundIt(dTotal,roundTo));
            paymentDetails.ShippingTotal = this.GetBasicAmount(RoundIt(order.ShippingAmount,roundTo));
            paymentDetails.TaxTotal = this.GetBasicAmount(RoundIt(order.TaxAmount,roundTo));
            paymentDetails.Custom = order.OrderNumber;
            paymentDetails.ItemTotal = GetBasicAmount(RoundIt(order.CalculateSubTotal(), roundTo));
            //paymentDetails.OrderDescription = orderDescription;
            
            
            //This tells PayPal that the CSK is making the call. Please leave this
            //as it helps us keep going :):) (not monetarily, just with some love from PayPal).
            paymentDetails.ButtonSource = "CSK 2.1.0";
            //load up the payment items
            PaymentDetailsItemType item;

            int itemCount = order.Items.Count;

            PaymentDetailsItemType[] items = new PaymentDetailsItemType[itemCount];
            
            for (int i = 0; i < itemCount; i++) {
                item = new PaymentDetailsItemType();
                item.Name = order.Items[i].ProductName;
                item.Number = order.Items[i].Sku;
                item.Quantity = order.Items[i].Quantity.ToString();
                item.Amount = GetBasicAmount(RoundIt(order.Items[i].PricePaid, roundTo));
                items[i] = item;
            }
            paymentDetails.PaymentDetailsItem = items;
            checkoutRequest.DoExpressCheckoutPaymentRequest = checkoutReqType;
            checkoutRequest.DoExpressCheckoutPaymentRequest.DoExpressCheckoutPaymentRequestDetails = checkoutDetails;
            checkoutRequest.DoExpressCheckoutPaymentRequest.DoExpressCheckoutPaymentRequestDetails.PaymentDetails = paymentDetails;
            PayPalSvc.DoExpressCheckoutPaymentResponseType response=service2.DoExpressCheckoutPayment(checkoutRequest);
            
            string errors = this.CheckErrors(response);
            string sOut = "";
            Commerce.Common.Transaction trans = new Commerce.Common.Transaction();
            if (errors == string.Empty) {
                trans.GatewayResponse = response.Ack.ToString();
                trans.AuthorizationCode = response.DoExpressCheckoutPaymentResponseDetails.PaymentInfo.TransactionID;
                
            } else {
                trans.GatewayResponse = errors;
            }

            //return out the transactionID
            return trans;


        }


        static object StringToEnum(Type t, string Value)
        {
            object oOut = null;
            foreach (System.Reflection.FieldInfo fi in t.GetFields())
                if (fi.Name == Value)
                    oOut = fi.GetValue(null);    // We use null because
            return oOut;
        }
        public Commerce.Common.Transaction DoDirectCheckout(Commerce.Common.Order order, bool AuthOnly)
        {
            
            PayPalSvc.DoDirectPaymentReq req = new DoDirectPaymentReq();
            req.DoDirectPaymentRequest = new DoDirectPaymentRequestType();
            req.DoDirectPaymentRequest.Version = "1.0";

            DoDirectPaymentRequestDetailsType details=new DoDirectPaymentRequestDetailsType();
            details.CreditCard = new CreditCardDetailsType();
            details.CreditCard.CardOwner = new PayerInfoType();
            details.CreditCard.CardOwner.Address = new AddressType();
            details.CreditCard.CardOwner.PayerName = new PersonNameType();
            details.PaymentDetails = new PaymentDetailsType();

            CountryCodeType payerCountry = CountryCodeType.US;
            if (order.BillingAddress.Country != "US")
            {
                try
                {
                    payerCountry = (CountryCodeType)StringToEnum(typeof(CountryCodeType), order.BillingAddress.Country);
                }
                catch
                {
                }
            }

            details.CreditCard.CardOwner.Address.Country = payerCountry;
            details.CreditCard.CardOwner.PayerCountry = payerCountry;
            
            details.CreditCard.CardOwner.Address.CountrySpecified = true;
            details.CreditCard.CardOwner.Address.Street1 = order.BillingAddress.Address1;
            details.CreditCard.CardOwner.Address.Street2 = order.BillingAddress.Address2;
            details.CreditCard.CardOwner.Address.CityName = order.BillingAddress.City;
            details.CreditCard.CardOwner.Address.StateOrProvince = order.BillingAddress.StateOrRegion;
            details.CreditCard.CardOwner.Address.PostalCode = order.BillingAddress.Zip;

            details.CreditCard.CardOwner.PayerName.FirstName = order.BillingAddress.FirstName;
            details.CreditCard.CardOwner.PayerName.LastName = order.BillingAddress.LastName;


            //the basics
            int roundTo=System.Globalization.CultureInfo.CurrentCulture.NumberFormat.CurrencyDecimalDigits;
            decimal dTotal = Math.Round(order.CalculateSubTotal(), roundTo) + Math.Round(order.TaxAmount, roundTo) + Math.Round(order.ShippingAmount, roundTo);
            
            details.PaymentDetails.OrderTotal = GetBasicAmount(dTotal);
            details.PaymentDetails.ShippingTotal = this.GetBasicAmount(Math.Round(order.ShippingAmount, roundTo));
            details.PaymentDetails.TaxTotal = this.GetBasicAmount(Math.Round(order.TaxAmount, roundTo));
            details.PaymentDetails.Custom = order.OrderNumber;
            details.PaymentDetails.ItemTotal = GetBasicAmount(Math.Round(order.CalculateSubTotal(), roundTo));
            details.PaymentDetails.ButtonSource = "CSK 2.1.1";
           
           

            //credit card
            details.CreditCard.CreditCardNumber = order.CreditCardNumber;
            CreditCardTypeType ccType = CreditCardTypeType.Visa;
            switch(order.CreditCardType){
                case Commerce.Common.CreditCardType.MasterCard:
                    ccType = CreditCardTypeType.MasterCard;
                    break;
                case Commerce.Common.CreditCardType.Amex:
                    ccType = CreditCardTypeType.Amex;
                    break;
            }

            details.CreditCard.CreditCardType = ccType;
            details.CreditCard.ExpMonth = Convert.ToInt16(order.CreditCardExpireMonth);
            details.CreditCard.ExpYear = Convert.ToInt16(order.CreditCardExpireYear);
            details.CreditCard.CVV2 = order.CreditCardSecurityNumber;

            //set the IP - required
            details.IPAddress = order.UserIP;

            //set the req var to details
            req.DoDirectPaymentRequest.DoDirectPaymentRequestDetails = details;

            //sale type
            if (AuthOnly) {
                details.PaymentAction = PaymentActionCodeType.Authorization;
            } else {
                details.PaymentAction = PaymentActionCodeType.Sale;
            }

            //send the request
            //DoDirectPaymentResponseType response = service2.DoDirectPayment(req); <--COMMENTED FOR SIMULATION PURPOSES
            
            //string errors = this.CheckErrors(response);
            Commerce.Common.Transaction trans = new Commerce.Common.Transaction();
            trans.OrderID = order.OrderID;
            
            string sOut = "";
            //if (errors == string.Empty) {
                //trans.GatewayResponse = response.Ack.ToString();
                //trans.AuthorizationCode = response.TransactionID;
                //trans.CVV2Code = response.CVV2Code;

            trans.GatewayResponse = Properties.Resources.Success;
            trans.AuthorizationCode = Commerce.Common.Utility.GenerateRandomAuthorizationCode();
            trans.CVV2Code = "M";

            //} else {
            //    trans.GatewayResponse = errors;
            //    throw new Exception(errors);
            //}
            return trans;
        }


        #endregion

	    #region Helper Functions	
        
        string GetAmountValue(BasicAmountType amount) {
            
            //coerce it to a decimal
            decimal dAmount = decimal.Parse(amount.ToString());
            
            string sOut = "";
            try {
                sOut = dAmount.ToString("c");
            } catch {
                sOut = "--";
            }
            return sOut;
        }

        BasicAmountType GetBasicAmount(decimal amount) {
            BasicAmountType bAmount = new BasicAmountType();
            bAmount.Value = amount.ToString(CultureInfo.InvariantCulture);
            
            //this is lame....
            //why you have to specify a currency for each amount
            //is beyond me... oh well...
            //says alot for duck-typing...
            //if you have a better way to do this, it's about 2 am here
            //and I'll send you $10
            bAmount.currencyID = ppCurrencyType;
            return bAmount;
        }            
    
        string CheckErrors(AbstractResponseType abstractResponse) {
		    bool errorsExist = false;
		    string errorList="";
		    // First, check the Obvious.  Make sure Ack is not Success
		    if (!abstractResponse.Ack.Equals(AckCodeType.Success)) {
			    errorsExist = true;
		    }
		    // Check to make sure there is nothing in the Errors Collection
		    if (abstractResponse.Errors!=null) {
			    if (abstractResponse.Errors.Length > 0) {
				    errorsExist = true;
				    // Do something with the errors
                    errorList = "ERROR: ";
                    for (int i = 0; i < abstractResponse.Errors.Length; i++) {
					    // Access each error abstractResponse.Errors[i] and do something
					    errorList+=abstractResponse.Errors[i].LongMessage+ " ("+ abstractResponse.Errors[i].ErrorCode+")"+Environment.NewLine;
				    }
			    }
		    }
		return errorList;
	    }
		
        public class TransactionSearchParam{
			public DateTime EndDate=DateTime.Now;
			public string TransactionID="";
			public string Amount="";
			public string Currency="";
			public string ItemNumber="";
			public string PayerEmail="";
			public string LastName="";
			public string FirstName="";
			public string Receiver="";
			public string ReceiptID="";
			public string PaymentStatus="";
			public string PaymentType="";
           
		}

    		

    }
	    #endregion
	

}
