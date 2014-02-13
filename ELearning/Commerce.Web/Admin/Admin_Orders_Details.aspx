<%@ Page Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="Admin_Orders_Details.aspx.cs" Inherits="Admin_Admin_Orders_Details" Title="Order Details" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>
<%@ Register Src="../Modules/ResultMessage.ascx" TagName="ResultMessage" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminPlaceHolder" Runat="Server">
 


     <uc1:ResultMessage ID="uResult" runat="server" />
    <h1><a href="admin_orders.aspx">
        <asp:Localize ID="OrdersContent" runat="server" meta:resourcekey="OrdersContentResource1" Text="Orders"></asp:Localize> >>> </a>
        <asp:Localize ID="OrderDetailContent" runat="server" meta:resourcekey="OrderDetailContentResource1" Text="Order Detail"></asp:Localize>: 
    <asp:Label ID="lblOrderNumber" runat="server" meta:resourcekey="lblOrderNumberResource1" ></asp:Label></h1>

<table style="border:1px solid gainsboro">
    <tr><td colspan="2" height="30" bgcolor="whitesmoke"><b>
        <asp:Localize ID="StatusContent" runat="server" meta:resourcekey="StatusContentResource1" Text="Status"></asp:Localize>: <%=Commerce.Common.Utility.ParseCamelToProper(order.OrderStatus.ToString())%></b></td></tr>
    <tr>
    <td style="background-color:#ffffcc;" colspan="2">Usuario: <%=order.UserName %> </td>
    </tr>        
    <tr>
        <td style="background-color:#ffffcc;" colspan="2">
            <asp:Localize ID="LastUpdatedByContent" runat="server" meta:resourcekey="LastUpdatedByContentResource1" Text="Last Updated By"></asp:Localize>: <%=order.ModifiedBy %> </td>
    </tr>
    <tr>
        <td style="background-color:#ffffcc;" colspan="2">
            <asp:Localize ID="LastUpdatedOnContent" runat="server" meta:resourcekey="LastUpdatedOnContentResource1" Text="Last Updated On"></asp:Localize>: <%=order.ModifiedOn %></td>
    </tr>
    <tr>
        <td width="50%" valign="top">
            <h2>
                <asp:Localize ID="BillToContent" runat="server" meta:resourcekey="BillToContentResource1" Text="Bill To"></asp:Localize>:</h2>
            <table>
                <tr>
                    <td valign="top" style="height: 41px">
                    <%=Commerce.Common.Utility.ToggleHtmlBR(order.BillToAddress,true)%>
                    </td>
                </tr>
                <tr>
                    <td>
                        <br />
                        <b>
                            <asp:Localize ID="PaymentMethodContent" runat="server" meta:resourcekey="PaymentMethodContentResource1" Text="Payment Method"></asp:Localize></b><br />
                    <%=order.Transactions[0].TransactionType%> 
                        <%if (order.Transactions[0].TransactionType == Commerce.Common.TransactionType.DepositoBancario){%>
                          <br />
                        <asp:Localize ID="DepositNumberContent" runat="server" meta:resourcekey="DepositNumberContentResource1" Text="Deposit Number"></asp:Localize>: <%= order.BankDepositNumber %>          
                        <%}
                    %>
                    </td>
                </tr>                

                <tr>
                    <td>
                        <br />
                        <b>
                            <asp:Localize ID="TransactionIDContent" runat="server" Text="Transaction ID"  meta:resourcekey="TransactionIDContentResource1"></asp:Localize></b><br />
                        <%=order.Transactions[0].AuthorizationCode %>
                    </td>
                </tr>               
            </table>
        </td>
        <%if(!order.IsDigitalOrder()){ %>
        <td valign="top">
            <h2>
                <asp:Localize ID="ShipToContent" runat="server" meta:resourcekey="ShipToContentResource1" Text="Ship To"></asp:Localize>:</h2>
             <table>
                    <tr>
                        <td style="width: 166px"><%=Commerce.Common.Utility.ToggleHtmlBR(order.ShipToAddress,true)%></td>
                    </tr>                   
                    <tr>
                        <td valign="top" style="width: 166px">
                        <br />
                        <b>
                            <asp:Localize ID="ShippingMethodContent" runat="server" meta:resourcekey="ShippingMethodContentResource1" Text="Shipping Method"></asp:Localize></b><br />
                        <%=order.ShippingMethod.ToString()%>
                            </td>
                    </tr>  
                    <%if (order.ShippingTrackingNumber != string.Empty)
                      { %>
                    <tr>
                        <td>
                            <asp:Localize ID="TrackingNumberContent" runat="server" meta:resourcekey="TrackingNumberContentResource1" Text="Tracking Number"></asp:Localize>: <%= order.ShippingTrackingNumber%></td>
                    </tr>
                    
                    <%} %>
                    
                    <%if(OrderController.CanShip(order)){%>
                    <tr>
                        <td style="width: 166px"><b>
                            <asp:Localize ID="ShipthisorderContent" runat="server" meta:resourcekey="ShipthisorderContentResource1" Text="Ship this order"></asp:Localize></b></td>
                    </tr>
                    <tr>
                        <td style="width: 166px">
                            <asp:Localize ID="EnterTrackingNumberContent" runat="server" meta:resourcekey="EnterTrackingNumberContentResource1" Text="Enter a tracking number"></asp:Localize><br />
                            <asp:TextBox ID="txtTrackingNumber" runat="server" TextMode="MultiLine" Height="59px" Width="219px" meta:resourcekey="txtTrackingNumberResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 166px"><asp:Button ID="btnSetShipped" runat="server" Text="Ship it" OnClick="btnSetShipped_Click" meta:resourcekey="btnSetShippedResource1" />
                            
                        </td>
                    </tr>
                    <%}%>
                    <tr>
                        <td><uc1:ResultMessage ID="uShipResult" runat="server" /></td>
                    </tr>
            </table>
            
        </td>
        <%} %>
    </tr>
    <tr>
        <td colspan="2">
        <h2>Items</h2>
        <asp:GridView ID="dgItems" Runat="server" AutoGenerateColumns="False" Width="100%" meta:resourcekey="dgItemsResource1">
            <EmptyDataTemplate>
                &nbsp;-- No items  --
            </EmptyDataTemplate>
            <Columns>
                <asp:BoundField DataField="productID" Visible="False" meta:resourcekey="BoundFieldResource1"></asp:BoundField>
                <asp:BoundField HeaderText="Item" DataField="productName" meta:resourcekey="BoundFieldResource2"></asp:BoundField>
                <asp:BoundField HeaderText="Atributos" DataField="Attributes" meta:resourcekey="BoundFieldResource3" ></asp:BoundField> 
                <asp:BoundField HeaderText="Cantidad" DataField="quantity" meta:resourcekey="BoundFieldResource4"></asp:BoundField>
                <asp:BoundField HeaderText="Precio" DataField="pricePaid" DataFormatString="{0:c}" HtmlEncode="False" meta:resourcekey="BoundFieldResource5">
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField HeaderText="Total" DataField="LineTotal" DataFormatString="{0:c}" HtmlEncode="False" meta:resourcekey="BoundFieldResource6">
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </asp:BoundField>
            </Columns>
        </asp:GridView>
        </td>
    </tr>
	<tr >
		<td colspan="2">
			<table width="100%"><tr>
					<td align="right" >
                        <asp:Localize ID="TaxContent" runat="server" meta:resourcekey="TaxContentResource1" Text="Tax"></asp:Localize>:</td>
					<td width="100" align="right">
                        <%=order.TaxAmount.ToString("c")%>
                    </td>
				</tr>
				<tr>
					<td align="right">
                        <asp:Localize ID="ShippingContent" runat="server" meta:resourcekey="ShippingContentResource1" Text="Shipping"></asp:Localize>:</td>
					<td width="100" align="right">
                        <%=order.ShippingAmount.ToString("c")%>
                    </td>
				</tr>
				<tr>
					<td align="right"><b>Total:</b></td>
					<td width="100" align="right">
                        <b>
                        <%
                        Response.Write(order.OrderTotal.ToString("c"));
                        %>
                        </b>
                    </td>
				</tr>
			</table>
		</td>
	</tr>    
	<tr>
        <td colspan="2">
        <h2>
            <asp:Localize ID="TransactionsContent" runat="server" meta:resourcekey="TransactionsContentResource1" Text="Transactions"></asp:Localize></h2>
        <asp:GridView ID="gTransactions" runat="server" AutoGenerateColumns="False" meta:resourcekey="gTransactionsResource1">
            <Columns>
                <asp:BoundField DataField="TransactionDate" DataFormatString="{0:d}" HeaderText="Fecha" meta:resourcekey="BoundFieldResource7" />
                <asp:BoundField DataField="Amount" DataFormatString="{0:c}" HeaderText="Monto" HtmlEncode="False" meta:resourcekey="BoundFieldResource8" />
                <asp:BoundField DataField="TransactionType" HeaderText="Tipo" meta:resourcekey="BoundFieldResource9" />
            </Columns>
        </asp:GridView>
        
        <%if (OrderController.CanRefund(order))
          { %>
        <br />
        <asp:Button ID="btnRefund" runat="server" Text="Refund Transaction" OnClick="btnRefund_Click1" meta:resourcekey="btnRefundResource1"/><br />
        <span class="smalltext">
            <asp:Localize ID="RefundContent" runat="server" meta:resourcekey="RefundContentResource1" Text="You can refund this order and the user's credit card will be refunded"></asp:Localize>.
            <uc1:ResultMessage ID="uResultRefund" runat="server" />
        </span>
        <%} %>
        </td>
    </tr>

	<tr>
        <td colspan="2">
        <atlas:UpdatePanel ID="WizUpdatePanel" runat="server" Mode="Conditional" >
        <ContentTemplate>  

        <h2>
            <asp:Localize ID="NotesContent" runat="server" meta:resourcekey="NotesContentResource1" Text="Notes"></asp:Localize></h2>
        <asp:GridView ID="gNotes" runat="server" AutoGenerateColumns="False" meta:resourcekey="gNotesResource1">
            <Columns>
                <asp:BoundField DataField="createdOn" DataFormatString="{0:d}" HeaderText="Fecha" meta:resourcekey="BoundFieldResource10" />
                <asp:BoundField DataField="Note" HeaderText="Nota" meta:resourcekey="BoundFieldResource11" />
                <asp:BoundField DataField="OrderStatus" HeaderText="Estado" meta:resourcekey="BoundFieldResource12" />
            </Columns>

        </asp:GridView>
        <br />
        <b>
            <asp:Localize ID="AddNoteContent" runat="server" meta:resourcekey="AddNoteContentResource1" Text="Add a Note"></asp:Localize>:</b><br />
            <asp:TextBox ID="txtAddNote" runat="server" TextMode="MultiLine" Height="84px" Width="208px" meta:resourcekey="txtAddNoteResource1"></asp:TextBox><br />
            <asp:Button ID="btnAddNote" runat="server" Text="Add" OnClick="btnAddNote_Click1" meta:resourcekey="btnAddNoteResource1" />
        </ContentTemplate>
        </atlas:UpdatePanel>
        <atlas:UpdateProgress ID="uProgress" runat="server">
            <ProgressTemplate>
            <div style="width:500px;text-align:center">
                <img src="../images/spinner.gif" align="absmiddle"/><asp:Localize ID="LoadingContent"
                    runat="server" meta:resourcekey="LoadingContentResource1" Text="Loading"></asp:Localize>...
            </div>
            </ProgressTemplate>
         </atlas:UpdateProgress> 

        </td>
    </tr>
    <%if (OrderController.CanCancel(order))
      { %>
    <tr>
        <td>
        <h2>
            <asp:Localize ID="OrderCancellationContent" runat="server" meta:resourcekey="OrderCancellationContentResource1" Text="Order Cancellation"></asp:Localize></h2>
            <asp:Localize ID="OrderCancellationDescriptionContent" runat="server" meta:resourcekey="OrderCancellationDescriptionContentResource1" Text="You can cancel this order if needed by clicking on the button below.&#13;&#10;        Please be sure to enter a reason why this order was cancelled"></asp:Localize>.
        <br /><br />
         <asp:TextBox ID="txtCancelReason" runat="server" TextMode="MultiLine" Height="84px" Width="208px" meta:resourcekey="txtCancelReasonResource1"></asp:TextBox><br />
         <asp:Button ID="btnCancelOrder" runat="server" Text="Cancel Order" OnClick="btnCancelOrder_Click1" meta:resourcekey="btnCancelOrderResource1" />
         <asp:CheckBox ID="chkRefundCancelledOrder" runat="server" Text="Issue Refund?" meta:resourcekey="chkRefundCancelledOrderResource1" />
            <br />
            </td>
    </tr>
    <%} %>
    <tr>
        <td>
            <h2>
                <asp:Localize ID="OverridesContent" runat="server" meta:resourcekey="OverridesContentResource1" Text="Overrides"></asp:Localize></h2>
            <asp:Localize ID="ChangeStatusTo" runat="server" meta:resourcekey="ChangeStatusToResource1" Text="Change status to"></asp:Localize>:
            <asp:DropDownList ID="ddlStatusID" runat="server" meta:resourcekey="ddlStatusIDResource1">
            </asp:DropDownList>
            <asp:Button ID="btnSetStatus" runat="server" OnClick="btnSetStatus_Click" Text="Set" meta:resourcekey="btnSetStatusResource1" />
            <asp:Label ID="lblOrderID" runat="server" Visible="False" meta:resourcekey="lblOrderIDResource1"></asp:Label>
            <uc1:ResultMessage ID="uResStatus" runat="server" />


        </td>
    </tr>
</table>

<script type="text/ecmascript" >
function CheckRefund(){
		
	return confirm("¿Reembolsar esta transacción? Esta acción es irreversible...");

}</script>
</asp:Content>


