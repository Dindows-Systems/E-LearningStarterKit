using System;
using System.Text;
using System.Data;
using System.Data.Common;
using System.Collections;
using System.Configuration;
using System.Xml;
using System.Xml.Serialization;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Commerce.Common;
using WekeRoad.Tools;

namespace Commerce.Stats
{

    /// <summary>
    /// A Persistable class that uses Generics to store it's state
    /// in the database. This class maps to the CSK_Stats_Tracker table.
    /// </summary>
    public class Tracker : ActiveRecord<Tracker>
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
                Table = new TableSchema.Table("CSK_Stats_Tracker");
                Table.Columns = new TableSchema.TableColumnCollection();
                Table.Columns.Add("trackingID", DbType.Int32, false, true, false);
                Table.Columns.Add("userName", DbType.String, false, false, false);
                Table.Columns.Add("adID", DbType.Int32, true, false, false);
                Table.Columns.Add("promoID", DbType.Int32, true, false, false);
                Table.Columns.Add("productSKU", DbType.String, true, false, false);
                Table.Columns.Add("categoryID", DbType.Int32, true, false, false);
                Table.Columns.Add("pageURL", DbType.String, true, false, false);
                Table.Columns.Add("behaviorID", DbType.Int32, false, false, true);
                Table.Columns.Add("searchString", DbType.String, true, false, false);
                Table.Columns.Add("sessionID", DbType.String, true, false, false);
                Table.Columns.Add("createdOn", DbType.DateTime, true, false, false);
                Table.Columns.Add("createdBy", DbType.String, true, false, false);
                Table.Columns.Add("modifiedOn", DbType.DateTime, true, false, false);
                Table.Columns.Add("modifiedBy", DbType.String, true, false, false);

            }
        }

        public Tracker()
            : base()
        {
            SetSQLProps();
        }
        public Tracker(int trackingID)
        {
            SetSQLProps();
            base.LoadByKey(trackingID);
        }

        #endregion

        #region private vars

        int trackingID = 0;
        string userName = string.Empty;
        int adID = 0;
        int promoID = 0;
        string productSKU = string.Empty;
        int categoryID = 0;
        string pageURL = string.Empty;
        int behaviorID = 0;
        string searchString = string.Empty;
        string sessionID = string.Empty;

        #endregion

        #region Public Props
        [XmlAttribute("TrackingID")]
        public int TrackingID
        {
            get { return trackingID; }
            set
            {
                trackingID = value;
                this.MarkDirty();
                this.SetColumnValue("trackingID", value);

            }
        }
        [XmlAttribute("UserName")]
        public string UserName
        {
            get { return userName; }
            set
            {
                userName = value;
                this.MarkDirty();
                this.SetColumnValue("userName", value);

            }
        }
        [XmlAttribute("AdID")]
        public int AdID
        {
            get { return adID; }
            set
            {
                adID = value;
                this.MarkDirty();
                this.SetColumnValue("adID", value);

            }
        }
        [XmlAttribute("PromoID")]
        public int PromoID
        {
            get { return promoID; }
            set
            {
                promoID = value;
                this.MarkDirty();
                this.SetColumnValue("promoID", value);

            }
        }
        [XmlAttribute("ProductSKU")]
        public string ProductSKU
        {
            get { return productSKU; }
            set
            {
                productSKU = value;
                this.MarkDirty();
                this.SetColumnValue("productSKU", value);

            }
        }
        [XmlAttribute("CategoryID")]
        public int CategoryID
        {
            get { return categoryID; }
            set
            {
                categoryID = value;
                this.MarkDirty();
                this.SetColumnValue("categoryID", value);

            }
        }
        [XmlAttribute("PageURL")]
        public string PageURL
        {
            get { return pageURL; }
            set
            {
                pageURL = value;
                this.MarkDirty();
                this.SetColumnValue("pageURL", value);

            }
        }
        [XmlAttribute("Behavior")]
        public BehaviorType Behavior
        {
            get { return (BehaviorType)behaviorID; }
            set
            {
                behaviorID = (int)value;
                this.MarkDirty();
                this.SetColumnValue("behaviorID", value);

            }
        }
        [XmlAttribute("SearchString")]
        public string SearchString
        {
            get { return searchString; }
            set
            {
                searchString = value;
                this.MarkDirty();
                this.SetColumnValue("searchString", value);

            }
        }
        [XmlAttribute("SessionID")]
        public string SessionID
        {
            get { return sessionID; }
            set
            {
                sessionID = value;
                this.MarkDirty();
                this.SetColumnValue("sessionID", value);

            }
        }

        #endregion

        #region Extended Data Access - Stored Procedures


        /// <summary>
        /// Executes "CSK_Stats_Tracker_GetByBehaviorID" and returns the results in an IDataReader 
        /// </summary>
        /// <returns>System.Data.IDataReader </returns>	
        public static IDataReader GetByBehaviorID(int behaviorID)
        {

            Database db = DatabaseFactory.CreateDatabase();
            //retrieve data from database
            DbCommand cmd = db.GetStoredProcCommand("CSK_Stats_Tracker_GetByBehaviorID");
            db.AddInParameter(cmd, "@behaviorID", DbType.Int32, behaviorID);

            return DBHelper.GetReader(cmd);

        }

        /// <summary>
        /// Executes "CSK_Stats_Tracker_SynchTrackingCookie" and returns the results in an IDataReader 
        /// </summary>
        /// <returns>System.Data.IDataReader </returns>	
        public static IDataReader SynchTrackingCookie(string userName, string trackerCookie)
        {

            Database db = DatabaseFactory.CreateDatabase();
            //retrieve data from database
            DbCommand cmd = db.GetStoredProcCommand("CSK_Stats_Tracker_SynchTrackingCookie");
            db.AddInParameter(cmd, "@userName", DbType.String, userName);
            db.AddInParameter(cmd, "@trackerCookie", DbType.String, trackerCookie);

            return DBHelper.GetReader(cmd);

        }

        /// <summary>
        /// Executes "CSK_Stats_Tracker_GetRecentlyViewedProducts" and returns the results in an IDataReader 
        /// </summary>
        /// <returns>System.Data.IDataReader </returns>	
        public static IDataReader GetRecentlyViewedProducts(string username)
        {

            Database db = DatabaseFactory.CreateDatabase();
            //retrieve data from database
            DbCommand cmd = db.GetStoredProcCommand("CSK_Stats_Tracker_GetRecentlyViewedProducts");
            db.AddInParameter(cmd, "@username", DbType.String, username);

            return DBHelper.GetReader(cmd);

        }

        /// <summary>
        /// Executes "CSK_Stats_Tracker_GetByProductAndBehavior" and returns the results in an IDataReader 
        /// </summary>
        /// <returns>System.Data.IDataReader </returns>	
        public static IDataReader GetByProductAndBehavior(int behaviorID, string sku)
        {

            Database db = DatabaseFactory.CreateDatabase();
            //retrieve data from database
            DbCommand cmd = db.GetStoredProcCommand("CSK_Stats_Tracker_GetByProductAndBehavior");
            db.AddInParameter(cmd, "@behaviorID", DbType.Int32, behaviorID);
            db.AddInParameter(cmd, "@sku", DbType.String, sku);

            return DBHelper.GetReader(cmd);

        }
        #endregion

        #region Extended Add Routines

        public static void Add(BehaviorType behavior, int categoryID, string productSKU, string searchString)
        {
            Add(behavior, categoryID, productSKU, searchString, 0, 0, "");
        }
        public static void Add(BehaviorType behavior, string productSKU)
        {
            Add(behavior, 0, productSKU, "", 0, 0, "");
        }
        public static void Add(BehaviorType behavior, int categoryID)
        {
            Add(behavior, categoryID, "", "", 0, 0, "");
        }
        public static void Add(BehaviorType behavior)
        {
            Add(behavior, 0, "", "", 0, 0, "");
        }
        public static void Add(Tracker track)
        {

            track.Save("System");

        }
        public static void Add(BehaviorType behavior, int categoryID, string productSKU, string searchString,
            int adID, int promoID, string pageUrl)
        {

            //get the page from the server
            if (pageUrl == string.Empty)
                pageUrl = System.Web.HttpContext.Current.Request.Url.PathAndQuery;

            string sessionID = System.Web.HttpContext.Current.Session.SessionID;

            Tracker track = new Tracker();
            track.Behavior = behavior;
            track.CategoryID = categoryID;
            track.ProductSKU = productSKU;
            track.SearchString = searchString;
            track.AdID = adID;
            track.PromoID = promoID;
            track.PageURL = pageUrl;
            track.SessionID = sessionID;
            track.UserName = Commerce.Common.Utility.GetUserName();

            Add(track);

        }


        #endregion

    }
}
