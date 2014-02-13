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
using Commerce.Common;
using System.Collections.Generic;

public partial class Modules_AdContainer : System.Web.UI.UserControl {
	
	public string AdText;
	public DataTable LoadTable = null;
	public bool CanEdit = false;
	public string BoxCssClass = "AdBox";
	protected string PageName = "";
	protected AdCollection Ads;
	private Commerce.Common.AdBoxPlacement boxPlacement;

	public Commerce.Common.AdBoxPlacement BoxPlacement {
		get {
			return boxPlacement;
		}
		set {
			boxPlacement = value;
		}
	}

	protected void Page_Load(object sender, EventArgs e) {
		CanEdit = Page.User.IsInRole("Administrator");
		BindAds();
		FormatAddAnAdURL();
	}

	protected void BindAds() {
		string thisPath = Request.Url.LocalPath;
		PageName = System.IO.Path.GetFileName(thisPath);

		Ads = AdController.GetByPage(PageName, BoxPlacement.ToString());
		repeater.ItemDataBound += new RepeaterItemEventHandler(repeater_ItemDataBound);
		repeater.DataSource = Ads;
		repeater.DataBind();
	}

	protected void repeater_ItemDataBound(object sender, RepeaterItemEventArgs e) {
		MultiView mv = e.Item.FindControl("multiView") as MultiView;
		View view = null;
		string productSku = DataBinder.Eval(e.Item.DataItem, "ProductSku") as string;
		int categoryID = (int)DataBinder.Eval(e.Item.DataItem, "CategoryID");
		if(!CanEdit) {
			if(productSku != string.Empty && productSku != null && productSku != "0") {
				view = mv.FindControl("hasSku") as View;
				mv.SetActiveView(view);
			}
			else if(categoryID != 0) {
				view = mv.FindControl("hasCategoryId") as View;
				mv.SetActiveView(view);
			}
			else {
				view = mv.FindControl("noSkuOrCategoryId") as View;
				mv.SetActiveView(view);
			}
		}
		else {
				view = mv.FindControl("canEdit") as View;
				mv.SetActiveView(view);
		}
	}

	protected string FormatSkuURL(object adId, object productSku) {
		string AdId = adId.ToString();
		string ProductSku = (string)productSku;
		return "~/click.aspx?f=" + Server.UrlEncode(PageName) + "&aid=" + AdId +
			"&sku=" + Server.UrlEncode(ProductSku);
	}

	protected string FormatCategoryIdURL(object adId, object categoryId) {
		string AdId = adId.ToString();
		string CategoryId = categoryId.ToString();
		return "~/click.aspx?f=" + Server.UrlEncode(PageName) + "&aid=" + AdId +
			"&cid=" + CategoryId;
	}



	protected string FormatDblClick(object adId) {
		string AdId = adId.ToString();
		string location = string.Empty;
		location = "showPopWin('admin/content_ad_editor.aspx?id=" + AdId + "&pn=" + PageName +
				"&pl=" + BoxPlacement + "', 650, 600, null)";
		return location;
	}

	protected void FormatAddAnAdURL() {
		string location = string.Empty;
		if(!CanEdit) {
			addAnAd.Visible = false;	
		}
		else {
			location = "showPopWin('admin/content_ad_editor.aspx?pn=" + PageName +
					"&pl=" + BoxPlacement + "', 650, 650, null)";
			addAnAd.Attributes["onclick"] = location;
			addAnAd.Visible = true;
		}
	}

}
