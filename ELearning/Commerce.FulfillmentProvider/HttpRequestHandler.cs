using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Net;
using System.IO;

namespace Commerce.Providers
{
    public class HttpRequestHandler
    {
        #region Variables
		private string _url;
		#endregion

		#region Properties
		public string Url
		{
			get { return _url; }
			set { _url = value; }
		}
		#endregion

		#region Constructors

        public HttpRequestHandler(string url)
		{
			Url = url;
		}

		#endregion

		#region Methods

		public string POST(string XmlPostData)
		{
			ASCIIEncoding encodedData=new ASCIIEncoding();
			byte[]  byteArray=encodedData.GetBytes(XmlPostData);
			HttpWebRequest wr = (HttpWebRequest) WebRequest.Create(new Uri(Url));
			wr.Method = "POST";
			wr.KeepAlive = false;
			wr.UserAgent = "CSK";
			wr.ContentType = "application/x-www-form-urlencoded";
			wr.ContentLength = XmlPostData.Length;
			Stream SendStream=wr.GetRequestStream();
			SendStream.Write(byteArray,0,byteArray.Length);
			SendStream.Close();
			HttpWebResponse WebResp = (HttpWebResponse) wr.GetResponse();
			string res = "";
			try
			{
				using (StreamReader sr = new StreamReader(WebResp.GetResponseStream()) )
				{
					res = sr.ReadToEnd();
				}
				WebResp.Close();
				return res;
			}
			catch(Exception ex)
			{
				throw new Exception(string.Format( Properties.Resources.HttpRequestFailed, ex.ToString()));
			}
		}
		#endregion
    }
}
