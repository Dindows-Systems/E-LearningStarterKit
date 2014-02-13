using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Commerce.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;
using System.Collections;
using Commerce.Providers;
using WekeRoad.Tools;

/// <summary>
/// Summary description for OrderController
/// </summary>
public static  class OrderController
{
    
    public static decimal CalculateTax(string zip,decimal subtotal){

        return TaxService.CalculateAmountByZIP(zip, subtotal);

    }

    public static decimal CalculateTax(decimal subtotal)
    {
        return TaxService.CalculateAmount(subtotal);
    }

    public static void CancelOrder(Order order, string cancellationReason){

        //first, update the status
        order.OrderStatus = OrderStatus.OrdenCanceladaAntesDelEnvio;
        order.Save(Utility.GetUserName());

        //next, add a note to say it was cancelled
        OrderNote note = new OrderNote();
        note.OrderID = order.OrderID;
        note.OrderStatus = Enum.GetName(typeof(OrderStatus),OrderStatus.OrdenCanceladaAntesDelEnvio);
        note.Note = string.Format(Resources.Common.OrderCancelled, Utility.GetUserName(),cancellationReason);
        note.Save(Utility.GetUserName());


    }

    #region Getters

    public static IDataReader GetAllByFilter(DateTime dtStart, DateTime dtEnd, string userName, string orderNumber)
    {

        IDataReader rdr = null;
        //load the default db from the base class
        Database db = DatabaseFactory.CreateDatabase();
        //specify the SP
        string cmd = "CSK_Store_Order_Query";
        using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
        {

            db.AddInParameter(dbCommand, "@dateStart", DbType.DateTime, dtStart);
            db.AddInParameter(dbCommand, "@dateEnd", DbType.DateTime, dtEnd);
            db.AddInParameter(dbCommand, "@userName", DbType.String, userName);
            db.AddInParameter(dbCommand, "@orderNumber", DbType.String, orderNumber);

            //return a reader using the Ent Blocks
            rdr = db.ExecuteReader(dbCommand);
        }
        return rdr;

    }

    public static OrderCollection GetByUser()
    {
        return GetByUser(Utility.GetUserName());
    }
    public static OrderCollection GetByUser(string userName)
    {
        Query q = new Query(Order.GetTableSchema());
        q.AddWhere("userName", userName);
        q.AddWhere("orderStatusID", Comparison.NotEquals, OrderStatus.NoProcesada);
        OrderCollection list = new OrderCollection();
        list.Load(DBHelper.GetReader(q.BuildSelectCommand()));
        return list;
    }
    public static OrderCollection GetByUserOrderBy(string columnName, string ascDesc)
    {
        string userName = Utility.GetUserName();

        Query q = new Query(Order.GetTableSchema());
        q.AddWhere("userName", userName);
        q.AddWhere("orderStatusID", Comparison.NotEquals, OrderStatus.NoProcesada);
        
        if (ascDesc=="asc")
            q.OrderBy = OrderBy.Asc(columnName);

        if (ascDesc == "desc")
            q.OrderBy = OrderBy.Desc(columnName);
        
        OrderCollection list = new OrderCollection();
        list.Load(DBHelper.GetReader(q.BuildSelectCommand()));
        return list;
    
    }
    /// <summary>
    /// Returns any unchecked out order (aka "The Cart") for the currently logged-in user
    /// </summary>
    /// <returns></returns>
    public static Order GetCurrentOrder()
    {
        int orderID = GetCartOrderID();
        return GetOrder(orderID);

    }
    /// <summary>
    /// Returns any unchecked out order (aka "The Cart") for a user
    /// </summary>
    /// <returns></returns>
    public static Order GetCurrentOrder(string userName)
    {
        Query q = new Query(Order.GetTableSchema());
        q.AddWhere("OrderStatusID", OrderStatus.NoProcesada);
        q.AddWhere("userName", userName);
        IDataReader rdr = DBHelper.GetReader(q.BuildSelectCommand());

        Order order = new Order();
        order.Load(rdr);
        rdr.Close();
        
        return order;

    }
   /// <summary>
    /// Returns an order by it's GUID ID.
    /// </summary>
    /// <param name="orderID"></param>
    /// <returns></returns>
    public static Order GetOrder(int orderID){

        Order order = new Order();
        DataSet ds = new DataSet();
        //set to false since this is not a new order
        order.IsNew = false;
        string sql = "";

        //use a multiple return set to load up the order info
        
        //0 - the order itself
        Query q = new Query(Order.GetTableSchema());
        q.AddWhere("orderID", orderID);
        
        //append the sql
        sql += q.GetSelectSql() + "\r\n;";

        //1 - items
        q = new Query(OrderItem.GetTableSchema());
        q.AddWhere("orderID", orderID);
        q.OrderBy = OrderBy.Asc("createdOn");

        //append the sql
        sql += q.GetSelectSql() + "\r\n;";

        //2 - notes
        q = new Query(OrderNote.GetTableSchema());
        q.AddWhere("orderID", orderID);

        //append the sql
        sql += q.GetSelectSql() + "\r\n;";

        //3 - transactions
        q = new Query(Transaction.GetTableSchema());
        q.AddWhere("orderID", orderID);

        //append the sql
        sql += q.GetSelectSql() + "\r\n;";

        //Build the Command
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand cmd = db.GetSqlStringCommand(sql);
        db.AddInParameter(cmd, "@orderID", DbType.Int32, orderID);

        //load the dataset
        ds = db.ExecuteDataSet(cmd); ;

        //load up the bits - order first
        order.Load(ds.Tables[0]);

        //then items
        order.Items = new OrderItemCollection();
        order.Items.Load(ds.Tables[1]);
        if(order.Items.Count>0)
            order.LastAdded = order.Items[order.Items.Count - 1];

        //notes
        order.Notes = new OrderNoteCollection();
        order.Notes.Load(ds.Tables[2]);
        
        //transactions
        order.Transactions = new TransactionCollection();
        order.Transactions.Load(ds.Tables[3]);


        return order;
    }

    public static Order GetOrder(string orderGuid)
    {
        int orderID = 0;
        Query q = new Query(Order.GetTableSchema());
        q.AddWhere("orderGuid", orderGuid);
        q.SelectList = "orderID";
        object result = DBHelper.ExecuteScalar(q.BuildSelectCommand());
        
        if (result != null)
            orderID = (int)result;

        return GetOrder(orderID);
    }

    #endregion

    #region Address Methods
    public static int GetAddressBookCount()
    {
        Query q = new Query(Address.GetTableSchema());
        q.AddWhere("userName", Utility.GetUserName());
        q.AddAggregate("addressID", AggregateFunction.Count, "addCount");
        int iOut = (int)DBHelper.ExecuteScalar(q.BuildSelectCommand());
        return iOut;

    }
    public static AddressCollection GetUserAddresses()
    {
        
        AddressCollection list = new AddressCollection();
        IDataReader rdr = Address.FetchByParameter("userName", Utility.GetUserName());
        list.Load(rdr);
        rdr.Close();
        return list;
    }
    /// <summary>
    /// Saves the address to the DB
    /// </summary>
    /// <param name="address"></param>
    /// <param name="isBilling"></param>
    public static void SaveAddress(Address address){
        
        //check to see if this address exists
        Address addCheck = new Address();
        addCheck.Address1 = address.Address1;
        addCheck.City = address.City;
        addCheck.StateOrRegion = addCheck.StateOrRegion;
        addCheck.Country = addCheck.Country;
        addCheck.UserName = address.UserName;

        //use the Find() method to see if this address exists
        AddressCollection list = new AddressCollection();
        IDataReader rdr=Address.Find(addCheck);
        list.Load(rdr);
        rdr.Close();

        if (list.Count>0)
        {
            //this is an old address
            //set the address ID and mark it as old
            //this will tell the base class to run an Update
            address.AddressID = list[0].AddressID;
            address.IsNew = false;

        }
        //save it back
        address.Save(Utility.GetUserName());

    }
    #endregion

    #region Permission Sets
    public static bool CanRefund(Order order)
    {
        bool bOut = false;

        //if the order is not set to shipped
        //or if it hasn't already been refunded
        //we're good to go

        //your rules might be different, alter as needed
        switch (order.OrderStatus)
        {
            case OrderStatus.NoProcesada:
                break;
            case OrderStatus.RecibidaEsperandoPago:
                bOut = true;
                break;
            case OrderStatus.PagoRecibidoProcesandoOrden:
                bOut = true;
                break;
            case OrderStatus.ObteniendoItemsDelIventario:
                bOut = true;
                break;
            case OrderStatus.EsperandoEnvioAlCliente:
                bOut = true;
                break;
            case OrderStatus.ItemsDemoradosNoDisponibles:
                break;
            case OrderStatus.EnviadoAlCliente:
                break;
            case OrderStatus.DemoradoRedirigiendoEnvio:
                break;
            case OrderStatus.SolicitudDelClienteDemorada:
                bOut = true;
                break;
            case OrderStatus.OrdenDemoradaBajoRevision:
                bOut = true;
                break;
            case OrderStatus.OrdenCanceladaAntesDelEnvio:
                break;
            case OrderStatus.OrdenReembolsada:
                break;
            default:
                break;
        }

        //make sure the order total is valid
        if (order.CalculateSubTotal() <= 0)
            bOut = false;

        return bOut;
    }
    public static bool CanShip(Order order)
    {
        bool bOut = false;
        //if the order is not set to shipped
        //or if it hasn't already been refunded
        //we're good to go

        //your rules might be different, alter as needed
        switch (order.OrderStatus)
        {
            case OrderStatus.NoProcesada:
                break;
            case OrderStatus.RecibidaEsperandoPago:
                bOut = true;
                break;
            case OrderStatus.PagoRecibidoProcesandoOrden:
                bOut = true;
                break;
            case OrderStatus.ObteniendoItemsDelIventario:
                bOut = true;
                break;
            case OrderStatus.EsperandoEnvioAlCliente:
                bOut = true;
                break;
            case OrderStatus.ItemsDemoradosNoDisponibles:
                break;
            case OrderStatus.EnviadoAlCliente:
                break;
            case OrderStatus.DemoradoRedirigiendoEnvio:
                break;
            case OrderStatus.SolicitudDelClienteDemorada:
                bOut = true;
                break;
            case OrderStatus.OrdenDemoradaBajoRevision:
                bOut = true;
                break;
            case OrderStatus.OrdenCanceladaAntesDelEnvio:
                break;
            case OrderStatus.OrdenReembolsada:
                break;
            default:
                break;
        }

        return bOut;

    }
    public static bool CanCancel(Order order)
    {
        bool bOut = true;
        switch (order.OrderStatus)
        {
            case OrderStatus.NoProcesada:
                break;
            case OrderStatus.RecibidaEsperandoPago:
                break;
            case OrderStatus.PagoRecibidoProcesandoOrden:
                break;
            case OrderStatus.ObteniendoItemsDelIventario:
                break;
            case OrderStatus.EsperandoEnvioAlCliente:
                bOut = false;
                break;
            case OrderStatus.ItemsDemoradosNoDisponibles:
                break;
            case OrderStatus.EnviadoAlCliente:
                break;
            case OrderStatus.DemoradoRedirigiendoEnvio:
                break;
            case OrderStatus.SolicitudDelClienteDemorada:
                break;
            case OrderStatus.OrdenDemoradaBajoRevision:
                break;
            case OrderStatus.OrdenCanceladaAntesDelEnvio:
                bOut = false;
                break;
            case OrderStatus.OrdenReembolsada:
                bOut = false;
                break;
            default:
                break;
        }
        return bOut;

    }
    #endregion

    #region Transaction Methods
    static void ValidateOrder(Order order, bool validateAddress)
    {

        if (validateAddress)
        {
            //need to have shipping and billing
            TestCondition.IsNotNull(order.ShippingAddress, Resources.Common.NeedShippingAddress);
            TestCondition.IsNotNull(order.BillingAddress, Resources.Common.NeedBillingAddress);

        }

        //need to have the IP, email, first and last set
        TestCondition.IsNotNull(order.UserIP, Resources.Common.NeedValidIPAddress);
        TestCondition.IsNotNull(order.Email, Resources.Common.NeedValidEmail);
        TestCondition.IsNotNull(order.FirstName, Resources.Common.NeedValidFirstName);
        TestCondition.IsNotNull(order.LastName, Resources.Common.NeedValidLastName);

        //validation
        TestCondition.IsGreaterThanZero(order.CalculateSubTotal(), Resources.Common.InvalidSubtotal);
        TestCondition.IsNotEmptyString(order.UserName, Resources.Common.InvalidUserName);
        TestCondition.IsGreaterThanZero(order.Items.Count, Resources.Common.NoItems);


        //finally, for good measure, go through each monetary figure
        //and make sure it's decimal setting is appropriate
        //the subtotal is always rounded
        int currencyDecimals = System.Globalization.CultureInfo.CurrentCulture.NumberFormat.CurrencyDecimalDigits;
        order.ShippingAmount = Math.Round(order.ShippingAmount, currencyDecimals);
        order.TaxAmount = Math.Round(order.TaxAmount, currencyDecimals);
        foreach (OrderItem item in order.Items)
        {
            item.PricePaid = Math.Round(item.PricePaid, currencyDecimals);
            item.OriginalPrice = Math.Round(item.OriginalPrice, currencyDecimals);
        }


    }

    #region Chargers
    /// <summary>
    /// Executes the charge using the gateway of choice. If you are going to accept
    /// Different types of payments (like POs or Offline Cards), then this is 
    /// the place to put your routines.
    /// </summary>
    /// <param name="transType"></param>
    /// <returns></returns>
    static Transaction ExecuteCharge(Order order,TransactionType transType)
    {
        Transaction trans = null;
        if (transType == TransactionType.PagoTarjetaDeCredito)
        {
            //if this is successful, there's no going back
            //NO errors after this!
            trans = Commerce.Providers.PaymentService.RunCharge(order);
            trans.TransactionNotes = string.Format(Resources.Common.CreditCardTransCompleted, DateTime.Now.ToString());
            
        }
        else if (transType == TransactionType.PagoPayPal)
        {
            //this is an express checkout, use the PayPal API
            string certPath = HttpContext.Current.Server.MapPath("~/App_Data/" + SiteConfig.PayPalAPICertificate);
            Commerce.PayPal.APIWrapper wrapper = new Commerce.PayPal.APIWrapper(
                SiteConfig.PayPalAPIAccountName,
                SiteConfig.PayPalAPIAccountPassword,
                certPath,
                SiteConfig.PayPalAPICertificationPassword,SiteConfig.CurrencyCode);

            
            //the token should be in the BillingAddress of the order
            //check to be sure
            TestCondition.IsNotEmptyString(order.BillingAddress.PayPalToken, Resources.Common.InvalidPayPalToken);

            trans = wrapper.DoExpressCheckout(order, SiteConfig.AuthorizeSaleOnly);
            if (trans != null)
            {
                trans.TransactionNotes = string.Format(Resources.Common.PayPalExpressCheckoutTransCompleted, DateTime.Now.ToString());

                //an acknowledgement is received from PayPal
                //and it says "Success" if, well, it was a success
                if (trans.GatewayResponse != "Success")
                {
                    throw new Exception(string.Format(Resources.Common.PayPalExpressCheckoutError, trans.GatewayResponse));
                }

            }

        }
        else if (transType == TransactionType.DepositoBancario)
        {
            //TestCondition.IsNotEmptyString(order.BankDepositNumber, Resources.OrderValidations.NeedsBankDepositNumber);
            
            trans = new Transaction();
            trans.AuthorizationCode = Utility.GenerateRandomAuthorizationCode();
        }

        if (trans != null)
        {
            //add the baseline information
            trans.OrderID = order.OrderID;
            trans.Amount = order.OrderTotal;
            trans.TransactionType = transType;
            trans.TransactionDate = DateTime.Now;

        }
        else
        {
            //if the transaction's null, an error occurred along the way
            //throw an exception, as the order is not valid
            throw new Exception(Resources.Common.InvalidTransaction);
        }
        return trans;

    }
    #endregion


    public static Transaction TransactOrder(Order order, TransactionType transType)
    {
        Database db = DatabaseFactory.CreateDatabase();
        
        //Validate the Order
        ValidateOrder(order, true);
        
        //update the order info
        order.OrderDate = DateTime.Now;
        order.SubTotalAmount = order.CalculateSubTotal();
        order.UserIP = HttpContext.Current.Request.UserHostAddress;
        order.OrderStatus = OrderStatus.RecibidaEsperandoPago;

        //setting the final order number. This is for internal reference
        //to your business. Update as needed to reflect your companies
        //ordering system
        switch (transType)
        {
            case TransactionType.PagoPayPal:
                order.OrderNumber = "PP-" + Utility.GetRandomString();
                break;
            case TransactionType.OrdenDeCompra:
                order.OrderNumber = "OC-" + Utility.GetRandomString();
                break;
            case TransactionType.PagoTarjetaDeCredito:
            case TransactionType.PagoTarjetaDeCreditoFueraDeLinea:
                order.OrderNumber = "TC-" + Utility.GetRandomString();
                break;
            case TransactionType.DepositoBancario:
                order.OrderNumber = "DB-" + Utility.GetRandomString();
                break;
        }
        DbCommand orderCommand = order.GetUpdateCommand(Resources.Common.OrderSystem);
        
        //create a note for the order
        OrderNote note = new OrderNote();
        note.Note = Resources.Common.OrderCreated;
        note.OrderID = order.OrderID;
        note.OrderStatus = OrderStatus.RecibidaEsperandoPago.ToString();


        DbCommand noteCommand = note.GetInsertCommand(Resources.Common.OrderSystem);
        
        //the transaction to hold the charge info
        Transaction trans = null;



        using (DbConnection connection = db.CreateConnection())
        {
            connection.Open();
            DbTransaction transaction = connection.BeginTransaction();

            try
            {
                //Execute the order update
                db.ExecuteNonQuery(orderCommand, transaction);

                //add in the order note
                db.ExecuteNonQuery(noteCommand, transaction);

                //execute the charge - this charges the user
                //NO ERRORS after this, cannot roll back
                trans = ExecuteCharge(order,transType);

                //add the transaction to the order
                if (trans != null)
                    order.Transactions.Add(trans);

                try
                {
                    //record the transaction
                    //since the order is paid, the order record MUST be comitted
                    //if this call fails, enter it manually
                    DbCommand transRecordCommand = trans.GetInsertCommand(Resources.Common.OrderSystem);

                    //finally add in the transaction
                    db.ExecuteNonQuery(transRecordCommand, transaction);

                    OrderNote successNote = new OrderNote();
                    successNote.Note = string.Format(Resources.Common.SuccessfullyTransacted,order.OrderNumber);
                    successNote.OrderID = order.OrderID;
                    successNote.OrderStatus = OrderStatus.PagoRecibidoProcesandoOrden.ToString();
                    db.ExecuteNonQuery(successNote.GetInsertCommand(Resources.Common.OrderSystem), transaction);
                }
                catch (Exception x)
                {
                    //do nothing
                    //if the transaction record does not record in the DB for some reason
                    //we do NOT want to fail the overall transaction because they have already been
                    //charged. Log this failure....

                    //TODO: Log failure
                
                }

                // Commit the transaction
                transaction.Commit();
                //close the connection ... we are done with it.  
                connection.Close();

                //send off notification *after* the transaction commits ...
                //that way, we close the transacation ASAP.  
                //send off the notifications
                //NO ERRORS 
                try
                {
                    //to user saying thank you
                    MessagingController.SendOrderReceivedEmail(order);

                    //to merchant
                    MessagingController.SendMerchantOrderNotice(order);

                }
                catch
                {

                }

            }
            catch (Exception x)
            {
                // Rollback transaction 
                transaction.Rollback();
                throw x;

            }

        }

        return trans;

    }
    public static void Refund(Order order)
    {

        //add a transaction to the order, indicating it's been refunded
        Transaction trans = new Transaction();
        trans.Amount= 0 - order.OrderTotal;
        trans.TransactionNotes= string.Format(Resources.Common.OrderRefundedOn, DateTime.Now.ToString());
        trans.TransactionType=TransactionType.Reembolso;
        trans.OrderID=order.OrderID;
        trans.TransactionDate = DateTime.Now;
        DbCommand cmdTrans=trans.GetInsertCommand(Utility.GetUserName());

        //add a note as well
        OrderNote note=new OrderNote();
        note.OrderID=order.OrderID;
        note.Note = Resources.Common.OrderRefunded;
        note.OrderStatus=Enum.GetName(typeof(OrderStatus),order.OrderStatus);
        DbCommand cmdNote=note.GetInsertCommand(Utility.GetUserName());

        //set the status
        order.OrderStatus=OrderStatus.OrdenReembolsada;
        DbCommand cmdOrder=order.GetUpdateCommand(Utility.GetUserName());
        //commit
        Database db = DatabaseFactory.CreateDatabase();
        using (DbConnection connection = db.CreateConnection())
        {
            connection.Open();
            DbTransaction transaction = connection.BeginTransaction();

            try
            {
                //get the commands

                //run the queries
                db.ExecuteNonQuery(cmdTrans, transaction);
                db.ExecuteNonQuery(cmdNote, transaction);
                db.ExecuteNonQuery(cmdOrder, transaction);
                
                //call the provider to refund the order
                //if this fails, toss the DB bits
                //NO ERRORS after this
                PaymentService.Refund(order);

                // Commit the transaction
                transaction.Commit();
                //close the connection ... we are done with it.  
                connection.Close();


            }
            catch (Exception x)
            {
                // Rollback transaction 
                transaction.Rollback();
                throw x;

            }


        }
    }
    #region PP Standard Methods
    /// <summary>
    /// This method creates an order in the database, without applying a transaction to it.
    /// The order id is created for sending to PayPal in the "Custom" field. When the IPN/PDT 
    /// come back to the site, this value is used to Reconcile the transaction.
    /// </summary>
    public static void CreateStandardOrder()
    {

        Order order = GetCurrentOrder();

        //validate the order without address info since we won't know the billing address
        ValidateOrder(order,false);

        order.OrderGUID = System.Guid.NewGuid().ToString();

        //use your own logic for this one :)
        order.OrderNumber = "PPS" + Utility.GetRandomString();

        //flag the status as awaiting payment
        order.OrderStatus = OrderStatus.RecibidaEsperandoPago;
        order.OrderDate = DateTime.Now;

        //update the order status to "paid"
        Query q = new Query(Order.GetTableSchema());
        Hashtable updates = new Hashtable();
        updates.Add("orderStatusID", OrderStatus.PagoRecibidoProcesandoOrden);
        q.AddWhere("orderID", order.OrderID);
        DbCommand orderCommand = q.BuildUpdateCommand(updates);

        //create a note for the order
        OrderNote note = new OrderNote();
        note.Note = Resources.Common.OrderCreated;
        note.OrderID = order.OrderID;
        note.OrderStatus = OrderStatus.RecibidaEsperandoPago.ToString();

        //get the command to transact in the transaction
        DbCommand noteCommand = note.GetInsertCommand(Resources.Common.OrderSystem);


        //open the default db from the EL factory
        Database db = DatabaseFactory.CreateDatabase();
        using (DbConnection connection = db.CreateConnection())
        {
            connection.Open();
            DbTransaction transaction = connection.BeginTransaction();

            try
            {
                //input the order
                db.ExecuteNonQuery(orderCommand, transaction);


                //add in the order note
                db.ExecuteNonQuery(noteCommand, transaction);


                // Commit the transaction
                transaction.Commit();
                //close the connection ... we are done with it.  
                connection.Close();


            }
            catch (Exception x)
            {
                // Rollback transaction 
                transaction.Rollback();
                throw x;

            }
        }
    }

    /// <summary>
    /// This method commits the PayPal Standard order once received by the PDT or IPN.
    /// </summary>
    /// <returns></returns>
    public static Transaction CommitStandardOrder(Order order,string transactionID, decimal reportedAmount)
    {
        //the IPN and PDT return a transactionID as well as the amount paid.
        //make sure the amount is >= the amount of the transaction

        //create a transaction for this order
        Commerce.Common.Transaction trans = new Transaction();

        //if there are transactions for this order, that means that the PDT or IPN has already 
        //been received, so ignore it
        if (order.Transactions.Count == 0)
        {

            //no transactions
            //validate the transactionID
            TestCondition.IsNotEmptyString(transactionID, Resources.Common.InvalidPayPalTransactionID);

            //now check the amount of the order versus that paid for
            TestCondition.IsTrue(order.OrderTotal <= reportedAmount, Resources.Common.PayPalAmountDontMatchOrder);

            //add the baseline information
            trans.OrderID = order.OrderID;
            trans.Amount = order.OrderTotal;

            trans.TransactionType = TransactionType.PagoPayPal;
            trans.TransactionDate = DateTime.Now;
            trans.AuthorizationCode = transactionID;
            trans.TransactionNotes = string.Format(Resources.Common.PayPalStandardPaymentReceivedOn, DateTime.Now.ToString(),transactionID);

            //add a note to the Order
            OrderNote note = new OrderNote();
            note.Note = Resources.Common.PayPalPaymendReceived;
            note.OrderID = order.OrderID;
            note.OrderStatus = Utility.ParseCamelToProper(OrderStatus.PagoRecibidoProcesandoOrden.ToString());


            //finally, update the order status
            order.OrderStatus = OrderStatus.PagoRecibidoProcesandoOrden;

            //save em down
            //open the default db from the EL factory
            Database db = DatabaseFactory.CreateDatabase();
            using (DbConnection connection = db.CreateConnection())
            {
                connection.Open();
                DbTransaction transaction = connection.BeginTransaction();

                try
                {
                    //get the commands
                    DbCommand orderCommand = order.GetUpdateCommand(Resources.Common.OrderSystem);
                    DbCommand noteCommand = note.GetInsertCommand(Resources.Common.OrderSystem);
                    DbCommand transCommand = trans.GetInsertCommand(Resources.Common.OrderSystem);

                    //run the queries
                    db.ExecuteNonQuery(orderCommand, transaction);
                    db.ExecuteNonQuery(noteCommand, transaction);
                    db.ExecuteNonQuery(transCommand, transaction);

                    // Commit the transaction
                    transaction.Commit();
                    //close the connection ... we are done with it.  
                    connection.Close();


                }
                catch (Exception x)
                {
                    // Rollback transaction 
                    transaction.Rollback();
                    throw x;

                }

                //notifications
                try
                {
                    //send off notification *after* the transaction commits ...
                    MessagingController.SendOrderReceivedEmail(order);

                    //to merchant; this is redundant a bit, as the standard bits
                    //will tell merchant anyway.
                    MessagingController.SendMerchantOrderNotice(order);

                }
                catch
                {
                    //Do Nothing
                }
            }
        }
        else
        {
            //set it to the first transaction for this order
            trans = order.Transactions[0];
        }

        return trans;

    }

    #endregion


    #endregion

    #region Cart Methods
    /// <summary>
    /// Executes the CSK_Store_Order_MigrateOrder Stored Procedure, which merges the cart items 
    /// from an anonymous account to a known account transactionally.
    /// </summary>
    /// <param name="oldUserName">Anonymous User</param>
    /// <param name="newUserName">Known User</param>
    public static void MigrateCart(string oldUserName, string newUserName)
    {


        Order fromOrder = GetOrder(GetCartOrderID(oldUserName));
        Order toOrder = GetOrder(GetCartOrderID(newUserName));
        
        //first see if there is an order for the now-recognized user
        if (toOrder.OrderNumber==string.Empty)
        {
            //if not, just update the old order with the new user's username
            fromOrder.UserName = newUserName;
            fromOrder.Save(Utility.GetUserName());
        }
        else
        {
            //the logged-in user has an existing basket. 
            //if there is no basket from their anon session, 
            //we don't need to do anything
            if(fromOrder.OrderNumber!=string.Empty){

                //in this case, there is an order (cart) from their anon session
                //and an order that they had open from their last session
                //need to marry the items.

                //this part is up to your business needs - some merchants
                //will want to replace the cart contents
                //others will want to synch them. We're going to assume that
                //this scenario will synch the existing items.

                //############### Synch the Cart Items
                if (toOrder.Items.Count > 0 && fromOrder.Items.Count > 0)
                {
                    //there are items in both carts, move the old to the new
                    //when synching, find matching items in both carts
                    //update the quantities of the matching items in the logged-in cart
                    //removing them from the anon cart

                    //a switch to tell us if we need to update the from orders
                    bool itemsRemoved = false;
                    foreach (OrderItem anonItem in fromOrder.Items)
                    {
                        //see if the item is also in the logged-in cart
                        OrderItem foundItem=toOrder.Items.FindItem(anonItem);

                        if (foundItem!=null)
                        {
                            //increment the quantity
                            foundItem.Quantity += anonItem.Quantity;
                            
                            //remove this item from the anon cart
                            fromOrder.Items.Remove(foundItem);
                            itemsRemoved = true;
                            
                        }

                    }

                    //if items were removed, we need to save them
                    if (itemsRemoved)
                        fromOrder.SaveItems();

                    //all matching items are updated, now move all remaining items
                    //to the logged-in cart
                    bool itemsAdded = false;
                    foreach (OrderItem anonItem in fromOrder.Items)
                    {
                        //reset the orderID
                        anonItem.OrderID = toOrder.OrderID;
                        toOrder.Items.Add(anonItem);
                        itemsAdded = true;
                    }   
               
                    //finally, save it down to the DB
                    if(itemsAdded)
                       toOrder.SaveItems();

                }
                else if(toOrder.Items.Count==0)
                {
                    //items exist only in the anon cart
                    //move the anon items to the new cart
                    //then save the order and the order items.
                    toOrder.IsNew = true;
                    toOrder.OrderGUID = fromOrder.OrderGUID;
                    toOrder.UserName = newUserName;
                    toOrder.OrderNumber = fromOrder.OrderNumber;
                    toOrder.OrderDate = fromOrder.OrderDate;
                    toOrder.Save(newUserName);
                    foreach(OrderItem item in fromOrder.Items) {
	                    //reset the orderID on each item
	                    item.OrderID = toOrder.OrderID;
	                    toOrder.Items.Add(item);
                    }   
                    toOrder.SaveItems();
                    //fromOrder.SaveItems();
                }
                else if(fromOrder.Items.Count==0){
                    //no items in the old cart, do nothing
                }


                //finally, drop the anon order from the DB, we don't want to 
                //keep it
                fromOrder.DeletePermanent();
            }
        }

    }
    public static int GetCartItemCount()
    {
        int orderID = GetCartOrderID();
        Query q = new Query(OrderItem.GetTableSchema());
        q.AddAggregate("orderItemID", AggregateFunction.Count, "items");
        q.AddWhere("orderID", orderID);
        object result = DBHelper.ExecuteScalar(q.BuildSelectCommand());
        int iOut = 0;
        if (result != null)
            iOut = (int)result;
        return iOut;
    }
    public static OrderItemCollection GetCartItems()
    {
        //get the cart items for the current user's cart
        int orderID = GetCartOrderID();
        OrderItemCollection list = new OrderItemCollection();

        if (orderID != 0)
        {
            Query q = new Query(OrderItem.GetTableSchema());
            q.AddWhere("orderID", orderID);

            IDataReader rdr = DBHelper.GetReader(q.BuildSelectCommand());
            list.Load(rdr);
            rdr.Close();


        }
        return list;
    }
    public static void AddItem(Product product)
    {

        //try
        //{
            //get the current orderID
            int orderID = ProvisionOrder(Utility.GetUserName());

            //get the current quantity
            int oldQuantity = GetExistingQuantity(orderID,product);

            //if the existing quantity is 0, the item's not there so add it
            if (oldQuantity == 0)
            {
                SaveOrderItem(product, orderID, Utility.GetUserName());
            }
            else
            {
                string selectedAttributes = null;
                if (product.SelectedAttributes != null)
                    selectedAttributes = product.SelectedAttributes.ToString();
                //it's there so adjust it
                AdjustQuantity(orderID, product.ProductID, selectedAttributes, oldQuantity + product.Quantity);
            }
        //}
        //catch
        //{

        //}
    }
    public static void AdjustQuantity(int orderID, int productID, string selectedAttributes, int newQuantity)
    {
        //check to see if this product is already added, if not, add it. If it's there, adjust the quantity
        Query q = new Query(OrderItem.GetTableSchema());
        Hashtable updates = new Hashtable();
        q.AddWhere("orderID", orderID);
        q.AddWhere("productID", productID);
        q.AddWhere("attributes", selectedAttributes);
        updates.Add("quantity", newQuantity);
        updates.Add("modifiedOn", DateTime.Now.ToString());
        updates.Add("modifiedBy", Utility.GetUserName());

        //check the rows updated, if it's more than one the item has already been set and we're done
        DBHelper.ExecuteQuery(q.BuildUpdateCommand(updates));

    }
    public static void RemoveItem(int productID, string selectedAttributes)
    {
        Query q = new Query(OrderItem.GetTableSchema());
        int orderID = GetCartOrderID();
        q.AddWhere("orderID", orderID);
        q.AddWhere("productID", productID);
        
        if(selectedAttributes!=string.Empty)
            q.AddWhere("attributes", selectedAttributes);
        
        DBHelper.ExecuteQuery(q.BuildDeleteCommand());
    }    
    public static void RemoveItem(int productID)
    {
        RemoveItem(productID, "");
    }
    static int GetExistingQuantity(int orderID, Product product)
    {
        int iOut = 0;
        Query q = new Query(OrderItem.GetTableSchema());
        q.AddWhere("orderID", orderID);
        q.AddWhere("productID", product.ProductID);
        if (product.SelectedAttributes != null)
            q.AddWhere("attributes", product.SelectedAttributes.ToString());
        q.SelectList = "quantity";

        object result = DBHelper.ExecuteScalar(q.BuildSelectCommand());
        if (result != null)
        {
            int.TryParse(result.ToString(), out iOut);
        }
        return iOut;

    }

    public static int GetCartOrderID(string userName)
    {
        int iOut = 0;
        //get the current order for the user. if there isn't one, make one
        Query q = new Query(Order.GetTableSchema());

        q.AddWhere("userName", userName);
        q.AddWhere("orderStatusID", OrderStatus.NoProcesada);
        q.SelectList = "orderID";

        object oResult = DBHelper.ExecuteScalar(q.BuildSelectCommand());
        if (oResult != null)
        {
            iOut = (int)oResult;
        }
        return iOut;

    }
    public static int GetCartOrderID()
    {
        return GetCartOrderID(Utility.GetUserName());

    }
    public static string GetCartOrderGuid()
    {
        string sOut = "";
        //get the current order for the user. if there isn't one, make one
        Query q = new Query(Order.GetTableSchema());

        q.AddWhere("userName", Utility.GetUserName());
        q.AddWhere("orderStatusID", OrderStatus.NoProcesada);
        q.SelectList = "orderGUIID";

        object oResult = DBHelper.ExecuteScalar(q.BuildSelectCommand());
        if (oResult != null)
        {
            sOut = oResult.ToString();
        }
        return sOut;

    }

    public static string GetOrderStatusDescription(OrderStatus orderStatus)
    {
        string description = null;
        Query qry = new Query("CSK_Store_OrderStatus");
        qry.AddWhere("OrderStatusID", (int)orderStatus);
        DbCommand cmd = qry.BuildSelectCommand();
        IDataReader rdr = DBHelper.GetReader(cmd);
        if (rdr.Read())
            description = rdr.GetString(rdr.GetOrdinal("OrderStatus"));
        rdr.Close();
        return description;
    }

    static int ProvisionOrder(string userName)
    {
        int orderID = GetCartOrderID();

        if (orderID == 0)
        {
            //create an order
            Order newOrder = new Order();
            newOrder.OrderGUID = System.Guid.NewGuid().ToString();
            newOrder.OrderStatus = OrderStatus.NoProcesada;
            newOrder.SubTotalAmount = 0;
            newOrder.UserIP = HttpContext.Current.Request.UserHostAddress;
            newOrder.UserName = userName;
            newOrder.OrderNumber = "XX" + Utility.GetRandomString();
            newOrder.Save(userName);
            orderID = newOrder.OrderID;
        }

        return orderID;
    }
    static void SaveOrderItem(Product product, int orderID, string userName)
    {
        decimal adjustedPrice = product.OurPrice;

        if (product.DiscountAmount != 0)
        {
            adjustedPrice = product.OurPrice - product.DiscountAmount;
        }
        OrderItem item = new OrderItem();
        item.OrderID = orderID;
        item.ProductID = product.ProductID;
        item.PromoCode = product.PromoCode;
        item.PricePaid = adjustedPrice;
        item.OriginalPrice = product.RetailPrice;
        item.ProductName = product.ProductName;
        item.ImageFile = product.ImageFile;
        item.ShippingEstimate = product.ShippingEstimate;

        //save them as a list - no need for the XML structure here.
        //especially since the structure of the Attributes might change
        //making this hard to inflate properly
        if(product.SelectedAttributes!=null)
            item.Attributes = product.SelectedAttributes.ToString();
        
        item.Weight = product.Weight;
        item.Quantity = product.Quantity;
        item.Width = product.Width;
        item.Height = product.Height;
        item.Length = product.Length;
        item.DateAdded = DateTime.Now;
        item.ImageFile = product.ImageFile;
        item.Rating = product.Rating;
        item.Save(userName);
    }

    #endregion

}
