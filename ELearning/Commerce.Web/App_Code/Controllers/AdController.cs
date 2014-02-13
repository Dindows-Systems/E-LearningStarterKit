using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Commerce.Common;
using WekeRoad.Tools;

/// <summary>
/// Summary description for AdController
/// </summary>
public static class AdController
{
    public static AdCollection GetByPage(string pageName, string placement){
        Query q = new Query(Ad.GetTableSchema());
        q.AddWhere("pageName", pageName);
        q.AddWhere("placement", placement);
        AdCollection list = new AdCollection();
        list.Load(DBHelper.GetReader(q.BuildSelectCommand()));
        return list;
    }
}
