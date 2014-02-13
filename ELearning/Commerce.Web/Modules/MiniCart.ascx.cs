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

public partial class Modules_MiniCart : System.Web.UI.UserControl
{
    protected Order currentOrder;
    protected Boolean tieneDigitalesYaComprados;
    protected void Page_Load(object sender, EventArgs e)
    {
        //currentOrder = OrderController.GetCurrentOrder();

        OrderItemCollection items=OrderController.GetCartItems();
        rptBasket.DataSource = items;
        rptBasket.DataBind();

        decimal dTotal = 0;
        foreach (OrderItem item in items)
        {
            dTotal += item.LineTotal;
        }

        lblSubtotal.Text = dTotal.ToString("c");
        int orderID = OrderController.GetCartOrderID();
        tieneDigitalesYaComprados = ProductController.GetCountProductosCarritoCompradosDigitales(orderID) > 0;

    }
    protected void DeleteItem(object sender, RepeaterCommandEventArgs e)
    {
        Label lblProductID = (Label)e.Item.FindControl("lblProductID");
        Label lblSelectedAtts = (Label)e.Item.FindControl("lblSelectedAtts");

        if (lblProductID != null && lblSelectedAtts!=null)
        {
            OrderController.RemoveItem(int.Parse(lblProductID.Text));
        }
        Response.Redirect("basket.aspx");
    }
}
