using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text;
using System.Data.SqlClient;
using System.Xml;
using Commerce.Common;

public partial class AffiliateFeed : System.Web.UI.Page
{
    private int _affiliateID;
    private int _categoryID;
    private string _connectionString;
    private string _siteUrl = "";
    private string _appPath = "";

    readonly string FEED_TITLE = Resources.Common.FeedTitle;
    readonly string FEED_DESCRIPTION = Resources.Common.FeedDescription;
    //Many thanks to Randy "Kenpo" Jones for this one!

    protected void Page_Load(object sender, EventArgs e)
    {
        _affiliateID = Convert.ToInt32(Request.QueryString["aid"]);
        _categoryID = Convert.ToInt32(Request.QueryString["catid"]);
        _connectionString = ConfigurationManager.ConnectionStrings["CommerceTemplate"].ConnectionString;
        //Get the application's URL
        if (Request.ApplicationPath == "/")
            _appPath = Request.ApplicationPath;
        else
            _appPath = Request.ApplicationPath + "/";
        _siteUrl = Request.Url.ToString();
        _siteUrl = _siteUrl.Replace(Request.Path, "") + _appPath;
        Response.Clear();
        Response.ContentType = "text/xml";
        BuildRssFeed();
    }

    public void BuildRssFeed()
    {
        XmlTextWriter rssFeed = new XmlTextWriter(Response.OutputStream, Encoding.UTF8);
        rssFeed.WriteStartDocument();
        // The mandatory rss tag
        rssFeed.WriteStartElement("rss");
        rssFeed.WriteAttributeString("version", "2.0");
        // The channel tag contains RSS feed details
        rssFeed.WriteStartElement("channel");
        rssFeed.WriteElementString("title", FEED_TITLE);
        rssFeed.WriteElementString("link", _siteUrl);
        rssFeed.WriteElementString("description", FEED_DESCRIPTION);
        rssFeed.WriteElementString("language", System.Globalization.CultureInfo.CurrentCulture.Name);

        ProductCollection products = new ProductCollection();
        IDataReader rdr = ProductController.GetByCategoryID(_categoryID);
        products.Load(rdr);
        rdr.Close();
        string imagePath = "";
        string link = "";
        foreach (Commerce.Common.Product product in products)
        {

            link = Utility.GetRewriterUrl("product", product.Sku, "aid="+_affiliateID.ToString());
            rssFeed.WriteStartElement("item");
            rssFeed.WriteElementString("title", product.ProductName);
            rssFeed.WriteElementString("description", product.ShortDescription);
            rssFeed.WriteElementString("link", link);
            rssFeed.WriteElementString("imagelink", Commerce.Common.Utility.GetSiteRoot() + "/" + product.ImageFile);
            rssFeed.WriteElementString("price", product.OurPrice.ToString("C"));
            rssFeed.WriteEndElement();

        }

        // Close all tags 
        rssFeed.WriteEndElement();
        rssFeed.WriteEndElement();
        rssFeed.WriteEndDocument();
        rssFeed.Flush();
        rssFeed.Close();
        Response.End();
    }
}
