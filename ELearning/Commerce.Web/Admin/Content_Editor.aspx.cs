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
using Commerce.Providers;

public partial class Admin_Content_Editor : System.Web.UI.Page
{
    protected string ContentName = "";
    protected string ContentText = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        ContentName = Commerce.Common.Utility.GetParameter("id");
        if (!Page.IsPostBack)
        {
            if (ContentName != string.Empty)
            {

                TextEntry text = ContentService.ContentGet(ContentName);
                if (text.Content != null)
                {
                    txtContent.Text = text.Content;
                }

            }
        }

    }


    protected void btnSave_Click(object sender, System.EventArgs e)
    {
        ContentService.ContentSave(ContentName, "", txtContent.Text);
        ResultMessage1.ShowSuccess(Resources.Admin.ContentSaved);
    }
}
