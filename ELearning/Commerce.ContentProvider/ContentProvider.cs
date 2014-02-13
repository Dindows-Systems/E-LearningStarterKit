using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration.Provider;
using System.Data;

namespace Commerce.Providers
{
    public class ContentProviderCollection : System.Configuration.Provider.ProviderCollection
    {
        public new ContentProvider this[string name]
        {
            get { return (ContentProvider)base[name]; }
        }

        public override void Add(ProviderBase provider)
        {
            if (provider == null)
                throw new ArgumentNullException("provider");

            if (!(provider is ContentProvider))
                throw new ArgumentException
                    (Properties.Resources.InvalidProvider, "provider");

            base.Add(provider);
        }
    }    
    public abstract class ContentProvider : System.Configuration.Provider.ProviderBase
    {
		#region Methods
	        public abstract void ContentDelete(int contentID);
			public abstract IDataReader ContentGet(string contentName);
			public abstract IDataReader ContentGetByGroup(int groupID);
			public abstract IDataReader ContentGetByID(int contentID);
	        public abstract void ContentGROUPSDelete(int groupID);
			public abstract IDataReader ContentGROUPSGet(int groupID);
			public abstract IDataReader ContentGROUPSGetList();
			public abstract int ContentGROUPSInsert(string contentGroup);
	        public abstract void ContentGROUPSUpdate(int groupID, string contentGroup);
	        public abstract void ContentInsert(string contentName, string title, string content, int groupID, string iconPath, string status, string createdBy, DateTime dateExpires, string externalLink, string callOut);
	        public abstract void ContentSave(string contentName, string title, string content, int groupID, string iconPath, string status, string userName, string callOut, string externalLink);
	        public abstract void ContentUpdate(int contentID, string contentName, string title, string content, int groupID, string iconPath, string status, string lastEditedBy, string callOut);
		#endregion

    }

}

