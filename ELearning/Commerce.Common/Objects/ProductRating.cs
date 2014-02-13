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
    public class ProductRatingCollection : ActiveList<ProductRating>
    {

    }
    /// <summary>
    /// A Persistable class that uses Generics to store it's state
    /// in the database. This class maps to the CSK_Store_ProductRating table.
    /// </summary>
    [Serializable]
    public class ProductRating : ActiveRecord<ProductRating>
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
                Table = Query.BuildTableSchema("CSK_Store_ProductRating");

            }

            //set the default values
            this.SetColumnValue("ratingID", 0);
            this.SetColumnValue("productID", 0);
            this.SetColumnValue("userName", string.Empty);
            this.SetColumnValue("rating", 0);

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
            ProductRating item = new ProductRating();
            return ProductRating.Table;
        }

        public ProductRating()
            : base()
        {
            SetSQLProps();
        }
        public ProductRating(int ratingID)
        {
            SetSQLProps();
            base.LoadByKey(ratingID);

        }

        #endregion

        #region Public Props
        [XmlAttribute("RatingID")]
        public int RatingID
        {
            get
            {
                return int.Parse(this.GetColumnValue("ratingID").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("ratingID", value);

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
        [XmlAttribute("Rating")]
        public int Rating
        {
            get
            {
                return int.Parse(this.GetColumnValue("rating").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("rating", value);

            }
        }

        #endregion

        #region ObjectDataSource Support

        public static void Add(int productID, string userName, int rating)
        {
            ProductRating productrating = new ProductRating();

            productrating.ProductID = productID;
            productrating.UserName = userName;
            productrating.Rating = rating;
            string uName = System.Web.HttpContext.Current.User.Identity.Name;
            productrating.Save(uName);
        }

        public static void Update(int ratingID, int productID, string userName, int rating)
        {
            ProductRating productrating = new ProductRating(ratingID);

            productrating.RatingID = ratingID;
            productrating.ProductID = productID;
            productrating.UserName = userName;
            productrating.Rating = rating;
            string uName = System.Web.HttpContext.Current.User.Identity.Name;
            productrating.Save(uName);
        }
        #endregion
    }
}
