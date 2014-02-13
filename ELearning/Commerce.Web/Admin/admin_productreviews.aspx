<%@ Page Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="admin_productreviews.aspx.cs" Inherits="Admin_admin_productreviews" Title="Review Administration" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>
<%@ Register Src="../Modules/ResultMessage.ascx" TagName="ResultMessage" TagPrefix="uc1" %>
<%@ Register Namespace="Commerce.Web.UI.Controls" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminPlaceHolder" Runat="Server">


    <h1>
        <asp:Localize ID="ReviewEditContent" runat="server" meta:resourcekey="ReviewEditContentResource1" Text="Review Edit"></asp:Localize>: <%=Commerce.Common.Utility.GetParameter("pn")%></h1>
    <asp:Panel ID=pnlGrid runat=server meta:resourcekey="pnlGridResource1">
    </asp:Panel>
     &nbsp;
	<asp:panel id="pnlEdit" Runat="server" Visible=False meta:resourcekey="pnlEditResource1">
        <uc1:ResultMessage ID="uResult" runat="server" visible="False" />
		<TABLE id="Table2" cellSpacing="0" cellPadding="0" width="100%">
			<TR id="trError" runat="server" visible="False" enableviewstate="False">
				<TD id="tdError" bgColor="#ffcc33" colSpan="2" runat="server">
					<asp:Label id="lblError" runat="server"></asp:Label>
				</TD>
			</TR>
			<TR>
				<TD colSpan="2">
					<TABLE id="Table4" cellSpacing="1" width="100%" bgColor="gainsboro">
						<TR id="trID" runat="server">
							<TD bgColor="whitesmoke" style="width: 73px" runat="server">ID</TD>
							<TD bgColor="white" runat="server">
								<asp:Label id="lblID" runat="server"></asp:Label>
							</TD>
						</TR>
						<TR>
							<TD bgColor="whitesmoke" style="width: 73px">
                                <asp:Localize ID="RatingContent" runat="server" meta:resourcekey="RatingContentResource1" Text="Rating"></asp:Localize></TD>
							<TD bgColor="white">
							    <cc1:ProductRatingDropDownList id="ddlRating" runat="server" meta:resourcekey="ddlRatingResource1" >
                                    <asp:ListItem Value="0">-</asp:ListItem>
                                    <asp:ListItem Value="5">5 Estrellas</asp:ListItem>
                                    <asp:ListItem Value="4">4 Estrellas</asp:ListItem>
                                    <asp:ListItem Value="3">3 Estrellas</asp:ListItem>
                                    <asp:ListItem Value="2">2 Estrellas</asp:ListItem>
                                    <asp:ListItem Value="1">1 Estrella</asp:ListItem>
                                </cc1:ProductRatingDropDownList></TD>
						</TR>
						
						<TR>
							<TD bgColor="whitesmoke" style="width: 73px">
                                <asp:Localize ID="TitleContent" runat="server" meta:resourcekey="TitleContentResource1" Text="Title"></asp:Localize></TD>
							<TD bgColor="white">
								<asp:textbox id="txtTitle" runat="server" Columns="80" MaxLength="100" meta:resourcekey="txtTitleResource1"></asp:textbox>
								<asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" Display="Dynamic" ControlToValidate="txtTitle"
									ErrorMessage="Required" meta:resourcekey="RequiredFieldValidator1Resource1">*</asp:RequiredFieldValidator>
							</TD>
						</TR>
						<TR>
							<TD bgColor="whitesmoke" style="width: 73px">
                                <asp:Localize ID="BodyContent" runat="server" meta:resourcekey="BodyContentResource1" Text="Body"></asp:Localize></TD>
							<TD bgColor="white">
								<asp:textbox id="txtBody" runat="server" Columns="70" Rows="10" TextMode="MultiLine" meta:resourcekey="txtBodyResource1"></asp:textbox>
								<asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" Display="Dynamic" ControlToValidate="txtBody"
									ErrorMessage="Required" meta:resourcekey="RequiredFieldValidator2Resource1">*</asp:RequiredFieldValidator>
							</TD>
						</TR>
						<TR>
							<TD bgColor="whitesmoke" style="width: 73px">
                                <asp:Localize ID="AuthorContent" runat="server" meta:resourcekey="AuthorContentResource1" Text="Author"></asp:Localize></TD>
							<TD bgColor="white">
								<asp:textbox id="thxAuthor" runat="server" Columns="25" MaxLength="256" meta:resourcekey="thxAuthorResource1"></asp:textbox>
								<asp:RequiredFieldValidator id="RequiredFieldValidator3" runat="server" Display="Dynamic" ControlToValidate="thxAuthor"
									ErrorMessage="Required" meta:resourcekey="RequiredFieldValidator3Resource1">*</asp:RequiredFieldValidator>
							</TD>
						</TR>
						<TR>
							<TD bgColor="whitesmoke" style="width: 73px">
                                <asp:Localize ID="PostDateContent" runat="server" meta:resourcekey="PostDateContentResource1" Text="Post Date"></asp:Localize></TD>
							<TD bgColor="white">
								<asp:textbox id="txtPostDate" runat="server" Columns="25" meta:resourcekey="txtPostDateResource1"></asp:textbox>
								<asp:RequiredFieldValidator id="RequiredFieldValidator4" runat="server" Display="Dynamic" ControlToValidate="txtPostDate"
									ErrorMessage="Required" meta:resourcekey="RequiredFieldValidator4Resource1">*</asp:RequiredFieldValidator>
							</TD>
						</TR>
						<TR>
							<TD bgColor="whitesmoke" style="width: 73px">
                                <asp:Localize ID="HelpfulRatingContent" runat="server" meta:resourcekey="HelpfulRatingContentResource1" Text="Helpful Rating"></asp:Localize></TD>
							<TD bgColor="white">
								<asp:Label id="lblHelpful" runat="server" meta:resourcekey="lblHelpfulResource1" />
							</TD>
						</TR>
						<TR>
							<TD bgColor="whitesmoke" style="width: 73px">
                                <asp:Localize ID="ApprovedContent" runat="server" meta:resourcekey="ApprovedContentResource1" Text="Approved"></asp:Localize></TD>
							<TD bgColor="white">
								<asp:checkbox id="ckbApproved" runat="server" meta:resourcekey="ckbApprovedResource1"></asp:checkbox>
							</TD>
						</TR>						
					</TABLE>
				</TD>
			</TR>
				<TR>
				<TD>
					<asp:Button id="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1"></asp:Button>&nbsp;
					&nbsp;<asp:Button ID="btnPerm" runat="server" Text="Permanently Delete" OnClick="btnPerm_Click" meta:resourcekey="btnPermResource1" /></TD>
				<TD align="right">
                    &nbsp;<input type=button value="Regresar" onclick="location.href='admin_reviews.aspx'" id="Button1" /></TD>
			</TR>
		</TABLE>
	</asp:panel> 

	<script>
        function CheckDelete() {
        		
	        return confirm("¿Eliminar permanentemente este comentario? Esta acción es irreversible...");

        }
    </script>	   
</asp:Content>

