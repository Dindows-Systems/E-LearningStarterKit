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

public partial class Modules_Admin_ProductCategories : System.Web.UI.UserControl {
    protected void Page_Load(object sender, EventArgs e) {

    }
    int catLevel = 0;
    private void BuildCategoryList(DataSet ds) {

        ds.Relations.Add("NodeRelation", ds.Tables[0].Columns["categoryID"], ds.Tables[0].Columns["parentID"], false);

        foreach (DataRow dbRow in ds.Tables[0].Rows) {
					if(int.Parse(dbRow["parentID"].ToString()) == 0) {
                catLevel = 0;
                ddlCats.Items.Add(new ListItem(dbRow["categoryName"].ToString(), dbRow["categoryID"].ToString()));
                PopulateSubTree(dbRow);
            }
        }

    }
    private void PopulateSubTree(DataRow dbRow) {
        catLevel++;
        foreach (DataRow childRow in dbRow.GetChildRows("NodeRelation")) {
            ddlCats.Items.Add(new ListItem("---" + childRow["categoryName"].ToString(), childRow["categoryID"].ToString()));
            PopulateSubTree(childRow);
        }
    }
    public void LoadCategories(int productID) {
        lblID.Text = productID.ToString();
        DataSet ds = CategoryController.GetDataSetList(); ;
        BuildCategoryList(ds);
        LoadCatList();

    }
    void LoadCatList() {
        dgCats.DataSource = CategoryController.GetByProductID(int.Parse(lblID.Text));
        dgCats.DataBind();
    }

    protected void DeleteCat(object source, DataGridCommandEventArgs e) {
        string sCatID = e.Item.Cells[0].Text;
        ProductController.RemoveFromCategory(int.Parse(lblID.Text),int.Parse(sCatID));
        LoadCatList();
    }
    protected void btnCats_Click(object sender, EventArgs e) {
        ProductController.AddToCategory(int.Parse(lblID.Text),int.Parse(ddlCats.SelectedValue));
        LoadCatList();

    }
}
