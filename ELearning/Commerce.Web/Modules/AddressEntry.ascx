<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddressEntry.ascx.cs" Inherits="AddressEntry" %>
  <table cellspacing="1" cellpadding="2">
        <tr>
        
            <td colspan="2">
            <%if(OrderController.GetAddressBookCount()>1){ %>
                <img src="images/addressbook.gif" align="absmiddle"/>
                <asp:LinkButton ID="lnkToggle" runat="server" OnClick="lnkToggle_Click" CausesValidation="False" meta:resourcekey="lnkToggleResource1">Show Address Book</asp:LinkButton>
                <asp:Panel ID="pnlAddBook" runat="server" meta:resourcekey="pnlAddBookResource1">
                <asp:DataList ID="dtAddresses" runat="server" CellPadding="4" CellSpacing="2" 
                RepeatColumns="2" Width="550px" OnItemCommand="SelectAddress" meta:resourcekey="dtAddressesResource1" >
                <ItemTemplate>
                    <asp:Label ID="lblAddressID" runat="server" Text='<%# Eval("addressID") %>' Visible="False" meta:resourcekey="lblAddressIDResource1"></asp:Label>
                    <%# Eval("FullAddress") %>
                    <br />
                    <asp:Button ID="btnUse" runat="server" Text="Use This Address"  CausesValidation="False" meta:resourcekey="btnUseResource1"/>
                </ItemTemplate>
                
                </asp:DataList>
                 
                <br /><br /> 
                </asp:Panel>  
             <%} %>         
            </td>
        </tr>
        <tr>
            <td  class="checkoutlabel" style="width: 36px" >
                <asp:Localize ID="FirstContent" runat="server" meta:resourcekey="FirstContentResource1" Text="First"></asp:Localize>:</td>
            <td>
                <asp:TextBox Runat="server" ID="txtFirst" meta:resourcekey="txtFirstResource1"></asp:TextBox>
                <asp:RequiredFieldValidator Runat="server" ControlToValidate="txtFirst" ErrorMessage="Required"
                    ID="RequiredFieldValidator1" meta:resourcekey="RequiredFieldValidator1Resource1"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td  class="checkoutlabel" style="width: 36px">
                <asp:Localize ID="LastContent" runat="server" meta:resourcekey="LastContentResource1" Text="Last"></asp:Localize>:</td>
            <td>
                <asp:TextBox Runat="server" ID="txtLast" meta:resourcekey="txtLastResource1"></asp:TextBox>
                <asp:RequiredFieldValidator Runat="server" ControlToValidate="txtLast" ErrorMessage="Required"
                    ID="Requiredfieldvalidator5" meta:resourcekey="Requiredfieldvalidator5Resource1"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td  class="checkoutlabel" style="width: 36px" >
                <asp:Localize ID="EmailContent" runat="server" meta:resourcekey="EmailContentResource1" Text="Email"></asp:Localize></td>
            <td height="28">
                <asp:TextBox Runat="server" ID="txtEmail" meta:resourcekey="txtEmailResource1"></asp:TextBox>
                <asp:RequiredFieldValidator Runat="server" ControlToValidate="txtEmail" ErrorMessage="Required"
                    ID="Requiredfieldvalidator4" meta:resourcekey="Requiredfieldvalidator4Resource1"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="Correo no válido." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ></asp:RegularExpressionValidator></td>
        </tr>
        <tr>
            <td  class="checkoutlabel" style="width: 36px">
                <asp:Localize ID="AddresContent" runat="server" meta:resourcekey="AddresContentResource1" Text="Address"></asp:Localize></td>
            <td>
                <asp:TextBox Runat="server" ID="txtAddress1" meta:resourcekey="txtAddress1Resource1"></asp:TextBox>
                <asp:RequiredFieldValidator Runat="server" ControlToValidate="txtAddress1" ErrorMessage="Required"
                    ID="RequiredFieldValidator2" meta:resourcekey="RequiredFieldValidator2Resource1"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td  class="checkoutlabel" style="height: 23px; width: 36px;">
                <asp:Localize ID="Address2Content" runat="server" meta:resourcekey="Address2ContentResource1" Text="Address"></asp:Localize> 2</td>
            <td style="height: 23px">
                <asp:TextBox Runat="server" ID="txtAddress2" meta:resourcekey="txtAddress2Resource1"></asp:TextBox>
            </td>
        </tr>
        <TR>
	        <TD class="checkoutlabel" style="width: 36px">
                <asp:Localize ID="CountryContent" runat="server" meta:resourcekey="CountryContentResource1" Text="Country"></asp:Localize></TD>
	        <TD>
                Ecuador</TD>
        </TR>
        <TR>
	        <TD class="checkoutlabel" style="width: 36px">
                <asp:Localize ID="StateRegionContent" runat="server" meta:resourcekey="StateRegionContentResource1" Text="State/Region"></asp:Localize></TD>
	        <TD>
		        
		        <asp:DropDownList id="ddlState" runat="server" meta:resourcekey="ddlStateResource1">
			        <asp:ListItem value="AZ" meta:resourcekey="ListItemResource1">Azuay</asp:ListItem>
			        <asp:ListItem value="BO" meta:resourcekey="ListItemResource2">Bol&#237;var</asp:ListItem>
			        <asp:ListItem value="CA" meta:resourcekey="ListItemResource3">Ca&#241;ar</asp:ListItem>
			        <asp:ListItem value="CR" meta:resourcekey="ListItemResource4">Carchi</asp:ListItem>
			        <asp:ListItem value="CH" meta:resourcekey="ListItemResource5">Chimborazo</asp:ListItem>
			        <asp:ListItem value="CO" meta:resourcekey="ListItemResource6">Cotopaxi</asp:ListItem>
			        <asp:ListItem value="EO" meta:resourcekey="ListItemResource7">El Oro</asp:ListItem>
			        <asp:ListItem value="ES" meta:resourcekey="ListItemResource8">Esmeraldas</asp:ListItem>
			        <asp:ListItem value="GA" meta:resourcekey="ListItemResource9">Gal&#225;pagos</asp:ListItem>
			        <asp:ListItem value="GY" meta:resourcekey="ListItemResource10">Guayas</asp:ListItem>
			        <asp:ListItem value="IM" meta:resourcekey="ListItemResource11">Imbabura</asp:ListItem>
			        <asp:ListItem value="LO" meta:resourcekey="ListItemResource12">Loja</asp:ListItem>
			        <asp:ListItem value="LR" meta:resourcekey="ListItemResource13">Los R&#237;os</asp:ListItem>
			        <asp:ListItem value="MA" meta:resourcekey="ListItemResource14">Manab&#237;</asp:ListItem>
			        <asp:ListItem value="MS" meta:resourcekey="ListItemResource15">Morona Santiago</asp:ListItem>
			        <asp:ListItem value="NA" meta:resourcekey="ListItemResource16">Napo</asp:ListItem>
			        <asp:ListItem value="OR" meta:resourcekey="ListItemResource17">Orellana</asp:ListItem>
			        <asp:ListItem value="PA" meta:resourcekey="ListItemResource18">Pastaza</asp:ListItem>
			        <asp:ListItem value="PI" meta:resourcekey="ListItemResource19">Pichincha</asp:ListItem>
			        <asp:ListItem value="SU" meta:resourcekey="ListItemResource20">Sucumb&#237;os</asp:ListItem>
			        <asp:ListItem value="TU" meta:resourcekey="ListItemResource21">Tungurahua</asp:ListItem>
			        <asp:ListItem value="ZC" meta:resourcekey="ListItemResource22">Zamora Chinchipe</asp:ListItem>
		        </asp:DropDownList><asp:RequiredFieldValidator id="valState" runat="server" EnableClientScript="False" ControlToValidate="ddlState"
			        ErrorMessage="Required" Display="Dynamic" meta:resourcekey="valStateResource1"></asp:RequiredFieldValidator></TD>
        </TR>
      <tr>
          <td class="checkoutlabel" style="width: 36px">
              <asp:Localize ID="CityContent" runat="server" meta:resourcekey="CityContentResource1" Text="City"></asp:Localize></td>
          <td>
                <asp:TextBox Runat="server" ID="txtCity" meta:resourcekey="txtCityResource1"></asp:TextBox><asp:RequiredFieldValidator Runat="server" ControlToValidate="txtCity" ErrorMessage="Required"
                    ID="RequiredFieldValidator3" meta:resourcekey="RequiredFieldValidator3Resource1"></asp:RequiredFieldValidator></td>
      </tr>

    </table>

