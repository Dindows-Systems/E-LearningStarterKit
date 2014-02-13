using System;
using System.Collections.Generic;
using System.Text;
using Commerce.Providers;
using System.Configuration;
using System.Configuration.Provider;
using System.Web.Configuration;
using System.Web;
using System.Web.Caching;
using System.Data;

namespace Commerce.Providers
{
    public class ContentService
    {

        #region Provider-specific bits
        private static ContentProvider _provider = null;
        private static ContentProviderCollection _providers = null;
        private static object _lock = new object();

        public ContentProvider Provider
        {
            get { return _provider; }
        }

        public ContentProviderCollection Providers
        {
            get { return _providers; }
        }
        static ContentProvider Instance
        {
            get
            {
                LoadProviders();
                return _provider;
            }
        }
        private static void LoadProviders()
        {
            // Avoid claiming lock if providers are already loaded
            if (_provider == null)
            {
                lock (_lock)
                {
                    // Do this again to make sure _provider is still null
                    if (_provider == null)
                    {
                        // Get a reference to the <imageService> section
                        ContentServiceSection section = (ContentServiceSection)
                            WebConfigurationManager.GetSection
                            ("ContentProviderService");

                        // Load registered providers and point _provider
                        // to the default provider
                        _providers = new ContentProviderCollection();
                        ProvidersHelper.InstantiateProviders
                            (section.Providers, _providers,
                            typeof(ContentProvider));
                        _provider = _providers[section.DefaultProvider];

                        if (_provider == null)
                            throw new ProviderException
                                (Properties.Resources.UnableLoadContentProvider);
                    }
                }
            }
        }
        #endregion
	
	
		#region Services (Business Layer)
		public static void ContentDelete(int contentID){
			Instance.ContentDelete(contentID);
		}		
		
		public static TextEntry ContentGet(string contentName){
			IDataReader rdr=Instance.ContentGet(contentName);
            TextEntry text = new TextEntry();
            text.Load(rdr);
            rdr.Close();
            return text;		
		}
		public static IDataReader ContentGetByGroup(int groupID){
			IDataReader rdr=Instance.ContentGetByGroup(groupID);
			return rdr;		
		}
		public static IDataReader ContentGetByID(int contentID){
			IDataReader rdr=Instance.ContentGetByID(contentID);
			return rdr;		
		}
		public static void ContentGROUPSDelete(int groupID){
			Instance.ContentGROUPSDelete(groupID);
		}		
		
		public static IDataReader ContentGROUPSGet(int groupID){
			IDataReader rdr=Instance.ContentGROUPSGet(groupID);
			return rdr;		
		}
		public static IDataReader ContentGROUPSGetList(){
			IDataReader rdr=Instance.ContentGROUPSGetList();
			return rdr;		
		}
		public static int ContentGROUPSInsert(string contentGroup){
			return Instance.ContentGROUPSInsert(contentGroup);
		}			
		public static void ContentGROUPSUpdate(int groupID, string contentGroup){
			Instance.ContentGROUPSUpdate(groupID, contentGroup);
		}		
		
		public static void ContentInsert(string contentName, string title, string content, int groupID, string iconPath, string status, string createdBy, DateTime dateExpires, string externalLink, string callOut){
			Instance.ContentInsert(contentName, title, content, groupID, iconPath, status, createdBy, dateExpires, externalLink, callOut);
		}		
		
		public static void ContentSave(string contentName, string title, string content, int groupID, string iconPath, string status, string userName, string callOut, string externalLink){
			Instance.ContentSave(contentName, title, content, groupID, iconPath, status, userName, callOut, externalLink);
		}
        public static void ContentSave(string contentName, string title, string content) {
            Instance.ContentSave(contentName, title, content, 0, "", "", "", "", "");
        }		
		public static void ContentUpdate(int contentID, string contentName, string title, string content, int groupID, string iconPath, string status, string lastEditedBy, string callOut){
			Instance.ContentUpdate(contentID, contentName, title, content, groupID, iconPath, status, lastEditedBy, callOut);
		}		
		
		
		#endregion
	
	}
}

