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
    public class TransactionCollection : ActiveList<Transaction>
    {

    }
    /// <summary>
    /// A Persistable class that uses Generics to store it's state
    /// in the database. This class maps to the CSK_Store_Transaction table.
    /// </summary>
    [Serializable]
    public class Transaction : ActiveRecord<Transaction>
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
                Table = Query.BuildTableSchema("CSK_Store_Transaction");

            }

            //set the default values
            this.SetColumnValue("transactionID",0);
            this.SetColumnValue("orderID", 0);
            this.SetColumnValue("authorizationCode", string.Empty);
            this.SetColumnValue("transactionDate", new DateTime(1900, 01, 01));
            this.SetColumnValue("transactionTypeID", 0);
            this.SetColumnValue("amount", 0);
            this.SetColumnValue("transactionNotes", string.Empty);

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
            Transaction item = new Transaction();
            return Transaction.Table;
        }

        public Transaction()
            : base()
        {
            SetSQLProps();
        }
        public Transaction(int transactionID)
        {
            SetSQLProps();
            base.LoadByKey(transactionID);

        }

        #endregion

        #region Custom - not in DB
        private string _CVV2Code;

        public string CVV2Code
        {
            get
            {
                return _CVV2Code;
            }
            set
            {
                _CVV2Code = value;
            }
        }

        private string _GatewayResponse;

        public string GatewayResponse
        {
            get
            {
                return _GatewayResponse;
            }
            set
            {
                _GatewayResponse = value;
            }
        }

        #endregion

        #region Public Props
        [XmlAttribute("TransactionID")]
        public string TransactionID
        {
            get
            {
                return this.GetColumnValue("transactionID").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("transactionID", value);

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
        [XmlAttribute("AuthorizationCode")]
        public string AuthorizationCode
        {
            get
            {
                return this.GetColumnValue("authorizationCode").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("authorizationCode", value);

            }
        }
        [XmlAttribute("TransactionDate")]
        public DateTime TransactionDate
        {
            get
            {
                return DateTime.Parse(this.GetColumnValue("transactionDate").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("transactionDate", value);

            }
        }
        [XmlAttribute("TransactionTypeID")]
        public int TransactionTypeID
        {
            get
            {
                return int.Parse(this.GetColumnValue("transactionTypeID").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("transactionTypeID", value);

            }
        }
        //enum
        public TransactionType TransactionType
        {
            get
            {
                return (TransactionType)this.GetColumnValue("transactionTypeID");
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("transactionTypeID", value);
            }
        }
        [XmlAttribute("Amount")]
        public decimal Amount
        {
            get
            {
                return decimal.Parse(this.GetColumnValue("amount").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("amount", value);

            }
        }
        [XmlAttribute("TransactionNotes")]
        public string TransactionNotes
        {
            get
            {
                return this.GetColumnValue("transactionNotes").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("transactionNotes", value);

            }
        }

        #endregion


    }
}
