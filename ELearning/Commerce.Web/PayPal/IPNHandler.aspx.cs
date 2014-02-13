using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net;
using System.IO;
using Commerce.Common;

public partial class IPNHandler : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string ppTX = Request.Form["txn_id"].ToString();
        string sOrderID = Request.Form["custom"].ToString();
        string sAmount = Request.Form["mc_gross"].ToString();

        //all we need at this point is the SUCCESS flag
        if (VerifyIPN()) {
            
            //get the amount
            if (sAmount != string.Empty) {

                Order order = new Order(sOrderID);
                
                //get the amount from the IPN
                decimal dPaidFor = decimal.Parse(sAmount);

                //commit the order
                OrderController.CommitStandardOrder(order,ppTX, decimal.Parse(sAmount));

            }
        }

    }
    bool VerifyIPN() {
        string strFormValues = Request.Form.ToString();
        string strNewValue;
        string strResponse;
        string serverURL = "";

        if (SiteConfig.UsePPStandardSandbox)
        {
            serverURL = "https://www.sandbox.paypal.com/cgi-bin/webscr";
        } else {
            serverURL = "https://www.paypal.com/cgi-bin/webscr"; ;
            //serverURL="http://www.eliteweaver.co.uk/cgi-bin/webscr ";
        }
        // Create the request back
        HttpWebRequest req = (HttpWebRequest)WebRequest.Create(serverURL);

        // Set values for the request back
        req.Method = "POST";
        req.ContentType = "application/x-www-form-urlencoded";
        strNewValue = strFormValues + "&cmd=_notify-validate";
        req.ContentLength = strNewValue.Length;

        // Write the request back IPN strings
        StreamWriter stOut = new StreamWriter(req.GetRequestStream(), System.Text.Encoding.ASCII);
        stOut.Write(strNewValue);
        stOut.Close();

        // Do the request to PayPal and get the response
        StreamReader stIn = new StreamReader(req.GetResponse().GetResponseStream());
        strResponse = stIn.ReadToEnd();
        stIn.Close();


        // Confirm whether the IPN was VERIFIED or INVALID. If INVALID, just ignore the IPN
        return strResponse == "VERIFIED";
        
    }

}
