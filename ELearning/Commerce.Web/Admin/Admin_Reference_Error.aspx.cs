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

public partial class Admin_Admin_Reference_Error : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Exception x = Server.GetLastError();
        ResultMessage1.ShowFail(Resources.Admin.CannotChangeRecordWithAssociatedRecords + ":<xmp style='font-face:courier;background-color:whitesmoke;font-size:10pt'>"+x.Message+"</xmp>");
        Server.ClearError();
    }
}
