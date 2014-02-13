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

public partial class Members_ProductReview : System.Web.UI.Page {
    int productID = 0;
    protected void Page_Load(object sender, EventArgs e) {
        productID = Commerce.Common.Utility.GetIntParameter("id");
        if (!Page.IsPostBack) {
            if (!ReviewExists())
                ToggleEditor(true);
        } else {

        }
    }
    bool ReviewExists() {
        string userName = Commerce.Common.Utility.GetUserName();

        //see if there is a review for this user and product
        ProductReviewCollection revs =ProductController.GetByProductAndAuthor(productID, userName);

        bool bOut = false;

        if (revs.Count>0)
        {
            pnlReview.Visible = false;
            pnlFinished.Visible = false;
            pnlReviewed.Visible = true;
            
            bOut = true;

        }
        return bOut;
    }
    void ToggleEditor(bool showReviewPanel) {
        pnlReview.Visible = showReviewPanel;
        pnlFinished.Visible = !showReviewPanel;

    }
    protected void btnSave_Click(object sender, EventArgs e) {
        string sRating = ddlRating.SelectedValue;
        if (!String.IsNullOrEmpty(sRating)) {
            
            //if the selection is null for some reason
            //default it.
            int rating = int.Parse(sRating);

            //add the review
            string review = Commerce.Common.Utility.StripHTML(txtReview.Text);
            string title = Commerce.Common.Utility.StripHTML(txtTitle.Text);
            try {
                string thisUser=Commerce.Common.Utility.GetUserName();
                
                ProductReview rev = new ProductReview();
                rev.ProductID = productID;
                rev.AuthorName = thisUser;
                rev.Body = review;
                rev.IsApproved = false;
                rev.PostDate = DateTime.Now;
                rev.Rating = rating;
                rev.Title = title;

                rev.Save(thisUser);
                
                ResultMessage1.ShowSuccess(Resources.Common.ReviewSaved);
            } catch (Exception x) {
                ResultMessage1.ShowFail(string.Format(Resources.Common.ReviewNotSaved,x.Message));
            }
        }
        ToggleEditor(false);

    }
}
