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

public partial class Modules_Content_InlineRichEditor : System.Web.UI.UserControl
{

    public int Height = 100;
    public int Width = 400;
    public string Title;
    private string text;

    public string Text
    {
        get { return txtContent.Text; }
        set { txtContent.Text = value; }
    }
	
    protected void Page_Load(object sender, EventArgs e)
    {
        txtContent.Height = Height;
        txtContent.Width = Width;
    }
}
