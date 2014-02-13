
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Text;
using System.Web.Configuration;
using System.Configuration.Provider;
using System.Data;
using System.Data.SqlClient;


namespace Commerce.Providers {
        class SqlContentProvider:ContentProvider {

		
		public override void ContentDelete(int contentID)
		{
			try
			{
                Microsoft.Practices.EnterpriseLibrary.Data.Database db = Microsoft.Practices.EnterpriseLibrary.Data.DatabaseFactory.CreateDatabase();

				string cmd = "CSK_Content_Delete";
	            System.Data.Common.DbCommand dbCommand = db.GetStoredProcCommand(cmd);
				
				db.AddInParameter(dbCommand, "@contentID", DbType.Int32, contentID);

				//return a reader using the Ent Blocks
				db.ExecuteNonQuery(dbCommand);
				dbCommand.Dispose();
			}catch(SqlException x){
				HandleError(x,"CSK_Content_Delete");
			
			}
		}

		
		
		public override System.Data.IDataReader ContentGet(string contentName){
			System.Data.IDataReader rdr=null;
			try
			{
                Microsoft.Practices.EnterpriseLibrary.Data.Database db = Microsoft.Practices.EnterpriseLibrary.Data.DatabaseFactory.CreateDatabase();

				string cmd = "CSK_Content_Get";
	            System.Data.Common.DbCommand dbCommand = db.GetStoredProcCommand(cmd);
				
				db.AddInParameter(dbCommand, "@contentName", DbType.String, contentName);

				//return a reader using the Ent Blocks
				rdr=db.ExecuteReader(dbCommand);
				dbCommand.Dispose();
			}catch(System.Data.SqlClient.SqlException x){
				HandleError(x,"CSK_Content_Get");
			}
			return rdr;		
		}
		
		
		
		
		public override System.Data.IDataReader ContentGetByGroup(int groupID){
			System.Data.IDataReader rdr=null;
			try
			{
                Microsoft.Practices.EnterpriseLibrary.Data.Database db = Microsoft.Practices.EnterpriseLibrary.Data.DatabaseFactory.CreateDatabase();

				string cmd = "CSK_Content_GetByGroup";
	            System.Data.Common.DbCommand dbCommand = db.GetStoredProcCommand(cmd);
				
				db.AddInParameter(dbCommand, "@groupID", DbType.Int32, groupID);

				//return a reader using the Ent Blocks
				rdr=db.ExecuteReader(dbCommand);
				dbCommand.Dispose();
			}catch(System.Data.SqlClient.SqlException x){
				HandleError(x,"CSK_Content_GetByGroup");
			}
			return rdr;		
		}
		
		
		
		
		public override System.Data.IDataReader ContentGetByID(int contentID){
			System.Data.IDataReader rdr=null;
			try
			{
                Microsoft.Practices.EnterpriseLibrary.Data.Database db = Microsoft.Practices.EnterpriseLibrary.Data.DatabaseFactory.CreateDatabase();

				string cmd = "CSK_Content_GetByID";
	            System.Data.Common.DbCommand dbCommand = db.GetStoredProcCommand(cmd);
				
				db.AddInParameter(dbCommand, "@contentID", DbType.Int32, contentID);

				//return a reader using the Ent Blocks
				rdr=db.ExecuteReader(dbCommand);
				dbCommand.Dispose();
			}catch(System.Data.SqlClient.SqlException x){
				HandleError(x,"CSK_Content_GetByID");
			}
			return rdr;		
		}
		
		
		
		public override void ContentGROUPSDelete(int groupID)
		{
			try
			{
                Microsoft.Practices.EnterpriseLibrary.Data.Database db = Microsoft.Practices.EnterpriseLibrary.Data.DatabaseFactory.CreateDatabase();

				string cmd = "CSK_Content_GROUPSDelete";
	            System.Data.Common.DbCommand dbCommand = db.GetStoredProcCommand(cmd);
				
				db.AddInParameter(dbCommand, "@groupID", DbType.Int32, groupID);

				//return a reader using the Ent Blocks
				db.ExecuteNonQuery(dbCommand);
				dbCommand.Dispose();
			}catch(SqlException x){
				HandleError(x,"CSK_Content_GROUPSDelete");
			
			}
		}

		
		
		public override System.Data.IDataReader ContentGROUPSGet(int groupID){
			System.Data.IDataReader rdr=null;
			try
			{
                Microsoft.Practices.EnterpriseLibrary.Data.Database db = Microsoft.Practices.EnterpriseLibrary.Data.DatabaseFactory.CreateDatabase();

				string cmd = "CSK_Content_GROUPSGet";
	            System.Data.Common.DbCommand dbCommand = db.GetStoredProcCommand(cmd);
				
				db.AddInParameter(dbCommand, "@groupID", DbType.Int32, groupID);

				//return a reader using the Ent Blocks
				rdr=db.ExecuteReader(dbCommand);
				dbCommand.Dispose();
			}catch(System.Data.SqlClient.SqlException x){
				HandleError(x,"CSK_Content_GROUPSGet");
			}
			return rdr;		
		}
		
		
		
		
		public override System.Data.IDataReader ContentGROUPSGetList(){
			System.Data.IDataReader rdr=null;
			try
			{
                Microsoft.Practices.EnterpriseLibrary.Data.Database db = Microsoft.Practices.EnterpriseLibrary.Data.DatabaseFactory.CreateDatabase();

				string cmd = "CSK_Content_GROUPSGetList";
	            System.Data.Common.DbCommand dbCommand = db.GetStoredProcCommand(cmd);
				

				//return a reader using the Ent Blocks
				rdr=db.ExecuteReader(dbCommand);
				dbCommand.Dispose();
			}catch(System.Data.SqlClient.SqlException x){
				HandleError(x,"CSK_Content_GROUPSGetList");
			}
			return rdr;		
		}
		
		
			
		public override int ContentGROUPSInsert(string contentGroup){
			int iOut=0;
			try
			{
				System.Data.IDataReader rdr=null;
                Microsoft.Practices.EnterpriseLibrary.Data.Database db = Microsoft.Practices.EnterpriseLibrary.Data.DatabaseFactory.CreateDatabase();

				string cmd = "CSK_Content_GROUPSInsert";
	            System.Data.Common.DbCommand dbCommand = db.GetStoredProcCommand(cmd);
				
				db.AddInParameter(dbCommand, "@contentGroup", DbType.String, contentGroup);

				//return a reader using the Ent Blocks
				rdr=db.ExecuteReader(dbCommand);
				dbCommand.Dispose();
				if(rdr.Read()){
					iOut=(int)rdr[0];
				}
				rdr.Close();
			}catch(SqlException x){
				HandleError(x,"CSK_Content_GROUPSInsert");
			}
			return iOut;		
		}			
		
		public override void ContentGROUPSUpdate(int groupID, string contentGroup)
		{
			try
			{
                Microsoft.Practices.EnterpriseLibrary.Data.Database db = Microsoft.Practices.EnterpriseLibrary.Data.DatabaseFactory.CreateDatabase();

				string cmd = "CSK_Content_GROUPSUpdate";
	            System.Data.Common.DbCommand dbCommand = db.GetStoredProcCommand(cmd);
				
				db.AddInParameter(dbCommand, "@groupID", DbType.Int32, groupID);
				db.AddInParameter(dbCommand, "@contentGroup", DbType.String, contentGroup);

				//return a reader using the Ent Blocks
				db.ExecuteNonQuery(dbCommand);
				dbCommand.Dispose();
			}catch(SqlException x){
				HandleError(x,"CSK_Content_GROUPSUpdate");
			
			}
		}

		
		public override void ContentInsert(string contentName, string title, string content, int groupID, string iconPath, string status, string createdBy, DateTime dateExpires, string externalLink, string callOut)
		{
			try
			{
                Microsoft.Practices.EnterpriseLibrary.Data.Database db = Microsoft.Practices.EnterpriseLibrary.Data.DatabaseFactory.CreateDatabase();

				string cmd = "CSK_Content_Insert";
	            System.Data.Common.DbCommand dbCommand = db.GetStoredProcCommand(cmd);
				
				db.AddInParameter(dbCommand, "@contentName", DbType.String, contentName);
				db.AddInParameter(dbCommand, "@title", DbType.String, title);
				db.AddInParameter(dbCommand, "@content", DbType.String, content);
				db.AddInParameter(dbCommand, "@groupID", DbType.Int32, groupID);
				db.AddInParameter(dbCommand, "@iconPath", DbType.String, iconPath);
				db.AddInParameter(dbCommand, "@status", DbType.String, status);
				db.AddInParameter(dbCommand, "@createdBy", DbType.String, createdBy);
				db.AddInParameter(dbCommand, "@dateExpires", DbType.DateTime, dateExpires);
				db.AddInParameter(dbCommand, "@externalLink", DbType.String, externalLink);
				db.AddInParameter(dbCommand, "@callOut", DbType.String, callOut);

				//return a reader using the Ent Blocks
				db.ExecuteNonQuery(dbCommand);
				dbCommand.Dispose();
			}catch(SqlException x){
				HandleError(x,"CSK_Content_Insert");
			
			}
		}

		
		public override void ContentSave(string contentName, string title, string content, int groupID, string iconPath, string status, string userName, string callOut, string externalLink)
		{
			try
			{
                Microsoft.Practices.EnterpriseLibrary.Data.Database db = Microsoft.Practices.EnterpriseLibrary.Data.DatabaseFactory.CreateDatabase();

				string cmd = "CSK_Content_Save";
	            System.Data.Common.DbCommand dbCommand = db.GetStoredProcCommand(cmd);
				
				db.AddInParameter(dbCommand, "@contentName", DbType.String, contentName);
				db.AddInParameter(dbCommand, "@title", DbType.String, title);
				db.AddInParameter(dbCommand, "@content", DbType.String, content);
				db.AddInParameter(dbCommand, "@groupID", DbType.Int32, groupID);
				db.AddInParameter(dbCommand, "@iconPath", DbType.String, iconPath);
				db.AddInParameter(dbCommand, "@status", DbType.String, status);
				db.AddInParameter(dbCommand, "@userName", DbType.String, userName);
				db.AddInParameter(dbCommand, "@callOut", DbType.String, callOut);
				db.AddInParameter(dbCommand, "@externalLink", DbType.String, externalLink);

				//return a reader using the Ent Blocks
				db.ExecuteNonQuery(dbCommand);
				dbCommand.Dispose();
			}catch(SqlException x){
				HandleError(x,"CSK_Content_Save");
			
			}
		}

		
		public override void ContentUpdate(int contentID, string contentName, string title, string content, int groupID, string iconPath, string status, string lastEditedBy, string callOut)
		{
			try
			{
                Microsoft.Practices.EnterpriseLibrary.Data.Database db = Microsoft.Practices.EnterpriseLibrary.Data.DatabaseFactory.CreateDatabase();

				string cmd = "CSK_Content_Update";
	            System.Data.Common.DbCommand dbCommand = db.GetStoredProcCommand(cmd);
				
				db.AddInParameter(dbCommand, "@contentID", DbType.Int32, contentID);
				db.AddInParameter(dbCommand, "@contentName", DbType.String, contentName);
				db.AddInParameter(dbCommand, "@title", DbType.String, title);
				db.AddInParameter(dbCommand, "@content", DbType.String, content);
				db.AddInParameter(dbCommand, "@groupID", DbType.Int32, groupID);
				db.AddInParameter(dbCommand, "@iconPath", DbType.String, iconPath);
				db.AddInParameter(dbCommand, "@status", DbType.String, status);
				db.AddInParameter(dbCommand, "@lastEditedBy", DbType.String, lastEditedBy);
				db.AddInParameter(dbCommand, "@callOut", DbType.String, callOut);

				//return a reader using the Ent Blocks
				db.ExecuteNonQuery(dbCommand);
				dbCommand.Dispose();
			}catch(SqlException x){
				HandleError(x,"CSK_Content_Update");
			
			}
		}

		#region Error Handling
		void HandleError(SqlException x, string sprocName){
			string sException= string.Format(Properties.Resources.Error, sprocName, x.Message);
			throw new Exception(sException,x);
		}
		
		#endregion

    }
}
