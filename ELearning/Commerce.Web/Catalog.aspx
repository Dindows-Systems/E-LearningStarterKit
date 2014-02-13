<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Catalog.aspx.cs" Inherits="Catalog" Title="Cat&aacute;logo" %>

<%@ Register Src="Modules/MainNavigation.ascx" TagName="MainNavigation" TagPrefix="uc4" %>
<%@ Register Src="Modules/Products/ProductSummaryDisplay.ascx" TagName="ProductSummaryDisplay" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table width="770px" border="0" >
<tr>
    <td style="width:25%" >
    <uc4:MainNavigation ID="MainNavigation1" runat="server" />
    <div class="twentypixspacer"></div>
    <center>
        <a href="<%=Page.ResolveUrl("~/affiliatefeed.aspx") %>?catid=<%=categoryID.ToString()%>" target="_blank"><img src="<%=Page.ResolveUrl("images/rss.jpg") %>" /></a>
    
    </center>
    </td>
<td style="width:55%">
<h2><a href="<%=Page.ResolveUrl("~/default.aspx") %>">Inicio</a> >> <asp:Label ID="lblBreadCrumb" runat="server"></asp:Label>
</h2>
    <asp:Image ID="imgHead" runat="server" /><br />
    <asp:Label ID="lblDescription" runat="server"></asp:Label>
    
        <asp:DataList ID="dtProducts" runat="server"  RepeatColumns="2" RepeatDirection="Horizontal">
            <ItemTemplate>
            <uc1:ProductSummaryDisplay ID="ProductSummaryDisplay1" runat="server" 
                ProductName='<%#Eval("ProductName") %>'
                ImageFile='<%#Eval("ImageFile") %>'
                ProductID='<%#Eval("ProductID") %>'
                OurPrice='<%#Eval("OurPrice") %>'
                RetailPrice='<%#Eval("RetailPrice") %>'
                ShippingEstimate='<%#Eval("ShippingEstimate") %>'
                Rating='<%#Eval("Rating") %>'
                SKU='<%#Eval("SKU") %>'
           />
            </ItemTemplate>
        </asp:DataList>

  
</td>
<td style="width:20%">
            <h2><asp:Label ID="lblSubHead" runat="server"></asp:Label></h2>
            <div>
                <asp:Repeater ID="rptSubs" runat="server" >
                <ItemTemplate>
                <!--
                
                  <a href="catalog.aspx?cid=<%#Eval("categoryid") %>" class="subcategory"><%#Eval("categoryName") %></a><br/>
                -->
                <a href="<%#Commerce.Common.Utility.GetRewriterUrl("catalog",Eval("categoryName").ToString(),"") %>" class="subcategory"><%#Eval("categoryName") %></a><br/>
              
                </ItemTemplate>
                </asp:Repeater>
            </div>
            <br />


          <h2 class="shaded">Por Marca</h2>
           <div>
            <asp:Repeater ID="rptManList" runat="server" >
            <ItemTemplate>
               <a href="<%#Commerce.Common.Utility.GetRewriterUrl("catalog",categoryName,"&m="+Eval("manufacturerID").ToString()) %>" class="subcategory"><%#Eval("manufacturer")%></a><br/>
              <!--
              <a href="catalog.aspx?cid=<%=categoryID.ToString()%>&m=<%#Eval("manufacturerID") %>" class="subcategory"><%#Eval("manufacturer") %></a><br/>
              -->
            </ItemTemplate>
            <FooterTemplate>
                <!--
               <a href="catalog.aspx?cid=<%=categoryID.ToString()%>" class="subcategory">Show All</a>
               -->
               <a href="<%#Commerce.Common.Utility.GetRewriterUrl("catalog",categoryName,"") %>" class="subcategory">Mostrar Todos</a><br/>
            </FooterTemplate>
            </asp:Repeater>
            </div>
            <br />
          <h2 class="shaded">Por Precio</h2>
           <div>
           <asp:Repeater ID="rptPriceRanges" runat="server" >
            <ItemTemplate>
               <a href="<%#Commerce.Common.Utility.GetRewriterUrl("catalog",categoryName,"&ps="+Eval("lowRange").ToString()+"&pe="+Eval("hiRange").ToString()) %>" class="subcategory">
               <%#Convert.ToDecimal(Eval("lowRange")).ToString("C") %> - <%#Convert.ToDecimal(Eval("hiRange")).ToString("C")%></a>
               </a><br/>
                <!--
              <a href="catalog.aspx?cid=<%=categoryID.ToString()%>&ps=<%#Eval("lowRange")%>&pe=<%#Eval("hiRange")%>"
              class="subcategory"><%#Convert.ToDecimal(Eval("lowRange")).ToString("C") %> - <%#Convert.ToDecimal(Eval("hiRange")).ToString("C")%></a><br/>
                -->
            </ItemTemplate>
             <FooterTemplate>
               <a href="<%#Commerce.Common.Utility.GetRewriterUrl("catalog",categoryName,"") %>" class="subcategory">Mostrar Todos</a><br/>
            </FooterTemplate>
           </asp:Repeater>
            </div>
        <br />

</td>
</tr>
</table>
</asp:Content>

