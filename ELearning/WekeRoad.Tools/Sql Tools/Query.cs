using System;
using System.Collections.Generic;
using System.Text;
using System.Data.Common;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Collections;

namespace WekeRoad.Tools
{
    #region enums
    /// <summary>
    /// Enum for General SQL Functions
    /// </summary>
    public enum AggregateFunction
    {
        None,
        Count,
        Sum,
        Avg,
        Min,
        Max,
        StdDev,
        Var

    }

    /// <summary>
    /// SQL Comparison Operators
    /// </summary>
    public enum Comparison
    {
        Equals,
        NotEquals,
        Like,
        NotLike,
        GreaterThan,
        GreaterOrEquals,
        LessThan,
        LessOrEquals,
        Blank
    }
    #endregion

    #region Support Classes
    public class Join
    {
        private string fromColumn;

        public string FromColumn
        {
            get { return fromColumn; }
            set { fromColumn = value; }
        }
	
        private string  toColumn;

	    public string  ToColumn
	    {
		    get { return toColumn;}
		    set { toColumn = value;}
	    }
	
        private string  joinTable;

        public string  JoinTable
        {
            get { return joinTable; }
            set { joinTable = value; }
        }
	
    }
    /// <summary>
    /// Creates an aggregate function call for ANSI SQL
    /// </summary>
    public class Aggregate
    {

        private  string aggregateString="";

        public  string AggregateString
        {
            get { return aggregateString; }
        }     
        
        private Aggregate()
        {

        }
        public static Aggregate New(AggregateFunction agg, string columnName, string alias){
            Aggregate aggOut = new Aggregate();
            aggOut.aggregateString = Enum.GetName(typeof(AggregateFunction), agg).ToUpper() + "([" + columnName + "]) as '" + alias+"'";
            return aggOut;
        }

    }
    
    /// <summary>
    /// Creates a WHERE clause for a SQL Statement
    /// </summary>
    public class Where
    {

        private string tablName;

        public string TableName
        {
            get { return tablName; }
            set { tablName = value; }
        }
	
        private string columnName;

        public string ColumnName
        {
            get { return columnName; }
            set { columnName = value; }
        }

        private Comparison comp;

        public Comparison Comparison
        {
            get { return comp; }
            set { comp = value; }
        }

        private object paramValue;

        public object ParameterValue
        {
            get { return paramValue; }
            set { paramValue = value; }
        }
	
	
    }
    /// <summary>
    /// Creates an ORDER BY statement for ANSI SQL
    /// </summary>
    public class OrderBy
    {

        private string orderString;

        public string OrderString
        {
            get { return orderString; }
        }



        private OrderBy()
        {

        }


        public static OrderBy Desc(string columnName)
        {
            OrderBy orderBy = new OrderBy();
            orderBy.orderString = " ORDER BY [" + columnName + "] DESC";
            return orderBy;

        }

        public static OrderBy Asc(string columnName)
        {
            OrderBy orderBy = new OrderBy();
            orderBy.orderString = " ORDER BY [" + columnName+"]";
            return orderBy;
        }

    }
    #endregion

    /// <summary>
    /// Creates a SQL Statement and SQL Commands
    /// </summary>
    public class Query
    {
        public static TableSchema.Table BuildTableSchema(string tableName)
        {
            TableSchema.Table schemaTable = new TableSchema.Table(tableName);
            schemaTable.Columns = SchemaService.GetColumns(tableName);

            return schemaTable;
        }
        
        
        /// <summary>
        /// Takes the enum value and returns the proper SQL 
        /// </summary>
        /// <param name="comp"></param>
        /// <returns></returns>
        string GetComparisonOperator(Comparison comp)
        {
            string sOut = "=";
            switch (comp)
            {
                case Comparison.Blank:
                    sOut = " ";
                    break;
                case Comparison.GreaterThan:
                    sOut = ">";
                    break;
                case Comparison.GreaterOrEquals:
                    sOut = ">=";
                    break;
                case Comparison.LessThan:
                    sOut = "<";
                    break;
                case Comparison.LessOrEquals:
                    sOut = "<=";
                    break;
                case Comparison.Like:
                    sOut = " LIKE ";
                    break;
                case Comparison.NotEquals:
                    sOut = " <> ";
                    break;
                case Comparison.NotLike:
                    sOut = " NOT LIKE ";
                    break;
            }
            return sOut;
        }
       
        #region props

        TableSchema.Table table;

        private string  top="100 PERCENT";
        public string  Top
        {
            get { return top; }
            set { top= value; }
        }
	

        private bool distinct;
        public bool Distinct
        {
            get { return distinct; }
            set { distinct = value; }
        }
        

        private string selectList=" * ";

	    public string SelectList
	    {
		    get { return selectList;}
		    set { selectList = value;}
	    }
        private OrderBy orderBy;

        public OrderBy OrderBy
        {
            get { return orderBy; }
            set { orderBy = value; }
        }	
        List<Aggregate> aggregates;
        List<Where> wheres;
        List<Join> joins;

        #endregion

        #region .ctors
        void SetLists()
        {
            wheres = new List<Where>();
            aggregates = new List<Aggregate>();
            joins = new List<Join>();

        }
        public Query(string tableName)
        {
            table = Query.BuildTableSchema(tableName);
            SetLists();
        }
        public Query(TableSchema.Table tbl)
        {
            table = tbl;
            SetLists();
        }
        #endregion

        #region Add Methods for adding WHERE, Aggregates, and Joins
        public void AddInnerJoin(string ToTableName, string FromColumnName, string ToColumnName)
        {
            Join j=new Join();
            j.ToColumn=ToColumnName;
            j.JoinTable=ToTableName;
            j.FromColumn = FromColumnName;

            joins.Add(j);
        }
        public void AddInnerJoin(string ToTableName)
        {
            Join j = new Join();
            j.ToColumn = table.PrimaryKey.ColumnName;
            j.JoinTable = ToTableName;
            j.FromColumn = table.PrimaryKey.ColumnName;

            joins.Add(j);
        }        
        public void AddAggregate(string columnName, AggregateFunction func, string alias)
        {
            Aggregate agg = Aggregate.New(func, columnName, alias);
            AddAggregate(agg);
        }
        public void AddAggregate(Aggregate agg)
        {
            aggregates.Add(agg);
        }

        public void AddWhere(Where where)
        {
            wheres.Add(where);
        }
        public void AddWhere(string columnName, object paramValue)
        {
            AddWhere(table.Name,columnName, Comparison.Equals, paramValue);
            
        }
        public void AddWhere(string tableName, string columnName, object paramValue)
        {
            AddWhere(tableName,columnName, Comparison.Equals, paramValue);

        }
        public void AddWhere(string columnName, Comparison comp, object paramValue)
        {
            AddWhere(table.Name, columnName, comp, paramValue);

        }
        public void AddWhere(string tableName, string columnName, Comparison comp, object paramValue)
        {
            Where w = new Where();
            w.ColumnName = columnName;
            w.ParameterValue = paramValue;
            w.Comparison = comp;
            w.TableName = tableName;
            AddWhere(w);
        }
        #endregion

        #region Command Builders
        /// <summary>
        /// Creates a SELECT command based on the Query object's settings.
        /// If you need a more complex query you should consider using a Stored Procedure
        /// </summary>
        /// <returns>System.Data.Common.DbCommand</returns>
        public DbCommand BuildSelectCommand()
        {
            //get the SQL
            string sql = GetSelectSql();

            //now lets build the command, with the help of the Ent Lib
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand selectCommand = db.GetSqlStringCommand(sql);

            TableSchema.TableColumn column = null;
            foreach (Where where in wheres)
            {
                //get the column so we have more info, like type
                column = table.GetColumn(where.ColumnName);
                if (column != null)
                {
                    db.AddInParameter(selectCommand, "@" + where.ColumnName, column.DataType, where.ParameterValue);
                }
                else
                {
                    //might be a reference to a join table
                    if(where.ColumnName.Contains("ID")){
                        db.AddInParameter(selectCommand, "@" + where.ColumnName, DbType.Int32, where.ParameterValue);
                    }else{
                        db.AddInParameter(selectCommand, "@" + where.ColumnName, DbType.String, where.ParameterValue);
                    }

                }
            }

            return selectCommand;

        }

        /// <summary>
        /// Builds a Delete command based on a give WHERE condition
        /// </summary>
        /// <returns></returns>
        public DbCommand BuildDeleteCommand()
        {
            string sql = "DELETE FROM " + table.Name;
            Database db = DatabaseFactory.CreateDatabase();
            //stub this out
            DbCommand delCommand = db.GetSqlStringCommand("SELECT * FROM foo");

            TableSchema.TableColumn column = null;

            string whereClause=" WHERE ";
            if (wheres.Count > 0)
            {
                foreach (Where where in wheres)
                {
                    column = table.GetColumn(where.ColumnName);
                    
                    //Append the SQL
                    sql += whereClause + where.ColumnName + " " + GetComparisonOperator(where.Comparison) + " @_" + where.ColumnName;
                    
                    //add in the parameter
                    if (column != null)
                    {
                        db.AddInParameter(delCommand, "@_" + where.ColumnName, column.DataType, where.ParameterValue);
                    }
                    else
                    {
                        //can't find the column, so it might be an enum or a join
                        if(where.ColumnName.EndsWith("ID")){
                            db.AddInParameter(delCommand, "@_" + where.ColumnName, DbType.Int32, where.ParameterValue);
                        }else{
                            db.AddInParameter(delCommand, "@_" + where.ColumnName, DbType.String, where.ParameterValue);

                        }
                    }
                    whereClause = " AND ";
                }

            }
            else
            {
                sql = GetDeleteSql();
            }
            delCommand.CommandText = sql;

            return delCommand;
        }
        
        /// <summary>
        /// Builds an update query for this table with the passed-in hash values
        /// </summary>
        /// <param name="updateSettings">The column/value settings</param>
        /// <returns></returns>
        public DbCommand BuildUpdateCommand(Hashtable updateSettings)
        {
            string sql = "UPDATE " + table.Name;
            Database db = DatabaseFactory.CreateDatabase();
            
            //stub this out
            DbCommand updateCommand = db.GetSqlStringCommand("SELECT * FROM foo");

            TableSchema.TableColumn column = null;
            //append the update statements
            IDictionaryEnumerator looper = updateSettings.GetEnumerator();
            string setClause = " SET ";
            while (looper.MoveNext())
            {
                column = table.GetColumn(looper.Key.ToString());
                if (column != null)
                {
                    sql += setClause + looper.Key.ToString() + "=@" + looper.Key.ToString() + ",";
                    db.AddInParameter(updateCommand, "@" + looper.Key.ToString(), column.DataType, looper.Value);
                    setClause = "";
                }
                else
                {
                    //there's no column in this table that corresponds to the passed-in hash
                    //throw an exception
                    throw new Exception("There is no column in " + table.Name + " called " + looper.Key.ToString());
                }
            }
            //trim the comma
            sql = sql.Remove(sql.Length - 1, 1);


            string whereClause = " WHERE ";
            if (wheres.Count > 0)
            {
                foreach (Where where in wheres)
                {
                    column = table.GetColumn(where.ColumnName);

                    //Append the SQL
                    sql += whereClause + where.ColumnName + " " + GetComparisonOperator(where.Comparison) + " @_" + where.ColumnName;

                    //add in the parameter
                    if (column != null)
                        db.AddInParameter(updateCommand, "@_" + where.ColumnName, column.DataType, where.ParameterValue);
                    whereClause = " AND ";
                }

            }

            updateCommand.CommandText = sql;

            return updateCommand;
        }
        #endregion       
        
        #region SQL Builders
        //this is only used with the SQL constructors below
        //it's not used in the command builders above, which need to set the parameters
        //right at the time of the command build
        string BuildWhere()
        {
            string whereClause = " WHERE ";
            string sql = "";
            TableSchema.TableColumn column;
            if (wheres.Count > 0)
            {
                foreach (Where where in wheres)
                {
                    column = table.GetColumn(where.ColumnName);

                    //Append the SQL
                    sql += whereClause + where.ColumnName + " " + GetComparisonOperator(where.Comparison) + " @" + where.ColumnName;

                }

            }
            return sql;

        }
        /// <summary>
        /// Creates a SELECT statement based on the Query object settings
        /// </summary>
        /// <returns></returns>
        public string GetSelectSql()
        {

            string select = "SELECT TOP "+top+" ";
            string groupBy = "";
            string where = "";
            string order = "";
            string join = "";
            string query = "";

            string whereOperator = " WHERE ";

            if (aggregates.Count > 0)
            {
                //if there's an aggregate, do it up first
                string aggList = "";
                string thisAggregate = "";
                groupBy = " GROUP BY ";

                //select * on an aggregate doesn't make sense
                if (selectList.Trim() == "*")
                    selectList = string.Empty;


                foreach (Aggregate agg in aggregates)
                {
                    thisAggregate = agg.AggregateString + ",";
                    if (distinct)
                        thisAggregate = thisAggregate.Replace("(", "(DISTINCT ");
                    aggList += thisAggregate;
                }
                
                //remove trailing comma
                if (aggList.Length > 0)
                {
                    aggList = aggList.Remove(aggList.Length - 1, 1);
                }

                //set the select to the aggregate
                select += aggList;

                //if the passed-in select list is not empty,
                //we need to use a GROUP BY with a HAVING
                //since we will want to group our aggregate
                //with the passed-in columns
                if (selectList.Length > 0)
                {
                    select += ", " + selectList;

                    //need to build a GROUP BY and Having
                    //SQL Rules dictate that whatever's in the select list (minus aggregate functions
                    //needs to be in the GROUP BY. Same for HAVING
                    //if there is a term in HAVING, then it needs to be in the GROUP BY

                    //can't have aliases in the GROUP BY 
                    if (selectList.ToLower().Contains(" as "))
                    {
                        //first, split the selectList by commas
                        if (selectList.Length > 0)
                        {
                            string[] selectCols = selectList.Split(',');
                            if (selectCols.Length > 0)
                            {
                                //string the as bits off each one, and append on to the GROUP BY
                                foreach (string sCol in selectCols)
                                {
                                    groupBy += "[" + sCol.Substring(0, sCol.ToLower().IndexOf(" as ")) + "],";
                                }

                                //remove the trailing comma
                                groupBy = groupBy.Remove(groupBy.Length - 1, 1);

                            }
                        }
                    }
                    else
                    {
                        groupBy += this.selectList;

                    }


                    //if there are columns in the where list, append on a comma
                    if (wheres.Count > 0 && groupBy.Trim() != "GROUP BY")
                        groupBy += ",";

                    //use the WHEREs to append on the bits in the HAVING clause
                    whereOperator = " HAVING ";
                    foreach (Where wHaving in this.wheres)
                    {
                        if (!groupBy.Contains(wHaving.ColumnName))
                            groupBy += "[" + wHaving.ColumnName + "],";
                    }

                    //trim off the last comma
                    if(groupBy.Trim().EndsWith(","))
                        groupBy = groupBy.Remove(groupBy.Length - 1, 1);
                }
                else
                {
                    //there were no passed-in columns
                    //so we can use a WHERE here without a GROUP BY
                    
                    whereOperator = " WHERE ";
                    groupBy = " ";
                }
            }
            else
            {
                //prepend on the "DISTINCT" term
                if(distinct)
                    select += " DISTINCT ";

                select += selectList;
            }

            //append on the selectList, which is a property that can be set
            //and is "*" by default

            select += " FROM " + table.Name;


            //joins
            if (joins.Count > 0)
            {
                foreach(Join j in joins){
                    join += " INNER JOIN " + j.JoinTable + " ON "+table.Name+".[" + j.FromColumn + "]="+j.JoinTable+".[" + j.ToColumn + "] ";

                }


            }

            //now for the wheres...
            //MUST USE parameters to avoid injection issues
            //the following line is my favorite... Moe, Larry, Curly...
            foreach (Where wWhere in wheres)
            {
                where += whereOperator +wWhere.TableName+"."+ wWhere.ColumnName + " " + this.GetComparisonOperator(wWhere.Comparison) + " @" + wWhere.ColumnName;
                whereOperator = " AND ";
            }


            //Finally, do the orderby 
            if (this.orderBy != null)
                order = orderBy.OrderString;

            query = select + join+ groupBy + where + order;

            return query;

        }

        public string GetUpdateSql()
        {
            //split the TablNames and loop out the SQL
            string updateSQL = "UPDATE " + table.Name + " SET ";

            string cols = "";
            int loopCount = 1;

            string colName = "";

            foreach (TableSchema.TableColumn col in table.Columns)
            {
                colName = col.ColumnName;

                //don't want to change the created bits
                if (!col.IsPrimaryKey && colName.ToLower() != "createdby" && colName.ToLower() != "createdon")
                {
                    cols += colName + "=@" + colName+",";

                }
            }
            cols = cols.Remove(cols.Length - 1, 1);

            updateSQL += cols;

            if (wheres.Count == 0)
            {
                updateSQL += " WHERE " + table.PrimaryKey.ColumnName + "=@" + table.PrimaryKey.ColumnName + "; SELECT @" + table.PrimaryKey.ColumnName + " as id";
            }
            else
            {
                updateSQL += BuildWhere();
            }
            return updateSQL;
        }
        /// <summary>
        /// Loops the TableColums[] array for the object, creating a SQL string
        /// for use as an INSERT statement
        /// </summary>
        /// <returns></returns>
        public string GetInsertSql()
        {

            //split the TablNames and loop out the SQL
            string insertSQL = "INSERT INTO " + table.Name;

            string cols = "";
            string pars = "";

            int loopCount = 1;
            string colName = "";

            //if table columns are null toss an exception
            foreach (TableSchema.TableColumn col in table.Columns)
            {
                colName = col.ColumnName;
                if (!col.IsPrimaryKey)
                {
                    cols += colName+",";
                    pars += "@" + colName + ",";


                }
            }
            cols = cols.Remove(cols.Length - 1, 1);
            pars = pars.Remove(pars.Length - 1, 1);
            insertSQL += "(" + cols + ") ";
            insertSQL += "VALUES(" + pars + "); SELECT @@IDENTITY as newID";

            return insertSQL;
        }


        public string GetDeleteSql()
        {
            string sql = "DELETE FROM " + table.Name;
            if (wheres.Count == 0)
            {
                sql+=" WHERE " + table.PrimaryKey.ColumnName + "=@" + table.PrimaryKey.ColumnName;

            }
            else
            {
                sql += BuildWhere();
            }
            return sql;

        }
        #endregion    


    }
}
