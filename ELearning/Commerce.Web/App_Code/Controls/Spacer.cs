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
    /// Renders a transparent gif image with a particular size.
    /// Default size is 1x1.
    /// </summary>
    public class Spacer : Control
    {
        #region Members

        string htmlImage = "<div><img src=\"{0}\" border=\"0\" width=\"{1}\" height=\"{2}\"></div>";

        #endregion

        protected override void Render(HtmlTextWriter output)
        {
            output.Write(string.Format(htmlImage,
                string.Format("{0}{1}", ImagePath, ImageName),
                Convert.ToInt32(Width.Value).ToString(),
                Convert.ToInt32(Height.Value).ToString()));
        }

        #region Properties

        /// <summary>
        /// Spacer image path.
        /// </summary>
        private string imagePath = null;
        public string ImagePath
        {
            get {
                if (Utility.IsNullOrEmpty(imagePath))
                    imagePath = Utility.GetSiteRoot() + "/images/";

                return (imagePath.EndsWith("/") ? imagePath : string.Format("{0}{1}", imagePath, "/"));
            }
            set { imagePath = value; }
        }

        /// <summary>
        /// Spacer image name. This usually is a 1x1 transparent gif.
        /// </summary>
        private string imageName = null;
        public string ImageName
        {
            get {
                if (Utility.IsNullOrEmpty(imageName))
                    imagePath = "1pix.gif";

                return imagePath;
            }
            set { imagePath = value; }
        }

        /// <summary>
        /// Spacer width.
        /// </summary>
        Unit width = Unit.Pixel(1);
        public Unit Width
        {
            get { return width; }
            set { width = value; }
        }

        /// <summary>
        /// Spacer height.
        /// </summary>
        Unit height = Unit.Pixel(1);
        public Unit Height
        {
            get { return height; }
            set { height = value; }
        }

        #endregion
    }
}
