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

public partial class Admin_Admin_Orders_Details : System.Web.UI.Page {
    protected Commerce.Common.Order order;
    
    protected void Page_Load(object sender, EventArgs e) {
      
        if(!Page.IsPostBack){
            LoadOrder();
            if (order != null)
            {
                this.Page.Title = string.Format(Resources.Admin.OrderDetailsPageTitle, order.OrderNumber);
            }
            else
            {
                lblOrderNumber.Text = Resources.Admin.InvalidOrder;
            }
        }

    }
    void LoadOrder() {
        int orderID = Commerce.Common.Utility.GetIntParameter("id");
        if (orderID != 0)
        {
            order = OrderController.GetOrder(orderID);
            dgItems.DataSource = order.Items;
            dgItems.DataBind();

            gTransactions.DataSource = order.Transactions;
            gTransactions.DataBind();
            LoadNotes();
            LoadDropDowns();
            lblOrderID.Text = order.OrderID.ToString();
            lblOrderNumber.Text = order.OrderNumber;
        }
    }
    void LoadNotes() {
            gNotes.DataSource = order.Notes;
            gNotes.DataBind();
    }
    void LoadDropDowns() {
        Commerce.Common.Utility.LoadListItems(ddlStatusID.Items, Lookups.GetList("CSK_Store_OrderStatus"),
            "OrderStatus", "orderStatusID", Convert.ToInt16(order.OrderStatus).ToString(), true);
    }
    protected void btnSetShipped_Click(object sender, EventArgs e) {
        try {
            LoadOrder();
            order.OrderStatus = OrderStatus.EnviadoAlCliente;
            order.ShippingTrackingNumber = txtTrackingNumber.Text;
            order.Save(Utility.GetUserName());
            SetUserAsCustomerInForums();
            uShipResult.ShowSuccess(Resources.Admin.OrderShipped);
            
            //reload the order. Hate to call it twice but there's not much we can
            //do bout that.
            LoadOrder();
        } catch (Exception x) {
            uResult.ShowFail(x.Message);
        }
    }
    protected void btnRefund_Click(object sender, EventArgs e) {

    }
    protected void btnAddNote_Click(object sender, EventArgs e) {

    }
    protected void btnCancelOrder_Click(object sender, EventArgs e) {

    }
    protected void btnSetStatus_Click(object sender, EventArgs e) {
        int statusID = int.Parse(ddlStatusID.SelectedValue);
        LoadOrder();
        order.OrderStatus = (OrderStatus)statusID;
        order.Save(Utility.GetUserName());

        // Asign Customer to Customer Group in Forums
        SetUserAsCustomerInForums();

        Response.Redirect(Request.Url.PathAndQuery);
    }

    private void SetUserAsCustomerInForums()
    {
        if (order.OrderStatus == OrderStatus.EnviadoAlCliente | order.OrderStatus == OrderStatus.EsperandoEnvioAlCliente | order.OrderStatus == OrderStatus.PagoRecibidoProcesandoOrden)
        {
            int userId = yaf.DB.user_getIdByUserName(int.Parse(ConfigurationManager.AppSettings["DefaultBoardId"]), order.UserName);
            yaf.DB.usergroup_save(userId, ConfigurationManager.AppSettings["CustomerGroupId"], true);
        }
    }
    protected void btnAddNote_Click1(object sender, EventArgs e) {
        if (txtAddNote.Text != string.Empty) {
            //Commerce.Services.StoreDataService.OrdersAddNote(int.Parse(lblOrderID.Text), txtAddNote.Text,
                //ddlStatusID.SelectedItem.Text, User.Identity.Name);
            OrderNote note = new OrderNote();
            note.OrderID = int.Parse(lblOrderID.Text);
            note.OrderStatus = ddlStatusID.SelectedItem.Text;
            note.Note = txtAddNote.Text;
            note.Save(Utility.GetUserName());
            LoadOrder();
        }
    }
    void RefundOrder() {
        bool haveError = false;
        if (order==null)
            LoadOrder();

        try {
            OrderController.Refund(order);
            uResultRefund.ShowSuccess(Resources.Admin.OrderRefunded);
        } catch (Exception x) {
            uResultRefund.ShowFail(x.Message);
           

        }

        if (!haveError)
            LoadOrder();

    }
    protected void btnCancelOrder_Click1(object sender, EventArgs e) {
        LoadOrder();
        OrderController.CancelOrder(order, txtCancelReason.Text);
        
        if (chkRefundCancelledOrder.Checked) {
            //refund the order
            RefundOrder();

        }
        Response.Redirect(Request.Url.PathAndQuery);
    }
    protected void btnRefund_Click1(object sender, EventArgs e) {
        RefundOrder();
    }
}
