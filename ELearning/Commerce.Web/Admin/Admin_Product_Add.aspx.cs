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

public partial class Admin_Admin_Product_Add : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadDropDowns();
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        
        Commerce.Common.Product product = new Commerce.Common.Product();

        product.AdminComments = txtAdminComments.Text;
        product.CurrencyCode = txtCurrencyCode.Text;
        product.DimensionUnit = txtDimensionUnit.Text;
        product.Height = decimal.Parse(txtHeight.Text);
        product.Length = decimal.Parse(txtLength.Text);
        product.ListOrder = int.Parse(txtListOrder.Text);
        product.ManufacturerID = int.Parse(ddlManufactureID.SelectedValue);
        product.ProductName = txtProductName.Text;
        product.ProductType = (ProductType)int.Parse(ddlProductTypeID.SelectedValue);
        product.ShipEstimateID = int.Parse(ddlShipEstimateID.SelectedValue);
        product.ShippingType = (ShippingType)int.Parse(ddlShippingTypeID.SelectedValue);
        product.ShortDescription = txtShortDescription.Text;
        product.Sku = txtSku.Text;
        product.Status = (ProductStatus)int.Parse(ddlStatusID.SelectedValue);
        product.StockLocation = txtStockLocation.Text;
        product.TaxTypeID = int.Parse(ddlTaxTypeID.SelectedValue);
        product.UnitOfMeasure = txtUnitOfMeasure.Text;
        
        //default this to avoid division errors
        product.TotalRatingVotes = 1;
        product.RatingSum = 4;

        //Thanks Herman (osi_ni) for this contribution
        decimal _Dec=0;
        int _LO=0;
        decimal _Weight=0;
        decimal _Width=0;
        decimal _ourPrice=0;
        decimal _retailPrice=0;
       
        product.OurPrice = (decimal.TryParse(txtOurPrice.Text, out _Dec) ? _ourPrice : 0);
        product.RetailPrice = (decimal.TryParse(txtRetailPrice.Text, out _Dec) ? _retailPrice : 0);
        
        product.Height = (decimal.TryParse(txtHeight.Text, out _Dec) ? _Dec : 0);
        product.Weight = (decimal.TryParse(txtWeight.Text, out _Weight) ? _Weight : 0);
        product.Width = (decimal.TryParse(txtWidth.Text, out _Width) ? _Width : 0);
        product.ListOrder = (int.TryParse(txtListOrder.Text, out _LO) ? _LO : 0);

        //save it up and redirect
        try
        {
            product.Save(Utility.GetUserName());
        }
        catch(Exception x)
        {
            ResultMessage1.ShowFail(x.Message);
        }

        //send to the detail page
        Response.Redirect("admin_product_details.aspx?id=" + product.ProductID.ToString());
    }
    void LoadDropDowns()
    {
        Utility.LoadListItems(ddlManufactureID.Items, Lookups.GetList("CSK_Store_Manufacturer"), "manufacturer", "manufacturerid", "", true);
        Utility.LoadListItems(ddlStatusID.Items, Lookups.GetList("CSK_Store_ProductStatus"), "status", "statusid", "", true);
        Utility.LoadListItems(ddlProductTypeID.Items, Lookups.GetList("CSK_Store_ProductType"), "producttype", "producttypeid", "", true);
        Utility.LoadListItems(ddlShippingTypeID.Items, Lookups.GetList("CSK_Store_ShippingType"), "shippingtype", "shippingtypeid", "", true);
        Utility.LoadListItems(ddlShipEstimateID.Items, Lookups.GetList("CSK_Store_ShippingEstimate"), "shippingestimate", "shipestimateid", "", true);
        Utility.LoadListItems(ddlTaxTypeID.Items, Lookups.GetList("CSK_Tax_Type"), "taxtype", "taxtypeid", "", true);

    }

    protected void btnQuickMan_Click(object sender, EventArgs e)
    {
        Lookups.QuickAdd("CSK_Store_Manufacturer","manufacturer",txtQuickMan.Text);
        txtQuickMan.Text = "";
        this.LoadDropDowns();
        ddlManufactureID.SelectedIndex = ddlManufactureID.Items.Count - 1;
    }
}
