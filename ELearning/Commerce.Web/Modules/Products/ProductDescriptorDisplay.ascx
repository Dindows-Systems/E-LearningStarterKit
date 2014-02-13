<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProductDescriptorDisplay.ascx.cs" Inherits="Modules_Products_ProductDescriptorDisplay" %>
    <%
        foreach (Commerce.Common.ProductDescriptor desc in DescriptorList)
        {
    
    %>
       <div class="productsection">
         <h2><%=desc.Title%></h2>
         <%
             if (desc.IsBulletedList)
             {
         %>
         <ul>
         <%
             string[] sList = desc.Descriptor.Split('\r', '\n');
                foreach (string listItem in sList)
                {
                    if (!String.IsNullOrEmpty(listItem))
                    {
        %>
            <li><%=listItem%></li>
        
        <%
                    }
                }
        %>
        </ul>
        <%
             }
             else
             {
        %>
            <%=Commerce.Common.Utility.ToggleHtmlBR(desc.Descriptor,true)%>
        <%
             }
        %>
    
       </div>
    <%
        }    
    %>