<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProductCrossSells.ascx.cs" Inherits="Modules_Admin_ProductCrossSells" %>
<%@ Register Src="../ResultMessage.ascx" TagName="ResultMessage" TagPrefix="uc1" %>
<%@ Register Assembly="eWorld.UI" Namespace="eWorld.UI" TagPrefix="ew" %>
<h1>
    <asp:Localize ID="CrossSellsContent" runat="server" meta:resourcekey="CrossSellsContentResource1" Text="Cross-sells"></asp:Localize></h1>

<table class="admintable1">
<tr><td>

       <asp:Label ID="lblID" runat="server" Visible="False" meta:resourcekey="lblIDResource1"></asp:Label>
          <table cellpadding="3" cellspacing="0" >
              <tr>
                  <td class="adminlabel">
                      <asp:Localize ID="ProductsContent" runat="server" meta:resourcekey="ProductsContentResource1" Text="Products"></asp:Localize></td>
                  <td>
                      <asp:CheckBoxList ID="chkProducts" runat="server" CellPadding="5" CellSpacing="2" RepeatColumns="4" meta:resourcekey="chkProductsResource1">
                      </asp:CheckBoxList></td>
              </tr>
                <tr>
                    <td class="adminlabel" style="height: 24px" colspan="2"><asp:Button ID="btnAddCross" runat="server" Text="Save Cross-Sell" OnClick="SaveCrossList" meta:resourcekey="btnAddCrossResource1"/>&nbsp;&nbsp;<uc1:ResultMessage ID="ResultMessage1" runat="server" /></td>                    
                </tr>
            </table>
     </td>
     </tr>
     </table>    
    