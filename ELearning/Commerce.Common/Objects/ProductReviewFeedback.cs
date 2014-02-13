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
    public class ProductReviewFeedbackCollection : ActiveList<ProductReviewFeedback>
    {

    }
    /// <summary>
    /// A Persistable class that uses Generics to store it's state
    /// in the database. This class maps to the CSK_Store_ProductReviewFeedback table.
    /// </summary>
    public class ProductReviewFeedback : ActiveRecord<ProductReviewFeedback>
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
                Table = Query.BuildTableSchema("CSK_Store_ProductReviewFeedback");

            }

            //set the default values
            this.SetColumnValue("feedbackID", 0);
            this.SetColumnValue("reviewID", 0);
            this.SetColumnValue("userName", string.Empty);
            this.SetColumnValue("isHelpful", false);

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
            ProductReviewFeedback item = new ProductReviewFeedback();
            return ProductReviewFeedback.Table;
        }

        public ProductReviewFeedback()
            : base()
        {
            SetSQLProps();
        }
        public ProductReviewFeedback(int ReviewID)
        {
            SetSQLProps();
            base.LoadByKey(ReviewID);

        }

        #endregion

        #region Public Props
        [XmlAttribute("FeedbackID")]
        public int FeedbackID
        {
            get
            {
                return int.Parse(this.GetColumnValue("feedbackID").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("feedbackID", value);

            }
        }
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
        [XmlAttribute("IsHelpful")]
        public bool IsHelpful
        {
            get
            {
                return bool.Parse(this.GetColumnValue("isHelpful").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("isHelpful", value);

            }
        }

        #endregion


    }
}
