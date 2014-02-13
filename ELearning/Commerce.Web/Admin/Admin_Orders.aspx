<%@ Page Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="Admin_Orders.aspx.cs" Inherits="Admin_Admin_Orders" Title="Orders Admin" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<%@ Register Assembly="eWorld.UI" Namespace="eWorld.UI" TagPrefix="ew" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminPlaceHolder" Runat="Server">


        <h2>
            <asp:Localize ID="SelectOrderContent" runat="server" meta:resourcekey="SelectOrderContentResource1" Text="Select Order"></asp:Localize></h2>
        <table>
            <tr>
                <td class="adminlabel">
                    <asp:Localize ID="UserNameContent" runat="server" meta:resourcekey="UserNameContentResource1" Text="User Name"></asp:Localize></td>
                <td class="adminitem">
                <asp:TextBox ID="txtName" runat="server" Width="160px" meta:resourcekey="txtNameResource1"></asp:TextBox>
                </td>
           </tr>
            <tr>
                <td class="adminlabel">
                    <asp:Localize ID="OrderNumberContent" runat="server" meta:resourcekey="OrderNumberContentResource1" Text="Order Number"></asp:Localize></td>
                <td class="adminitem">
                    <asp:TextBox ID="txtOrderNumber" runat="server" Width="160px" meta:resourcekey="txtOrderNumberResource1"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="adminlabel" valign="top">
                    <asp:Localize ID="DateRangeContent" runat="server" meta:resourcekey="DateRangeContentResource1" Text="Date Range"></asp:Localize></td>
                <td class="adminitem">
                    <asp:Localize ID="BetweenContent" runat="server" meta:resourcekey="BetweenContentResource1" Text="Between"></asp:Localize><br />
                    <ew:calendarpopup id="calStart" runat="server" AllowArbitraryText="False" CellPadding="2px" CellSpacing="0px" Culture="Spanish (Ecuador)" JavascriptOnChangeFunction="" LowerBoundDate="" meta:resourcekey="calStartResource1" SelectedDate="2006-10-17" UpperBoundDate="12/31/9999 23:59:59" VisibleDate="2006-10-17">
                        <SelectedDateStyle BackColor="Yellow" Font-Names="Verdana,Helvetica,Tahoma,Arial"
                            Font-Size="XX-Small" ForeColor="Black" />
                        <WeekendStyle BackColor="LightGray" Font-Names="Verdana,Helvetica,Tahoma,Arial" Font-Size="XX-Small"
                            ForeColor="Black" />
                        <GoToTodayStyle BackColor="White" Font-Names="Verdana,Helvetica,Tahoma,Arial" Font-Size="XX-Small"
                            ForeColor="Black" />
                        <DayHeaderStyle BackColor="Orange" Font-Names="Verdana,Helvetica,Tahoma,Arial" Font-Size="XX-Small"
                            ForeColor="Black" />
                        <MonthHeaderStyle BackColor="Yellow" Font-Names="Verdana,Helvetica,Tahoma,Arial"
                            Font-Size="XX-Small" ForeColor="Black" />
                        <WeekdayStyle BackColor="White" Font-Names="Verdana,Helvetica,Tahoma,Arial" Font-Size="XX-Small"
                            ForeColor="Black" />
                        <OffMonthStyle BackColor="AntiqueWhite" Font-Names="Verdana,Helvetica,Tahoma,Arial"
                            Font-Size="XX-Small" ForeColor="Gray" />
                        <ClearDateStyle BackColor="White" Font-Names="Verdana,Helvetica,Tahoma,Arial" Font-Size="XX-Small"
                            ForeColor="Black" />
                        <TodayDayStyle BackColor="LightGoldenrodYellow" Font-Names="Verdana,Helvetica,Tahoma,Arial"
                            Font-Size="XX-Small" ForeColor="Black" />
                    </ew:calendarpopup>
                    <br />
                    <asp:Localize ID="AndContent" runat="server" meta:resourcekey="AndContentResource1" Text="And"></asp:Localize><br />
                    <ew:calendarpopup id="calEnd" runat="server" AllowArbitraryText="False" CellPadding="2px" CellSpacing="0px" Culture="Spanish (Ecuador)" JavascriptOnChangeFunction="" LowerBoundDate="" meta:resourcekey="calEndResource1" SelectedDate="2006-10-17" UpperBoundDate="12/31/9999 23:59:59" VisibleDate="2006-10-17">
                        <SelectedDateStyle BackColor="Yellow" Font-Names="Verdana,Helvetica,Tahoma,Arial"
                            Font-Size="XX-Small" ForeColor="Black" />
                        <WeekendStyle BackColor="LightGray" Font-Names="Verdana,Helvetica,Tahoma,Arial" Font-Size="XX-Small"
                            ForeColor="Black" />
                        <GoToTodayStyle BackColor="White" Font-Names="Verdana,Helvetica,Tahoma,Arial" Font-Size="XX-Small"
                            ForeColor="Black" />
                        <DayHeaderStyle BackColor="Orange" Font-Names="Verdana,Helvetica,Tahoma,Arial" Font-Size="XX-Small"
                            ForeColor="Black" />
                        <MonthHeaderStyle BackColor="Yellow" Font-Names="Verdana,Helvetica,Tahoma,Arial"
                            Font-Size="XX-Small" ForeColor="Black" />
                        <WeekdayStyle BackColor="White" Font-Names="Verdana,Helvetica,Tahoma,Arial" Font-Size="XX-Small"
                            ForeColor="Black" />
                        <OffMonthStyle BackColor="AntiqueWhite" Font-Names="Verdana,Helvetica,Tahoma,Arial"
                            Font-Size="XX-Small" ForeColor="Gray" />
                        <ClearDateStyle BackColor="White" Font-Names="Verdana,Helvetica,Tahoma,Arial" Font-Size="XX-Small"
                            ForeColor="Black" />
                        <TodayDayStyle BackColor="LightGoldenrodYellow" Font-Names="Verdana,Helvetica,Tahoma,Arial"
                            Font-Size="XX-Small" ForeColor="Black" />
                    </ew:calendarpopup>
                    &nbsp;<br />
                
                </td>
           </tr>
           <tr>
                <td colspan="2"><asp:Button ID="btnDates" runat="server" Text="Go" OnClick="btnDates_Click" meta:resourcekey="btnDatesResource1" /></td>
           </tr>
        </table>
            
            
        <hr />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" meta:resourcekey="GridView1Resource1">
            <Columns>
                <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                    <ItemTemplate>
                        <a href='admin_orders_details.aspx?id=<%# Eval("orderID") %>'>Ver Orden</a>
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:BoundField DataField="orderNumber" HeaderText="Id" meta:resourcekey="BoundFieldResource9" />
                <asp:BoundField DataField="orderDate" HeaderText="Date" meta:resourcekey="BoundFieldResource1" />
                <asp:BoundField DataField="firstName" HeaderText="First" meta:resourcekey="BoundFieldResource2" />
                <asp:BoundField DataField="lastName" HeaderText="Last" meta:resourcekey="BoundFieldResource3" />
                <asp:BoundField DataField="userName" HeaderText="Usuario" />
                <asp:BoundField DataField="orderStatus" HeaderText="Status" meta:resourcekey="BoundFieldResource4" />
                <asp:BoundField DataField="payments" DataFormatString="{0:c}" HeaderText="Payments"   HtmlEncode="False" meta:resourcekey="BoundFieldResource8">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>


</asp:Content>

