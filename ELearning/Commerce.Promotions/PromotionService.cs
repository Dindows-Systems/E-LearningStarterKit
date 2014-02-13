using System;
using System.Collections.Generic;
using System.Text;
using WekeRoad.Tools;
using Commerce.Common;

namespace Commerce.Promotions
{
    public class PromotionService
    {
        static List<ProductDiscount> discounts=null;

        /// <summary>
        /// A Collection of all the discounts, per product, in the store
        /// </summary>
        public static List<ProductDiscount> Discounts
        {
            get
            {
                if (discounts == null)
                {
                    discounts = ProductDiscount.GetDiscounts();
                }
                return discounts;
            }
        }

        /// <summary>
        /// Resets the static Discounts property. Use when you update
        /// the promos from the admin section.
        /// </summary>
        public static void ResetPromos()
        {
            discounts = ProductDiscount.GetDiscounts();

        }
        /// <summary>
        /// Returns discount information by SKU
        /// </summary>
        /// <param name="sku">Product Sku</param>
        /// <returns>ProductDiscount</returns>
        public static ProductDiscount GetProductDiscount(string sku)
        {
            ProductDiscount pOut = null;
            foreach (ProductDiscount disc in Discounts)
            {
                
                if (disc.Sku.Trim().ToLower().Equals(sku.Trim().ToLower()))
                {
                    pOut = disc;
                    break;
                }

            }
            return pOut;
        }
        /// <summary>
        /// Returns discount information by ProductID
        /// </summary>
        /// <param name="productID">ProductID</param>
        /// <returns>ProductDiscount</returns>
        public static ProductDiscount GetProductDiscount(int productID)
        {
            ProductDiscount pOut = null;
            foreach (ProductDiscount disc in Discounts)
            {
                if (disc.ProductID==productID)
                {
                    pOut = disc;
                    break;
                }

            }
            return pOut;

        }

        /// <summary>
        /// Sets the pricing of a product according to the discounts found, and 
        /// returns the discount information (title, etc).
        /// </summary>
        /// <param name="product"></param>
        /// <returns>ProductDiscount</returns>
        public static ProductDiscount SetProductPricing(Commerce.Common.Product product)
        {
            ProductDiscount discount = GetProductDiscount(product.ProductID);
            if (discount == null)
            {
                //this is a normal pricing scheme
                //meaning that the "everyday discount" off of retail
                //is in effect
                discount = new ProductDiscount();
                discount.Title = Properties.Resources.LowPrice;
                discount.Description = Properties.Resources.AlwaysLower;
                //the price has already been set by the merchant 
                //in the product's RetailPrice. So back-calculate it
                if(product.RetailPrice>0)
                    discount.Discount = product.OurPrice / product.RetailPrice * 100;
                discount.DiscountedPrice = product.OurPrice;
                discount.DiscountAmount = product.RetailPrice - product.OurPrice;

            }
            product.OurPrice = discount.DiscountedPrice;
            product.YouSavePrice = discount.DiscountAmount;

            //calc the percent saved
            //this is calculated as the overall savings between the
            //retail price, and the final discounted price
            decimal dSavingsRate = discount.DiscountedPrice / product.RetailPrice;
            decimal savingsPercent = 1 - (dSavingsRate);

            product.YouSavePercent = Math.Round(savingsPercent, 2);


            return discount;
        }

        //public static List<BundleItem> GetBundleByProduct(int productID)
        //{
        //    return BundleItem.GetByProductID(productID);
        //}

        public bool ProductHasDiscount(int productID)
        {
            return GetProductDiscount(productID) != null;
        }
        public bool ProductHasDiscount(string sku)
        {
            return GetProductDiscount(sku) != null;
        }

        public static ProductCollection GetCrossSells(int productID)
        {
            ProductCollection crossList = new ProductCollection();
            Query q = new Query(Product.GetTableSchema());
            q.AddInnerJoin("CSK_Promo_Product_CrossSell_Map", "productID", "crossProductID");
            q.AddWhere("CSK_Promo_Product_CrossSell_Map", "productID", productID);

            System.Data.IDataReader rdr = DBHelper.GetReader(q.BuildSelectCommand());
            crossList.Load(rdr);
            rdr.Close();
            return crossList;
        }

        //public static void DeleteBundle(int bundleID)
        //{
        //    //delete the items first
        //    Query q = new Query("CSK_Promo_Product_Bundle_Map");
        //    q.AddWhere("bundleID", bundleID);
        //    DBHelper.ExecuteQuery(q.BuildDeleteCommand());

        //    //then the bundle
        //    q = new Query(Bundle.GetTableSchema());
        //    q.AddWhere("bundleID", bundleID);
        //    DBHelper.ExecuteQuery(q.BuildDeleteCommand());


        //}
    }

    
}
