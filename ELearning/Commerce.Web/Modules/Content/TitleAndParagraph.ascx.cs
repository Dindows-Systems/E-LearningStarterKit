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

public partial class Modules_Content_TitleAndParagraph : System.Web.UI.UserControl {
    public bool CanEdit = false;
    public string ContentName = "";
    public DataTable LoadTable;
    public string Title = "";
    public string ContentText;
    protected void Page_Load(object sender, EventArgs e) {
        CanEdit = Page.User.IsInRole("Administrator");
        pnlCommand.Visible = false;

        ToggleEditor(false);
        //if(!Page.IsPostBack){
        try {
            if (LoadTable != null) {

                lblTitle.Text = LoadTable.Rows[0]["title"].ToString();
                lblContent.Text = LoadTable.Rows[0].ToString();

            } else {
                if (ContentName != string.Empty) {
                    TextEntry text = ContentService.ContentGet(ContentName);
                    Title = text.Title;
                    ContentText = text.Content;
                    lblTitle.Text = text.Title;
                    lblContent.Text = text.Content;
                } else {
                    lblTitle.Text = "Set both the ContentID and PageName";
                }
            }
        } catch {

        }
    }
    void ToggleEditor(bool show) {
        tblEdit.Visible = show;
        pnlContent.Visible = !show;

    }

    protected void btnEdit_Click(object sender, System.EventArgs e) {
        ToggleEditor(true);
        //load up the content to edit
        TextEntry text = Commerce.Providers.ContentService.ContentGet(ContentName);

        txtTitle.Text = text.Title;
        txtContent.Text = text.Content;

    }

    protected void btnCancel_Click(object sender, System.EventArgs e) {
        ToggleEditor(false);
    }

    protected void btnSave_Click(object sender, System.EventArgs e) {
        //save the content up
        Commerce.Providers.ContentService.ContentSave(ContentName, txtTitle.Text, txtContent.Text);
        Response.Redirect(Request.Url.PathAndQuery);

    }
}
