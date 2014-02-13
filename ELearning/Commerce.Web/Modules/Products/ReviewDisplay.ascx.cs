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

public partial class Modules_Products_ReviewDisplay : System.Web.UI.UserControl
{
    public Commerce.Common.Product product;
    protected void Page_Load(object sender, EventArgs e)
    {
        rptReviews.DataSource = product.Reviews;
        rptReviews.DataBind();

    }
    protected void PostReviewResponse(object sender, RepeaterCommandEventArgs e)
    {
        Label lblReviewID = (Label)e.Item.FindControl("lblReviewID");
        string commandName = e.CommandName;
        bool bIsHelpful = commandName == "Yes";
        if (lblReviewID != null)
        {
            Label lblThanks = (Label)e.Item.FindControl("lblThanks");

            
            ProductReviewFeedback feedback = new ProductReviewFeedback();
            feedback.ReviewID = int.Parse(lblReviewID.Text);
            feedback.UserName = Utility.GetUserName();
            feedback.IsHelpful = bIsHelpful;
            feedback.Save(Utility.GetUserName());


            if (lblThanks != null)
            {
                if (bIsHelpful)
                {
                    lblThanks.Text = "Thank you for letting us know you liked this review";
                }
                else
                {
                    lblThanks.Text = "Thank you for letting us know you did not like this review";

                }
            }

        }
    }
}
