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
    public class ProductCollection : ActiveList<Product>
    {

    }

    /// <summary>
    /// A Persistable class that uses Generics to store it's state
    /// in the database. This class maps to the CSK_Store_Product table.
    /// </summary>
    [Serializable]
    public class Product : ActiveRecord<Product>
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
                Table = Query.BuildTableSchema("CSK_Store_Product");

            }

            //set the default values
            this.SetColumnValue("productID", 0);
            this.SetColumnValue("sku", string.Empty);
            this.SetColumnValue("productName", string.Empty);
            this.SetColumnValue("shortDescription", string.Empty);
            this.SetColumnValue("manufacturerID", 0);
            this.SetColumnValue("attributeXML", string.Empty);
            this.SetColumnValue("statusID", 0);
            this.SetColumnValue("productTypeID", 0);
            this.SetColumnValue("shippingTypeID", 0);
            this.SetColumnValue("shipEstimateID", 0);
            this.SetColumnValue("taxTypeID", 0);
            this.SetColumnValue("stockLocation", string.Empty);
            this.SetColumnValue("ourPrice", 0);
            this.SetColumnValue("retailPrice", 0);
            this.SetColumnValue("weight", 0);
            this.SetColumnValue("currencyCode", string.Empty);
            this.SetColumnValue("unitOfMeasure", string.Empty);
            this.SetColumnValue("adminComments", string.Empty);
            this.SetColumnValue("length", 0);
            this.SetColumnValue("height", 0);
            this.SetColumnValue("width", 0);
            this.SetColumnValue("dimensionUnit", string.Empty);
            this.SetColumnValue("isDeleted", false);
            this.SetColumnValue("listOrder", 0);
            this.SetColumnValue("ratingSum", 4);
            this.SetColumnValue("totalRatingVotes", 1);
            this.SetColumnValue("defaultImage", string.Empty);

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
            Product item = new Product();
            return Product.Table;
        }

        public Product()
            : base()
        {
            SetSQLProps();
        }
        public Product(int productID)
        {
            SetSQLProps();
            base.LoadByKey(productID);

        }

        #endregion
        

        #region Custom Constructors
        public Product(string sku)
        {

            SetSQLProps();
            LoadByParam("sku", sku);

        }

        #endregion

        #region Custom


        //holds the XML and is responsible for putting/pulling from DB
        //XML attribute listing
        private Attributes attributes;
        public Attributes Attributes
        {
            get
            {
                attributes = (Attributes)Utility.XmlToObject(typeof(Attributes), this.AttributeXML);
                return attributes;
            }
            set
            {
                attributes = value;
                this.SetColumnValue("attributeXML",Utility.ObjectToXML(typeof(Attributes), attributes));
            }
        }
        private Attributes selectedAttributes;
        public Attributes SelectedAttributes
        {
            get
            {
                return selectedAttributes;
            }
            set
            {
                selectedAttributes = value;
            }
        }

        //images
        private ImageCollection images;

        public ImageCollection Images
        {
            get { return images; }
            set { images = value; }
        }

        //reviews
        private ProductReviewCollection reviews;

        public ProductReviewCollection Reviews
        {
            get { return reviews; }
            set { reviews = value; }
        }

        //descriptors
        private ProductDescriptorCollection descriptors;

        public ProductDescriptorCollection Descriptors
        {
            get { return descriptors; }
            set { descriptors = value; }
        }



        private double rating;

        public double Rating
        {
            get {

                if (this.TotalRatingVotes > 0)
                {
                    rating = this.RatingSum / TotalRatingVotes;
                }
                else
                {
                    rating = 4;
                }
                return rating; 
            
            }

        }

        private string shippingEstimate;

        public string ShippingEstimate
        {
            get { return shippingEstimate; }
            set { shippingEstimate = value; }
        }

        private string imageFile;

        public string ImageFile
        {
            get { return imageFile; }
            set { imageFile = value; }

        }

        private int quantity;

        public int Quantity
        {
            get { return quantity; }
            set { quantity = value; }
        }

        private decimal discountAmount;

        public decimal DiscountAmount
        {
            get { return discountAmount; }
            set { discountAmount = value; }
        }

        private string promoCode;

        public string PromoCode
        {
            get { return promoCode; }
            set { promoCode = value; }
        }
        private decimal _youSavePercent;

        public decimal YouSavePercent
        {
            get
            {
                return _youSavePercent;
            }
            set
            {
                _youSavePercent = value;
            }
        }

        private decimal _youSavePrice;

        public decimal YouSavePrice
        {
            get
            {
                return _youSavePrice;
            }
            set
            {
                _youSavePrice = value;
            }
        }

        #endregion

        #region Public Props

        [XmlAttribute("defaultImage")]
        public string DefaultImage
        {
            get
            {
                return this.GetColumnValue("defaultImage").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("defaultImage", value);

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
        [XmlAttribute("ShortDescription")]
        public string ShortDescription
        {
            get
            {
                return this.GetColumnValue("shortDescription").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("shortDescription", value);

            }
        }
        [XmlAttribute("ManufacturerID")]
        public int ManufacturerID
        {
            get
            {
                return int.Parse(this.GetColumnValue("manufacturerID").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("manufacturerID", value);

            }
        }
        [XmlAttribute("AttributeXML")]
        public string AttributeXML
        {
            get
            {
                return this.GetColumnValue("attributeXML").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("attributeXML", value);

            }
        }
        [XmlAttribute("StatusID")]
        public int StatusID
        {
            get
            {
                return int.Parse(this.GetColumnValue("statusID").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("statusID", value);

            }
        }
        //enum
        public ProductStatus Status
        {
            get
            {
                return (ProductStatus)this.GetColumnValue("statusID");
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("statusID", value);
            }
        }
        [XmlAttribute("ProductTypeID")]
        public int ProductTypeID
        {
            get
            {
                return int.Parse(this.GetColumnValue("productTypeID").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("productTypeID", value);

            }
        }
        //enum
        public ProductType ProductType
        {
            get
            {
                return (ProductType)this.GetColumnValue("productTypeID");
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("productTypeID", value);
            }
        }
        [XmlAttribute("ShippingTypeID")]
        public int ShippingTypeID
        {
            get
            {
                return int.Parse(this.GetColumnValue("shippingTypeID").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("shippingTypeID", value);

            }
        }
        //enum
        public ShippingType ShippingType
        {
            get
            {
                return (ShippingType)this.GetColumnValue("shippingTypeID");
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("shippingTypeID", value);
            }
        }
        [XmlAttribute("ShipEstimateID")]
        public int ShipEstimateID
        {
            get
            {
                return int.Parse(this.GetColumnValue("shipEstimateID").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("shipEstimateID", value);

            }
        }
        [XmlAttribute("TaxTypeID")]
        public int TaxTypeID
        {
            get
            {
                return int.Parse(this.GetColumnValue("taxTypeID").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("taxTypeID", value);

            }
        }

        [XmlAttribute("StockLocation")]
        public string StockLocation
        {
            get
            {
                return this.GetColumnValue("stockLocation").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("stockLocation", value);

            }
        }
        [XmlAttribute("OurPrice")]
        public decimal OurPrice
        {
            get
            {
                return decimal.Parse(this.GetColumnValue("ourPrice").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("ourPrice", value);

            }
        }
        [XmlAttribute("RetailPrice")]
        public decimal RetailPrice
        {
            get
            {
                return decimal.Parse(this.GetColumnValue("retailPrice").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("retailPrice", value);

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
        [XmlAttribute("CurrencyCode")]
        public string CurrencyCode
        {
            get
            {
                return this.GetColumnValue("currencyCode").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("currencyCode", value);

            }
        }
        [XmlAttribute("UnitOfMeasure")]
        public string UnitOfMeasure
        {
            get
            {
                return this.GetColumnValue("unitOfMeasure").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("unitOfMeasure", value);

            }
        }
        [XmlAttribute("AdminComments")]
        public string AdminComments
        {
            get
            {
                return this.GetColumnValue("adminComments").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("adminComments", value);

            }
        }
        [XmlAttribute("Length")]
        public decimal Length
        {
            get
            {
                return decimal.Parse(this.GetColumnValue("length").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("length", value);

            }
        }
        [XmlAttribute("Height")]
        public decimal Height
        {
            get
            {
                return decimal.Parse(this.GetColumnValue("height").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("height", value);

            }
        }
        [XmlAttribute("Width")]
        public decimal Width
        {
            get
            {
                return decimal.Parse(this.GetColumnValue("width").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("width", value);

            }
        }
        [XmlAttribute("DimensionUnit")]
        public string DimensionUnit
        {
            get
            {
                return this.GetColumnValue("dimensionUnit").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("dimensionUnit", value);

            }
        }
        [XmlAttribute("IsDeleted")]
        public bool IsDeleted
        {
            get
            {
                return bool.Parse(this.GetColumnValue("isDeleted").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("isDeleted", value);

            }
        }
        [XmlAttribute("ListOrder")]
        public int ListOrder
        {
            get
            {
                return int.Parse(this.GetColumnValue("listOrder").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("listOrder", value);

            }
        }
        [XmlAttribute("RatingSum")]
        public int RatingSum
        {
            get
            {
                return int.Parse(this.GetColumnValue("ratingSum").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("ratingSum", value);

            }
        }
        [XmlAttribute("TotalRatingVotes")]
        public int TotalRatingVotes
        {
            get
            {
                return int.Parse(this.GetColumnValue("totalRatingVotes").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("totalRatingVotes", value);

            }
        }

        public bool IsDigitalProduct
        {
            get {
                bool isDigital = false;
                if (ProductType == ProductType.DownloadableSoftware & ShippingType == ShippingType.DownloadOnly)
                    isDigital = true;
                return isDigital;
            }
        }
	

        #endregion

        #region ObjectDataSource Support

        public static void Add(string sku, string productName, string shortDescription, int manufacturerID, string attributeXML, int statusID, int productTypeID, int shippingTypeID, int shipEstimateID, int taxTypeID, string stockLocation, decimal ourPrice, decimal retailPrice, decimal weight, string currencyCode, string unitOfMeasure, string adminComments, decimal length, decimal height, decimal width, string dimensionUnit, bool isDeleted, int listOrder, int ratingSum, int totalRatingVotes)
        {
            Product product = new Product();

            product.Sku = sku;
            product.ProductName = productName;
            product.ShortDescription = shortDescription;
            product.ManufacturerID = manufacturerID;
            product.AttributeXML = attributeXML;
            product.StatusID = statusID;
            product.ProductTypeID = productTypeID;
            product.ShippingTypeID = shippingTypeID;
            product.ShipEstimateID = shipEstimateID;
            product.TaxTypeID = taxTypeID;
            product.StockLocation = stockLocation;
            product.OurPrice = ourPrice;
            product.RetailPrice = retailPrice;
            product.Weight = weight;
            product.CurrencyCode = currencyCode;
            product.UnitOfMeasure = unitOfMeasure;
            product.AdminComments = adminComments;
            product.Length = length;
            product.Height = height;
            product.Width = width;
            product.DimensionUnit = dimensionUnit;
            product.IsDeleted = isDeleted;
            product.ListOrder = listOrder;
            product.RatingSum = ratingSum;
            product.TotalRatingVotes = totalRatingVotes;
            string userName = System.Web.HttpContext.Current.User.Identity.Name;
            product.Save(userName);
        }

        public static void Update(int productID, string sku, string productName, string shortDescription, int manufacturerID, string attributeXML, int statusID, int productTypeID, int shippingTypeID, int shipEstimateID, int taxTypeID, string stockLocation, decimal ourPrice, decimal retailPrice, decimal weight, string currencyCode, string unitOfMeasure, string adminComments, decimal length, decimal height, decimal width, string dimensionUnit, bool isDeleted, int listOrder, int ratingSum, int totalRatingVotes)
        {
            Product product = new Product(productID);

            product.ProductID = productID;
            product.Sku = sku;
            product.ProductName = productName;
            product.ShortDescription = shortDescription;
            product.ManufacturerID = manufacturerID;
            product.AttributeXML = attributeXML;
            product.StatusID = statusID;
            product.ProductTypeID = productTypeID;
            product.ShippingTypeID = shippingTypeID;
            product.ShipEstimateID = shipEstimateID;
            product.TaxTypeID = taxTypeID;
            product.StockLocation = stockLocation;
            product.OurPrice = ourPrice;
            product.RetailPrice = retailPrice;
            product.Weight = weight;
            product.CurrencyCode = currencyCode;
            product.UnitOfMeasure = unitOfMeasure;
            product.AdminComments = adminComments;
            product.Length = length;
            product.Height = height;
            product.Width = width;
            product.DimensionUnit = dimensionUnit;
            product.IsDeleted = isDeleted;
            product.ListOrder = listOrder;
            product.RatingSum = ratingSum;
            product.TotalRatingVotes = totalRatingVotes;
            string userName = System.Web.HttpContext.Current.User.Identity.Name;
            product.Save(userName);
        }
        #endregion
    }
}
