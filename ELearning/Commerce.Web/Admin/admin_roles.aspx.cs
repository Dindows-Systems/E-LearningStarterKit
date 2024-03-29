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

public partial class AdminUsers_admin_roles : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    public void LinkButtonClick(object sender, CommandEventArgs e)
    {
        string roleName;

        if (e.CommandName.Equals("delete"))
        {
            roleName = (string)e.CommandArgument;

            Roles.DeleteRole(roleName);
            
            Response.Redirect("admin_roles.aspx");
        }

        if (e.CommandName.Equals("add"))
        {
            roleName = txtRoleName.Text.Trim();
            if (roleName == "")
                return;

            Roles.CreateRole(roleName);

            Response.Redirect("admin_roles.aspx");
        }
    }
}
