<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MiniCart.ascx.cs" Inherits="Modules_MiniCart" %>

        <div class="coreboxtop"></div>
        <div class="coreboxheader">
            <a href="basket.aspx">Su Carrito</a>
            <%if (tieneDigitalesYaComprados)
              {%>
              <div class="tenpixspacer"></div>
              No puede hacer checkout!
              <%} %>
        </div>
        
        <div class="coreboxbody">            
            <%if (!tieneDigitalesYaComprados)
              {%>
            <asp:Hyperlink ID="lnkCheckoutTop" runat="server" SkinID="Checkout" NavigateUrl="~/checkout.aspx"></asp:Hyperlink>
            <%}else{%>
             <div class="tenpixspacer"></div>
             Retire del carrito los productos digitales que ha comprado con anterioridad (Solo se pueden adquirir una vez). <!--<br />Cualquier duda consultar <a href="Basket.aspx">Mi Carrito</a>.-->
             <div class="tenpixspacer"></div>
             <%} %>
<table>
<asp:Repeater ID="rptBasket" runat="server" OnItemCommand="DeleteItem">
    <ItemTemplate>
                
            <tr>
                <td><img src='<%# Eval("imageFile") %>'  width="40" /></td>
                <td>
                 <div class="smalltext"><b>
                     <asp:Localize ID="AddedOnContent" runat="server" meta:resourcekey="AddedOnContentResource1" Text="Added on"></asp:Localize> 
                     <%# DateTime.Parse(Eval("modifiedOn").ToString()).ToShortDateString() %>
                 </b></div>
                </td>
                <!--
                <td>
                <asp:ImageButton runat="server" ID="imgRemove" ImageUrl="~/images/icons/delete.gif" meta:resourcekey="imgRemoveResource1"></asp:ImageButton>

                </td>
                -->
            </tr>
            <tr>
                <td colspan="2">
                    <a href='product.aspx?id=<%# Eval("productID") %>'>
                        <%# Eval("productName") %>
                    </a>
                      <br />
                    <div class="ourprice">
                        <%# Eval("quantity") %>
                        X 
                        <%# decimal.Parse(Eval("pricePaid").ToString()).ToString("C") %>
                    </div>
                    <asp:Label ID="lblProductID" runat="server" Visible="False" Text='<%# Eval("productID") %>' meta:resourcekey="lblProductIDResource1"></asp:Label>
                    <asp:Label ID="lblSelectedAtts" runat="server" Visible="False" Text='<%# Eval("attributes") %>' meta:resourcekey="lblSelectedAttsResource1"></asp:Label>
                                
                </td>
            </tr>

    </ItemTemplate>
</asp:Repeater>
</table>
<hr />
<div><b>
    <asp:Localize ID="SubtotalContent" runat="server" meta:resourcekey="SubtotalContentResource1" Text="Subtotal"></asp:Localize>: <asp:Label ID="lblSubtotal" runat="server" meta:resourcekey="lblSubtotalResource1"></asp:Label></b>
</div>
<div class="tenpixspacer"></div>
<%if (!tieneDigitalesYaComprados)
 {%>
         <asp:Hyperlink ID="lnkCheckout" runat="server" SkinID="Checkout" NavigateUrl="~/checkout.aspx"></asp:Hyperlink>
<%} %>
</div>
<div class="coreboxbottom"></div>