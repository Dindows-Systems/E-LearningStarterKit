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

public partial class PDTHandler : System.Web.UI.Page
{
    void Page_Load(object sender, EventArgs e)
    {

        //###############################################################################
        //  Page Validators
        //###############################################################################

        TestCondition.IsNotNull(Request.QueryString["tx"], Resources.Common.NoTransactionID);
        TestCondition.IsNotNull(Request.QueryString["cm"], Resources.Common.NoTransactionID);

        //##############################################################################
        
        
        string ppTX = Request.QueryString["tx"].ToString();
        string sOrderID = Request.QueryString["cm"].ToString();

        string pdtResponse = GetPDT(ppTX);
        //all we need at this point is the SUCCESS flag
        if (pdtResponse.StartsWith("SUCCESS"))
        {

            string sAmount = GetPDTValue(pdtResponse, "mc_gross");

            //make sure the totals add up
            try
            {
                Order order = new Order(sOrderID);

                //commit the order
                OrderController.CommitStandardOrder(order,ppTX, decimal.Parse(sAmount));


                //send off to the receipt page
                Response.Redirect("../receipt.aspx?t=" + sOrderID);

            }
            catch (Exception x)
            {
                Response.Write(string.Format( Resources.Common.InvalidOrder,x.Message));
            }

        }
        else
        {
            Response.Write(string.Format( Resources.Common.PDTFailure,pdtResponse));
        }

        

    }
    string GetPDTValue(string pdt, string key) {
        
        string[] keys = pdt.Split('\n');
        string thisVal = "";
        string thisKey="";
        foreach (string s in keys) {
            string[] bits = s.Split('=');
            if (bits.Length > 1) {
                thisVal = bits[1];
                thisKey = bits[0];
                if (thisKey.ToLower().Equals(key))
                    break;
            }
        }
        return thisVal;


    }
    string GetPDT(string transactionID)
    {

        string sOut = "";
        string PDTID = "";
        PDTID = SiteConfig.PayPalPDTID;

        string sCmd = "_notify-synch";

        string serverURL = "";
        if (SiteConfig.UsePPStandardSandbox)
        {
            serverURL = "https://www.sandbox.paypal.com/cgi-bin/webscr";
        }
        else
        {
            serverURL = "https://www.paypal.com/cgi-bin/webscr"; ;

        }


        try
        {
            string strFormValues = Request.Form.ToString();
            string strNewValue;
            string strResponse;

            // Create the request back
            HttpWebRequest req = (HttpWebRequest)WebRequest.Create(serverURL);

            // Set values for the request back
            req.Method = "POST";
            req.ContentType = "application/x-www-form-urlencoded";
            strNewValue = strFormValues + "&cmd=_notify-synch&at=" + PDTID + "&tx=" + transactionID;
            req.ContentLength = strNewValue.Length;

            // Write the request back IPN strings
            StreamWriter stOut = new StreamWriter(req.GetRequestStream(), System.Text.Encoding.ASCII);
            stOut.Write(strNewValue);
            stOut.Close();

            // Do the request to PayPal and get the response
            StreamReader stIn = new StreamReader(req.GetResponse().GetResponseStream());
            strResponse = stIn.ReadToEnd();

            stIn.Close();
            sOut = Server.UrlDecode(strResponse);


        }
        catch (Exception x)
        {
        }
        return sOut;

    }
}
