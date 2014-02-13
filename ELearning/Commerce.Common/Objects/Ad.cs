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
    public class AdCollection : ActiveList<Ad>
    {

    }
    /// <summary>
    /// A Persistable class that uses Generics to store it's state
    /// in the database. This class maps to the CSK_Store_Ad table.
    /// </summary>
    [Serializable]
    public class Ad : ActiveRecord<Ad>
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
                Table = Query.BuildTableSchema("CSK_Store_Ad");
            }

            //set the default values
            this.SetColumnValue("adID", 0);
            this.SetColumnValue("pageName", string.Empty);
            this.SetColumnValue("listOrder", 0);
            this.SetColumnValue("placement", string.Empty);
            this.SetColumnValue("adText", string.Empty);
            this.SetColumnValue("productSku", string.Empty);
            this.SetColumnValue("promoID", 0);
            this.SetColumnValue("categoryID", 0);
            this.SetColumnValue("dateExpires", DateTime.Now.AddDays(30));
            this.SetColumnValue("isActive", false);
            this.SetColumnValue("isDeleted", false);

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
            Ad ad = new Ad();
            return Ad.Table;
        }

        public Ad()
            : base()
        {
            SetSQLProps();
        }
        public Ad(int adID)
        {
            SetSQLProps();
            base.LoadByKey(adID);

        }

        #endregion

        #region Public Props
        [XmlAttribute("AdID")]
        public int AdID
        {
            get
            {
                return int.Parse(this.GetColumnValue("adID").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("adID", value);

            }
        }
        [XmlAttribute("PageName")]
        public string PageName
        {
            get
            {
                return this.GetColumnValue("pageName").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("pageName", value);

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
        [XmlAttribute("Placement")]
        public string Placement
        {
            get
            {
                return this.GetColumnValue("placement").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("placement", value);

            }
        }
        [XmlAttribute("AdText")]
        public string AdText
        {
            get
            {
                return this.GetColumnValue("adText").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("adText", value);

            }
        }
        [XmlAttribute("ProductSku")]
        public string ProductSku
        {
            get
            {
                return this.GetColumnValue("productSku").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("productSku", value);

            }
        }
        [XmlAttribute("PromoID")]
        public int PromoID
        {
            get
            {
                return int.Parse(this.GetColumnValue("promoID").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("promoID", value);

            }
        }
        [XmlAttribute("CategoryID")]
        public int CategoryID
        {
            get
            {
                return int.Parse(this.GetColumnValue("categoryID").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("categoryID", value);

            }
        }
        [XmlAttribute("DateExpires")]
        public DateTime DateExpires
        {
            get
            {
                return DateTime.Parse(this.GetColumnValue("dateExpires").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("dateExpires", value);

            }
        }
        [XmlAttribute("IsActive")]
        public bool IsActive
        {
            get
            {
                return bool.Parse(this.GetColumnValue("isActive").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("isActive", value);

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

        #endregion

        #region ObjectDataSource Support

        public static void Add(string pageName, int listOrder, string placement, string adText, string productSku, int promoID, int categoryID, DateTime dateExpires, bool isActive, bool isDeleted)
        {
            Ad ad = new Ad();

            ad.PageName = pageName;
            ad.ListOrder = listOrder;
            ad.Placement = placement;
            ad.AdText = adText;
            ad.ProductSku = productSku;
            ad.PromoID = promoID;
            ad.CategoryID = categoryID;
            ad.DateExpires = dateExpires;
            ad.IsActive = isActive;
            ad.IsDeleted = isDeleted;
            string userName = System.Web.HttpContext.Current.User.Identity.Name;
            ad.Save(userName);
        }

        public static void Update(int adID, string pageName, int listOrder, string placement, string adText, string productSku, int promoID, int categoryID, DateTime dateExpires, bool isActive, bool isDeleted)
        {
            Ad ad = new Ad(adID);

            ad.AdID = adID;
            ad.PageName = pageName;
            ad.ListOrder = listOrder;
            ad.Placement = placement;
            ad.AdText = adText;
            ad.ProductSku = productSku;
            ad.PromoID = promoID;
            ad.CategoryID = categoryID;
            ad.DateExpires = dateExpires;
            ad.IsActive = isActive;
            ad.IsDeleted = isDeleted;
            string userName = System.Web.HttpContext.Current.User.Identity.Name;
            ad.Save(userName);
        }
        #endregion
    }
}
