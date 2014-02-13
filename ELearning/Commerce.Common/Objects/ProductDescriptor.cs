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
    public class ProductDescriptorCollection : ActiveList<ProductDescriptor>
    {

    }
    /// <summary>
    /// A Persistable class that uses Generics to store it's state
    /// in the database. This class maps to the CSK_Store_ProductDescriptor table.
    /// </summary>
    [Serializable]
    public class ProductDescriptor : ActiveRecord<ProductDescriptor>
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
                Table = Query.BuildTableSchema("CSK_Store_ProductDescriptor");

            }

            //set the default values
            this.SetColumnValue("descriptorID", 0);
            this.SetColumnValue("productID", 0);
            this.SetColumnValue("title", string.Empty);
            this.SetColumnValue("descriptor", string.Empty);
            this.SetColumnValue("isBulletedList", false);
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
            ProductDescriptor item = new ProductDescriptor();
            return ProductDescriptor.Table;
        }

        public ProductDescriptor()
            : base()
        {
            SetSQLProps();
        }
        public ProductDescriptor(int descriptorID)
        {
            SetSQLProps();
            base.LoadByKey(descriptorID);

        }

        #endregion

        #region Public Props
        [XmlAttribute("DescriptorID")]
        public int DescriptorID
        {
            get
            {
                return int.Parse(this.GetColumnValue("descriptorID").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("descriptorID", value);

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
        [XmlAttribute("Descriptor")]
        public string Descriptor
        {
            get
            {
                return this.GetColumnValue("descriptor").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("descriptor", value);

            }
        }
        [XmlAttribute("IsBulletedList")]
        public bool IsBulletedList
        {
            get
            {
                return bool.Parse(this.GetColumnValue("isBulletedList").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("isBulletedList", value);

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

        public static void Add(int productID, string title, string descriptor, bool isBulletedList, int listOrder)
        {
            ProductDescriptor productdescriptor = new ProductDescriptor();

            productdescriptor.ProductID = productID;
            productdescriptor.Title = title;
            productdescriptor.Descriptor = descriptor;
            productdescriptor.IsBulletedList = isBulletedList;
            productdescriptor.ListOrder = listOrder;
            string userName = System.Web.HttpContext.Current.User.Identity.Name;
            productdescriptor.Save(userName);
        }

        public static void Update(int descriptorID, int productID, string title, string descriptor, bool isBulletedList, int listOrder)
        {
            ProductDescriptor productdescriptor = new ProductDescriptor(descriptorID);

            productdescriptor.DescriptorID = descriptorID;
            productdescriptor.ProductID = productID;
            productdescriptor.Title = title;
            productdescriptor.Descriptor = descriptor;
            productdescriptor.IsBulletedList = isBulletedList;
            productdescriptor.ListOrder = listOrder;
            string userName = System.Web.HttpContext.Current.User.Identity.Name;
            productdescriptor.Save(userName);
        }
        #endregion
    }
}
