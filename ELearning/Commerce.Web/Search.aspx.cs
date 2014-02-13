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

public partial class Search : System.Web.UI.Page {
    protected void Page_Load(object sender, EventArgs e) {

        string sQuery = Commerce.Common.Utility.GetParameter("q");
		RunSearch(sQuery);
		this.Title = string.Format(Resources.Common.SearchResults, sQuery);
		lblQuery.Text = ": '"+sQuery+"'";

    }

	void RunSearch(string sQuery) {
        if (!String.IsNullOrEmpty(sQuery)) {
			//IDataReader rdr = Commerce.Services.StoreDataService.ProductsSmartSearch(500, true, sQuery);
            rptSearch.DataSource = ProductController.RunSmartSearch(50,
                 sQuery); ;
			rptSearch.DataBind();

            if (rptSearch.Items.Count == 0)
                ResultMessage1.ShowFail(Resources.Common.NoResults);
        }
	}
}
