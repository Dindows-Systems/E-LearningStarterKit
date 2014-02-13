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

public partial class Receipt : System.Web.UI.Page
{
    protected Commerce.Common.Order order;
    protected void Page_Load(object sender, EventArgs e)
    {
        string orderGuid = Commerce.Common.Utility.GetParameter("t");
        if (orderGuid != string.Empty) {
            order = OrderController.GetOrder(orderGuid);
            lblReceipt.Text = order.ToHtml();
            if (!IsPostBack)
                BankDepositNumberTextBox.Text = order.BankDepositNumber.Trim();
        } else {
            lblReceipt.Text = "<h1>" + Resources.Common.InvalidOrder2 + "</h1>";
       
        }
        if (!IsPostBack)
        {
            if (!string.IsNullOrEmpty(order.BankDepositNumber.Trim()))
            {
                BankDepositNumberTextBox.Enabled = false;
                SaveDepositNumberButton.Enabled = false;
            }
        }
    }

    protected void PayOrderButton_Click(object sender, EventArgs e)
    {
        order.BankDepositNumber = BankDepositNumberTextBox.Text.Trim();
        order.Save(System.Threading.Thread.CurrentPrincipal.Identity.Name);
        DepositNumberSavedLabel.Text = Resources.PaymentInfo.DepositNumberSaved;
        BankDepositNumberTextBox.Enabled = false;
        SaveDepositNumberButton.Enabled = false;
    }
}
