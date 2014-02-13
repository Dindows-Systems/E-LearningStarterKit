<%@ Page Language="C#" MasterPageFile="~/site.master" %>

<%@ Register TagPrefix="yaf" Namespace="yaf" %>
<%@ Register TagPrefix="yc" Namespace="yaf.controls" %>

<script runat="server">
    public void Page_Error(object sender, System.EventArgs e)
    {
        Exception x = Server.GetLastError();
        yaf.DB.eventlog_create(forum.PageUserID, this, x);
        yaf.Utils.LogToMail(x);
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <html>
    <head>
        <meta name="Description" content="A bulletin board system written in ASP.NET">
        <meta name="Keywords" content="Yet Another Forum.net, Forum, ASP.NET, BB, Bulletin Board, opensource">
        <!-- If you don't want the forum to set the page title, you can remove runat and id -->
        <title runat="server" id="ForumTitle">This title is overwritten</title>
    </head>
    <body>    
        <br />
        <table style="width:770px" border="0">
        <tr>            
            <td><yaf:Forum runat="server" ID="forum" /></td>        
        </tr>
        </table>
    </body>
    </html>
</asp:Content>
