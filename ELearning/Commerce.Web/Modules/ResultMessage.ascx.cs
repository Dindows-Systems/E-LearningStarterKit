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

public partial class ResultMessage : System.Web.UI.UserControl {
    protected void Page_Load(object sender, EventArgs e) {

    }
    public void ShowSuccess(string message) {
        tblResult.Visible = true;
        trSuccess.Visible = true;
        trFail.Visible = false;
        lblSuccess.Text = message;
    }
    public void ShowFail(string message) {
        tblResult.Visible = true;
        trSuccess.Visible = false;
        trFail.Visible = true;
        lblFail.Text = message;

    }
    protected string GetPath() {
        string sPath = Request.ApplicationPath;
        if (sPath == "/") {
            sPath = "";
        }
        return sPath;
    }
}
