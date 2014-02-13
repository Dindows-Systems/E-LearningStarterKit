//
// This control has its origins in Pager control that belongs to 
// CS project (www.communityserver.org).
//

using System;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.UI;
using System.Web;
using System.Text;
using System.IO;

namespace Commerce.Web.UI.Controls
{
	/// <summary>
	/// Summary description for Pager.
	/// </summary>
	public class HyperLinkPager : Label, INamingContainer 
	{
		#region Member variables

		HyperLink previousLink;
		HyperLink nextLink;
		HyperLink firstLink;
		HyperLink lastLink;
		HyperLink[] pagingHyperLinks;

        public HyperLinkPager()
        {
        }

        #endregion

		#region Render functions

        /// <summary>
        /// This event handler adds the children controls and is resonsible
        /// for determining the template type used for the control.
        /// </summary>
        protected override void CreateChildControls()
        {
            //AutoBindForTotalRecordsValue();

            Controls.Clear();

            // Add Page buttons
            //
            AddPageLinks();

            // Add Previous Next child controls
            //
            AddPreviousNextLinks();

            // Add First Last child controls
            //
            AddFirstLastLinks();
        }

        protected override void Render(HtmlTextWriter writer) 
		{
			int totalPages = CalculateTotalPages();

			// Do we have data?
			//
			if (totalPages <= 1)
				return;

            if (ShowCurrentPage)
                RenderCurrentPage(writer);

			AddAttributesToRender(writer);

			// Render the paging buttons
			//
			writer.AddAttribute(HtmlTextWriterAttribute.Class, this.CssClass, false);

			// Render the first button
			//
			RenderFirst(writer);

			// Render the previous button
			//
			RenderPrevious(writer);
            
			// Render the page button(s)
			//
			RenderPagingButtons(writer);

			// Render the next button
			//
			RenderNext(writer);

			// Render the last button
			//
			RenderLast(writer);
		}

        void RenderCurrentPage(HtmlTextWriter writer)
        {
            writer.Write(string.Format(this.CurrentPageStringFormat, (this.PageIndex + 1), this.CalculateTotalPages(), this.TotalRecords));
        }

		void RenderFirst(HtmlTextWriter writer) 
		{
			int totalPages = CalculateTotalPages();

			if ((PageIndex >= 3) && (totalPages > 5)) 
			{
				firstLink.RenderControl(writer);

				LiteralControl l = new LiteralControl("&nbsp;...&nbsp;");
				l.RenderControl(writer);
			}
		}

		void RenderLast(HtmlTextWriter writer) 
		{
			int totalPages = CalculateTotalPages();

			if (((PageIndex + 3) < totalPages) && (totalPages > 5)) 
			{
				LiteralControl l = new LiteralControl("&nbsp;...&nbsp;");
				l.RenderControl(writer);

				lastLink.RenderControl(writer);
			}
		}

		void RenderPrevious(HtmlTextWriter writer) 
		{
			Literal l;

			if (HasPrevious) 
			{
				previousLink.RenderControl(writer);

				l = new Literal();
				l.Text = "&nbsp;";
				l.RenderControl(writer);
			}
		}

		void RenderNext(HtmlTextWriter writer) 
		{
			Literal l;

			if (HasNext) 
			{

				l = new Literal();
				l.Text = "&nbsp;";
				l.RenderControl(writer);

				nextLink.RenderControl(writer);
			}
		}

		void RenderButtonRange(int start, int end, HtmlTextWriter writer) 
		{
			for (int i = start; i < end; i++) 
			{
				// Are we working with the selected index?
				//
				if (PageIndex == i) 
				{
					// Render different output
					//
					Literal l = new Literal();
					l.Text = "<b>" + (i + 1).ToString() + "</b>";

					l.RenderControl(writer);
				} 
				else 
				{
					pagingHyperLinks[i].RenderControl(writer);
				}
				if ( i < (end - 1) )
					writer.Write(" ");
			}
		}

		void RenderPagingButtons(HtmlTextWriter writer) 
		{
			int totalPages;

			// Get the total pages available
			//
			totalPages = CalculateTotalPages();

			// If we have <= 5 pages display all the pages and exit
			//
			if ( totalPages <= 5) 
			{
				RenderButtonRange(0, totalPages, writer);
			} 
			else 
			{
				int lowerBound = (PageIndex - 2);
				int upperBound = (PageIndex + 3);

				if (lowerBound <= 0) 
					lowerBound = 0;

				if (PageIndex == 0)
					RenderButtonRange(0, 5, writer);

				else if (PageIndex == 1)
					RenderButtonRange(0, (PageIndex + 4), writer);

				else if (PageIndex < (totalPages - 2))
					RenderButtonRange(lowerBound, (PageIndex + 3), writer);

				else if (PageIndex == (totalPages - 2))
					RenderButtonRange((totalPages - 5), (PageIndex + 2), writer);

				else if (PageIndex == (totalPages - 1))
					RenderButtonRange((totalPages - 5), (PageIndex + 1), writer);
			}
		}

		#endregion

		#region ControlTree functions

		void AddPageLinks() 
		{
			// First add the lower page buttons
			//
			pagingHyperLinks = new HyperLink[CalculateTotalPages()];

			// Create the buttons and add them to 
			// the Controls collection
			//
			for (int i = 0; i < pagingHyperLinks.Length; i++) 
			{
				pagingHyperLinks[i] = new HyperLink();
				pagingHyperLinks[i].EnableViewState = false;
				pagingHyperLinks[i].Text = (i + 1).ToString();
				pagingHyperLinks[i].ID = (i + 1).ToString();
				pagingHyperLinks[i].NavigateUrl = CreatePagerURL((i + 1).ToString());
				Controls.Add(pagingHyperLinks[i]);
			}
		}

		void AddFirstLastLinks() 
		{
			int start = 1;
			firstLink = new HyperLink();
			firstLink.ID = Resources.Controls.First;
			firstLink.Text = this.FirstPageText;
			firstLink.NavigateUrl = CreatePagerURL(start.ToString());
			Controls.Add(firstLink);

			int last = CalculateTotalPages();
			lastLink = new HyperLink();
            lastLink.ID = Resources.Controls.Last;
			lastLink.Text = this.LastPageText;
			lastLink.NavigateUrl = CreatePagerURL(last.ToString());
			Controls.Add(lastLink);
		}

		void AddPreviousNextLinks() 
		{
			int previous;
			
			if (this.PageIndex < 2)
				previous = 1;
			else
				previous = this.PageIndex;

			previousLink = new HyperLink();
            previousLink.ID = Resources.Controls.Prev;
			previousLink.Text = this.PreviousPageText;
			previousLink.NavigateUrl = CreatePagerURL(previous.ToString());
			Controls.Add(previousLink);

			int next = this.PageIndex + 2;
			nextLink = new HyperLink();
            nextLink.ID = Resources.Controls.Next;
			nextLink.Text = this.NextPageText;
			nextLink.NavigateUrl = CreatePagerURL(next.ToString());
			Controls.Add(nextLink);
		}

		#endregion

		#region Properties
        
        /// <summary>
        /// Override how this control handles its controls collection
        /// </summary>
        public override ControlCollection Controls
        {
            get
            {
                EnsureChildControls();
                return base.Controls;
            }

        }

		private bool HasPrevious 
		{
			get 
			{
				if (PageIndex > 0)
					return true;

				return false;
			}
		}

		private bool HasNext 
		{
			get 
			{
				if (PageIndex + 1 < CalculateTotalPages() )
					return true;

				return false;
			}
		}

        private bool IsBoundUsingDataSourceID
        {
            get
            {
                return (this.DataSourceID.Length > 0);
            }
        }

        bool showCurrentPage = true;
        public bool ShowCurrentPage
        {
            get { return showCurrentPage; }
            set { showCurrentPage = value; }
        }

        string currentPageStringFormat = Resources.Controls.PageXOfY;
        /// <summary>
        /// CurrentPageStringFormat is the text that should be used to dispaly current page number.
        /// It has been provided to allow custom formatting. 
        /// There are 2 implicit params that you may use: page index and total pages number.
        /// Its implicit format is: "Page {0} of {1} ({2} records) &nbsp;-&nbsp;" and it makes use of both params.
        /// </summary>
        public string CurrentPageStringFormat
        {
            get { return currentPageStringFormat; }
            set { currentPageStringFormat = value; }
        }

        string dataSourceID = string.Empty;
        public string DataSourceID
        {
            get
            {
                object obj1 = ViewState["DataSourceID"];
                if (obj1 != null)
                {
                    dataSourceID = (string)obj1;
                }

                return dataSourceID;
            }
            set
            {
                dataSourceID = value;

                ViewState["DataSourceID"] = dataSourceID;                
            }
        }
 
        string firstPageText = "&lt;&lt;";
        public string FirstPageText
        {
            get { return firstPageText; }
            set { firstPageText = value; }
        }

        string lastPageText = "&gt;&gt;";
        public string LastPageText
        {
            get { return lastPageText; }
            set { lastPageText = value; }
        }

        string previousPageText = "&lt;";
        public string PreviousPageText
        {
            get { return previousPageText; }
            set { previousPageText = value; }
        }

        string nextPageText = "&gt;";
        public string NextPageText
        {
            get { return nextPageText; }
            set { nextPageText = value; }
        }

        int _pageIndex = 0;
        public virtual int PageIndex
        {
            get
            {
                HttpContext context = HttpContext.Current;

                if (Page.IsPostBack && ViewState["PageIndex"] != null)
                {
                    _pageIndex = (int)ViewState["PageIndex"];
                }
                else
                {
                    if (context.Request.QueryString["pageindex"] != null)
                        _pageIndex = int.Parse(context.Request.QueryString["pageindex"]) - 1;
                }

                if (_pageIndex < 0)
                    return 0;
                else
                    return _pageIndex;
            }
            set
            {
                ViewState["PageIndex"] = value;
                _pageIndex = value;
            }
        }

        public virtual int PageSize
        {
            get
            {
                int pageSize = Convert.ToInt32(ViewState["PageSize"]);

                if (pageSize == 0)
                    return 10;

                return pageSize;
            }
            set
            {
                ViewState["PageSize"] = value;
            }

        }

        public int TotalRecords
        {
            get
            {
                return Convert.ToInt32(ViewState["TotalRecords"]);
            }
            set
            {
                ViewState["TotalRecords"] = value;
            }
        }

		#endregion

		#region Helper methodss

		protected virtual string CreatePagerURL(string pageIndex)
		{
            HttpContext context = HttpContext.Current;

            if (context.Request.Url.AbsoluteUri.IndexOf("?") == -1)
			{
                return context.Request.Url.AbsoluteUri.ToString() + "?PageIndex=" + pageIndex;
			}
			else
			{
                if (context.Request.Url.AbsoluteUri.IndexOf("PageIndex=") == -1)
                    return context.Request.Url.AbsoluteUri.ToString() + "&PageIndex=" + pageIndex;
				else
				{
                    return Regex.Replace(context.Request.Url.AbsoluteUri.ToString(), @"PageIndex=(\d+\.?\d*|\.\d+)", "PageIndex=" + pageIndex);
				}
			}
		}

		/// <summary>
		/// Static that caculates the total pages available.
		/// </summary>
		/// 
		public virtual int CalculateTotalPages() 
		{
			int totalPagesAvailable;

			if (TotalRecords == 0)
				return 0;

			// First calculate the division
			//
			totalPagesAvailable = TotalRecords / PageSize;

			// Now do a mod for any remainder
			//
			if ((TotalRecords % PageSize) > 0)
				totalPagesAvailable++;

			return totalPagesAvailable;
		}

        /*
        protected void AutoBindForTotalRecordsValue()
        {
            if (!IsBoundUsingDataSourceID)
                return;

            // Is this bound via ObjectDataSource control?
            // TODO: a better lookup
            //
            ObjectDataSource ods = Page.FindControl(this.DataSourceID) as ObjectDataSource;
            if (ods == null)
            {
                ods = this.Parent.FindControl(this.DataSourceID) as ObjectDataSource;
                if (ods == null)
                    return;
            }

            // Wee need to search for TotalRecords bound parameter in ObjectDataSource
            //
            foreach (Parameter p in ods.SelectParameters)
            {
                if (p is ControlParameter)
                {
                    if (((ControlParameter)p).ControlID == this.ID)
                    {
                        if (((ControlParameter)p).PropertyName.ToLower() == "totalrecords")
                        {

                            // I found the appropriate param
                            //ctrl.Selected += new ObjectDataSourceStatusEventHandler(ObjectDataSource_Selected);
                        }
                    }
                }
            }
        }

        public static void ObjectDataSource_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.OutputParameters["TotalRecords"] != null)
            {
                //this.TotalRecords = Convert.ToInt32(e.OutputParameters["TotalRecords"]);
            }
        }
        */
		#endregion
	}
}
