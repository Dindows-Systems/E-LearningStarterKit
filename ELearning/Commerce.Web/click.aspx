<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    string toPage = Commerce.Common.Utility.GetParameter("p");
    string fromPage = Commerce.Common.Utility.GetParameter("f");
    string productSku = Commerce.Common.Utility.GetParameter("sku");
    int categoryID = Commerce.Common.Utility.GetIntParameter("cid");
    int adID = Commerce.Common.Utility.GetIntParameter("aid");
    
    protected void Page_Load(object sender, EventArgs e){
        if (productSku!=string.Empty)
        {
            toPage = Commerce.Common.Utility.GetRewriterUrl("product", productSku, "");
            
        }else if(categoryID>0){
            Commerce.Common.Category cat = new Commerce.Common.Category(categoryID);
            toPage = Commerce.Common.Utility.GetRewriterUrl("catalog", cat.CategoryName, "");
        }
        //record this
        Commerce.Stats.Tracker.Add(Commerce.Stats.BehaviorType.ClickingOnAd, categoryID,productSku, "", adID, 0, fromPage);
        Response.Redirect(toPage);
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Click</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <!--this page records clicks and forwards on-->
        
    </div>
    </form>
</body>
</html>
