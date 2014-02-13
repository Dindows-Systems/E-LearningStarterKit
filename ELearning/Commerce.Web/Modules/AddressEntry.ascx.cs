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

public partial class AddressEntry : System.Web.UI.UserControl
{

    Address address = null;
    private bool useAddressBook=true;

    public bool UseAddressBook
    {
        get { return useAddressBook; }
        set { useAddressBook = value; }
    }
    private string addressBookTitle;

    public string AddressBookTitle
    {
        get { return addressBookTitle; }
        set { addressBookTitle = value; }
    }
	
    public Address SelectedAddress
    {
        get { 
        
            //return the entered text bits as an address
            address = new Address();
            address.FirstName = txtFirst.Text;
            address.LastName = txtLast.Text;
            address.Address1 = txtAddress1.Text;
            address.City = txtCity.Text;
            address.Email = txtEmail.Text;
            address.Address2 = txtAddress2.Text;
            //address.Zip = txtZip.Text;
            address.Zip = "";

            //if (ddlCountry.SelectedValue == "US")
            //{
            address.StateOrRegion = ddlState.SelectedValue;

            //}
            //else
            //{
            //    address.StateOrRegion = txtState.Text;

            //}
            //address.Country = ddlCountry.SelectedValue;
            address.Country = Country.EC.ToString();
            
            return address;

        }
        set {
            address = value;
            txtFirst.Text=address.FirstName;
            txtLast.Text = address.LastName;
            txtAddress1.Text =  address.Address1;
            txtCity.Text =  address.City;
            txtEmail.Text = address.Email;
            txtAddress2.Text=address.Address2;
            //txtZip.Text=address.Zip;
            
            //if (address.Country == "US")
            //{
                ddlState.SelectedValue=address.StateOrRegion;
                ToggleStateDrop(true);
            //}
            //else
            //{
                //txtState.Text=address.StateOrRegion ;
            //    ToggleStateDrop(false);

            //}

        }
    }
	
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {
            pnlAddBook.Visible = false;
            if (useAddressBook)
            {
                dtAddresses.DataSource = OrderController.GetUserAddresses();
                dtAddresses.DataBind();
            }
            ToggleStateDrop(true);
            //ddlCountry.SelectedValue = "US";
        }
    }

    protected void SelectAddress(object sender, DataListCommandEventArgs e)
    {
        Label lblID = (Label)e.Item.FindControl("lblAddressID");
        if (lblID != null)
        {
            int shipAddressID = int.Parse(lblID.Text);
            Address shipAddress = new Address(shipAddressID);

            this.SelectedAddress = shipAddress;

        }
    }

    void ToggleStateDrop(bool showIt)
    {

        ddlState.Visible = showIt;
        valState.Visible = showIt;
        //txtState.Visible = !showIt;
    }
    protected void ddlCountry_SelectedIndexChanged(object sender, System.EventArgs e)
    {
        //if (ddlCountry.SelectedValue == "US")
        //{
            ToggleStateDrop(true);
        //}
        //else
        //{
        //    ToggleStateDrop(false);
        //}
    }

    protected void lnkToggle_Click(object sender, EventArgs e)
    {
        pnlAddBook.Visible = !pnlAddBook.Visible;
        
    }
}
