using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Modules_CatalogList1 : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TreeNode padre;
        TreeNode hijo;

        foreach (Commerce.Common.Category cat in CategoryController.CategoryList)
        {

            if (cat.ParentID == 0)
            {
                padre = new TreeNode();
                padre.Text = "<b>" + cat.CategoryName;
                padre.NavigateUrl = Commerce.Common.Utility.GetRewriterUrl("catalog", cat.CategoryName, "");                
                
                //get the kids
                foreach (Commerce.Common.Category subCat in CategoryController.CategoryList)
                {
                    if (subCat.ParentID == cat.CategoryID)
                    {
                        hijo = new TreeNode();
                        hijo.Text = "<span class='subcategory'>" + subCat.CategoryName + "</span>";
                        hijo.NavigateUrl = Commerce.Common.Utility.GetRewriterUrl("catalog", subCat.CategoryName, "");                        
                        padre.ChildNodes.Add(hijo);
                    }
                }
                CatalogTreeView.Nodes.Add(padre);
            }
        }
    }
}
