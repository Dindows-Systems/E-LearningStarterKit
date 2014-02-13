using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace Commerce.Web.UI.Controls
{
    /// <summary>
    /// Summary description for ProductRatingDropDownList
    /// </summary>
    public class ProductRatingDropDownList : DropDownList
    {
        public ProductRatingDropDownList()
        {
            Items.Add(new ListItem("-", "0"));
            Items.Add(new ListItem("5" + Resources.Common.Stars, "5"));
            Items.Add(new ListItem("4" + Resources.Common.Stars, "4"));
            Items.Add(new ListItem("3" + Resources.Common.Stars, "3"));
            Items.Add(new ListItem("2" + Resources.Common.Stars, "2"));
            Items.Add(new ListItem("1" + Resources.Common.Stars, "1"));
        }
    }
}
