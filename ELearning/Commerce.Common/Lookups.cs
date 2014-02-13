using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;


namespace Commerce.Common
{

    public static class Lookups
    {
        /// <summary>
        /// This is a simple function to use with lookup tables
        /// that are not represented with a business object.
        /// </summary>
        /// <param name="tableName">Name of the table to query. All results will be returned</param>
        /// <returns>IDataReader</returns>
        public static IDataReader GetList(string tableName)
        {
            IDataReader rdr=null;
            DbCommand dbCommand = null;
            Database db = Helper.GetDB();
            try
            {
                using (dbCommand = db.GetSqlStringCommand("SELECT * FROM "+tableName))
                {

                    rdr = db.ExecuteReader(dbCommand);

                }
            }
            finally
            {
                dbCommand.Dispose();

            }
            return rdr;
        }

        /// <summary>
        /// This is a simple function to use with lookup tables
        /// that are not represented with a business object.
        /// You can supply a parameter name and value
        /// </summary>
        /// <param name="tableName">The name of the table</param>
        /// <param name="paramField">The column to use </param>
        /// <param name="paramValue">The column value</param>
        /// <returns></returns>
        public static IDataReader GetListByIntParam(string tableName, string paramField, int paramValue)
        {
            IDataReader rdr=null;
            DbCommand dbCommand = null;
            Database db = Helper.GetDB();
            try
            {
                using (dbCommand = db.GetSqlStringCommand("SELECT * FROM "+tableName+" WHERE "+paramField+"=@"+paramField))
                {
                    db.AddInParameter(dbCommand, "@" + paramField, DbType.Int32, paramValue);
                    rdr = db.ExecuteReader(dbCommand);

                }
            }
            finally
            {
                dbCommand.Dispose();

            }
            return rdr;
        }
        /// <summary>
        /// This is a simple function to use with lookup tables
        /// that are not represented with a business object.
        /// You can supply a parameter name and value
        /// </summary>
        /// <param name="tableName">The name of the table</param>
        /// <param name="paramField">The column to use </param>
        /// <param name="paramValue">The column value</param>
        /// <returns></returns>
        public static IDataReader GetListByStringParam(string tableName, string paramField, string paramValue)
        {
            IDataReader rdr=null;
            DbCommand dbCommand = null;
            Database db = Helper.GetDB();
            try
            {
                using (dbCommand = db.GetSqlStringCommand("SELECT * FROM "+tableName+" WHERE "+paramField+"=@"+paramField))
                {
                    db.AddInParameter(dbCommand, "@" + paramField, DbType.String, paramValue);
                    rdr = db.ExecuteReader(dbCommand);

                }
            }
            finally
            {
                dbCommand.Dispose();

            }
            return rdr;
        }

        public static void QuickAdd(string tableName, string paramField, string paramValue)
        {
            DbCommand dbCommand = null;
            Database db = Helper.GetDB();
            try
            {
                using (dbCommand = db.GetSqlStringCommand("INSERT INTO " + tableName + " ("+paramField+") VALUES(@p1) "))
                {
                    db.AddInParameter(dbCommand, "@p1", DbType.String, paramValue);
                    db.ExecuteNonQuery(dbCommand);

                }
            }
            finally
            {
                dbCommand.Dispose();

            }
        }
    
    }
}
