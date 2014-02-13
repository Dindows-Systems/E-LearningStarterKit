using System;
using System.Collections.Generic;
using System.Text;
using System.Data; 
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Collections;
using System.Web.UI.WebControls;
using System.Xml.Serialization;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace WekeRoad.Tools
{
    /// <summary>
    /// Base class for persisting objects. Follows the "Active Record Design Pattern".
    /// You can read more on this pattern at http://en.wikipedia.org/wiki/Active_Record
    /// </summary>
    /// <typeparam name="T"></typeparam>
    [Serializable]
    public abstract class ActiveRecord<T> where T:ActiveRecord<T>,new()
    {

        #region Base Properties

        #region State Properties

        public bool IsLoaded = false;

        protected bool isNew = true;
        /// <summary>
        /// True if data in the object needs to be saved
        /// </summary>
        public bool IsNew
        {
            get
            {
                return isNew;
            }
            set
            {
                isNew = value;
            }
        }

        protected bool isDirty = false;
        /// <summary>
        /// True if data in the object has been changed and differs from DB.
        /// </summary>
        public bool IsDirty
        {
            get
            {
                return isDirty;
            }
        }

        /// <summary>
        /// Automatically called upon object creation. Sets IsNew to true;
        /// </summary>
        protected void MarkNew()
        {
            this.isNew = true;
        }

        /// <summary>
        /// Called after any property is set. Sets IsDirty to True.
        /// </summary>
        protected void MarkDirty()
        {
            this.isDirty = true;
        }

        protected void MarkOld()
        {
            this.isNew = false;
        }

        private string tableName;
        /// <summary>
        /// Name of the table
        /// </summary>
        public string TableName
        {
            get { return tableName; }
            set { tableName = value; }
        }



        #endregion 

        
        
        public DateTime CreatedOn
        {
            get
            {
                DateTime dOut = DateTime.Now;
                DateTime.TryParse(this.GetColumnValue("createdOn").ToString(), out dOut);
                return dOut;
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("createdOn", value);

            }
        }
        public string ModifiedBy
        {
            get
            {
                return this.GetColumnValue("modifiedBy").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("modifiedBy", value);

            }
        }
        public DateTime ModifiedOn
        {
            get
            {
                DateTime dOut = DateTime.Now;
                DateTime.TryParse(this.GetColumnValue("modifiedOn").ToString(), out dOut);
                return dOut;
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("modifiedOn", value);

            }
        }
        public string CreatedBy
        {
            get
            {
                return this.GetColumnValue("createdBy").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("createdBy", value);

            }
        }
        private TableSchema.TableColumn primaryKeyColumn;
        public TableSchema.TableColumn PrimaryKeyColumn
        {
            get { return primaryKeyColumn; }
            set { primaryKeyColumn = value; }
            
        }

        public TableSchema.TableColumn[] TableColumns;

        #endregion

        #region DB Properties/Methods

        protected object GetDefaultSetting(TableSchema.TableColumn column)
        {
            object oOut = 0;

            switch (column.DataType)
            {
                case DbType.Xml:
                case DbType.String:
                case DbType.AnsiString:
                case DbType.StringFixedLength:
                case DbType.AnsiStringFixedLength:
                    oOut=string.Empty;
                    break;
                case DbType.Date:
                case DbType.DateTime:
                    oOut=new DateTime(1900,01,01);
                    break;
                case DbType.Boolean:
                    oOut = false;
                    break;
                case DbType.Guid:
                    oOut = System.Guid.NewGuid();
                    break;
                default:
                    oOut = 0;
                    break;
            }
            return oOut;

        }


        /// <summary>
        /// The column settings hold the current values of the object in a collection
        /// so that reflection is not needed in the base class to fill out the commands
        /// </summary>
        TableSchema.TableColumnSettingCollection columnSettings = null;
     

        private static TableSchema.Table table;
        /// <summary>
        /// The base static class that holds all schema info for the table.
        /// The class must be instanced at least once to populate this table.
        /// </summary>
        public static TableSchema.Table Table
        {
            get { return table; }
            set { table = value; }

        }
        /// <summary>
        /// Sets the Primary Key of the object
        /// </summary>
        /// <param name="oValue"></param>
        void SetPrimaryKey(object oValue)
        {
            this.columnSettings.SetValue(Table.PrimaryKey.ColumnName, oValue);

        }

        /// <summary>
        /// Returns the current value of the primary key
        /// </summary>
        /// <returns></returns>
        object GetPrimaryKeyValue()
        {
            return this.columnSettings.GetValue(Table.PrimaryKey.ColumnName).ToString();

        }
        
        protected void SetColumnValue(string columnName, object oValue)
        {
            if (columnSettings == null)
                columnSettings = new TableSchema.TableColumnSettingCollection();
            columnSettings.SetValue(columnName, oValue);
        }

        /// <summary>
        /// Returns the current value of a column.
        /// </summary>
        /// <param name="columnName"></param>
        /// <returns></returns>
        protected object GetColumnValue(string columnName)
        {
            object oOut = null;
            TableSchema.TableColumn col = Table.GetColumn(columnName);

            if (columnSettings != null)
            {
                oOut = columnSettings.GetValue(columnName);
            }

            return oOut;
        }
        #endregion

        #region default constructor
        public ActiveRecord()
        {
            this.MarkNew();

        }
        protected void LoadByParam(string columnName, object paramValue)
        {
            this.MarkOld();
            IDataReader rdr = null;
            try
            {
                Query q = new Query(Table);
                q.AddWhere(columnName, paramValue);
                rdr = DBHelper.GetReader(q.BuildSelectCommand());
                if (rdr.Read())
                {
                    Load(rdr);
                }
                else
                {
                    //if no records, this is new still
                    this.MarkNew();

                }
            }
            finally
            {
                rdr.Close();

            }
        }
        protected void LoadByKey(int keyID){
            this.MarkOld();
            IDataReader rdr = null;
            try
            {
                Query q = new Query(Table);
                q.AddWhere(Table.PrimaryKey.ColumnName, keyID);
                rdr = DBHelper.GetReader(q.BuildSelectCommand());
                if (rdr.Read())
                {
                    Load(rdr);
                }
                else
                {
                    //if no records, this is new still
                    this.MarkNew();

                }
            }
            finally
            {
                rdr.Close();

            }
        }

        #endregion

        #region Class Methods

        #region Serializers
        public string ToXML()
        {
            Type type = typeof(T);
            XmlSerializer ser = new XmlSerializer(type);
            using (System.IO.MemoryStream stm = new System.IO.MemoryStream())
            {

                //serialize to a memory stream
                ser.Serialize(stm, this);

                //reset to beginning so we can read it.  
                stm.Position = 0;
                //Convert a string. 
                using (System.IO.StreamReader stmReader = new System.IO.StreamReader(stm))
                {
                    string xmlData = stmReader.ReadToEnd();
                    return xmlData;
                }
            }
        }
        /// <summary>
        /// Returns an object based on the passed-in XML.
        /// </summary>
        /// <param name="xml"></param>
        /// <returns></returns>
        public object NewFromXML(string xml)
        {
            object oOut = null;
            Type type = typeof(T);
            //hydrate based on private string var
            if (xml.Length > 0)
            {
                System.Xml.Serialization.XmlSerializer serializer = new System.Xml.Serialization.XmlSerializer(type);
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(xml);
                System.IO.StringReader sReader = new System.IO.StringReader(xml);
                oOut = serializer.Deserialize(sReader);
                sb = null;
                sReader.Close();
            }

            return oOut;
        }

        #endregion

        #region CommandMethods

        public DbCommand GetSelectCommand()
        {
            Database db = DatabaseFactory.CreateDatabase();
            Query q = new Query(Table);
            DbCommand cmd = db.GetSqlStringCommand(q.GetSelectSql());

            return cmd;

        }
        /// <summary>
        /// Made Public for use with transactions
        /// </summary>
        /// <param name="userName"></param>
        /// <returns></returns>
        public DbCommand GetInsertCommand(string userName)
        {
            Database db = DatabaseFactory.CreateDatabase();
            Query q = new Query(Table);
            DbCommand cmd = db.GetSqlStringCommand(q.GetInsertSql());

            //loop the Columns and addin the params
            object oVal = null;
            foreach (TableSchema.TableColumn column in Table.Columns)
            {


                switch (column.ColumnName.ToLower())
                {
                    case "createdby":
                        oVal = userName;
                        break;
                    case "modifiedby":
                        oVal = userName;
                        break;
                    case "createdon":
                        oVal = DateTime.Now;
                        break;
                    case "modifiedon":
                        oVal = DateTime.Now;
                        break;
                    default:
                        oVal = this.GetColumnValue(column.ColumnName);
                        break;
                }
                db.AddInParameter(cmd, "@" + column.ColumnName, column.DataType, oVal);
            }

            return cmd;

        }
        public DbCommand GetUpdateCommand(string userName)
        {
            Database db = DatabaseFactory.CreateDatabase();
            Query q = new Query(Table);
            DbCommand cmd = db.GetSqlStringCommand(q.GetUpdateSql());

            //loop the Columns and addin the params
            object oVal = null;
            foreach (TableSchema.TableColumn column in Table.Columns)
            {
                switch (column.ColumnName.ToLower())
                {
                    case "modifiedby":
                        oVal = userName;
                        break;
                    case "modifiedon":
                        oVal = DateTime.Now;
                        break;
                    default:
                        oVal = this.GetColumnValue(column.ColumnName);
                        break;
                }

                db.AddInParameter(cmd, "@" + column.ColumnName, column.DataType, oVal);
            }
            return cmd;
        }
        public static DbCommand GetDeleteCommand(int keyID)
        {
            Database db = DatabaseFactory.CreateDatabase();
            Query q = new Query(Table);
            DbCommand cmd = db.GetSqlStringCommand(q.GetDeleteSql());

            db.AddInParameter(cmd, "@" + Table.PrimaryKey.ColumnName, DbType.Int32, keyID);
            return cmd;
        }

        #endregion

        #endregion
       
        #region Persistence
        /// <summary>
        /// Saves this object's state to the selected Database.
        /// </summary>
        /// <param name="userName"></param>
        public void Save(string userName)
        {
            DbCommand cmd = null;
            try
            {
                if (this.IsNew)
                {
                    cmd = GetInsertCommand(userName);
                }
                else
                {
                    cmd = GetUpdateCommand(userName);
                }

                //reset the Primary Key with the id passed back by the operation
                object pkVal = DBHelper.ExecuteInsertOrUpdate(cmd);
                
                //set the primaryKey
                SetPrimaryKey(pkVal);

                //set this object as old
                this.MarkOld();
            }
            finally
            {
                cmd.Dispose();
            }


        }

        public static int Delete(int keyID)
        {
            DbCommand cmd = GetDeleteCommand(keyID);
            int iOut = 0;
            try
            {
                iOut = DBHelper.ExecuteQuery(cmd);
            }
            finally
            {
                cmd.Dispose();
            }
            return iOut;
        }
        #endregion

        #region Loaders
        /// <summary>
        /// Loads the object with the current reader's values. Assumes the reader is already moved to 
        /// first position in recordset (aka has been "Read()")
        /// </summary>
        /// <param name="rdr"></param>
        public void Load(IDataReader rdr)
        {
            foreach (TableSchema.TableColumn col in Table.Columns)
            {
                try { this.SetColumnValue(col.ColumnName, rdr[col.ColumnName]); }
                catch { }
            }
            this.IsLoaded = true;
        }
        /// <summary>
        /// Loads the object with the current reader's values. Assumes the reader is already moved to 
        /// first position in recordset (aka has been "Read()")
        /// </summary>
        /// <param name="rdr"></param>
        public void Load(DataTable tbl)
        {
            if (tbl.Rows.Count > 0)
            {
                DataRow dr = tbl.Rows[0];
                Load(dr);
                this.IsLoaded = true;
            }
        }
        /// <summary>
        /// Loads the object with the current DataRow's values. 
        /// </summary>
        /// <param name="rdr"></param>
        public void Load(DataRow dr)
        {
            foreach (TableSchema.TableColumn col in Table.Columns)
            {
                try { this.SetColumnValue(col.ColumnName, dr[col.ColumnName]); }
                catch { }
            }
            this.IsLoaded = true;
        }
        #endregion

        #region Fetchers


        /// <summary>
        /// Returns all records for this table
        /// </summary>
        /// <returns></returns>
        public static T FetchByID(int keyValue)
        {
            //makes sure the table schema is loaded
            T item = new T();
            
            //build the query
            Query q = new Query(Table);
            q.AddWhere(Table.PrimaryKey.ColumnName, Comparison.Equals, keyValue);
            
            //load the reader
            IDataReader rdr = DBHelper.GetReader(q.BuildSelectCommand());
            if (rdr.Read())
            {
                item.Load(rdr);
            }
            rdr.Close();
            return item;
        }
        
        
        /// <summary>
        /// Returns all records for this table
        /// </summary>
        /// <returns>IDataReader</returns>
        public static IDataReader FetchAll()
        {
            //makes sure the table schema is loaded
            T item = new T();
            
            //build the query
            Query q = new Query(Table);

            //load the reader
            IDataReader rdr = DBHelper.GetReader(q.BuildSelectCommand());
            return rdr;
        }
        /// <summary>
        /// Returns all records for this table, ordered
        /// </summary>
        /// <returns>Generic Typed List</returns>
        /// <param name="oValue">Column to order by</param>
        public static IDataReader FetchAll(OrderBy orderBy)
        {
            //makes sure the table schema is loaded
            T item = new T();

            //build the query
            Query q = new Query(Table);
            q.OrderBy = orderBy;

            //load the reader
            IDataReader rdr = DBHelper.GetReader(q.BuildSelectCommand());
            return rdr;
        }

        /// <summary>
        /// Returns all records for the given column/parameter, ordered by the passed in orderBy
        /// The expression for this is always "column=parameter"
        /// </summary>
        /// <param name="columnName">Name of the column to use in parmeter statement</param>
        /// <param name="oValue">Value of the column</param>
        /// <param name="oValue">Column to order by</param>
        /// <returns>IDataReader</returns>
        public static IDataReader FetchByParameter(string columnName, object oValue, OrderBy orderBy)
        {
            //makes sure the table schema is loaded
            T item = new T();
            //build the query
            Query q = new Query(Table);
            q.OrderBy = orderBy;
            q.AddWhere(columnName, oValue);
            
            //load the reader
            IDataReader rdr = DBHelper.GetReader(q.BuildSelectCommand());
            return rdr;
        }

        
        /// <summary>
        /// Returns all records for the given column/parameter
        /// The expression for this is always "column=parameter"
        /// </summary>
        /// <param name="columnName"></param>
        /// <param name="oValue"></param>
        /// <returns>IDataReader</returns>
        public static IDataReader FetchByParameter(string columnName, object oValue)
        {
            T item = new T();
            //build the query
            Query q = new Query(Table);
            q.AddWhere(columnName, oValue);

            //load the reader
            IDataReader rdr = DBHelper.GetReader(q.BuildSelectCommand());

            //load up the list
            return rdr;
        }

        /// <summary>
        /// Returns all records for the given column/parameter
        /// The expression for this is always "column=parameter"
        /// </summary>
        /// <param name="columnName"></param>
        /// <param name="oValue"></param>
        /// <returns>IDataReader</returns>
        public static IDataReader FetchByParameter(string columnName, Comparison comparison, object oValue)
        {
            T item = new T();
            //build the query
            Query q = new Query(Table);
            q.AddWhere(columnName,comparison, oValue);
            
            //load the reader
            IDataReader rdr = DBHelper.GetReader(q.BuildSelectCommand());
            return rdr;
        }

        /// <summary>
        /// Returns all records for the given column/parameter
        /// The expression for this is always "column=parameter"
        /// </summary>
        /// <param name="columnName"></param>
        /// <param name="oValue"></param>
        /// <returns>IDataReader</returns>
        public static IDataReader FetchByParameter(string columnName, Comparison comparison, object oValue, OrderBy orderBy)
        {
            T item = new T();
            //build the query
            Query q = new Query(Table);
            q.AddWhere(columnName, comparison, oValue);
            q.OrderBy = orderBy;
            //load the reader
            IDataReader rdr = DBHelper.GetReader(q.BuildSelectCommand());

            //load up the list
            return rdr;
        }

        /// <summary>
        /// Uses the passed-in object as a parameter set. Does not use the created/modified fields
        /// </summary>
        /// <param name="item"></param>
        /// <returns></returns>
        public static IDataReader Find(T item)
        {
            return Find(item, null);
        }
        public static IDataReader Find(T item, OrderBy orderBy)
        {
            //build the sql string and command statements at the same time
            Database db = DatabaseFactory.CreateDatabase();
            Query q = new Query(table);

            //retrieve data from database
            string columnName = "";
            object columnValue=null;
            foreach (TableSchema.TableColumn col in Table.Columns)
            {

                columnName = col.ColumnName;
                columnValue = item.GetColumnValue(columnName);
                if (columnName.ToLower() != "createdon" &&
                    columnName.ToLower() != "createdby" &&
                    columnName.ToLower() != "modifiedon" &&
                    columnName.ToLower() != "modifiedby")
                {
                    object defaultValue = string.Empty;
                    switch (col.DataType)
                    {
                        case DbType.Boolean:
                            defaultValue = false;
                            break;
                        case DbType.Currency:
                        case DbType.Decimal:
                        case DbType.Int16:
                        case DbType.Double:
                        case DbType.Int32:
                            defaultValue = 0;
                            break;
                        case DbType.Date:
                        case DbType.DateTime:
                            defaultValue = new DateTime(1900, 1, 1);
                            break;
                    }
                    if (columnValue != null)
                    {
                        if (!columnValue.Equals(defaultValue))
                        {
                            q.AddWhere(columnName, columnValue);
                        }
                    }
                }
            }

            if (orderBy != null)
                q.OrderBy = orderBy;

            IDataReader rdr = DBHelper.GetReader(q.BuildSelectCommand());
            return rdr;

        }
        #endregion

        #region Many to Many Helpers
        /// <summary>
        /// Deletes records from mapping table where the value this object's primary key value
        /// and the mapColumnValue is the matching map record value
        /// </summary>
        /// <param name="mapTableName">The Mapping Table</param>
        /// <returns>Number of records deleted</returns>		
        public static int DeleteManyToManyRecord(string mapTableName, string column1, string column2, int column1Value, int column2Value)
        {
            Database db = DatabaseFactory.CreateDatabase();
            //remove all records from the Map Table
            string delSql = "DELETE FROM " + mapTableName + " WHERE " + column1 + "=@c1 AND " + column2 + "=@c2";
            DbCommand cmd = db.GetSqlStringCommand(delSql);
            db.AddInParameter(cmd, "@c1", DbType.Int32, column1Value);
            db.AddInParameter(cmd, "@c2", DbType.Int32, column2Value);

            //execute it
            int iOut = DBHelper.ExecuteQuery(cmd);
            return iOut;
        }
        /// <summary>
        /// Deletes records from mapping table where the value this object's primary key value
        /// and the mapColumnValue is the matching map record value
        /// </summary>
        /// <param name="mapTableName">The Mapping Table</param>
        /// <returns>Number of records deleted</returns>		
        public static int SaveManyToManyRecord(string mapTableName, string column1, string column2, int column1Value, int column2Value)
        {
            Database db = DatabaseFactory.CreateDatabase();
            //remove all records from the Map Table\
            //delete them first to be sure of no errors
            DeleteManyToManyRecord(mapTableName, column1, column2, column1Value, column2Value);

            string delSql = "INSERT INTO " + mapTableName + " ("+column1+","+column2+") " +
                "VALUES (@c1, @c2)"; 

            DbCommand cmd = db.GetSqlStringCommand(delSql);
            db.AddInParameter(cmd, "@c1", DbType.Int32, column1Value);
            db.AddInParameter(cmd, "@c2", DbType.Int32, column2Value);

            //execute it
            int iOut = DBHelper.ExecuteQuery(cmd);
            return iOut;
        }
        /// <summary>
        /// Deletes records from mapping table where the value this object's primary key value
        /// and the mapColumnValue is the matching map record value
        /// </summary>
        /// <param name="mapTableName">The Mapping Table</param>
        /// <returns>Number of records deleted</returns>		
        public int DeleteManyToMany(string mapTableName, string mapColumnName,int mapColumnValue)
        {
            Database db = DatabaseFactory.CreateDatabase();
            int pkValue = (int)this.GetPrimaryKeyValue();
            //remove all records from the Map Table
            string delSql = "DELETE FROM " + mapTableName + " WHERE " + Table.PrimaryKey.ColumnName + "=@pk AND " + mapColumnName+"=@map";
            DbCommand cmd = db.GetSqlStringCommand(delSql);
            db.AddInParameter(cmd, "@pk", DbType.Int32, pkValue);
            db.AddInParameter(cmd, "@map", DbType.Int32, mapColumnValue);

            //execute it
            int iOut = DBHelper.ExecuteQuery(cmd);
            return iOut;
        }
        /// <summary>
        /// Deletes records from mapping table where the value this object's primary key value
        /// </summary>
        /// <param name="mapTableName">The Mapping Table</param>
        /// <returns>Number of records deleted</returns>		
        public int DeleteAllManyToMany(string mapTableName)
        {
            Database db = DatabaseFactory.CreateDatabase();
            int pkValue = int.Parse(this.GetPrimaryKeyValue().ToString());
            
            //remove all records from the Map Table
            string delSql = "DELETE FROM " + mapTableName + " WHERE " + Table.PrimaryKey.ColumnName + "=@pk";
            DbCommand cmd =db.GetSqlStringCommand(delSql);
            db.AddInParameter(cmd, "@pk", DbType.Int32, pkValue);

            //execute it
            int iOut = DBHelper.ExecuteQuery(cmd);
            return iOut;
        }

        /// <summary>
        /// Saves records to a mapping table. Deletes all associative records first
        /// </summary>
        /// <param name="mapTableName">The Mapping Table</param>
        /// <param name="mapTableForiegnField">The associated foreign key</param>
        /// <param name="items">ListItemCollection, such as a CheckList.Items</param>
        public void SaveManyToMany(string mapTableName, string mapTableForiegnKey, ListItemCollection items)
        {
            //remove all existing 
            this.DeleteAllManyToMany(mapTableName);
            DbCommand cmd = null;
            Database db = DatabaseFactory.CreateDatabase();

            //loop the items and insert
            string iSql = "";
            try
            {
                foreach (ListItem l in items)
                {
                    if(cmd!=null)
                        cmd.Parameters.Clear();
                    if (l.Selected)
                    {

                        iSql = "INSERT INTO " + mapTableName + " ("+Table.PrimaryKey.ColumnName+", " + mapTableForiegnKey + ")" +
                            " VALUES (@" + Table.PrimaryKey.ColumnName + ",@_" + mapTableForiegnKey + ")";
                        cmd = db.GetSqlStringCommand(iSql);
                        db.AddInParameter(cmd, "@"+Table.PrimaryKey.ColumnName, DbType.Int32, this.GetPrimaryKeyValue());
                        db.AddInParameter(cmd, "@_" + mapTableForiegnKey, DbType.Int32, l.Value);

                        //execute
                        DBHelper.ExecuteQuery(cmd);

                    }
                }
            }
            catch
            {
                this.DeleteAllManyToMany(mapTableName);
                throw;
            }

        }

        #endregion

        #region Scaffolding
        void AddRow(HtmlTable tbl, string cellValue)
        {
            HtmlTableRow tr = new HtmlTableRow();
            HtmlTableCell td = new HtmlTableCell();
            tr = new HtmlTableRow();
            td = new HtmlTableCell();

            td.ColSpan = 2;
            td.InnerHtml = cellValue;
            tr.Cells.Add(td);
            tbl.Rows.Add(tr);
        }
        void AddRow(HtmlTable tbl, string cellValue1, Control control)
        {
            HtmlTableRow tr = new HtmlTableRow();
            HtmlTableCell td = new HtmlTableCell();
            tr = new HtmlTableRow();
            td = new HtmlTableCell();

            //label
            td.InnerHtml = "<b>"+cellValue1+"</b>";
            tr.Cells.Add(td);
            tbl.Rows.Add(tr);

            //control
            td = new HtmlTableCell();
            
            td.Controls.Add(control);
            tr.Cells.Add(td);
            tbl.Rows.Add(tr);


        }
        public void LoadEditControls(System.Web.UI.Control container)
        {
            HtmlTable tbl = new HtmlTable();
            tbl.Width = "600px";
            
            //add a header row
            AddRow(tbl,"<h1>" + Table.Name + " Administration</h1>");
            AddRow(tbl,"<hr>");

            string label = "";
            foreach (TableSchema.TableColumn col in Table.Columns)
            {
                Control ctrl=GetEditControl(col);
                if (ctrl == null)
                    throw new Exception("Invalid control for " + col.ColumnName);
                label = ParseCamelToProper(col.ColumnName);
                AddRow(tbl, label, ctrl);

            }
            Button btnSave = new Button();
            btnSave.ID = "btnSave";
            btnSave.Text = "Save";
            AddRow(tbl, "", btnSave);
            container.Controls.Add(tbl);
        }
        string ParseCamelToProper(string sIn)
        {

            char[] letters = sIn.ToCharArray();
            string sOut = "";
            int index = 0;

            foreach (char c in letters)
            {
                if (index == 0)
                {
                    sOut += " " + c.ToString().ToUpper();
                }else if (c.ToString() != c.ToString().ToLower())
                {
                    //it's uppercase, add a space
                    sOut += " " + c.ToString();
                }
                else
                {
                    sOut += c.ToString();

                }
                index++;
            }
            return sOut;
        }
        Control GetEditControl(TableSchema.TableColumn col)
        {
            Control cOut = null;
            switch (col.DataType)
            {
                case DbType.AnsiString:
                case DbType.String:
                case DbType.StringFixedLength:
                case DbType.Xml:
                case DbType.Guid:
                case DbType.Object:
                case DbType.AnsiStringFixedLength:
                    if (col.ColumnName.ToLower() == "createdby" || col.ColumnName.ToLower() == "modifiedby")
                    {
                        Label lbl = new Label();
                        lbl.ID = col.ColumnName;
                        if(!this.isNew)
                            lbl.Text = this.GetColumnValue(col.ColumnName).ToString();
                        cOut = lbl;
                    }
                    else
                    {
                        TextBox t = new TextBox();
                        if (col.MaxLength > 250)
                        {
                            t.TextMode = TextBoxMode.MultiLine;
                            t.Height = Unit.Pixel(200);
                            t.Width = Unit.Pixel(500);
                        }
                        else
                        {
                            t.Width = Unit.Pixel(150);

                        }
                        t.ID = col.ColumnName;
                        if (!this.isNew)
                            t.Text = this.GetColumnValue(col.ColumnName).ToString();
                        cOut = t;
                    }
                    break;
                case DbType.Binary:
                    //do nothing
                    break;
                case DbType.Boolean:
                    CheckBox chk = new CheckBox();
                    chk.ID = col.ColumnName;
                    if (!this.isNew)
                        chk.Checked = (bool)this.GetColumnValue(col.ColumnName);
                    cOut = chk;
                    break;
                case DbType.Byte:
                    break;
                case DbType.Date:
                case DbType.Time:
                case DbType.DateTime:
                    if (col.ColumnName.ToLower() == "modifiedon" || col.ColumnName.ToLower() == "createdon")
                    {
                        Label lblCreatedOn = new Label();
                        lblCreatedOn.ID = col.ColumnName;
                        lblCreatedOn.Text = this.GetColumnValue(col.ColumnName).ToString();
                        cOut = lblCreatedOn;

                    }
                    else
                    {
                        Calendar cal = new Calendar();
                        cal.ID = col.ColumnName;
                        if (!this.isNew)
                        {
                            cal.SelectedDate = (DateTime)this.GetColumnValue(col.ColumnName);
                            cal.VisibleDate = cal.SelectedDate;
                        }
                        cOut = cal;
                    }
                    break;
                case DbType.UInt16:
                case DbType.Int64:
                case DbType.UInt32:
                case DbType.UInt64:
                case DbType.VarNumeric:
                case DbType.Single:
                case DbType.Currency:
                case DbType.Decimal:
                case DbType.Double:
                    TextBox tt = new TextBox();
                    tt.Width = Unit.Pixel(50);
                    if (!this.isNew)
                        tt.Text = this.GetColumnValue(col.ColumnName).ToString();
                    cOut = tt;
                    break;
                case DbType.Int16:
                case DbType.Int32:
                    /*
                    if (col.IsForiegnKey)
                    {
                        DropDownList ddl = new DropDownList();
                        ddl.ID = col.ColumnName;
                        //load up the dropdown
                        

                        cOut = ddl;
                    }
                    else 
                     * */
                    if (col.IsPrimaryKey)
                    {
                        Label lbl = new Label();
                        lbl.ID = col.ColumnName;
                        if (!this.isNew)
                            lbl.Text = this.GetColumnValue(col.ColumnName).ToString();
                        cOut = lbl;

                    }
                    else
                    {
                        TextBox t = new TextBox();
                        t.Width = Unit.Pixel(50);
                        if (!this.isNew)
                            t.Text = this.GetColumnValue(col.ColumnName).ToString();
                        cOut = t;

                    }
                    break;
                default:
                    TextBox txtDefault = new TextBox();
                    txtDefault.Width = Unit.Pixel(150);
                    if (!this.isNew)
                        txtDefault.Text = this.GetColumnValue(col.ColumnName).ToString();
                    cOut = txtDefault;
                    break;
            }
            return cOut;
        }
        #endregion

    }
}
