using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;


namespace WekeRoad.Tools
{
    public class DBHelper
    {

        #region Data Access Methods
        /// <summary>
        /// Executes an insert/update command
        /// </summary>
        /// <param name="cmd"></param>
        /// <returns>Primary Key of updated record</returns>
        public static object ExecuteInsertOrUpdate(DbCommand cmd)
        {
            object oOut = null;
            Database db = DatabaseFactory.CreateDatabase();
            try
            {
                oOut = db.ExecuteScalar(cmd);

            }
            finally
            {
                cmd.Dispose();
            }
            return oOut;
        }

        public static IDataReader GetReader(DbCommand cmd)
        {
            IDataReader rdr = null;
            Database db = DatabaseFactory.CreateDatabase();

            try
            {
                rdr = db.ExecuteReader(cmd);
            }
            catch (DbException x)
            {
                string message = "Error on Insert: " + x.Message;
                throw new Exception(message, x);
                if (rdr != null)
                    rdr.Close();
            }
            finally
            {
                //cleanup
                cmd.Dispose();
            }

            return rdr;
        }

        public static DataSet GetDataSet(DbCommand cmd)
        {
            DataSet ds = new DataSet();
            Database db = DatabaseFactory.CreateDatabase();

            try
            {
                ds = db.ExecuteDataSet(cmd);
            }
            finally
            {
                //cleanup
                cmd.Dispose();
            }

            return ds;
        }
        /// <summary>
        /// Executes a passthrough Query
        /// </summary>
        /// <param name="cmd"></param>
        /// <returns>Int32 Representing records effected</returns>
        
        public static int ExecuteQuery(DbCommand cmd)
        {
            int iOut = 0;
            Database db = DatabaseFactory.CreateDatabase();

            try
            {
                iOut = db.ExecuteNonQuery(cmd);
            }
            catch (DbException x)
            {
                string message = "Error on Query Run: " + x.Message;
                throw new Exception(message, x);
            }
            finally
            {
                //cleanup
                cmd.Dispose();
            }

            return iOut;
        }
        public static object ExecuteScalar(DbCommand cmd)
        {
            Database db = DatabaseFactory.CreateDatabase();
            return db.ExecuteScalar(cmd);
        }

        public static IDataReader GetReader(string tableName)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand("SELECT * FROM " + tableName);
            return db.ExecuteReader(cmd);
        }
        #endregion


    
    }


    


        
}
