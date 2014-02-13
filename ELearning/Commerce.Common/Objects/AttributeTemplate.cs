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
    public class AttributeTemplateCollection : ActiveList<AttributeTemplate>
    {

    }
    /// <summary>
    /// A Persistable class that uses Generics to store it's state
    /// in the database. This class maps to the CSK_Store_AttributeTemplate table.
    /// </summary>
    public class AttributeTemplate : ActiveRecord<AttributeTemplate>
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
                Table = Query.BuildTableSchema("CSK_Store_AttributeTemplate");

            }

            //set the default values
            this.SetColumnValue("templateID", 0);
            this.SetColumnValue("attributeName", string.Empty);
            this.SetColumnValue("selectionList", string.Empty);
            this.SetColumnValue("description", string.Empty);
            this.SetColumnValue("attributeTypeID", 0);

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
            AttributeTemplate item = new AttributeTemplate();
            return AttributeTemplate.Table;
        }

        public AttributeTemplate()
            : base()
        {
            SetSQLProps();
        }
        public AttributeTemplate(int templateID)
        {
            SetSQLProps();
            base.LoadByKey(templateID);

        }

        #endregion

        #region Public Props
        [XmlAttribute("TemplateID")]
        public int TemplateID
        {
            get
            {
                return int.Parse(this.GetColumnValue("templateID").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("templateID", value);

            }
        }
        [XmlAttribute("AttributeName")]
        public string AttributeName
        {
            get
            {
                return this.GetColumnValue("attributeName").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("attributeName", value);

            }
        }
        [XmlAttribute("SelectionList")]
        public string SelectionList
        {
            get
            {
                return this.GetColumnValue("selectionList").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("selectionList", value);

            }
        }
        [XmlAttribute("Description")]
        public string Description
        {
            get
            {
                return this.GetColumnValue("description").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("description", value);

            }
        }
        [XmlAttribute("AttributeTypeID")]
        public int AttributeTypeID
        {
            get
            {
                return int.Parse(this.GetColumnValue("attributeTypeID").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("attributeTypeID", value);

            }
        }
        //enum
        public AttributeType AttributeType
        {
            get
            {
                return (AttributeType)this.GetColumnValue("attributeTypeID");
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("attributeType", value);
            }
        }

        #endregion

        #region ObjectDataSource Support

        public static void Add(string attributeName, string selectionList, string description, int attributeTypeID)
        {
            AttributeTemplate attributetemplate = new AttributeTemplate();

            attributetemplate.AttributeName = attributeName;
            attributetemplate.SelectionList = selectionList;
            attributetemplate.Description = description;
            attributetemplate.AttributeTypeID = attributeTypeID;
            string userName = System.Web.HttpContext.Current.User.Identity.Name;
            attributetemplate.Save(userName);
        }

        public static void Update(int templateID, string attributeName, string selectionList, string description, int attributeTypeID)
        {
            AttributeTemplate attributetemplate = new AttributeTemplate(templateID);

            attributetemplate.TemplateID = templateID;
            attributetemplate.AttributeName = attributeName;
            attributetemplate.SelectionList = selectionList;
            attributetemplate.Description = description;
            attributetemplate.AttributeTypeID = attributeTypeID;
            string userName = System.Web.HttpContext.Current.User.Identity.Name;
            attributetemplate.Save(userName);
        }
        #endregion
    }
}
