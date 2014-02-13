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
using System.Globalization;

public partial class Admin_Admin_Product_Details : System.Web.UI.Page {
    int productID = 0;
    protected void Page_Load(object sender, EventArgs e) {
        productID = Utility.GetIntParameter("id");
        SetNumericBoxesCulture();
        if (!Page.IsPostBack) {
            if(productID!=0)
                LoadEditor();
            TogglePanel(pnlMain);
        }

    }

    private void SetNumericBoxesCulture()
    {
        txtOurPrice.DecimalSign = CultureInfo.CurrentCulture.NumberFormat.NumberDecimalSeparator;
        txtOurPrice.GroupingSeparator = CultureInfo.CurrentCulture.NumberFormat.NumberGroupSeparator;
        txtRetailPrice.DecimalSign = CultureInfo.CurrentCulture.NumberFormat.NumberDecimalSeparator;
        txtRetailPrice.GroupingSeparator = CultureInfo.CurrentCulture.NumberFormat.NumberGroupSeparator;
        txtWeight.DecimalSign = CultureInfo.CurrentCulture.NumberFormat.NumberDecimalSeparator;
        txtWeight.GroupingSeparator = CultureInfo.CurrentCulture.NumberFormat.NumberGroupSeparator;
        txtLength.DecimalSign = CultureInfo.CurrentCulture.NumberFormat.NumberDecimalSeparator;
        txtLength.GroupingSeparator = CultureInfo.CurrentCulture.NumberFormat.NumberGroupSeparator;
        txtWidth.DecimalSign = CultureInfo.CurrentCulture.NumberFormat.NumberDecimalSeparator;
        txtWidth.GroupingSeparator = CultureInfo.CurrentCulture.NumberFormat.NumberGroupSeparator;
        txtHeight.DecimalSign = CultureInfo.CurrentCulture.NumberFormat.NumberDecimalSeparator;
        txtHeight.GroupingSeparator = CultureInfo.CurrentCulture.NumberFormat.NumberGroupSeparator;
    }

    #region Add Loader
    void LoadAddForm() {
        LoadDropDowns();
        btnDelete.Visible = false;
        btnSave.Text = Resources.Admin.Add;
        lblProductName.Text = Resources.Admin.AddNewProduct;
    }

    #endregion
    void LoadDropDowns() {
        Utility.LoadListItems(ddlManufactureID.Items, Lookups.GetList("CSK_Store_Manufacturer"), "manufacturer", "manufacturerid", "", true);
        Utility.LoadListItems(ddlStatusID.Items, Lookups.GetList("CSK_Store_ProductStatus"), "status", "statusid", "", true);
        Utility.LoadListItems(ddlProductTypeID.Items, Lookups.GetList("CSK_Store_ProductType"), "producttype", "producttypeid", "", true);
        Utility.LoadListItems(ddlShippingTypeID.Items, Lookups.GetList("CSK_Store_ShippingType"), "shippingtype", "shippingtypeid", "", true);
        Utility.LoadListItems(ddlShipEstimateID.Items, Lookups.GetList("CSK_Store_ShippingEstimate"), "shippingestimate", "shipestimateid", "", true);
        Utility.LoadListItems(ddlTaxTypeID.Items, Lookups.GetList("CSK_Tax_Type"), "taxtype", "taxtypeid", "", true);

    }

    #region Editor Loader
    void LoadEditor() {
        //load the drops
        btnDelete.Visible = true;
        btnDelete.Attributes.Add("onclick", "return CheckDelete();");
        btnSave.Text = Resources.Admin.Update;
        //load the rest
        LoadDropDowns();
        LoadEditData();
        lblID.Text = productID.ToString();

        //load up the images
        LoadImages();
        LoadCategories();
        //LoadCatList();
        LoadCrossProducts();
        LoadDescriptors();

    }
    void LoadDescriptors()
    {
        ProductDescriptors1.ProductID = productID;
    }

    void LoadCategories() {
        ProductCategories1.LoadCategories(productID);
    }
    void LoadCrossProducts() {
        ProductCrossSells1.LoadCrossProducts(productID);
    }


    void LoadImages() {
        ProductImages1.LoadImages(productID);

    }


    void LoadEditData() {
        Commerce.Common.Product product = new Commerce.Common.Product(productID);
        ProductAttributes1.LoadAttributes(product);
        LoadDropDowns();

        //Page Title ... 
        this.Title = string.Format( Resources.Admin.ProductDetails, product.ProductName);

        lblID.Text = productID.ToString();
        txtSku.Text = product.Sku;
        txtProductName.Text = product.ProductName;
        lblProductName.Text = product.ProductName;
        txtShortDescription.Text = product.ShortDescription;
        
        ddlManufactureID.SelectedValue = product.ManufacturerID.ToString();
        ddlStatusID.SelectedValue = Convert.ToInt16(product.Status).ToString();
        ddlProductTypeID.SelectedValue = Convert.ToInt16(product.ProductType).ToString();
        ddlShippingTypeID.SelectedValue = Convert.ToInt16(product.ShippingType).ToString();
        ddlShipEstimateID.SelectedValue = product.ShipEstimateID.ToString();
        ddlTaxTypeID.SelectedValue = product.TaxTypeID.ToString();
        
        txtStockLocation.Text = product.StockLocation;
        txtOurPrice.Text = product.OurPrice.ToString();
        txtRetailPrice.Text = product.RetailPrice.ToString();
        txtWeight.Text = product.Weight.ToString();
        txtCurrencyCode.Text = product.CurrencyCode;
        txtUnitOfMeasure.Text = product.UnitOfMeasure;
        txtAdminComments.Text = product.AdminComments;
        txtLength.Text = product.Length.ToString();
        txtHeight.Text = product.Height.ToString();
        txtWidth.Text = product.Width.ToString();
        txtDimensionUnit.Text = product.DimensionUnit;
        txtListOrder.Text = product.ListOrder.ToString();
    }
    #endregion


    #region Event Handlers

    protected void btnCancel_Click(object sender, System.EventArgs e) {
        Response.Redirect(Request.Url.PathAndQuery);
    }


    protected void cmdAdd_Click(object sender, System.EventArgs e) {
        LoadAddForm();
    }
    protected void btnDelete_Click(object sender, EventArgs e) {
        //Commerce.Common.Product.Delete(int.Parse(lblID.Text));
        ProductController.DeletePermanent(int.Parse(lblID.Text));
        Response.Redirect("admin_products.aspx");
    }
    protected void btnSave_Click(object sender, System.EventArgs e) {

        Commerce.Common.Product product = null;
        if (lblID.Text != string.Empty)
        {
            product = new Commerce.Common.Product(int.Parse(lblID.Text));
        }
        else
        {
            product = new Commerce.Common.Product();
        }
        product.AdminComments = txtAdminComments.Text;
        product.CurrencyCode = txtCurrencyCode.Text;
        product.DimensionUnit = txtDimensionUnit.Text;
        product.Height = decimal.Parse(txtHeight.Text);

        product.Length = decimal.Parse(txtLength.Text);
        product.ListOrder = int.Parse(txtListOrder.Text);
        product.ManufacturerID = int.Parse(ddlManufactureID.SelectedValue);
        product.OurPrice = decimal.Parse(txtOurPrice.Text);
        product.ProductName = txtProductName.Text;
        product.ProductType =(ProductType)int.Parse(ddlProductTypeID.SelectedValue);
        product.RetailPrice = decimal.Parse(txtRetailPrice.Text);
        product.ShipEstimateID = int.Parse(ddlShipEstimateID.SelectedValue);
        product.ShippingType = (ShippingType)int.Parse(ddlShippingTypeID.SelectedValue);
        product.ShortDescription = txtShortDescription.Text;
        product.Sku = txtSku.Text;
        product.Status = (ProductStatus)int.Parse(ddlStatusID.SelectedValue);
        product.StockLocation = txtStockLocation.Text;
        product.TaxTypeID = int.Parse(ddlTaxTypeID.SelectedValue);
        product.UnitOfMeasure = txtUnitOfMeasure.Text;
        product.Weight = decimal.Parse(txtWeight.Text);
        product.Width = decimal.Parse(txtWidth.Text);

        
        try {
            product.Save(Utility.GetUserName());
            ResultMessage1.ShowSuccess(Resources.Admin.UpdateSuccessful);
        } catch (Exception x) {
            ThrowError(x.Message);
        }

    }
    #endregion

    #region Error Handling
    void ThrowError(string message) {
        ResultMessage1.ShowFail(message);
    }


    #endregion


 
    protected void btnQuickMan_Click(object sender, EventArgs e) {
        if (txtQuickMan.Text != string.Empty)
        {
            Lookups.QuickAdd("CSK_Store_Manufacturer", "manufacturer", txtQuickMan.Text);
            txtQuickMan.Text = "";
            this.LoadDropDowns();
            ddlManufactureID.SelectedIndex = ddlManufactureID.Items.Count - 1;

        }
    }

    
    void TogglePanelsOff()
    {
        pnlMain.Visible = false;
        pnlImages.Visible = false;
        pnlCross.Visible = false;
        pnlCategories.Visible = false;
        pnlCategories.Visible = false;
        pnlDescriptions.Visible = false;
        pnlAtts.Visible = false;
        pnlModulos.Visible = false;// Alex Armijos

    }
    void TogglePanel(Panel pnl)
    {
        TogglePanelsOff();
        pnl.Visible = true;
    }
    protected void lnkMain_Click(object sender, EventArgs e)
    {
        TogglePanel(pnlMain);
    }
    protected void lnkCat_Click(object sender, EventArgs e)
    {
        TogglePanel(pnlCategories);

    }
    protected void lnkAtt_Click(object sender, EventArgs e)
    {
        TogglePanel(pnlAtts);
       

    }
    protected void lnkImages_Click(object sender, EventArgs e)
    {
        TogglePanel(pnlImages);

    }
    protected void lnkCross_Click(object sender, EventArgs e)
    {
        TogglePanel(pnlCross);

    }
    protected void lnkDesc_Click(object sender, EventArgs e)
    {
        TogglePanel(pnlDescriptions);
    }

    // Alex Armijos:
    protected void lnkModulos_Click(object sender, EventArgs e)
    {
        TogglePanel(pnlModulos);
    }

}
