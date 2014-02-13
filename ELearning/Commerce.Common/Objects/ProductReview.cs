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
    public class ProductReviewCollection : ActiveList<ProductReview>
    {

    }
    /// <summary>
    /// A Persistable class that uses Generics to store it's state
    /// in the database. This class maps to the CSK_Store_ProductReview table.
    /// </summary>
    [Serializable]
    public class ProductReview : ActiveRecord<ProductReview>
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
                Table = Query.BuildTableSchema("CSK_Store_ProductReview");

            }

            //set the default values
            this.SetColumnValue("reviewID", 0);
            this.SetColumnValue("productID", 0);
            this.SetColumnValue("title", string.Empty);
            this.SetColumnValue("body", string.Empty);
            this.SetColumnValue("postDate", new DateTime(1900, 01, 01));
            this.SetColumnValue("authorName", string.Empty);
            this.SetColumnValue("rating", 0);
            this.SetColumnValue("isApproved", false);

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
            ProductReview item = new ProductReview();
            return ProductReview.Table;
        }

        public ProductReview()
            : base()
        {
            SetSQLProps();
        }
        public ProductReview(int ReviewID)
        {
            SetSQLProps();
            base.LoadByKey(ReviewID);

        }

        #endregion

        #region Public Props
        [XmlAttribute("ReviewID")]
        public int ReviewID
        {
            get
            {
                return int.Parse(this.GetColumnValue("reviewID").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("reviewID", value);

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
        [XmlAttribute("Title")]
        public string Title
        {
            get
            {
                return this.GetColumnValue("title").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("title", value);

            }
        }
        [XmlAttribute("Body")]
        public string Body
        {
            get
            {
                return this.GetColumnValue("body").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("body", value);

            }
        }
        [XmlAttribute("PostDate")]
        public DateTime PostDate
        {
            get
            {
                return DateTime.Parse(this.GetColumnValue("postDate").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("postDate", value);

            }
        }
        [XmlAttribute("AuthorName")]
        public string AuthorName
        {
            get
            {
                return this.GetColumnValue("authorName").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("authorName", value);

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
        [XmlAttribute("IsApproved")]
        public bool IsApproved
        {
            get
            {
                return bool.Parse(this.GetColumnValue("isApproved").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("isApproved", value);

            }
        }

        #endregion

        #region ObjectDataSource Support

        public static void Add(int productID, string title, string body, DateTime postDate, string authorName, int rating, bool isApproved)
        {
            ProductReview productreview = new ProductReview();

            productreview.ProductID = productID;
            productreview.Title = title;
            productreview.Body = body;
            productreview.PostDate = postDate;
            productreview.AuthorName = authorName;
            productreview.Rating = rating;
            productreview.IsApproved = isApproved;
            string userName = System.Web.HttpContext.Current.User.Identity.Name;
            productreview.Save(userName);
        }

        public static void Update(int reviewID, int productID, string title, string body, DateTime postDate, string authorName, int rating, bool isApproved)
        {
            ProductReview productreview = new ProductReview(reviewID);

            productreview.ReviewID = reviewID;
            productreview.ProductID = productID;
            productreview.Title = title;
            productreview.Body = body;
            productreview.PostDate = postDate;
            productreview.AuthorName = authorName;
            productreview.Rating = rating;
            productreview.IsApproved = isApproved;
            string userName = System.Web.HttpContext.Current.User.Identity.Name;
            productreview.Save(userName);
        }
        #endregion
    }
}
