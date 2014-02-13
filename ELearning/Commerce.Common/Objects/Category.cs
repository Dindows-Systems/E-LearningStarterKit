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
    public class CategoryCollection : ActiveList<Category>
    {

    }
    /// <summary>
    /// A Persistable class that uses Generics to store it's state
    /// in the database. This class maps to the CSK_Store_Category table.
    /// </summary>
    [Serializable]
    public class Category : ActiveRecord<Category>
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
                Table = Query.BuildTableSchema("CSK_Store_Category");

            }

            //set the default values
            this.SetColumnValue("categoryID", 0);
            this.SetColumnValue("categoryName", string.Empty);
            this.SetColumnValue("imageFile", string.Empty);
            this.SetColumnValue("parentID", 0);
            this.SetColumnValue("shortDescription", string.Empty);
            this.SetColumnValue("longDescription", string.Empty);
            this.SetColumnValue("listOrder", 0);

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
            Category item = new Category();
            return Category.Table;
        }

        public Category()
            : base()
        {
            SetSQLProps();
        }
        public Category(int categoryID)
        {
            SetSQLProps();
            base.LoadByKey(categoryID);

        }

        #endregion

        #region Public Props
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
        [XmlAttribute("CategoryName")]
        public string CategoryName
        {
            get
            {
                return this.GetColumnValue("categoryName").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("categoryName", value);

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
        [XmlAttribute("ParentID")]
        public int ParentID
        {
            get
            {

                object parentID = this.GetColumnValue("parentID").ToString();
                //parentID can be null in the DB
                //but that will break this
                if (parentID.ToString()==string.Empty)
                {
                    return 0;
                }
                else
                {
                    return int.Parse(parentID.ToString());
                }
                
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("parentID", value);

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
        [XmlAttribute("LongDescription")]
        public string LongDescription
        {
            get
            {
                return this.GetColumnValue("longDescription").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("longDescription", value);

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

        #endregion

        #region ObjectDataSource Support

        public static void Add(string categoryName, string imageFile, int parentID, string shortDescription, string longDescription, int listOrder)
        {
            Category category = new Category();

            category.CategoryName = categoryName;
            category.ImageFile = imageFile;
            category.ParentID = parentID;
            category.ShortDescription = shortDescription;
            category.LongDescription = longDescription;
            category.ListOrder = listOrder;
            string userName = System.Web.HttpContext.Current.User.Identity.Name;
            category.Save(userName);
        }

        public static void Update(int categoryID, string categoryName, string imageFile, int parentID, string shortDescription, string longDescription, int listOrder)
        {
            Category category = new Category(categoryID);

            category.CategoryID = categoryID;
            category.CategoryName = categoryName;
            category.ImageFile = imageFile;
            category.ParentID = parentID;
            category.ShortDescription = shortDescription;
            category.LongDescription = longDescription;
            category.ListOrder = listOrder;
            string userName = System.Web.HttpContext.Current.User.Identity.Name;
            category.Save(userName);
        }
        #endregion
    }
}
