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

public partial class Modules_Admin_ProductDescriptors : System.Web.UI.UserControl
{
    private int productID;

    public int ProductID
    {
        get {

            return productID; 
        }
        set {
            
            productID = value; 
        }
    }
	
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            lblProductID.Text = productID.ToString();
            LoadDescriptors();
        }
    }
    void LoadDescriptors()
    {
        rptDescriptors.DataSource = ProductController.GetDescriptors(int.Parse(lblProductID.Text));
        rptDescriptors.DataBind();

    }
    protected string GetDescriptorList(object descriptor, object isBulletedList)
    {
        string sOut = descriptor.ToString();

        if ((bool)isBulletedList)
        {
            string[] sList = sOut.Split('\r');
            sOut = "<ul>";
            foreach (string s in sList)
            {
                sOut += "<li>" + s + "</li>";
            }
            sOut += "</ul>";
        }

        return sOut;
    }
    protected void DeleteDescriptor(object sender, RepeaterCommandEventArgs e)
    {
        if (e.CommandArgument != null)
        {

            int descriptorID = Convert.ToInt16(e.CommandArgument.ToString());
            //delete it out
            if (e.CommandName == "Save")
            {
                //update the text and checkbox
                CheckBox chkIsBulleted = (CheckBox)e.Item.FindControl("chkIsBulletedList");
                TextBox txtDesc = (TextBox)e.Item.FindControl("txtDescriptor");
                TextBox txtListOrder = (TextBox)e.Item.FindControl("txtDescriptorListOrder");
                if (chkIsBulletedList != null && txtDescriptor != null)
                {
                    ProductDescriptor pd = new ProductDescriptor(descriptorID);
                    pd.IsBulletedList = chkIsBulleted.Checked;
                    pd.Descriptor = txtDesc.Text;

                    try
                    {
                        pd.ListOrder = int.Parse(txtListOrder.Text);
                    }
                    catch
                    {

                    }
                    pd.Save(Utility.GetUserName());
                }
            }
            else
            {
                ProductDescriptor.Delete(descriptorID);

            }
            LoadDescriptors();

        }
    }
    protected void btnSaveDescriptor_Click(object sender, EventArgs e)
    {
        //add in the new desc list
        ProductDescriptor pd = new ProductDescriptor();
        try
        {
            pd.ListOrder = int.Parse(txtDescriptorListOrder.Text);
        }
        catch
        {

        }
        pd.Title = txtDescriptorTitle.Text;
        pd.Descriptor = txtDescriptor.Text;
        pd.IsBulletedList = chkIsBulletedList.Checked;
        pd.ProductID = int.Parse(lblProductID.Text);
        pd.Save(Utility.GetUserName());
        LoadDescriptors();
    }

}
