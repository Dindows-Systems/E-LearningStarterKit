/* Yet Another Forum.net
 * Copyright (C) 2003 Bj�rnar Henden
 * http://www.yetanotherforum.net/
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace yaf.pages
{
	/// <summary>
	/// Summary description for profile.
	/// </summary>
	public partial class profile : ForumPage
	{
		protected Repeater ForumAccess;
	
		public profile() : base("PROFILE")
		{
		}

		protected void Page_Load(object sender, System.EventArgs e)
		{
			// 20050909 CHP : BEGIN
			if (IsPrivate && !User.IsAuthenticated)
			{
				if(User.CanLogin)
					Forum.Redirect(Pages.login,"ReturnUrl={0}",Request.RawUrl);
				else
					Forum.Redirect(Pages.forum);
			}
			// 20050909 CHP : END

			if(Request.QueryString["u"] == null)
				Data.AccessDenied();

			if(!IsPostBack) 
			{
				userGroupsRow.Visible = BoardSettings.ShowGroupsProfile || IsAdmin;
				SuspendUnit.Items.Add(new ListItem(GetText("DAYS"),"1"));
				SuspendUnit.Items.Add(new ListItem(GetText("HOURS"),"2"));
				SuspendUnit.Items.Add(new ListItem(GetText("MINUTES"),"3"));
				SuspendUnit.Items.FindByValue("2").Selected = true;
				SuspendCount.Text = "2";

				BindData();
			}
		}

		private void BindData() 
		{
			using(DataTable dt = DB.user_list(PageBoardID,Request.QueryString["u"],true)) 
			{
				if(dt.Rows.Count<1)
					Data.AccessDenied(/*No such user exists*/);
				DataRow user = dt.Rows[0];

				PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
				PageLinks.AddLink(GetText("MEMBERS"),Forum.GetLink(Pages.members));
				PageLinks.AddLink(Server.HtmlEncode(user["Name"].ToString()),Utils.GetSafeRawUrl());
	
				// populate user information controls...
				UserName.Text					=	Server.HtmlEncode(user["Name"].ToString());
				Name.Text							=	Server.HtmlEncode(user["Name"].ToString());
				Joined.Text						=	String.Format("{0}",FormatDateLong((DateTime)user["Joined"]));
				LastVisit.Text				= FormatDateTime((DateTime)user["LastVisit"]);
				Rank.Text							=	user["RankName"].ToString();
				Location.Text					=	Server.HtmlEncode(Utils.BadWordReplace(user["Location"].ToString()));				
				RealName.InnerHtml		= Server.HtmlEncode(Utils.BadWordReplace(user["RealName"].ToString()));
				Interests.InnerHtml		= Server.HtmlEncode(Utils.BadWordReplace(user["Interests"].ToString()));
				Occupation.InnerHtml	= Server.HtmlEncode(Utils.BadWordReplace(user["Occupation"].ToString()));
				Gender.InnerText			= GetText("GENDER" + user["Gender"].ToString());
				
				if(IsAdmin || IsForumModerator)
				{
					EditSignature.CommandArgument = user["UserID"].ToString();
					// when you set the TextBox using .Text it automatically encodes HTML
					UserSignature.Text = user["Signature"].ToString();
				}
				
				double dAllPosts = 0.0;
				if((int)user["NumPostsForum"]>0) 
					dAllPosts = 100.0 * (int)user["NumPosts"] / (int)user["NumPostsForum"];

				Stats.InnerHtml = String.Format("{0:N0}<br/>[{1} / {2}]",
					user["NumPosts"],
					String.Format(GetText("NUMALL"),dAllPosts),
					String.Format(GetText("NUMDAY"),(double)(int)user["NumPosts"] / (int)user["NumDays"])
					);

				// private messages
				Pm.Visible			= User.IsAuthenticated && BoardSettings.AllowPrivateMessages;
				Pm.Text					= GetThemeContents("BUTTONS","PM");
				Pm.NavigateUrl	= Forum.GetLink(Pages.pmessage,"u={0}",user["UserID"]);
				// email link
				Email.Visible		= User.IsAuthenticated && BoardSettings.AllowEmailSending;
				Email.Text			= GetThemeContents("BUTTONS","EMAIL");
				Email.NavigateUrl	= Forum.GetLink(Pages.im_email,"u={0}",user["UserID"]);
				if(IsAdmin) Email.ToolTip = user["Email"].ToString();
				Home.Visible		= user["HomePage"]!=DBNull.Value;
				Home.NavigateUrl	= user["HomePage"].ToString();
				Home.Text			= GetThemeContents("BUTTONS","WWW");
				Blog.Visible		= user["Weblog"]!=DBNull.Value;
				Blog.NavigateUrl	= user["Weblog"].ToString();
				Blog.Text			= GetThemeContents("BUTTONS","WEBLOG");
				Msn.Visible			= User.IsAuthenticated && user["MSN"]!=DBNull.Value;
				Msn.Text			= GetThemeContents("BUTTONS","MSN");
				Msn.NavigateUrl		= Forum.GetLink(Pages.im_email,"u={0}",user["UserID"]);
				Yim.Visible			= User.IsAuthenticated && user["YIM"]!=DBNull.Value;
				Yim.NavigateUrl		= Forum.GetLink(Pages.im_yim,"u={0}",user["UserID"]);
				Yim.Text			= GetThemeContents("BUTTONS","YAHOO");
				Aim.Visible			= User.IsAuthenticated && user["AIM"]!=DBNull.Value;
				Aim.Text			= GetThemeContents("BUTTONS","AIM");
				Aim.NavigateUrl		= Forum.GetLink(Pages.im_aim,"u={0}",user["UserID"]);
				Icq.Visible			= User.IsAuthenticated && user["ICQ"]!=DBNull.Value;
				Icq.Text			= GetThemeContents("BUTTONS","ICQ");
				Icq.NavigateUrl		= Forum.GetLink(Pages.im_icq,"u={0}",user["UserID"]);

				if(BoardSettings.AvatarUpload && user["HasAvatarImage"]!=null && long.Parse(user["HasAvatarImage"].ToString())>0) 
				{
					Avatar.ImageUrl = Data.ForumRoot + "image.aspx?u=" + (Request.QueryString["u"]);
				} 
				else if(user["Avatar"].ToString().Length>0) // Took out BoardSettings.AvatarRemote
				{
					Avatar.ImageUrl = String.Format("{3}image.aspx?url={0}&width={1}&height={2}",
						Server.UrlEncode(user["Avatar"].ToString()),
						BoardSettings.AvatarWidth,
						BoardSettings.AvatarHeight,
						Data.ForumRoot);
				} 
				else 
				{
					Avatar.Visible = false;
				}

				Groups.DataSource = DB.usergroup_list(Request.QueryString["u"]);

				//EmailRow.Visible = IsAdmin;
				ModeratorInfo.Visible = IsAdmin || IsForumModerator;
				SuspendedRow.Visible = !user.IsNull("Suspended");
				if(!user.IsNull("Suspended"))
					ViewState["SuspendedTo"] = FormatDateTime(user["Suspended"]);

				RemoveSuspension.Text = GetText("REMOVESUSPENSION");
				Suspend.Text = GetText("SUSPEND");
				EditSignature.Text = GetText("EDIT_SIGNATURE");

				if(IsAdmin || IsForumModerator)
				{
					using(DataTable dt2 = DB.user_accessmasks(PageBoardID,Request.QueryString["u"]))
					{
						System.Text.StringBuilder html = new System.Text.StringBuilder();
						int nLastForumID = 0;
						foreach(DataRow row in dt2.Rows)
						{
							if(nLastForumID!=(int)row["ForumID"])
							{
								if(nLastForumID!=0)
									html.AppendFormat("</td></tr>");
								html.AppendFormat("<tr><td width='50%' class='postheader'>{0}</td><td width='50%' class='post'>",row["ForumName"]);
								nLastForumID = (int)row["ForumID"];
							}
							else
							{
								html.AppendFormat(", ");
							}
							html.AppendFormat("{0}",row["AccessMaskName"]);
						}
						if(nLastForumID!=0)
							html.AppendFormat("</td></tr>");
						AccessMaskRow.Text = html.ToString();
					}
				}
			}

			LastPosts.DataSource = DB.post_last10user(PageBoardID,Request.QueryString["u"],PageUserID);
			
			DataBind();
		}

		/// <summary>
		/// Edits the user's signature when clicked
		/// </summary>
		/// <param name="sender">The object sender inherit from Page.</param>
		/// <param name="e">The System.EventArgs inherit from Page.</param>
		protected void EditSignature_Command(object sender, CommandEventArgs e)
		{
			string body = UserSignature.Text;
			body = FormatMsg.RepairHtml(this,body,false);

			if(UserSignature.Text.Length>0)
				DB.user_savesignature(e.CommandArgument,body);
			else
				DB.user_savesignature(e.CommandArgument,DBNull.Value);
			
		}

		/// <summary>
		/// Suspends a user when clicked.
		/// </summary>
		/// <param name="sender">The object sender inherit from Page.</param>
		/// <param name="e">The System.EventArgs inherit from Page.</param>
		private void Suspend_Click(object sender, System.EventArgs e) 
		{
			// Admins can suspend anyone not admins
			// Forum Moderators can suspend anyone not admin or forum moderator
			using(DataTable dt=DB.user_list(PageBoardID,Request.QueryString["u"],null)) 
			{
				foreach(DataRow row in dt.Rows) 
				{
					if(int.Parse(row["IsAdmin"].ToString())>0) 
					{
						AddLoadMessage(GetText("ERROR_ADMINISTRATORS"));
						return;
					} 
					if(!IsAdmin && int.Parse(row["IsForumModerator"].ToString())>0) 
					{
						AddLoadMessage(GetText("ERROR_FORUMMODERATORS"));
						return;
					}
				}
			}

			DateTime suspend = DateTime.Now;
			int count = int.Parse(SuspendCount.Text);
			switch(SuspendUnit.SelectedValue) 
			{
				case "1":
					suspend += new TimeSpan(count,0,0,0);
					break;
				case "2":
					suspend += new TimeSpan(0,count,0,0);
					break;
				case "3":
					suspend += new TimeSpan(0,0,count,0);
					break;
			}

			DB.user_suspend(Request.QueryString["u"],suspend);
			BindData();
		}

		private void RemoveSuspension_Click(object sender, System.EventArgs e) 
		{
			DB.user_suspend(Request.QueryString["u"],null);
			BindData();
		}

		protected string GetSuspendedTo() 
		{
			if(ViewState["SuspendedTo"]!=null)
				return (string)ViewState["SuspendedTo"];
			else
				return "";
		}

		protected string FormatBody(object o) 
		{
			DataRowView row = (DataRowView)o;
			string html = FormatMsg.FormatMessage(this,row["Message"].ToString(),new MessageFlags(Convert.ToInt32(row["Flags"])));

			if(row["Signature"].ToString().Length>0) 
			{
				string sig = row["Signature"].ToString();
				
				// don't allow any HTML on signatures
				MessageFlags tFlags = new MessageFlags();
				tFlags.IsHTML = false;

				sig = FormatMsg.FormatMessage(this,sig,tFlags);
				html += "<br/><hr noshade/>" + sig;
			}

			return html;
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			RemoveSuspension.Click += new EventHandler(RemoveSuspension_Click);
			Suspend.Click += new EventHandler(Suspend_Click);
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    

		}
		#endregion

	}
}
