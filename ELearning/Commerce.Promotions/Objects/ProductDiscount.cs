
using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using WekeRoad.Tools;

namespace Commerce.Promotions
{
    
    
    public class ProductDiscount 
    {

        public ProductDiscount()
        {

        }
        public bool IsLoaded = false;
        #region private vars

        int _CampaignID;
        string _Campaign;
        int _PromoID;
        string _PromoCode;
        string _Title;
        string _Description;
        int _ProductID;
        string _Sku;
        string _ProductName;
        decimal _OurPrice;
        decimal _RetailPrice;
        decimal _DiscountAmount;
        decimal _DiscountedPrice;
        decimal _Discount;
        int _QtyThreshold;
        bool _IsActive;
        DateTime _DateEnd;
        #endregion

        #region Public Props
        public int CampaignID
        {
            get { return _CampaignID; }
            set { _CampaignID = value; }
        }
        public string Campaign
        {
            get { return _Campaign; }
            set { _Campaign = value; }
        }
        public int PromoID
        {
            get { return _PromoID; }
            set { _PromoID = value; }
        }
        public string PromoCode
        {
            get { return _PromoCode; }
            set { _PromoCode = value; }
        }
        public string Title
        {
            get { return _Title; }
            set { _Title = value; }
        }
        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }
        public int ProductID
        {
            get { return _ProductID; }
            set { _ProductID = value; }
        }
        public string Sku
        {
            get { return _Sku; }
            set { _Sku = value; }
        }
        public string ProductName
        {
            get { return _ProductName; }
            set { _ProductName = value; }
        }
        public decimal OurPrice
        {
            get { return _OurPrice; }
            set { _OurPrice = value; }
        }
        public decimal RetailPrice
        {
            get { return _RetailPrice; }
            set { _RetailPrice = value; }
        }
        public decimal DiscountAmount
        {
            get { return _DiscountAmount; }
            set { _DiscountAmount = value; }
        }
        public decimal DiscountedPrice
        {
            get { return _DiscountedPrice; }
            set { _DiscountedPrice = value; }
        }
        public decimal Discount
        {
            get { return _Discount; }
            set { _Discount = value; }
        }
        public int QtyThreshold
        {
            get { return _QtyThreshold; }
            set { _QtyThreshold = value; }
        }
        public bool IsActive
        {
            get { return _IsActive; }
            set { _IsActive = value; }
        }
        public DateTime DateEnd
        {
            get { return _DateEnd; }
            set { _DateEnd = value; }
        }
        #endregion

        public void Load(IDataReader rdr)
        {
                IsLoaded = true;
                _CampaignID = Helper.GetInt(rdr["CampaignID"]);
                _Campaign = Helper.GetString(rdr["CampaignName"]);
                _PromoID = Helper.GetInt(rdr["PromoID"]);
                _PromoCode = Helper.GetString(rdr["PromoCode"]);
                _Title = Helper.GetString(rdr["Title"]);
                _Description = Helper.GetString(rdr["Description"]);
                _ProductID = Helper.GetInt(rdr["ProductID"]);
                _Sku = Helper.GetString(rdr["Sku"]);
                _ProductName = Helper.GetString(rdr["ProductName"]);
                _OurPrice = Helper.GetDecimal(rdr["OurPrice"]);
                _RetailPrice = Helper.GetDecimal(rdr["RetailPrice"]);
                _DiscountAmount = Helper.GetDecimal(rdr["DiscountAmount"]);
                _DiscountedPrice = Helper.GetDecimal(rdr["DiscountedPrice"]);
                _Discount = Helper.GetDecimal(rdr["Discount"]);
                _QtyThreshold = Helper.GetInt(rdr["QtyThreshold"]);
                _IsActive = Helper.GetBool(rdr["IsActive"]);
                _DateEnd = Helper.GetDateTime(rdr["DateEnd"]);
            }

        #region Extended Data Access
        public static List<ProductDiscount> GetDiscounts()
        {

            //load the default db from the base class
            Database db = DatabaseFactory.CreateDatabase();
            //specify the SP

            string cmd = "CSK_Promo_ProductMatrix";
            List<ProductDiscount> coll = new List<ProductDiscount>();
            using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
            {
                //return a reader using the Ent Blocks
                IDataReader rdr = db.ExecuteReader(dbCommand);
                ProductDiscount disc;
                while (rdr.Read())
                {
                    disc = new ProductDiscount();
                    disc.Load(rdr);
                    coll.Add(disc);
                }
                rdr.Close();
                dbCommand.Dispose();
            }
            return coll;

        }
        #endregion


        }

}