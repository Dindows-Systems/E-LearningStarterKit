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

public partial class Modules_Content_Paragraph : System.Web.UI.UserControl
{
    public bool CanEdit = false;
    public string ContentName = "";
    public DataTable LoadTable;
    public string Title = "";
    protected string ContentText = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        CanEdit = Page.User.IsInRole("Administrator");
        if (ContentName != string.Empty)
        {
            if (LoadTable != null)
            {

                ContentText = LoadTable.Rows[0]["content"].ToString();

            }
            else
            {
                TextEntry text = ContentService.ContentGet(ContentName);
                if (text.Content != null)
                {
                    ContentText = text.Content;
                }
            }
        }
        else
        {
            ContentText = Resources.Controls.SetContentIdAndPageName;
        }

    }
}

