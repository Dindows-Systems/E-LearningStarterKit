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
using WekeRoad.Tools;

public partial class Admin_Content_Ad_Editor : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        string adID = Commerce.Common.Utility.GetParameter("id");
        string pageName = Commerce.Common.Utility.GetParameter("pn");
        string placement = Commerce.Common.Utility.GetParameter("pl");
        ViewState.Add("pageName", pageName);
        ViewState.Add("placement", placement);
        btnDelete.Visible = false;
        if (!Page.IsPostBack) {
            LoadProducts();
            LoadCategories();
        }        
        if (adID != string.Empty)
        {
            btnDelete.Visible = true;
            btnDelete.Attributes.Add("onclick", "return CheckDelete();");
            ViewState.Add("adID", adID);
            if (!Page.IsPostBack)
            {
                Commerce.Common.Ad ad = new Commerce.Common.Ad(int.Parse(adID));
                txtAdText.Text = ad.AdText;

                ddlCategoryID.SelectedValue = ad.CategoryID.ToString();
                ddlProductID.SelectedValue = ad.ProductSku;
            }
        }


        
    }
    void LoadProducts() {

        ddlProductID.DataSource = Commerce.Common.Product.FetchAll(OrderBy.Asc("productName"));
        ddlProductID.DataTextField = "productName";
        ddlProductID.DataValueField = "sku";
        ddlProductID.DataBind();
        //truncate the list if it's really long
        foreach (ListItem l in ddlProductID.Items) {
            if (l.Text.Length > 50) {
                l.Text = l.Text.Substring(0, 50) + "...";
            }
        }
        ListItem item = new ListItem(Resources.Admin.None, "0");
        ddlProductID.Items.Insert(0, item);
    }
    void LoadCategories() {
        DataSet ds = CategoryController.GetDataSetList();
        
        BuildCategoryList(ds);

        ListItem item = new ListItem(Resources.Admin.None, "0");
        ddlCategoryID.Items.Insert(0, item);

    }
    private void PopulateSubTree(DataRow dbRow) {
        catLevel++;
        foreach (DataRow childRow in dbRow.GetChildRows("NodeRelation")) {
            ddlCategoryID.Items.Add(new ListItem("---" + childRow["categoryName"].ToString(), childRow["categoryID"].ToString()));

            //Response.Write("&nbsp;&nbsp;&nbsp;"+catLevel.ToString()+" Child is "+childRow["categoryName"].ToString()+"<br>");
            PopulateSubTree(childRow);
        }
    }
    int catLevel;
    private void BuildCategoryList(DataSet ds) {

        ds.Relations.Add("NodeRelation", ds.Tables[0].Columns["categoryID"], ds.Tables[0].Columns["parentID"], false);

        foreach (DataRow dbRow in ds.Tables[0].Rows) {
					if(int.Parse(dbRow["parentID"].ToString()) == 0) {
                catLevel = 0;
                ddlCategoryID.Items.Add(new ListItem(dbRow["categoryName"].ToString(), dbRow["categoryID"].ToString()));
                PopulateSubTree(dbRow);
            }
        }

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {

        Commerce.Common.Ad ad = null; ;

        if (ViewState["adID"] != null)
        {
            int adID = int.Parse(ViewState["adID"].ToString());
            ad = new Commerce.Common.Ad(adID);

           }
        else
        {
            ad = new Commerce.Common.Ad();

        }
        ad.AdText = txtAdText.Text;
        ad.CategoryID = int.Parse(ddlCategoryID.Text);
        ad.DateExpires = DateTime.Now.AddDays(100);
        ad.PageName = ViewState["pageName"].ToString();
        ad.Placement = ViewState["placement"].ToString();
        ad.ProductSku = ddlProductID.Text;
        ad.Save(Commerce.Common.Utility.GetUserName());

        ResultMessage1.ShowSuccess(Resources.Admin.AdSaved);

    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        int adID = int.Parse(ViewState["adID"].ToString());
        Commerce.Common.Ad.Delete(adID);
        ResultMessage1.ShowSuccess(Resources.Admin.AdDeleted);
    }
}
