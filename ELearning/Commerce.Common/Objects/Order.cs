using System;
using System.Text;
using System.Data;
using System.Data.Common;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Xml;
using System.Xml.Serialization;
using Microsoft.Practices.EnterpriseLibrary.Data;
using WekeRoad.Tools;

namespace Commerce.Common
{
    public class OrderCollection : ActiveList<Order>
    {

    }
    /// <summary>
    /// A Persistable class that uses Generics to store it's state
    /// in the database. This class maps to the CSK_Store_Order table.
    /// </summary>
    [Serializable]
    public class Order : ActiveRecord<Order>
    {

        #region .ctors
        /// <summary>
        /// Sets the static Table property from our Base class. This property tells
        /// the base class how to create the CRUD queries, etc.
        /// </summary>
        void SetSQLProps()
        {

            if (Table == null)
            {
                Table = Query.BuildTableSchema("CSK_Store_Order");

            }

            //set the default values
            this.SetColumnValue("orderID", 0);
            this.SetColumnValue("orderGuid", string.Empty);
            this.SetColumnValue("orderNumber", string.Empty);
            this.SetColumnValue("orderDate", new DateTime(1900, 01, 01));
            this.SetColumnValue("orderStatusID", 9999);
            this.SetColumnValue("userName", string.Empty);
            this.SetColumnValue("email", string.Empty);
            this.SetColumnValue("firstName", string.Empty);
            this.SetColumnValue("lastName", string.Empty);
            this.SetColumnValue("shippingMethod", string.Empty);
            this.SetColumnValue("subTotalAmount", 0);
            this.SetColumnValue("shippingAmount", 0);
            this.SetColumnValue("handlingAmount", 0);
            this.SetColumnValue("taxAmount", 0);
            this.SetColumnValue("taxRate", 0);
            this.SetColumnValue("couponCodes", string.Empty);
            this.SetColumnValue("discountAmount", 0);
            this.SetColumnValue("specialInstructions", string.Empty);
            this.SetColumnValue("shipToAddress", string.Empty);
            this.SetColumnValue("billToAddress", string.Empty);
            this.SetColumnValue("userIP", string.Empty);
            this.SetColumnValue("shippingTrackingNumber", string.Empty);
            this.SetColumnValue("numberOfPackages", 0);
            this.SetColumnValue("packagingNotes", string.Empty);
            this.SetColumnValue("PaymentMethodID", 1);
            this.SetColumnValue("BankDepositNumber", string.Empty);
            
            //state properties - these are set automagically 
            //during save
            this.SetColumnValue("createdOn", DateTime.Now);
            this.SetColumnValue("createdBy", string.Empty);
            this.SetColumnValue("modifiedOn", DateTime.Now);
            this.SetColumnValue("modifiedBy", string.Empty);

        }

        public static TableSchema.Table GetTableSchema()
        {
            //instance an object to make sure
            //the table schema has been created
            Order item = new Order();
            return Order.Table;
        }

        public Order()
        {
            SetSQLProps();
            
        }
        public Order(string orderID)
        {
            SetSQLProps();
            //override the default implementation since orderID is a GUID
            Query q = new Query(Table);
            q.AddWhere("orderID", orderID);
            IDataReader rdr = DBHelper.GetReader(q.BuildSelectCommand());
            Load(rdr);
        }

        #endregion

        #region Custom - not in DB

        private OrderItem _lastAdded;

        public OrderItem LastAdded
        {
            get { return _lastAdded; }
            set { _lastAdded = value; }
        }

        int currencyDecimals = System.Globalization.CultureInfo.CurrentCulture.NumberFormat.CurrencyDecimalDigits;


        /// <summary>
        /// This is a calculated field that's also stored in the DB for
        /// Reporting purposes.
        /// </summary>
        public decimal CalculateSubTotal()
        {

            decimal dOut = 0;
            if (this.Items != null)
            {

                foreach (OrderItem item in this.Items)
                {
                    dOut += item.LineTotal;
                }

                dOut = Math.Round(dOut, currencyDecimals);
            }
            else
            {
                dOut = 0;
            }
            //using this for the save method
            return dOut;


        }
        /// <summary>
        /// Delete's a pending order from the system. This will not work
        /// for orders that have already been paid/cancelled/refunded
        /// </summary>
        public void DeletePermanent()
        {
            if (this.OrderStatus == OrderStatus.NoProcesada)
            {
                //in order - notes, transactions, items, order
                //notes
                Query q = new Query(OrderNote.GetTableSchema());
                q.AddWhere("orderID", OrderID);
                DbCommand deleteNote = q.BuildDeleteCommand();

                //transactions
                q = new Query(Transaction.GetTableSchema());
                q.AddWhere("orderID", OrderID);
                DbCommand deleteTrans = q.BuildDeleteCommand();
                
                //items
                q = new Query(OrderItem.GetTableSchema());
                q.AddWhere("orderID", OrderID);
                DbCommand deleteItems = q.BuildDeleteCommand();

                q = new Query(Table);
                q.AddWhere("orderID", OrderID);
                DbCommand deleteOrder = q.BuildDeleteCommand();

                Database db = DatabaseFactory.CreateDatabase();
                using (DbConnection connection = db.CreateConnection())
                {
                    connection.Open();
                    DbTransaction transaction = connection.BeginTransaction();
                    try
                    {
                        //Execute the order update
                        db.ExecuteNonQuery(deleteNote, transaction);
                        db.ExecuteNonQuery(deleteTrans, transaction);
                        db.ExecuteNonQuery(deleteItems, transaction);
                        db.ExecuteNonQuery(deleteOrder, transaction);
                        transaction.Commit();
                    }
                    catch(Exception x)
                    {
                        transaction.Rollback();
                        throw;
                    }
                }
            }
        }
        public void SaveItems(){

            //queue up a SQL batch of the existing items
            //and save them all at once
            
            //first, delete out all the existing items
            Query q = new Query(OrderItem.GetTableSchema());
            q.AddWhere("orderID", this.OrderID);
            DbCommand delCommand = q.BuildDeleteCommand();
            
            Database db=DatabaseFactory.CreateDatabase();
            using (DbConnection connection = db.CreateConnection())
            {
                connection.Open();
                DbTransaction transaction = connection.BeginTransaction();
                try
                {
                    //Execute the order update
                    db.ExecuteNonQuery(delCommand, transaction);

                    //loop the items and execute their inserts
                    DbCommand insertItemCommand = null;
                    foreach (OrderItem item in this.Items)
                    {
                        insertItemCommand = item.GetInsertCommand(Utility.GetUserName());
                        db.ExecuteNonQuery(insertItemCommand, transaction);

                    }

                    transaction.Commit();
                }
                catch
                {
                    transaction.Rollback();
                }

                connection.Close();
                transaction.Dispose();
            }


        }
        public decimal GetItemsWeight()
        {
            decimal dOut = 0;
            decimal dQty = 0;
            decimal dWeight = 0;

            foreach (OrderItem item in this.Items)
            {
                dQty = Convert.ToDecimal(item.Quantity);
                dWeight = item.Weight;
                dOut += dQty * dWeight;
            }
            return dOut;
        }
        public decimal GetTotalWidth()
        {
            decimal dOut = 0;
            decimal dQty = 0;
            decimal dWidth = 0;

            foreach (OrderItem item in this.Items)
            {
                dQty = Convert.ToDecimal(item.Quantity);
                dWidth = item.Width;
                dOut += dQty * dWidth;
            }
            return dOut;
        }
        public decimal GetTotalHeight()
        {
            decimal dOut = 0;
            decimal dQty = 0;
            decimal dHeight = 0;

            foreach (OrderItem item in this.Items)
            {
                dQty = Convert.ToDecimal(item.Quantity);
                dHeight = item.Height;
                dOut += dQty * dHeight;
            }
            return dOut;
        }
        public decimal GetMaxLength()
        {
            decimal dOut = 0;
            decimal dQty = 0;
            decimal dLength = 0;

            foreach (OrderItem item in this.Items)
            {
                dQty = Convert.ToDecimal(item.Quantity);
                dLength = item.Length;
                dOut += dQty * dLength;
            }
            return dOut;
        }

        public decimal OrderTotal
        {
            get
            {
                decimal dSub = this.CalculateSubTotal();
                if (dSub == 0)
                    dSub = this.SubTotalAmount;

                return dSub + this.TaxAmount + this.ShippingAmount;
            }
        }

        #region "Credit Card Information"
        [NonSerialized(), System.Xml.Serialization.XmlIgnore()]
        private string _CreditCardNumber;
        [NonSerialized(), System.Xml.Serialization.XmlIgnore()]
        private int _CrediCartExpYear;
        [NonSerialized(), System.Xml.Serialization.XmlIgnore()]
        private int _CreditCardExpireMonth;
        [NonSerialized(), System.Xml.Serialization.XmlIgnore()]
        private string _CreditCardSecurityNumber;
        [NonSerialized(), System.Xml.Serialization.XmlIgnore()]
        private CreditCardType _CreditCardType;

        //[NonSerialized()]
        [System.Xml.Serialization.XmlIgnore()]
        public string CreditCardNumber
        {
            get
            {
                return _CreditCardNumber;
            }
            set
            {
                _CreditCardNumber = value;
            }
        }

        //[NonSerialized()]
        [System.Xml.Serialization.XmlIgnore()]
        public int CreditCardExpireYear
        {
            get
            {
                return _CrediCartExpYear;
            }
            set
            {
                _CrediCartExpYear = value;
            }
        }

        //[NonSerialized()]
        [System.Xml.Serialization.XmlIgnore()]
        public int CreditCardExpireMonth
        {
            get
            {
                return _CreditCardExpireMonth;
            }
            set
            {
                _CreditCardExpireMonth = value;
            }
        }

        //[NonSerialized()]
        [System.Xml.Serialization.XmlIgnore()]
        public string CreditCardSecurityNumber
        {
            get
            {
                return _CreditCardSecurityNumber;
            }
            set
            {
                _CreditCardSecurityNumber = value;
            }
        }


        //[NonSerialized()]
        [System.Xml.Serialization.XmlIgnore()]
        public CreditCardType CreditCardType
        {
            get
            {
                return _CreditCardType;
            }
            set
            {
                _CreditCardType = value;
            }
        }


        #endregion


        public string PONumber
        {
            get
            {
                return _PONumber;
            }
            set
            {
                _PONumber = value;
            }
        }

        //Not currently implemented. Stubbed 
        //for future use.
        public string TaxExemptionCode
        {
            get
            {
                return _TaxExemptionCode;
            }
            set
            {
                _TaxExemptionCode = value;
            }
        }

        public OrderItemCollection Items;
        public Address ShippingAddress;
        public Address BillingAddress;
        public TransactionCollection Transactions;
        public OrderNoteCollection Notes;


        private string _PONumber;
        private string _TaxExemptionCode;
        #endregion

        #region ToString() Override
        public override string ToString()
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();

            //override the base class to output a nice text rendering
            sb.Append("*********" + Properties.Resources.OrderUppercase + this.OrderNumber + " ************************");
            sb.Append(Properties.Resources.BillTo + ":\r\n" + this.BillToAddress + "\r\n\r\n");
            sb.Append(Properties.Resources.ShipTo + ":\r\n" + this.ShipToAddress + "\r\n\r\n");

            if (this.Transactions.Count > 0)
            {
                sb.Append(Properties.Resources.PaymentMethod + ": " + this.Transactions[0].TransactionType.ToString() + "\r\n\r\n");
            }
            sb.Append(ItemsToString(false) + "\r\n\r\n");
            sb.Append(Properties.Resources.MoreInfo + ": " + Utility.GetSiteRoot() + "/admin/admin_orders_details.aspx?id=" + this.OrderID);
            return sb.ToString();
        }
        public string ToHtml()
        {
            System.Text.StringBuilder sb = new StringBuilder();
            sb.Append("<table width=600 cellpadding=0 cellspacing=0 >");
            sb.Append("<tr><td colspan=2 style='height:20;background-color:whitesmoke;border:1px solid #cccccc;font-size:14px;padding:10px'><b>" + Properties.Resources.OrderNumber + "&nbsp;" + this.OrderNumber + "</b></td></tr>");
            sb.Append("<tr><td colspan=2 style='padding:10px'><font color=#990000><b>Status:</b> " + Utility.ParseCamelToProper(Enum.GetName(typeof(OrderStatus), this.OrderStatus)) + "</font><br>");
            sb.Append("<b>"+ Properties.Resources.Date +"</b> " + this.OrderDate.ToShortDateString() + "<br><br></td></tr>");
            if (this.Transactions.Count > 0)
            {
                sb.Append("<tr><td colspan=2><font size=2>&nbsp;&nbsp;<b>"+ Properties.Resources.PaymentInformation +"</b></font></td></tr>");
                sb.Append("<tr><td colspan=2 style='border-top:1px solid #cccccc'>&nbsp;</td></tr>");
                sb.Append("<tr><td colspan=2 style='padding:10px'><b>" + Properties.Resources.TransactionNumber + ":</b> " + this.Transactions[0].AuthorizationCode + "<br>");
                sb.Append("<b>" + Properties.Resources.PaymentMethod + ":</b> " + this.Transactions[0].TransactionType.ToString() + "<br><br><br><br></td></tr>");
            }
            sb.Append("<tr><td colspan=2>&nbsp;&nbsp;<font size=2><b>" + Properties.Resources.ShippingAndBilling + "</b></font></td></tr>");
            sb.Append("<tr><td colspan=2 style='border-top:1px solid #cccccc'>&nbsp;</td></tr>");

            if (IsDigitalOrder())
                sb.Append("<tr><td width=50% style='padding:10px' valign=top><b>" + Properties.Resources.BillTo + ":</b><br>" + this.BillToAddress + "</td><td style='padding:10px' valign=top>&nbsp;</td></tr>");
            else
                sb.Append("<tr><td width=50% style='padding:10px' valign=top><b>" + Properties.Resources.BillTo + ":</b><br>" + this.BillToAddress + "</td><td style='padding:10px' valign=top><b>" + Properties.Resources.ShipTo + ":</b><br>" + this.ShipToAddress.ToString() + "<br><br><br><br></td></tr>");
            
            sb.Append("<tr><td colspan=2>&nbsp;&nbsp;<font size=2><b>" + Properties.Resources.OrderItems + "</b></font></td></tr>");
            sb.Append("<tr><td colspan=2 style='border-top:1px solid #cccccc'>&nbsp;</td></tr>");
            sb.Append("<tr><td colspan=2 style='padding:10px'>" + this.ItemsToString(true) + "</td></tr>");
            sb.Append("</table>");

            return sb.ToString();


        }
        public string ItemsToString(bool UseHtml)
        {

            string sOut = "";
            if (UseHtml)
            {
                sOut = "";
                StringBuilder sb = new StringBuilder();

                sb.Append("<table width=100% cellpadding=4 cellspacing=0>");
                sb.Append("<tr style='border:1px solid #cccccc; background-color:whitesmoke'><td align=center><b>Item</b></td><td><b>" + Properties.Resources.Quantity + "</b></td><td><b>" + Properties.Resources.Price + "</b></td><td><b>Total<b></td></tr>");

                string appendFormat = "<tr bgcolor=#ffffff><Td>{0}</td><td>{1}</td><td align=right>{2}</td><td align=right>{3}</td></tr>";
                string appendAltFormat = "<tr bgcolor=#f5f5f5><Td>{0}</td><td>{1}</td><td align=right>{2}</td><Td align=right>{3}</td></tr>";
                string formatToUse = appendFormat;

                bool isEven = true;

                foreach (OrderItem item in this.Items)
                {

                    if (isEven)
                    {
                        formatToUse = appendFormat;
                    }
                    else
                    {
                        formatToUse = appendAltFormat;
                    }
                    string attSelections = "";
                    if (item.Attributes != string.Empty)
                    {
                        attSelections = "<br>" + item.Attributes;
                    }

                    sb.AppendFormat(formatToUse, item.ProductName+" "+attSelections,
                        item.Quantity.ToString(), item.PricePaid.ToString("C"),
                        item.LineTotal.ToString("C"));
                    isEven = !isEven;


                }

                //append the totals
                sb.Append("<tr><td colspan=3 align=right><b>Subtotal:</td><td align=right>" + this.CalculateSubTotal().ToString("c") + "</td></tr>");
                sb.Append("<tr><td colspan=3 align=right><b>" + Properties.Resources.Tax +  ":</td><td align=right>" + this.TaxAmount.ToString("c") + "</td></tr>");
                if (!this.IsDigitalOrder())
                    sb.Append("<tr><td colspan=3 align=right><b>" + Properties.Resources.Shipping + ":</td><td align=right>" + this.ShippingAmount.ToString("c") + "</td></tr>");
                sb.Append("<tr><td colspan=3 align=right><b><font color:#990000>Total:</font></td><td align=right><font color:#990000>" + this.OrderTotal.ToString("c") + "</font></td></tr>");

                sb.Append("</table>");
                sOut = sb.ToString();
            }
            else
            {
                sOut = GetASCII();
            }
            return sOut;
        }

        /// <summary>
        /// Helper for the output of the string
        /// </summary>
        /// <returns></returns>
        string GetASCII()
        {
            StringBuilder sb = new StringBuilder();
            decimal runningTotal = 0;
            foreach (OrderItem item in this.Items)
            {
                runningTotal += item.LineTotal;
                sb.AppendLine("Item        :" + item.ProductName);
                sb.AppendLine( Properties.Resources.Quantity + "    :" + item.Quantity.ToString());
                sb.AppendLine(Properties.Resources.PricePaid + "  :" + item.PricePaid.ToString("C"));
                sb.AppendLine("");
                sb.AppendLine("");
            }
            sb.AppendLine("");
            sb.AppendLine("========================================");
            sb.AppendLine(Properties.Resources.GrandTotal + ": " + runningTotal.ToString("C"));
            return sb.ToString();
        }
        #endregion

        public bool IsDigitalOrder()
        {
            bool isDigital = true;
            Product product = null;

            foreach (OrderItem item in this.Items)
            {
                product = new Product(item.ProductID);
                if (!product.IsDigitalProduct)
                {
                    isDigital = false;
                    break;
                }
            }
            return isDigital;
        }

        public int NonDigitalItemCount
        {
            get {
                int count = 0;
                Product product = null;
                foreach (OrderItem item in this.Items)
                {
                    product = new Product(item.ProductID);
                    if (!product.IsDigitalProduct)
                        count+=item.Quantity;
                }
                return count;
            }
        }
	

        #region Public Props
        [XmlAttribute("OrderNumber")]
        public string OrderNumber
        {
            get
            {
                return this.GetColumnValue("orderNumber").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("orderNumber", value);

            }
        }
        [XmlAttribute("OrderGUID")]
        public string OrderGUID
        {
            get
            {
                return this.GetColumnValue("OrderGUID").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("OrderGUID", value);

            }
        }
        [XmlAttribute("OrderID")]
        public int OrderID
        {
            get
            {
                return int.Parse(this.GetColumnValue("orderID").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("orderID", value);

            }
        }
        [XmlAttribute("OrderDate")]
        public DateTime OrderDate
        {
            get
            {
                return DateTime.Parse(this.GetColumnValue("orderDate").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("orderDate", value);

            }
        }
        [XmlAttribute("OrderStatusID")]
        public int OrderStatusID
        {
            get
            {
                int iOut = 0;
                int.TryParse(this.GetColumnValue("orderStatusID").ToString(), out iOut);
                return iOut;
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("orderStatusID", value);

            }
        }
        //enum
        public OrderStatus OrderStatus
        {
            get
            {
                return (OrderStatus)this.GetColumnValue("orderStatusID");
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("orderStatusID", value);
            }
        }
        [XmlAttribute("UserName")]
        public string UserName
        {
            get
            {
                return this.GetColumnValue("userName").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("userName", value);

            }
        }
        [XmlAttribute("Email")]
        public string Email
        {
            get
            {
                return this.GetColumnValue("email").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("email", value);

            }
        }
        [XmlAttribute("FirstName")]
        public string FirstName
        {
            get
            {
                return this.GetColumnValue("firstName").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("firstName", value);

            }
        }
        [XmlAttribute("LastName")]
        public string LastName
        {
            get
            {
                return this.GetColumnValue("lastName").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("lastName", value);

            }
        }
        [XmlAttribute("ShippingMethod")]
        public string ShippingMethod
        {
            get
            {
                return this.GetColumnValue("shippingMethod").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("shippingMethod", value);

            }
        }
        [XmlAttribute("SubTotalAmount")]
        public decimal SubTotalAmount
        {
            get
            {
                return decimal.Parse(this.GetColumnValue("subTotalAmount").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("subTotalAmount", value);

            }
        }
        [XmlAttribute("ShippingAmount")]
        public decimal ShippingAmount
        {
            get
            {
                return decimal.Parse(this.GetColumnValue("shippingAmount").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("shippingAmount", value);

            }
        }
        [XmlAttribute("HandlingAmount")]
        public decimal HandlingAmount
        {
            get
            {
                return decimal.Parse(this.GetColumnValue("handlingAmount").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("handlingAmount", value);

            }
        }
        [XmlAttribute("TaxAmount")]
        public decimal TaxAmount
        {
            get
            {
                return decimal.Parse(this.GetColumnValue("taxAmount").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("taxAmount", value);

            }
        }
        [XmlAttribute("TaxRate")]
        public decimal TaxRate
        {
            get
            {
                return decimal.Parse(this.GetColumnValue("taxRate").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("taxRate", value);

            }
        }
        [XmlAttribute("CouponCodes")]
        public string CouponCodes
        {
            get
            {
                return this.GetColumnValue("couponCodes").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("couponCodes", value);

            }
        }
        [XmlAttribute("DiscountAmount")]
        public decimal DiscountAmount
        {
            get
            {
                return decimal.Parse(this.GetColumnValue("discountAmount").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("discountAmount", value);

            }
        }
        [XmlAttribute("SpecialInstructions")]
        public string SpecialInstructions
        {
            get
            {
                return this.GetColumnValue("specialInstructions").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("specialInstructions", value);

            }
        }
        [XmlAttribute("ShipToAddress")]
        public string ShipToAddress
        {
            get
            {
                return this.GetColumnValue("shipToAddress").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("shipToAddress", value);

            }
        }
        [XmlAttribute("BillToAddress")]
        public string BillToAddress
        {
            get
            {
                return this.GetColumnValue("billToAddress").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("billToAddress", value);

            }
        }
        [XmlAttribute("UserIP")]
        public string UserIP
        {
            get
            {
                return this.GetColumnValue("userIP").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("userIP", value);

            }
        }
        [XmlAttribute("ShippingTrackingNumber")]
        public string ShippingTrackingNumber
        {
            get
            {
                return this.GetColumnValue("shippingTrackingNumber").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("shippingTrackingNumber", value);

            }
        }
        [XmlAttribute("NumberOfPackages")]
        public int NumberOfPackages
        {
            get
            {
                return int.Parse(this.GetColumnValue("numberOfPackages").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("numberOfPackages", value);

            }
        }
        [XmlAttribute("PackagingNotes")]
        public string PackagingNotes
        {
            get
            {
                return this.GetColumnValue("packagingNotes").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("packagingNotes", value);

            }
        }

        [XmlAttribute("PaymentMethodID")]
        public PaymentMethod PaymentMethodId
        {
            get { return (PaymentMethod)this.GetColumnValue("PaymentMethodID"); }
            set 
            {
                this.MarkDirty();
                this.SetColumnValue("PaymentMethodID", value);
            }
        }
        [XmlAttribute("BankDepositNumber")]
        public string BankDepositNumber
        {
            get { return this.GetColumnValue("BankDepositNumber").ToString(); }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("BankDepositNumber", value);
            }
        }
	

        #endregion

    }
}
