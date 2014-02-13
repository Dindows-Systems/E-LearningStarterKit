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
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;
using Commerce.Common;

public partial class Install_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    string GetConnString(string tableName)
    {
        string sCString = "Server=" + txtServer.Text + ";Initial Catalog="+tableName+";";
        if (chkTrusted.Checked)
        {
            sCString += "Integrated Security=true;";
        }
        else
        {
            sCString += "user id=" + txtUsername.Text + "; Password=" + txtPassword.Text + ";";

        }
        return sCString;

    }
    void BindDBList()
    {
        //get the list of DBs from the username bits
        using (SqlConnection conn = new SqlConnection()) 
        {

            //the DBList query
            string sql = "SELECT * FROM sys.databases WHERE name NOT IN ('master','tempdb','model','msdb') ORDER BY name";

            conn.ConnectionString = GetConnString("master");

            try
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    using (SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                    {
                        ddlDB.DataSource = rdr;
                        ddlDB.DataTextField = "name";
                        ddlDB.DataValueField = "name";
                        ddlDB.DataBind();

                        rdr.Close();
                    }
                }
            }
            catch (Exception x)
            {
                ResultMessage1.ShowFail(x.Message);
            }
        }
    }
    protected void chkTrusted_CheckedChanged(object sender, EventArgs e)
    {
        pnlSqlMode.Visible = !chkTrusted.Checked;
    }
    protected void btnCreate_Click(object sender, EventArgs e)
    {
        //get the list of DBs from the username bits
        using (SqlConnection conn = new SqlConnection())
        {

            //the DBList query
            string sql = "CREATE DATABASE " + txtCreateDB.Text;

            conn.ConnectionString = GetConnString("master");

            try
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.ExecuteNonQuery();

                    BindDBList();

                    //select the one that was just created
                    ddlDB.SelectedValue = txtCreateDB.Text;
                }
            }
            catch (Exception x)
            {
                string sMessage = x.Message;
                if (x.Message.Contains("permission denied"))
                {
                    sMessage = Resources.Install.NotAllowedToCreateDatabase;
                }

                ResultMessage1.ShowFail(sMessage);
            }
        }
    }
    protected void btnSetServer_Click(object sender, EventArgs e)
    {
        BindDBList();
        pnlDB.Visible = true;
        pnlInstall.Visible = true;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        pnlServer.Visible = false;
        pnlDB.Visible = false;
        pnlInstall.Visible = false;
        bool haveError = false;

        //get the scripts from the InstallScripts directory
        string scriptPath = Server.MapPath("~/Install/InstallScripts");
        string[] scripts=Directory.GetFiles(scriptPath);
        lblProgress.Text = string.Format( Resources.Install.InstallingDatabaseInto, txtServer.Text, ddlDB.SelectedValue);

        //Response.Flush();

        SqlConnection conn = new SqlConnection(GetConnString(ddlDB.SelectedValue));
        try
        {
            conn.Open();
        }
        catch
        {
            haveError = true;
            ResultMessage1.ShowFail(Resources.Install.InvalidCredentials);
        }
        if (!haveError)
        {
            SqlTransaction trans = conn.BeginTransaction();
            SqlCommand cmd = new SqlCommand("", conn, trans);
            foreach (string script in scripts)
            {
                string[] statements = GetExecutionPlan(script);
                foreach (string statement in statements)
                {
                    string sql = statement;
                    try
                    {
                        cmd.CommandText = sql;
                        lblProgress.Text += string.Format( Resources.Install.Installing, Path.GetFileNameWithoutExtension(script) );
                        //Response.Flush();
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception x)
                    {
                        string sMessage = x.Message;
                        if (sMessage.ToLower().Contains("permission denied"))
                            sMessage = Resources.Install.NoPermissionToCreateSchema;
                        //trans.Rollback();
                        ResultMessage1.ShowFail(x.Message);
                        haveError = true;
                        trans.Rollback();
                        break;
                    }
                }

            }


            if (!haveError)
            {
                trans.Commit();
                conn.Close();
                conn.Dispose();
                cmd.Dispose();
                if (SetWebConfig())
                {
                    Response.Redirect("../default.aspx");
                }
                else
                {
                    lblProgress.Text = Resources.Install.NoWritePermissions;

                }
            }
        }
    }

    bool SetWebConfig()
    {
        bool bOut = true;
        try
        {
            string configPath = Server.MapPath("~/Web.Config");
            string sConfig = Utility.GetFileText("../Web.Config");

            //write them back
            Utility.UpdateFileText(configPath, "STOREDATASOURCEUNSET", GetConnString(ddlDB.SelectedValue));
            Utility.UpdateFileText(configPath, "MEMBERSHIPDATASOURCEUNSET", GetConnString(ddlDB.SelectedValue));
        }
        catch
        {
            bOut = false;
        }
        return bOut;
    }

    private string[] GetExecutionPlan(string filePath)
    {

        string sql = Utility.GetFileText(filePath);
        string[] SqlLine;
        Regex regex = new Regex("^GO", RegexOptions.IgnoreCase | RegexOptions.Multiline);

        SqlLine = regex.Split(sql);

        return SqlLine;
    }

}
