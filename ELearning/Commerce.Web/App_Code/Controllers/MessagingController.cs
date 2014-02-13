using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Commerce.Common;
using Commerce.Messaging;
using WekeRoad.Tools;

/// <summary>
/// Summary description for MessagingController
/// </summary>
public static class MessagingController
{
        /// <summary>
    /// This method can be used for all kinds of fun things - like dropping an EDI x12 document, or an
    /// XML message for BizTalk. For instance, you can serialize down an order simply by using
    /// order.ToXML(), put that string into a document (it's well-formatted XML already), and 
    /// drop it on an FTP server.
    /// </summary>
    /// <param name="absoluteFilePath">The path to the file to send</param>
    /// <param name="ftpServerUrl">should be something like ftp://servername.com/directory</param>
    /// <param name="userName">FTP username</param>
    /// <param name="password">FTP password</param>
    public static void SendFTP(string absoluteFilePath, string ftpServerUrl, string userName, string password)
    {

        FTPClient.PutFile(absoluteFilePath,
            ftpServerUrl, userName, password);
    }

    public static void SendIM()
    {
        throw new Exception(Resources.Common.PlaceHolder);
    }
    
    public enum Message : int
    {
        OrderReceivedEmail = 1,
        MailerToCustomer = 2,
        ShippingNotification = 4,
        OrderCancellations = 12,
        OrderRefunded = 13
    }

    /// <summary>
    /// This method will send a message to the shop owner, notifying them of a new order
    /// </summary>
    /// <param name="order">The order itself</param>
    /// <returns></returns>
    public static bool SendMerchantOrderNotice(Order order)
    {
        bool bOut = false;
        
        //load up the template
        string template = Utility.GetFileText("MailerTemplates/MailerToMerchant.txt");
        
        //get the mailer from the DB
        int mailerID = Convert.ToInt16(Message.OrderReceivedEmail);
        Email mailer = new Email(mailerID);

        //we're overriding the DB templates
        //use the text template
        //it's formatted nicely
        if (template.Length > 0)
        {
            //run some tag replacements. First with the name
            string sMessage = template;
            sMessage = sMessage.Replace("#NAME#", order.FirstName + " " + order.LastName);

            //ordernumber
            sMessage = sMessage.Replace("#ORDER#", order.ToHtml());

            //tagline
            sMessage = sMessage.Replace("#TAGLINE#", Resources.Common.Slogan);

            //items
            sMessage = sMessage.Replace("#LINK#", Utility.GetSiteRoot() + "/admin/admin_orders.aspx?id="+order.OrderID);

            //setup the mailer
            mailer.MessageBody = sMessage;
            mailer.ToList = order.Email;

            //send it off!
            bOut = Email.SendEmail(mailer);

        }

        return bOut;

    }
    /// <summary>
    /// This is an overriden method of the Mailer class. The default message in the DB is going
    /// to be overwritten with a nicely formatted HTML message stored in the EmailTemplates
    /// Directory. Feel free to change as needed.
    /// </summary>
    /// <param name="order">The order to send out the mailer for.</param>
    /// <returns></returns>
    public static bool SendOrderReceivedEmail(Order order){

        bool bOut = false;

        //get the mailer from the DB
        int mailerID = Convert.ToInt16(Message.MailerToCustomer);
        Email mailer = new Email(mailerID);

        //overriding the base DB template
        //using a nicely formatted HTML one...

        //load up the template
        //there is a text template too...
        string template=Utility.GetFileText("MailerTemplates/OrderConfirm.htm");

        if (template.Length > 0)
        {
            //run some tag replacements. First with the name
            string sMessage = template;
            sMessage = sMessage.Replace("#NAME#", order.FirstName + " " + order.LastName);

            //ordernumber
            sMessage = sMessage.Replace("#ORDERINFO#", order.ToHtml());

            //admin email
            sMessage = sMessage.Replace("#STOREEMAIL#", "<a href='mailto:"+mailer.FromEmail+"'>"+mailer.FromEmail+"</a>");

            //tagline
            sMessage = sMessage.Replace("#TAGLINE#", "<b>" + Resources.Common.Slogan + "</b>");
           
            //link
            sMessage = sMessage.Replace("#LINK#", "<a href='" + Utility.GetSiteRoot() + "'>" + Resources.Common.OurStore + "</a>");

            //setup the mailer
            mailer.MessageBody = sMessage;
            mailer.ToList = order.Email;


            //send it off!
            bOut= Email.SendEmail(mailer);

        }
        return bOut;
    }
}
