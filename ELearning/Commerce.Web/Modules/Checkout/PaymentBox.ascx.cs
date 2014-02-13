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

public partial class Modules_Checkout_PaymentBox : System.Web.UI.UserControl
{


    private string ccNumber;

    public string CCNumber
    {
        get { return txtCCNumber.Text; }
    }
    private int expMonth;

    public int ExpirationMonth
    {
        get {
            int iOut = 0;
            int.TryParse(ddlExpMonth.SelectedValue, out iOut);
            return iOut;
        }
    }
    private CreditCardType ccType;

    public CreditCardType CCType
    {
        get {
                 return (CreditCardType)int.Parse(ddlCCType.SelectedValue);
        }
    }
	
    private int expYear;

    public int ExpirationYear
    {
        get {
            int iOut = 0;
            int.TryParse(ddlExpYear.SelectedValue, out iOut);
            return iOut;
        }
    }
    private string securityCode;

    public string SecurityCode
    {
        get { return txtCCAuthCode.Text; }
    }

    public PaymentMethod PaymentMethodId
    {
        get { return (PaymentMethod)short.Parse(PaymentMethodDropDownList.SelectedValue); }
    }
	
	

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadExpirationYear();
        }
    }
    void LoadExpirationYear()
    {

        if (ddlExpYear != null)
        {
            for (int i = DateTime.Now.Year; i < DateTime.Now.Year + 6; i++)
            {
                ddlExpYear.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }
        }
    }

    protected void PaymentMethodDropDownList_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (PaymentMethodDropDownList.SelectedValue == "1")
            CreditCardPanel.Visible = true;
        else
            CreditCardPanel.Visible = false;
    }
}
