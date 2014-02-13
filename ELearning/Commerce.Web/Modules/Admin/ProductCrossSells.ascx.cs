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
using Commerce.Promotions;
using Commerce.Common;

public partial class Modules_Admin_ProductCrossSells : System.Web.UI.UserControl {
    protected void Page_Load(object sender, EventArgs e) {

    }

    void LoadProductList(int productID)
    {

        //grab all the products
        ProductCollection prods = ProductController.GetAll();
        ListItem item;
        foreach (Product prod in prods)
        {
            item = new ListItem("<img src='" + Page.ResolveUrl("../"+prod.DefaultImage) + "' width=80px><br><b>" + prod.Sku + "</b>", prod.ProductID.ToString());
            chkProducts.Items.Add(item);
        }

        //now load the cross-products for this product, and check off the
        //bits
        ProductCollection crosses = PromotionService.GetCrossSells(productID);
        foreach (Product cross in crosses)
        {
            foreach (ListItem l in chkProducts.Items)
            {
                if (int.Parse(l.Value) == cross.ProductID)
                    l.Selected = true;
            }
        }

    }


    public void LoadCrossProducts(int productID) {
        lblID.Text = productID.ToString();
        LoadProductList(productID);
        //load the selection list
        //Utility.LoadListItems(lstCrossProductID.Items, CrossSell.GetUnassignedProducts(productID), "productName", "productID", "", true);
        //lstCrossProductID.SelectedIndex = 0;

        //load up the grid
        //rptCross.DataSource = CrossSell.GetProducts(productID);
        //rptCross.DataBind();
    }
    protected void SaveCrossList(object sender, EventArgs e) {
        //first, remove all the cross-sell bits
        int productID=Utility.GetIntParameter("id");
        Product prod = new Product(productID);
        try
        {
            prod.SaveManyToMany("CSK_Promo_Product_CrossSell_Map", "crossProductID", chkProducts.Items);
            ResultMessage1.ShowSuccess("Cross-Sells saved");
            }
        catch (Exception x)
        {
            ResultMessage1.ShowFail(x.Message);

        }
    }
}
