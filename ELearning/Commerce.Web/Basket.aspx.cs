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
public partial class Basket : System.Web.UI.Page
{
    protected DataSet ds;
    protected Boolean tieneDigitalesYaComprados = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        pnlNada.Visible = false;
        if (!Page.IsPostBack)
        {
            BindBasket();
        }
    }
    void BindBasket()
    {

        int orderID = OrderController.GetCartOrderID();
        Order currentOrder = null;
        if (orderID != 0)
        {
            currentOrder = OrderController.GetOrder(orderID);
						//Load up the no_image_available.gif image in the event there is no ImageFile
						OrderItemCollection orderItemCollection = currentOrder.Items;
						foreach(OrderItem currentItem in orderItemCollection) {

                            Commerce.Common.Product product = ProductController.GetProductDeep(currentItem.ProductID);

                            if (product.ShippingType == ShippingType.DownloadOnly && product.ProductType == ProductType.DownloadableSoftware)
                            {
                                currentItem.EsCantidadFija = Boolean.Parse("true");
                                currentItem.MensajeCantidadFija = "En productos digitales y descargables la cantidad solo puede ser uno.";
                            }
                            else {
                                currentItem.EsCantidadFija = Boolean.Parse("false");
                                currentItem.MensajeCantidadFija = "";
                            }


							if((currentItem.ImageFile == null) || (currentItem.ImageFile.Length == 0)) {
								currentItem.ImageFile = "images/ProductImages/no_image_available.gif";
							}
                }
						//Bind it up
            rptBasket.DataSource = currentOrder.Items;
            rptBasket.DataBind();
            
            if (rptBasket.Items.Count == 0)
                HideBits();

            lblSubtotal.Text = currentOrder.CalculateSubTotal().ToString("c");

            tieneDigitalesYaComprados = ProductController.GetCountProductosCarritoCompradosDigitales(orderID) > 0;

        }
        else
        {
            HideBits();
        }

    }

    void rptBasket_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        throw new Exception("The method or operation is not implemented.");
        
    }

    
    void HideBits()
    {
        btnAdjust.Visible = false;
        pnlCheckout.Visible = false;
        lblSubtotal.Visible = false;
        pnlNada.Visible = true;

        //give them something to look at, other than a blank page ;)
        dtProducts.DataSource = ProductController.GetMostPopular();
        dtProducts.DataBind();

    }
    protected void DeleteItem(object sender, RepeaterCommandEventArgs e)
    {
        Label lblProductID = (Label)e.Item.FindControl("lblProductID");
        Label lblSelectedAtts = (Label)e.Item.FindControl("lblSelectedAtts");
        if (lblProductID != null && lblSelectedAtts != null)
        {
            OrderController.RemoveItem(int.Parse(lblProductID.Text),lblSelectedAtts.Text);
        }
        Response.Redirect("Basket.aspx");
    }
    protected void AdjustBasket(object sender, System.EventArgs e)
    {
        TextBox txtQ = null;
        Label lblProductID = null;
        Label lblSelectedAtts = null;
        int productID = 0;
        int newQuantity=0;
        string selectedAtts = "";
        int orderID = OrderController.GetCartOrderID();

        foreach (RepeaterItem item in rptBasket.Items)
        {
            txtQ = (TextBox)item.FindControl("txtQuantity");
            lblSelectedAtts = (Label)item.FindControl("lblSelectedAtts");
            lblProductID = (Label)item.FindControl("lblProductID");
            if (txtQ != null && lblProductID != null)
            {
                productID=int.Parse(lblProductID.Text);
				if (int.TryParse(txtQ.Text, out newQuantity))
				{
					if (newQuantity >= 0)
					{
						selectedAtts = lblSelectedAtts.Text;
                        OrderController.AdjustQuantity(orderID,productID,selectedAtts, newQuantity);
					}
				}
            }
        }
        Response.Redirect("Basket.aspx");
    }
}
