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
using Commerce.Common;

public partial class Catalog : System.Web.UI.Page
{
    protected string thisLink = "";
    protected string categoryName = "";
    protected int categoryID = 0;
    DataSet ds = null;

    protected void Page_Load(object sender, EventArgs e)
    {

        
        //this page can be accessed using a CategoryID (cid)
        //or by categoryName using the UrlRewriter

        categoryID = Utility.GetIntParameter("cid");
        categoryName = Utility.GetParameter("n");
        
        //if (!Page.IsPostBack)
            LoadData();
        

        //###############################################################################
        //  Page Validators - these must be implemented or they will be redirected
        //###############################################################################
        try
        {
            TestCondition.IsTrue(ds.Tables.Count == 6, Resources.Common.InvalidQuery);
            TestCondition.IsTrue(ds.Tables[0].Rows.Count > 0, Resources.Common.InvalidQuery);
        }
        catch
        {
            //if they don't have a current order but somehow wandered this way
            //well they can't really do much. So send them back the home page
            Response.Redirect(Page.ResolveUrl("~/404.aspx"));
        }
        //##############################################################################

        //track this
        TickStats();
        LoadPage();



    }
    void TickStats()
    {
        //add to viewer
        Commerce.Stats.Tracker.Add(Commerce.Stats.BehaviorType.BrowsingCategory, categoryID);
        Profile.FavoriteCategories.AddCategory(categoryID, categoryName);

    }

    void LoadData()
    {
        //this page will bounce if the dataset didn't fire properly

        if (categoryName != string.Empty)
        {
            ds = CategoryController.GetPageByName(categoryName);
            thisLink = Page.ResolveUrl("~/catalog/" + categoryName + ".aspx");
        }
        else if (categoryID != 0)
        {
            ds = CategoryController.GetPageByID(categoryID);

        }

    }

    void LoadPage()
    {
        categoryID = (int)ds.Tables[0].Rows[0]["categoryID"];
        categoryName = ds.Tables[0].Rows[0]["categoryName"].ToString();
        
        BindCategoryInfo();
        BindProductList();
        BindSubs();
        BindPriceList();
        BindManList();
        LoadCrumbs();

    }
    void BindCategoryInfo()
    {
        Category category = new Category();
        category.Load(ds.Tables[0]);

        lblSubHead.Text = category.CategoryName;

        if (category.ImageFile != string.Empty)
        {
            imgHead.ImageUrl = category.ImageFile;
        }
        else
        {
            imgHead.Visible = false;
        }
        lblDescription.Text = category.LongDescription;

    }
    void BindProductList()
    {
        
        //the product list is effected by 2 things
        //if it's a straight cateogry view or
        //a "Narrow By" view
        int manID = Utility.GetIntParameter("m");
        string sPriceStart = Utility.GetParameter("ps");
        string sPriceEnd = Utility.GetParameter("pe");
        decimal priceStart = 0;
        decimal priceEnd = 0;

        if (sPriceStart != string.Empty)
            priceStart = decimal.Parse(sPriceStart);


        if (sPriceEnd != string.Empty)
            priceEnd = decimal.Parse(sPriceEnd);

        //if the manufacturer or the price range was sent in
        //grab the reader and use it to populate the product list
        if (manID > 0)
        {
            dtProducts.DataSource = ProductController.GetByManufacturerID(categoryID,manID);
        }
        else if (priceStart > 0 && priceEnd > 0)
        {

            dtProducts.DataSource = ProductController.GetByPriceRange(categoryID, priceStart, priceEnd);

        }
        else
        {
            dtProducts.DataSource = ds.Tables[4];

        }


        dtProducts.DataBind();
    }
    void BindSubs()
    {
        rptSubs.DataSource = ds.Tables[1];
        rptSubs.DataBind();

    }
    void BindPriceList()
    {
        rptPriceRanges.DataSource = ds.Tables[3];
        rptPriceRanges.DataBind();

    }
    void BindManList(){
                
        rptManList.DataSource = ds.Tables[2];
        rptManList.DataBind();
    }
    void LoadCrumbs()
    {
        DataRow dr;
        int lastCount = 0;
        for (int i = 0; i < ds.Tables[5].Rows.Count - 1; i++)
        {
            dr = ds.Tables[5].Rows[i];
            //lblBreadCrumb.Text += " <a href='" + Page.ResolveUrl("~/catalog/") + dr["Category"].ToString() + ".aspx'>" + dr["Category"] + "</a> >>> ";
            lblBreadCrumb.Text += " <a href='" + Utility.GetRewriterUrl("catalog", dr["Category"].ToString(), "") + "'>" + dr["Category"] + "</a> >>> ";
            lastCount++;

        }
        lblBreadCrumb.Text += ds.Tables[5].Rows[lastCount]["Category"].ToString();

    }
}
