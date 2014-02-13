<%@ Control Language="C#" ClassName="AcceptedPayment" %>
    <div class="twentypixspacer"></div>
    <img src="<%=Page.ResolveUrl("~/images/visa.gif") %>" alt="Aceptamos Visa" />
    <img src="<%=Page.ResolveUrl("~/images/mc.gif")%>" alt="Aceptamos Mastercard"/>
    <img src="<%=Page.ResolveUrl("~/images/amex.gif")%>" alt="Aceptamos American Express"/>
    <img src="<%=Page.ResolveUrl("~/images/discover.gif")%>" alt="Aceptamos Discover"/>
    <img src="<%=Page.ResolveUrl("~/images/echeck.gif")%>" alt="Aceptamos eCheck"/>
    <a href="https://www.paypal.com/cgi-bin/webscr?cmd=xpt/popup/OLCWhatIsPayPal-outside" target="_blank">
    <img src="<%=Page.ResolveUrl("~/images/paypal.gif")%>" alt="Aceptamos PayPal"/>
    </a>