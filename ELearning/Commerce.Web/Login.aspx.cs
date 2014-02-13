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
using Commerce.Stats;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;
using Commerce.Common;
using Infragistics.WebUI.WebDataInput;


public partial class Login : System.Web.UI.Page
{
        
    protected void Page_Load(object sender, EventArgs e)
    {
        string redir = Commerce.Common.Utility.GetParameter("ReturnUrl");
        string comeFromErrorLogin = Commerce.Common.Utility.GetParameter("ComeFromErrorLogin");

        if (comeFromErrorLogin != null && "true".Equals(comeFromErrorLogin))
        {
            LabelError.Visible = true;
            LabelError.Text = "Su inicio de sesión no fue exitoso. Por favor vuelva a intentar.";
        }

        if (!String.IsNullOrEmpty(redir))
        {
            CreateUserWizard1.ContinueDestinationPageUrl = redir; 
        }
        
    }
    protected void LogInUser(object sender, EventArgs e) {
         //check to see if this person has a cookie
        if (Request.Cookies["shopperID"] != null) {
            string sAnonID = Request.Cookies["shopperID"].Value;
            //synch the tracker
            Tracker.SynchTrackingCookie(Login1.UserName, sAnonID);

            //Log it
            Tracker.Add(BehaviorType.LoggingIn);
           
            //reset the cookie so we know who this is
            Response.Cookies["shopperID"].Value = Login1.UserName;
            Response.Cookies["shopperID"].Expires = DateTime.Today.AddDays(365);
        }                       
    }
    protected void NewRegistration(object sender, EventArgs e) {
        string redir = Commerce.Common.Utility.GetParameter("ReturnUrl");
        if (redir != string.Empty) {
            Response.Redirect(redir);
        } else {
            Response.Redirect("default.aspx");
        }
    }
    
    protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
    {
        string cmd = "CSK_Store_User_Datos_Insert";

        Database db = DatabaseFactory.CreateDatabase();
        
        Control control = CreateUserWizard1.CreateUserStep.Controls[0];
        int pais = Int32.Parse(((DropDownList)control.FindControl("DropDownPaises")).SelectedValue);
        string ciudad = ((TextBox)control.FindControl("TextBoxCiudades")).Text;

        WebDateTimeEdit fechaNacimientoControl = (WebDateTimeEdit)control.FindControl("WebDateTimeEdit1");
        
        string fechaNacimiento = fechaNacimientoControl.Text;
        
       
        int nivelEstudio = Int32.Parse(((DropDownList)control.FindControl("DropDownNivelEstudio")).SelectedValue);
        int ocupacion = Int32.Parse(((DropDownList)control.FindControl("DropDownOcupacion")).SelectedValue);
        int area = Int32.Parse(((DropDownList)control.FindControl("DropDownListArea")).SelectedValue);
        int cargo = Int32.Parse(((DropDownList)control.FindControl("DropDownListCargo")).SelectedValue);

        //DropDownPaises.
        //int pais = Int32.Parse();

        using (DbCommand dbCommand = db.GetStoredProcCommand(cmd))
        {
            db.AddInParameter(dbCommand, "@usuario", DbType.String, CreateUserWizard1.UserName);
            db.AddInParameter(dbCommand, "@pais", DbType.Int32, pais);
            db.AddInParameter(dbCommand, "@ciudad", DbType.String, ciudad);
            db.AddInParameter(dbCommand, "@fecha_nacimiento", DbType.String, fechaNacimiento);
            db.AddInParameter(dbCommand, "@tipo_curso", DbType.Int32, 1);
            db.AddInParameter(dbCommand, "@nivel_curso", DbType.Int32, nivelEstudio);
            db.AddInParameter(dbCommand, "@ocupacion", DbType.Int32, ocupacion);
            db.AddInParameter(dbCommand, "@desempenio", DbType.Int32, area);
            db.AddInParameter(dbCommand, "@cargo", DbType.Int32, cargo);

            db.ExecuteNonQuery(dbCommand);
        }

        //Forum registration
        yaf.DB.user_register(CreateUserWizard1.UserName, CreateUserWizard1.Password, CreateUserWizard1.Email);
    }
   
}
