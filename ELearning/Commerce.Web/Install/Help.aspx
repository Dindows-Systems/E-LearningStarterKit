<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Help.aspx.cs" Inherits="Install_Help" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Creating Your Database</title>
</head>
<body margin="10px">
    <form id="form1" runat="server">
    <div style="padding:20px;">
    <h1>
        <asp:Localize ID="HowToCreateDatabaseContent" runat="server" meta:resourcekey="HowToCreateDatabaseContentResource1" Text="How do I create my database?"></asp:Localize></h1>
    <a href="default.aspx">Regresar</a>
        <p>
            <asp:Localize ID="GetSQLManagementStudioContent" runat="server" meta:resourcekey="GetSQLManagementStudioContentResource1" Text="The first step to working with SQL Express is to have a tool that is designed to&#13;&#10;            do just that. You can get the SQL Management Studio Express tool for free from here"></asp:Localize>:<br />
            <br />
            <a href="http://msdn.microsoft.com/vstudio/express/sql/download/">http://msdn.microsoft.com/vstudio/express/sql/download/</a><br />
            <br />
            <asp:Localize ID="SelectInstalationWithManagementStudioContent" runat="server" meta:resourcekey="SelectInstalationWithManagementStudioContentResource1" Text="Make sure that you select an installation with the Management Express tool"></asp:Localize>.</p>
        <p>
            <asp:Localize ID="ConnectToServerContent" runat="server" meta:resourcekey="ConnectToServerContentResource1" Text='When SP1 and the tools are installed, open up SQL Management Studio and connect&#13;&#10;            to your local Express Server. This will most likely be "localhost\SQLEXPRESS". Use&#13;&#10;            Windows Authentication'></asp:Localize>.</p>
        <p>
            Para agregar una base de datos, solo haga click derecho en Databases y seleccione "<strong>New Database</strong>".
            As&iacute;gnele un nombre como "<strong>ELearning</strong>".</p>
        <p>
            <img src="../images/Help/dbsetup_1gif.gif" />&nbsp;</p>
        <p>
            <asp:Localize ID="SetOwnerPermissionsContent" runat="server" meta:resourcekey="SetOwnerPermissionsContentResource1" Text='You need to let the ASP worker process, which is the identity that ASP runs under,&#13;&#10;            have "owner" permissions of these databases. To do this, drop open the new database&#13;&#10;            and go to the security folder. Right-click and select "New/User". A dialog will&#13;&#10;            pop up asking you for a name and rights assignments'></asp:Localize>.
        </p>
        <p>
            Su ASP worker process deber&iacute;a tener uno de dos nombres - en la mayor&iacute;a de m&aacute;quinas Windows XP este
            proceso se llama "[MACHINENAME]\<strong>ASPNET</strong>". En servidores y otras m&aacute;quinas XP, este proceso se llama "[MACHINENAME]\<strong>NETWORK SERVICE</strong>".
            Seleccione uno de estos nombres, e ingrese ese nombre en Usuario y Login:</p>
        <p>
            <img src="../images/Help/dbsetup_2gif.gif" />&nbsp;</p>
        <p>
            <asp:Localize ID="AddUserToDebOwnerContent" runat="server" meta:resourcekey="AddUserToDebOwnerContentResource1" Text="Finally, add this new user to the role of db_owner. This will allow for the creation&#13;&#10;            of tables and SPs, and the execution of those SPs"></asp:Localize>.</p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
    
    
    
    
    
    
    
    </div>
    </form>
</body>
</html>
