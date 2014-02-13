using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;
using System.Data;
using System.Data.SqlClient;

namespace WekeRoad.Tools
{
    

    
    public class SchemaService
    {
        public const string TABLE_COLUMN_SQL = "	SELECT     TABLE_CATALOG AS [Database], TABLE_SCHEMA AS Owner, TABLE_NAME AS TableName, COLUMN_NAME AS ColumnName,  " +
                          "ORDINAL_POSITION AS OrdinalPosition, COLUMN_DEFAULT AS DefaultSetting, IS_NULLABLE AS IsNullable, DATA_TYPE AS DataType,  " +
                          "CHARACTER_MAXIMUM_LENGTH AS MaxLength, NUMERIC_PRECISION AS Precision, DATETIME_PRECISION AS DatePrecision " +
                           "FROM         INFORMATION_SCHEMA.COLUMNS " +
                           "WHERE     (TABLE_NAME = @tblName) ";

        public const string SP_PARAM_SQL="SELECT     SPECIFIC_CATALOG AS [Database], SPECIFIC_SCHEMA AS Owner, SPECIFIC_NAME AS SPName, ORDINAL_POSITION AS OrdinalPosition,  " +
	                      "PARAMETER_MODE AS ParamType, IS_RESULT AS IsResult, PARAMETER_NAME AS Name, DATA_TYPE AS DataType,  " +
	                      "CHARACTER_MAXIMUM_LENGTH AS DataLength, REPLACE(PARAMETER_NAME, '@', '') AS CleanName " +
	                      "FROM         INFORMATION_SCHEMA.PARAMETERS " +
	                      "WHERE SPECIFIC_NAME=@spName";

        public const string SP_SQL = "	SELECT     SPECIFIC_CATALOG AS [Database], SPECIFIC_SCHEMA AS Owner, SPECIFIC_NAME AS Name, ROUTINE_DEFINITION AS SQL, CREATED AS CreatedOn, " +
                          "LAST_ALTERED AS ModifiedOn " +
                          "FROM         INFORMATION_SCHEMA.ROUTINES " +
                           "WHERE     (SPECIFIC_NAME = @spName) ";

        public const string TABLE_SQL = "SELECT     TABLE_CATALOG AS [Database], TABLE_SCHEMA AS Owner, TABLE_NAME AS Name, TABLE_TYPE "+
	            "FROM         INFORMATION_SCHEMA.TABLES "+
                "WHERE     (TABLE_TYPE = 'BASE TABLE') AND (TABLE_NAME <> N'sysdiagrams') " +
	            "AND TABLE_NAME=@tblName";


        public static TableSchema.TableColumnCollection GetColumns(string tblName)
        {


            TableSchema.TableColumnCollection columns = new TableSchema.TableColumnCollection();
            TableSchema.TableColumn column;

            Database db = DatabaseFactory.CreateDatabase();
            using (DbCommand cmd = db.GetSqlStringCommand(TABLE_COLUMN_SQL))
            {
                db.AddInParameter(cmd, "@tblName", DbType.String, tblName);
                IDataReader rdr = db.ExecuteReader(cmd);

                while (rdr.Read())
                {
                    column = new TableSchema.TableColumn();
                    column.ColumnName = rdr["columnName"].ToString();
                    column.DataType = GetDbType(rdr["datatype"].ToString().ToLower());
                    int maxLength = 100;
                    int.TryParse(rdr["maxlength"].ToString(), out maxLength);
                    column.MaxLength = maxLength;
                    int ordinal = (int)rdr["ordinalPosition"];
                    if (ordinal == 1)
                        column.IsPrimaryKey = true;
                    column.IsForiegnKey = column.ColumnName.EndsWith("ID");
                    column.IsNullable = rdr["IsNullable"].ToString() == "YES";
                    columns.Add(column);
                }
                rdr.Close();


            }
            return columns;

        }
        internal static DbType GetDbType(string sqlType)
        {
            DbType dbType = DbType.String;
            switch (sqlType)
	        {
		        case "bigint": return DbType.Int64;
		        case "binary": return DbType.Binary;
		        case "bit": return DbType.Boolean;
		        case "char": return DbType.AnsiStringFixedLength;
		        case "datetime": return DbType.DateTime;
		        case "decimal": return DbType.Decimal;
		        case "float": return DbType.Decimal;
		        case "image": return DbType.Byte;
		        case "int": return DbType.Int32;
		        case "money": return DbType.Currency;
		        case "nchar": return DbType.String;
                case "ntext": return DbType.String;
                case "numeric": return DbType.Decimal;
                case "nvarchar": return DbType.String;
                case "real": return DbType.Decimal;
                case "smalldatetime": return DbType.DateTime;
                case "smallint": return DbType.Int16;
		        case "smallmoney": return DbType.Currency;
                case "sql_variant": return DbType.String;
                case "sysname": return DbType.String;
                case "text": return DbType.String;
		        case "timestamp": return DbType.Time;
		        case "tinyint": return DbType.Int16;
                case "uniqueidentifier": return DbType.Guid;
		        case "varbinary": return DbType.Byte;
                case "varchar": return DbType.String;
		        default: return DbType.String;
	        }

        }

    
    }
}
