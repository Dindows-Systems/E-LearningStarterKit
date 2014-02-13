<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Install_Default"  Title="CSK Installer" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<%@ Register Src="../Modules/ResultMessage.ascx" TagName="ResultMessage" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="centercontent">
        <table width="100%">
            <tr><td height="50"><img src="<%=Page.ResolveUrl("~/images/yourlogohere.gif")%>" alt="CommerceStarterKit" /></td></tr>
            <tr>
                <td>
                    <h1>
                        <asp:Localize ID="InstallerContent" runat="server" meta:resourcekey="InstallerContentResource1" Text="Installer"></asp:Localize></h1>
                    Bienvenido a Latino E-Learning. Antes de que la aplicaci&oacute;n pueda ejecutarse, necesita instalar la base de datos de
                    su tienda. Si tiene problemas o necesita ayuda, puede acceder a nuestra 
                     <a href="Help.aspx">p&aacute;gina de ayuda de instalaci&oacute;n</a>.<br />
                    
                    <br />
                    Los errores m&aacute;s comunes asociados con la instaci&oacute;n de la base de datos tienen que ver con la seguridad.
                    Aseg&uacute;rese de que el inicio de sesi&oacute;n que use m&aacute;s abajo tiene derechos de Ejecuci&oacute;n en su Base de Datos. La mayor&iacute;a de los ISPs
                    le asignan esto con el inicio de sesi&oacute;n que le proporcionan, de forma que no deber&iacute;a tener problemas si est&aacute; instalando la 
                    base de datos remotamente.<br />
                    <br />
                    Si est&aacute; instalando este sitio localmente, talvez desee revisar nuestra <a href="Help.aspx">
                        p&aacute;gina de ayuda</a> que le ense&ntilde;ar&aacute; <a href="Help.aspx">c&oacute;mo configurar los permisos apropiadamente</a>
                    para autenticaci&oacute;n integrada usando SQL 2005 Express. (esta p&aacute;gina de ayuda no puede hacerlo
                    por usted).<br />
                    <br />
                    Si desea instalar el sistema por su cuenta (por ejemplo si solo quiere instalar
                    Latino E-Learning y no la membres&iacute;a), todos los scripts est&aacute;n en la carpeta Install/InstallScripts.
                     Cuando haya terminado solamente actualice el archivo Web.config seg&uacute;n sea necesario.<br />
                    <br />
                    <uc1:ResultMessage ID="ResultMessage1" runat="server" />
                    <br />
                       <asp:Panel ID="pnlServer" runat="server" meta:resourcekey="pnlServerResource1">
                      <div class="sectionheader">
                          <asp:Localize ID="ServerSelectionContent" runat="server" meta:resourcekey="ServerSelectionContentResource1" Text="Server Selection"></asp:Localize></div>
                      <table cellpadding="5">
                            <tr>
                                <td>
                                    <asp:Localize ID="ServerNameContent" runat="server" meta:resourcekey="ServerNameContentResource1" Text="Server Name"></asp:Localize></td>
                                <td style="width: 137px"><asp:TextBox ID="txtServer" runat="server" Text="localhost\SQLEXPRESS" Width="242px" meta:resourcekey="txtServerResource1"></asp:TextBox><br />
                                    <em>
                                        <asp:Localize ID="DbServerNameContent" runat="server" meta:resourcekey="DbServerNameContentResource1" Text="This is the name or IP of the DB Server that you want to install the database into.
                                        SQLExpress will automatically install itself into the above location."></asp:Localize></em></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Localize ID="TrustedConnectionContent" runat="server" meta:resourcekey="TrustedConnectionContentResource1" Text="Use Trusted Connection"></asp:Localize></td>
                                <td>
                                    <asp:CheckBox ID="chkTrusted" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="chkTrusted_CheckedChanged" meta:resourcekey="chkTrustedResource1" />
                                    <br />
                                    <i>Si selecciona "Usar Conexi&oacute;n Confiable", necesita darle permiso de DB_OWNER al ASP worker process. 
                                    Si no conoce c&oacute;mo hacer esto, <a href="Help.aspx"> LEA ESTO PRIMERO</a> o su instalaci&oacute;n fallar&aacute;.
                                    </i>
                                
                                </td>
                                
                            </tr>
                      </table>
                      <asp:Panel ID="pnlSqlMode" runat="server" Visible="False" meta:resourcekey="pnlSqlModeResource1">
                      <table cellpadding="5">
                             <tr>
                                <td>
                                    <asp:Localize ID="UsernameContent" runat="server" meta:resourcekey="UsernameContentResource1" Text="Username"></asp:Localize></td>
                                <td style="width: 137px"><asp:TextBox ID="txtUsername"  runat="server" meta:resourcekey="txtUsernameResource1" ></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td style="height: 21px">
                                    <asp:Localize ID="PasswordContent" runat="server" meta:resourcekey="PasswordContentResource1" Text="Password"></asp:Localize></td>
                                <td style="width: 137px; height: 21px"><asp:TextBox ID="txtPassword"  runat="server" meta:resourcekey="txtPasswordResource1" ></asp:TextBox></td>
                            </tr>
                       </table>
                       </asp:Panel>
                       <asp:Button ID="btnSetServer" runat="server" Text="Set Server" OnClick="btnSetServer_Click" meta:resourcekey="btnSetServerResource1" />
                        <br />
                        <br />
                       </asp:Panel>
                       <asp:Panel ID="pnlDB" runat="server" Visible="False" meta:resourcekey="pnlDBResource1">
                        <div class="sectionheader">
                            <asp:Localize ID="DatabaseSelectionContent" runat="server" meta:resourcekey="DatabaseSelectionContentResource1" Text="Database Selection"></asp:Localize></div>
                        <table cellpadding="5">
                            <tr>
                                <td>
                                    <asp:Localize ID="SelectDatabaseContent" runat="server" meta:resourcekey="SelectDatabaseContentResource1" Text="Select Database"></asp:Localize>:</td>
                                <td style="width: 201px"><asp:DropDownList ID="ddlDB" runat="server" meta:resourcekey="ddlDBResource1"></asp:DropDownList></td>
                            </tr>
                            <tr><td colspan="2">--<asp:Localize ID="OrContent" runat="server" meta:resourcekey="OrContentResource1" Text="or"></asp:Localize>--</td></tr>
                            <tr>
                                <td>
                                    <asp:Localize ID="CreateNewOneContent" runat="server" meta:resourcekey="CreateNewOneContentResource1" Text="Create a new one"></asp:Localize>:</td>
                                <td style="width: 201px"> <asp:TextBox id="txtCreateDB" runat="server" meta:resourcekey="txtCreateDBResource1"></asp:TextBox><asp:Button ID="btnCreate" runat="server" Text="Create" OnClick="btnCreate_Click" meta:resourcekey="btnCreateResource1" /> </td>
                           
                            </tr>
                        </table>
                               
                        </asp:Panel>
                           
                        <br />
                        <asp:Panel ID="pnlInstall" runat="server" Visible="False" meta:resourcekey="pnlInstallResource1">
                            <div class="sectionheader">
                                <asp:Localize ID="InstallContent" runat="server" meta:resourcekey="InstallContentResource1" Text="Install"></asp:Localize></div>

                            <asp:Button ID="Button1" runat="server" Text="Install" OnClick="Button1_Click" meta:resourcekey="Button1Resource1" />
                            
                       </asp:Panel>
                        <asp:Label ID="lblProgress" runat="server" meta:resourcekey="lblProgressResource1"></asp:Label>
            
            </td></tr>
        </table>
    </div>
    </form>
</body>
</html>
