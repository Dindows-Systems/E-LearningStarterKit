//===========================================================================
// This file was modified as part of an ASP.NET 2.0 Web project conversion.
// The class name was changed and the class modified to inherit from the abstract base class 
// in file 'App_Code\Migrated\pages\Stub_register_ascx_cs.cs'.
// During runtime, this allows other classes in your web application to bind and access 
// the code-behind page using the abstract base class.
// The associated content page 'pages\register.ascx' was also modified to refer to the new class name.
// For more information on this code pattern, please refer to http://go.microsoft.com/fwlink/?LinkId=46995 
//===========================================================================
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
using System.Web.Security;
using System.Globalization;

namespace yaf.pages
{
	/// <summary>
	/// Summary description for register.
	/// </summary>
	public partial class Migrated_register : register
	{
	
//		public register() : base("REGISTER")
        //public  Migrated_register() : base("REGISTER")
        //{
        //}

		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!User.CanLogin || BoardSettings.DisableRegistrations)
				Data.AccessDenied();

			if(!IsPostBack) {
				PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
				ForumRegister.Text = GetText("register");
				cancel.Text = GetText("Cancel");

				TimeZones.DataSource = Data.TimeZones();
				DataBind();
				TimeZones.Items.FindByValue("0").Selected = true;
			}
		}

		private void cancel_Click(object sender,EventArgs e) {
			Forum.Redirect(Pages.forum);
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			cancel.Click += new EventHandler(cancel_Click);
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

//		static public string CreatePassword(int length) {
//			string valid = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
//			string res = "";
//			Random rnd = new Random();
//			while(0<length--)
//				res += valid[rnd.Next(valid.Length)];
//			return res;
//		}

		protected void ForumRegister_Click(object sender, System.EventArgs e)
		{
			if(Page.IsValid) 
			{
				if(!Utils.IsValidEmail(Email.Text))
				{
					AddLoadMessage(GetText("BAD_EMAIL"));
					return;
				}

				if(DB.user_find(PageBoardID,false,UserName.Text,Email.Text).Rows.Count>0) 
				{
					AddLoadMessage(GetText("ALREADY_REGISTERED"));
					return;
				}

				DB.user_register(this,PageBoardID,UserName.Text,Password.Text,Email.Text,Location.Text,HomePage.Text,TimeZones.SelectedItem.Value,BoardSettings.EmailVerification);
				if(BoardSettings.EmailVerification)
					Forum.Redirect(Pages.info,"i=3");
				else
					Forum.Redirect(Pages.login);
			}
		}
	}
}
