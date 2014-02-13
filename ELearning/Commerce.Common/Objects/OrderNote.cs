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
    public class OrderNoteCollection : ActiveList<OrderNote>
    {

    }
    /// <summary>
    /// A Persistable class that uses Generics to store it's state
    /// in the database. This class maps to the CSK_Store_OrderNote table.
    /// </summary>
    [Serializable]
    public class OrderNote : ActiveRecord<OrderNote>
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
                Table = Query.BuildTableSchema("CSK_Store_OrderNote");

            }

            //set the default values
            this.SetColumnValue("noteID", 0);
            this.SetColumnValue("orderID", 0);
            this.SetColumnValue("note", string.Empty);
            this.SetColumnValue("orderStatus", string.Empty);

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
            OrderNote item = new OrderNote();
            return OrderNote.Table;
        }

        public OrderNote()
            : base()
        {
            SetSQLProps();
        }
        public OrderNote(int noteID)
        {
            SetSQLProps();
            base.LoadByKey(noteID);

        }

        #endregion

        #region Public Props
        [XmlAttribute("NoteID")]
        public int NoteID
        {
            get
            {
                return int.Parse(this.GetColumnValue("noteID").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("noteID", value);

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
        [XmlAttribute("Note")]
        public string Note
        {
            get
            {
                return this.GetColumnValue("note").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("note", value);

            }
        }
        [XmlAttribute("OrderStatus")]
        public string OrderStatus
        {
            get
            {
                return this.GetColumnValue("orderStatus").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("orderStatus", value);

            }
        }

        #endregion

        #region ObjectDataSource Support

        public static void Add(int orderID, string note, string orderStatus)
        {
            OrderNote ordernote = new OrderNote();

            ordernote.OrderID = orderID;
            ordernote.Note = note;
            ordernote.OrderStatus = orderStatus;
            string userName = System.Web.HttpContext.Current.User.Identity.Name;
            ordernote.Save(userName);
        }

        public static void Update(int noteID, int orderID, string note, string orderStatus)
        {
            OrderNote ordernote = new OrderNote(noteID);

            ordernote.NoteID = noteID;
            ordernote.OrderID = orderID;
            ordernote.Note = note;
            ordernote.OrderStatus = orderStatus;
            string userName = System.Web.HttpContext.Current.User.Identity.Name;
            ordernote.Save(userName);
        }
        #endregion
    }
}
