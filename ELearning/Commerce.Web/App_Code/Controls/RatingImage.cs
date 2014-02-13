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

namespace Commerce.Web.UI.Controls
{
    /// <summary>
    /// Summary description for RatingImage
    /// </summary>
    public class RatingImage : PlaceHolder
    {
        protected override void Render(HtmlTextWriter writer)
        {
            HtmlImage image = new HtmlImage();
            image.Border = 0;

            SetRatingImage(ref image);

            image.RenderControl(writer);
        }

        #region Properties

        /// <summary>
        /// Rating image path.
        /// </summary>
        private string imagePath = null;
        public string ImagePath
        {
            get
            {
                if (Utility.IsNullOrEmpty(imagePath))
                    imagePath = Utility.GetSiteRoot() + "/images/rating/";

                return (imagePath.EndsWith("/") ? imagePath : string.Format("{0}{1}", imagePath, "/"));
            }
            set { imagePath = value; }
        }

        /// <summary>
        /// Rating value.
        /// </summary>
        private double rating = 0.0;
        public double Rating
        {
            get {
                if (ViewState != null && ViewState["Rating"] != null)
                    rating = (double)ViewState["Rating"];

                return rating; 
            }
            set { 
                rating = value;

                if (ViewState != null)
                    ViewState["Rating"] = rating;
            }
        }

        private int totalVotes = 0;
        public int TotalVotes
        {
            get { 
                if (ViewState != null && ViewState["TotalVotes"] != null)
                    totalVotes = (int)ViewState["TotalVotes"];

                return totalVotes; 

            }
            set { 
                totalVotes = value;

                if (ViewState != null)
                    ViewState["TotalVotes"] = totalVotes;
            }
        }

        bool showTooltip = false;
        public bool ShowTooltip
        {
            get {
                if (ViewState != null && ViewState["ShowTooltip"] != null)
                    showTooltip = (bool)ViewState["ShowTooltip"];

                return showTooltip; 
            }
            set { 
                showTooltip = value;

                if (ViewState != null)
                    ViewState["ShowTooltip"] = showTooltip;
            }
        }

        #endregion

        #region Helpers

        /// <summary>
        /// Formats rating image path.
        /// </summary>
        protected string BuildImagePath(string imageName)
        {
            return string.Format("{0}{1}", ImagePath, imageName);
        }

        /// <summary>
        /// Selects the right rating image to be displayed.
        /// </summary>
        protected void SetRatingImage(ref HtmlImage ratingImage)
        {
            if (ratingImage == null)
                return;

            string text = "";

            if (Rating <= 0.25)
            {
                ratingImage.Src = BuildImagePath("star_0.gif");
                text = Resources.Common.Terrible;
            }
            else if (Rating <= 0.5)
            {
                ratingImage.Src = BuildImagePath("star_0h.gif");
                text = Resources.Common.Terrible;
            }
            else if (Rating <= 1)
            {
                ratingImage.Src = BuildImagePath("star_1.gif");
                text = Resources.Common.Poor;
            }
            else if (Rating <= 1.5)
            {
                ratingImage.Src = BuildImagePath("star_1h.gif");
                text = Resources.Common.Poor;
            }
            else if (Rating <= 2)
            {
                ratingImage.Src = BuildImagePath("star_2.gif");
                text = Resources.Common.Fair;
            }
            else if (Rating <= 2.5)
            {
                ratingImage.Src = BuildImagePath("star_2h.gif");
                text = Resources.Common.Fair;
            }
            else if (Rating <= 3)
            {
                ratingImage.Src = BuildImagePath("star_3.gif");
                text = Resources.Common.Average;
            }
            else if (Rating <= 3.5)
            {
                ratingImage.Src = BuildImagePath("star_3h.gif");
                text = Resources.Common.Average;
            }
            else if (Rating <= 4)
            {
                ratingImage.Src = BuildImagePath("star_4.gif");
                text = Resources.Common.Good;
            }
            else if (Rating <= 4.5)
            {
                ratingImage.Src = BuildImagePath("star_4h.gif");
                text = Resources.Common.Good;
            }
            else
            {
                ratingImage.Src = BuildImagePath("star_5.gif");
                text = Resources.Common.Excellent;
            }

            if (!ShowTooltip)
                return;

            if (Rating == 0)
                ratingImage.Alt = Resources.Common.NotRated;
                //ratingImage.Alt = string.Format("Rated {0} [{1} out of 5]", text, "0");
            else
                ratingImage.Alt = string.Format(Resources.Common.RatedDescription, text, Rating.ToString("#.##"), TotalVotes);
        }

        #endregion
    }
}
