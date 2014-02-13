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

public partial class Admin_Admin_Orders : System.Web.UI.Page {
    protected void Page_Load(object sender, EventArgs e) {
        if (!Page.IsPostBack) {
            calStart.SelectedDate = DateTime.Today.Subtract(TimeSpan.FromDays(30));
            calEnd.SelectedDate = DateTime.Today;
            LoadOrders();
        }
    }
    void LoadOrders()
    {
        string sName = txtName.Text;
        string orderNumber = txtOrderNumber.Text;

        //pad the end date by 1 day to make sure all of today's orders go in
        GridView1.DataSource = OrderController.GetAllByFilter(calStart.SelectedDate, calEnd.SelectedDate.AddDays(1),sName,orderNumber);
        GridView1.DataBind();

    }
    protected void btnDates_Click(object sender, EventArgs e) {
        LoadOrders();
    }
}
