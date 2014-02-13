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
    [Serializable]
    public class OrderItemCollection : ActiveList<OrderItem>
    {
        public OrderItem FindItem(OrderItem item)
        {
            OrderItem itemOut = null;
            foreach (OrderItem child in this)
            {
                if (child.ProductID == item.ProductID)
                {
                    itemOut = child;
                    break;
                }
            }
            return itemOut;
        }

        public new bool Contains(OrderItem item)
        {
            bool bOut=false;
            foreach (OrderItem child in this)
            {
                if (child.ProductID == item.ProductID)
                {
                    bOut = true;
                    break;
                }
            }
            return bOut;
        }
    }
    /// <summary>
    /// A Persistable class that uses Generics to store it's state
    /// in the database. This class maps to the CSK_Store_OrderItem table.
    /// </summary>
    [Serializable]
    public class OrderItem : ActiveRecord<OrderItem>
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
                Table = Query.BuildTableSchema("CSK_Store_OrderItem");

            }

            //set the default values
            this.SetColumnValue("orderItemID", 0);
            this.SetColumnValue("orderID", 0);
            this.SetColumnValue("productID", 0);
            this.SetColumnValue("sku", string.Empty);
            this.SetColumnValue("productName", string.Empty);
            this.SetColumnValue("imageFile", string.Empty);
            this.SetColumnValue("productDescription", string.Empty);
            this.SetColumnValue("weight", 0);
            this.SetColumnValue("dimensions", string.Empty);
            this.SetColumnValue("quantity", 0);
            this.SetColumnValue("originalPrice", 0);
            this.SetColumnValue("pricePaid", 0);
            this.SetColumnValue("attributes", string.Empty);
            this.SetColumnValue("downloadURL", string.Empty);
            this.SetColumnValue("isShipped", false);
            this.SetColumnValue("shipDate", new DateTime(1900, 01, 01));
            this.SetColumnValue("shipmentReference", string.Empty);
            this.SetColumnValue("shippingEstimate", string.Empty);

            //state properties - these are set automagically 
            //during save
            this.SetColumnValue("createdOn", DateTime.Now);
            this.SetColumnValue("createdBy", string.Empty);
            this.SetColumnValue("modifiedOn", DateTime.Now);
            this.SetColumnValue("modifiedBy", string.Empty);

        }
        /*
        private string esCantidadFija = "false";
        private string mensajeCantidadFija = "";
        */

        public Boolean EsCantidadFija
        {
            get { return (Boolean)this.GetColumnValue("esCantidadFija"); }
            set { this.SetColumnValue("esCantidadFija", value); }
        }

        public string MensajeCantidadFija
        {
            get { return (string)this.GetColumnValue("mensajeCantidadFija"); }
            set { this.SetColumnValue("mensajeCantidadFija", value); }
        }

        /*
        public string EsCantidadFija
        {
            get { return esCantidadFija;}
            set { esCantidadFija = value;}
        }

        public string MensajeCantidadFija
        {
            get { return mensajeCantidadFija; }
            set { mensajeCantidadFija = value; }
        }*/

        //MensajeCantidadFija

        public static TableSchema.Table GetTableSchema()
        {   
            //instance an object to make sure
            //the table schema has been created
            OrderItem item = new OrderItem();
            return OrderItem.Table;
        }

        public OrderItem()
            : base()
        {
            SetSQLProps();
        }
        public OrderItem(int orderItemID)
        {
            SetSQLProps();
            base.LoadByKey(orderItemID);

        }

        #endregion

        #region Custom - not in DB
        int currencyDecimals = System.Globalization.CultureInfo.CurrentCulture.NumberFormat.CurrencyDecimalDigits;
        /*
        private Attributes selectedAttributes;
        string attributeXML;
        public Attributes SelectedAttributes
        {
            get
            {
                selectedAttributes = (Attributes)Utility.XmlToObject(typeof(Attributes), this.GetColumnValue("attributes").ToString());
                return selectedAttributes;
            }
            set
            {
                selectedAttributes = value;
                this.SetColumnValue("attributes",Utility.ObjectToXML(typeof(Attributes), selectedAttributes));
            }
        }
        
        */
        public decimal LineTotal
        {
            get
            {
                decimal dOut = Convert.ToDecimal(this.Quantity) * this.PricePaid;
                return Math.Round(dOut, currencyDecimals);
            }
        }

        //additional properties for use as a cart
        private decimal height = 0;

        public decimal Height
        {
            get { return height; }
            set { height = value; }
        }
        private decimal length = 0;

        public decimal Length
        {
            get { return length; }
            set { length = value; }
        }
        private decimal width = 0;

        public decimal Width
        {
            get { return width; }
            set { width = value; }
        }



        private decimal _discountAmount;

        public decimal DiscountAmount
        {
            get
            {
                return _discountAmount;
            }
            set
            {
                _discountAmount = value;
            }
        }
        private string _promoCode;

        public string PromoCode
        {
            get
            {
                return _promoCode;
            }
            set
            {
                _promoCode = value;
            }
        }

        private DateTime _dateAdded;

        public DateTime DateAdded
        {
            get
            {
                return _dateAdded;
            }
            set
            {
                _dateAdded = value;
            }
        }
        #endregion


        #region Public Props

        [XmlAttribute("rating")]
        public double Rating
        {
            get
            {
                return (double)this.GetColumnValue("rating");
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("rating", value);

            }
        }
        [XmlAttribute("ShippingEstimate")]
        public string ShippingEstimate
        {
            get
            {
                return this.GetColumnValue("ShippingEstimate").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("ShippingEstimate", value);

            }
        }
        [XmlAttribute("ImageFile")]
        public string ImageFile
        {
            get
            {
                return this.GetColumnValue("imageFile").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("imageFile", value);

            }        
        }
	
        [XmlAttribute("OrderItemID")]
        public int OrderItemID
        {
            get
            {
                return int.Parse(this.GetColumnValue("orderItemID").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("orderItemID", value);

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
        [XmlAttribute("ProductID")]
        public int ProductID
        {
            get
            {
                return int.Parse(this.GetColumnValue("productID").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("productID", value);

            }
        }
        [XmlAttribute("Sku")]
        public string Sku
        {
            get
            {
                return this.GetColumnValue("sku").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("sku", value);

            }
        }
        [XmlAttribute("ProductName")]
        public string ProductName
        {
            get
            {
                return this.GetColumnValue("productName").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("productName", value);

            }
        }
        [XmlAttribute("ProductDescription")]
        public string ProductDescription
        {
            get
            {
                return this.GetColumnValue("productDescription").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("productDescription", value);

            }
        }
        [XmlAttribute("Weight")]
        public decimal Weight
        {
            get
            {
                return decimal.Parse(this.GetColumnValue("weight").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("weight", value);

            }
        }
        [XmlAttribute("Dimensions")]
        public string Dimensions
        {
            get
            {
                return this.GetColumnValue("dimensions").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("dimensions", value);

            }
        }
        [XmlAttribute("Quantity")]
        public int Quantity
        {
            get
            {
                return int.Parse(this.GetColumnValue("quantity").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("quantity", value);

            }
        }
        [XmlAttribute("OriginalPrice")]
        public decimal OriginalPrice
        {
            get
            {
                return decimal.Parse(this.GetColumnValue("originalPrice").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("originalPrice", value);

            }
        }
        [XmlAttribute("PricePaid")]
        public decimal PricePaid
        {
            get
            {
                return decimal.Parse(this.GetColumnValue("pricePaid").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("pricePaid", value);

            }
        }
        [XmlAttribute("Attributes")]
        public string Attributes
        {
            get
            {
                return this.GetColumnValue("attributes").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("attributes", value);

            }
        }
        [XmlAttribute("DownloadURL")]
        public string DownloadURL
        {
            get
            {
                return this.GetColumnValue("downloadURL").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("downloadURL", value);

            }
        }
        [XmlAttribute("IsShipped")]
        public bool IsShipped
        {
            get
            {
                return bool.Parse(this.GetColumnValue("isShipped").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("isShipped", value);

            }
        }
        [XmlAttribute("ShipDate")]
        public DateTime ShipDate
        {
            get
            {
                return DateTime.Parse(this.GetColumnValue("shipDate").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("shipDate", value);

            }
        }
        [XmlAttribute("ShipmentReference")]
        public string ShipmentReference
        {
            get
            {
                return this.GetColumnValue("shipmentReference").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("shipmentReference", value);

            }
        }

        #endregion

    }
}
