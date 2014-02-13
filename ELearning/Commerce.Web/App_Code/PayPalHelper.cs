using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text;
using Commerce.Common;

/// <summary>
/// A Helper class for sending things to PayPal. Many thanks to Rick Strahl for this
/// excellent code (posted on his blog).
/// </summary>
public class PayPalHelper
{
    /// <summary>
    /// Creates a link for a BuyNow button
    /// </summary>
    /// <param name="itemName"></param>
    /// <param name="itemNumber"></param>
    /// <param name="price"></param>
    /// <param name="tax"></param>
    /// <param name="shipping"></param>
    /// <param name="userName"></param>
    /// <returns></returns>
    public static string GetBuyNowButton(string itemName, string itemNumber, 
        double price, double tax, double shipping, string userName)
    {
        StringBuilder url = new StringBuilder();
        string serverURL = "https://www.sandbox.paypal.com/us/cgi-bin/webscr";
        if (!SiteConfig.UsePPStandardSandbox)
        {
            serverURL = "https://www.paypal.com/us/cgi-bin/webscr";
        }
        url.Append(serverURL + "?cmd=_xclick&currency_code=" + SiteConfig.CurrencyCode + "&business=" +
              HttpUtility.UrlEncode(SiteConfig.BusinessEmail));
        url.Append("&amount=" + price.ToString().Replace(",", "."));


        if (tax > 0)
            url.AppendFormat("&tax=" + tax.ToString().Replace(",", "."));

        if (shipping > 0)
            url.AppendFormat("&shipping=" + shipping.ToString().Replace(",", "."));
        
        url.AppendFormat("&item_name={0}", HttpUtility.UrlEncode(itemName));
        url.AppendFormat("&item_number={0}", HttpUtility.UrlEncode(itemNumber));
        url.AppendFormat("&custom={0}", HttpUtility.UrlEncode(userName));

        return "<a href='" + url.ToString() + "' target=_blank><img src='http://www.paypal.com/en_US/i/btn/x-click-but01.gif' border='0' alt='Make payments with PayPal - it's fast, free and secure!'></a>";

    }
    /// <summary>
    /// Creates the URL to send to PayPal so that a user can check out using PaymentsStandard
    /// </summary>
    /// <returns></returns>
    public static string GetUploadCartUrl(Order order)
    {
        //cart.Items.Load(ShoppingCartManager.GetCartItems());
        decimal total = order.CalculateSubTotal();
        decimal tax = order.TaxAmount;
        decimal shipping = order.ShippingAmount;
        
        //PayPal doesn't like more than 2 0's
        total = Math.Round(total, 2);
        tax = Math.Round(tax, 2);
        shipping = Math.Round(shipping, 2);

        StringBuilder url = new StringBuilder();
        string serverURL = "https://www.sandbox.paypal.com/us/cgi-bin/webscr";
        if (!SiteConfig.UsePPStandardSandbox)
        {
            serverURL = "https://www.paypal.com/us/cgi-bin/webscr";
        }
        url.Append(serverURL + "?cmd=_xclick&currency_code=" + SiteConfig.CurrencyCode + "&business=" +
              HttpUtility.UrlEncode(SiteConfig.BusinessEmail));
        

        if (total > 0)
            url.Append("&amount=" + total.ToString().Replace(",", "."));


        if (order.TaxAmount > 0)
            url.AppendFormat("&tax=" + tax.ToString().Replace(",", "."));

        if (order.ShippingAmount > 0)
            url.AppendFormat("&shipping=" + shipping.ToString().Replace(",", "."));

        
        url.Append("&item_name=Order Number " + order.OrderNumber);
        url.Append("&no_shipping=1");
        url.Append("&first_name="+ order.ShippingAddress.FirstName);
        url.Append("&last_name=" + order.ShippingAddress.LastName);
        url.Append("&address1=" + order.ShippingAddress.Address1);
        url.Append("address2=" + order.ShippingAddress.Address2);
        url.Append("&city=" + order.ShippingAddress.City);
        url.Append("&state=" + order.ShippingAddress.StateOrRegion);
        url.Append("&zip=" + order.ShippingAddress.Zip);

        //add the items
        /*
        string sItemNum = "";
        int index = 1;
        decimal itemAmount = 0;
        foreach (Commerce.Common.OrderItem item in order.Items)
        {

            sItemNum = index.ToString();
            itemAmount = Math.Round(item.PricePaid,2);
            url.AppendFormat("&item_name_" + sItemNum + "={0}", HttpUtility.UrlEncode(item.ProductName));
            url.AppendFormat("&quantity_" + sItemNum + "={0}", HttpUtility.UrlEncode(item.Quantity.ToString()));
            url.AppendFormat("&item_number_" + sItemNum + "={0}", HttpUtility.UrlEncode(item.Sku));
            url.AppendFormat("&amount_" + sItemNum + "={0}", HttpUtility.UrlEncode(itemAmount.ToString().Replace(",", ".")));
            index++;
        }
        */
        string SuccessUrl = Utility.GetSiteRoot() + "/PayPal/PDTHandler.aspx";
        string CancelUrl = Utility.GetSiteRoot() + "/Checkout.aspx";

        if (SuccessUrl != null && SuccessUrl != "")
            url.AppendFormat("&return={0}", HttpUtility.UrlEncode(SuccessUrl));
        if (CancelUrl != null && CancelUrl != "")
            url.AppendFormat("&cancel_return={0}", HttpUtility.UrlEncode(CancelUrl));
        return url.ToString();

    }
}
