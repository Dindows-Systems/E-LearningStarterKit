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
    public class ImageCollection : ActiveList<Image>
    {

    }
    /// <summary>
    /// A Persistable class that uses Generics to store it's state
    /// in the database. This class maps to the CSK_Store_Image table.
    /// </summary>
    [Serializable]
    public class Image : ActiveRecord<Image>
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
                Table = Query.BuildTableSchema("CSK_Store_Image");

            }

            //set the default values
            this.SetColumnValue("imageID", 0);
            this.SetColumnValue("productID", 0);
            this.SetColumnValue("imageFile", string.Empty);
            this.SetColumnValue("listOrder", 0);
            this.SetColumnValue("caption", string.Empty);

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
            Image item = new Image();
            return Image.Table;
        }

        public Image()
            : base()
        {
            SetSQLProps();
        }
        public Image(int imageID)
        {
            SetSQLProps();
            base.LoadByKey(imageID);

        }

        #endregion

        #region Public Props
        [XmlAttribute("ImageID")]
        public int ImageID
        {
            get
            {
                return int.Parse(this.GetColumnValue("imageID").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("imageID", value);

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
        [XmlAttribute("Caption")]
        public string Caption
        {
            get
            {
                return this.GetColumnValue("caption").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("caption", value);

            }
        }

        #endregion

        #region ObjectDataSource Support

        public static void Add(int productID, string imageFile, int listOrder, string caption)
        {
            Image image = new Image();

            image.ProductID = productID;
            image.ImageFile = imageFile;
            image.ListOrder = listOrder;
            image.Caption = caption;
            string userName = System.Web.HttpContext.Current.User.Identity.Name;
            image.Save(userName);
        }

        public static void Update(int imageID, int productID, string imageFile, int listOrder, string caption)
        {
            Image image = new Image(imageID);

            image.ImageID = imageID;
            image.ProductID = productID;
            image.ImageFile = imageFile;
            image.ListOrder = listOrder;
            image.Caption = caption;
            string userName = System.Web.HttpContext.Current.User.Identity.Name;
            image.Save(userName);
        }
        #endregion
    }
}
