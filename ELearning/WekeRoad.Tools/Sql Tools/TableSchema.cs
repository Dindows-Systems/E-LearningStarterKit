using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;

namespace WekeRoad.Tools
{
    [Serializable]
    public class TableSchema
    {
        [Serializable]
        public class TableColumnSettingCollection : List<TableColumnSetting>
        {
            bool Contains(string columnName)
            {
                bool bOut = false;
                foreach (TableColumnSetting setting in this)
                {
                    if (setting.ColumnName.ToLower().Equals(columnName.ToLower()))
                    {
                        bOut = true;
                        break;
                    }
                }
                return bOut;
            }
            
            public object GetValue(string columnName)
            {
                object oOut = null;
                foreach (TableColumnSetting child in this)
                {
                    if (child.ColumnName.ToLower().Equals(columnName.ToLower()))
                    {
                        oOut = child.CurrentValue;
                        break;
                    }
                }
                return oOut;
            }

            public void SetValue(string columnName, object oVal)
            {

                if (!Contains(columnName))
                {
                    TableColumnSetting setting = new TableColumnSetting();
                    setting.ColumnName = columnName;
                    setting.CurrentValue = oVal;
                    this.Add(setting);
                }
                else
                {

                    foreach (TableColumnSetting child in this)
                    {
                        if (child.ColumnName.ToLower().Equals(columnName.ToLower()))
                        {
                            child.CurrentValue = oVal;
                            break;
                        }
                    }
                }
            }

        }


        /// <summary>
        /// This is an intermediary class that holds the current value of a table column
        /// for each object instance.
        /// </summary>
        [Serializable]
        public class TableColumnSetting
        {

            private string columnName;
            public string ColumnName
            {
                get { return columnName; }
                set { columnName = value; }
            }

            private object currentValue;
            public object CurrentValue
            {
                get { return currentValue; }
                set { currentValue = value; }
            }


        }
        /// <summary>
        /// Holds information about the base table - this class should be 
        /// static for each object
        /// </summary>
        [Serializable]
        public class Table
        {

            public Table()
            {

            }
            public Table(string tableName)
            {
                this.name = tableName;
            }
            private TableColumnCollection columns;
            public TableColumnCollection Columns
            {
                get { return columns; }
                set { columns = value; }
            }

            private TableColumn primaryKey;
            public TableColumn PrimaryKey
            {
                get
                {

                    if (this.columns != null)
                    {
                        primaryKey = this.columns.GetPrimaryKey();
                    }
                    return primaryKey;
                }

            }

            private string name;
            public string Name
            {
                get { return name; }
                set { name = value; }
            }

            public TableColumn GetColumn(string columnName)
            {
                TableColumn col = null;
                foreach (TableColumn column in this.Columns)
                {
                    if (column.ColumnName.ToLower().Equals(columnName.ToLower()))
                    {
                        col = column;
                        break;
                    }
                }
                return col;
            }

        }



        [Serializable]
        public class TableColumnCollection : List<TableColumn>
        {

            #region Collection Methods
            bool Contains(string columnName)
            {
                bool bOut = false;
                foreach (TableColumn col in this)
                {
                    if (col.ColumnName.ToLower().Equals(columnName.ToLower()))
                    {
                        bOut = true;
                        break;
                    }
                }
                return bOut;
            }
            
            public void Add(string name, DbType dbType, bool isNullable,
                bool isPrimaryKey, bool isForeignKey)
            {
                TableColumn col = new TableColumn();
                col.IsPrimaryKey = isPrimaryKey;
                col.IsForiegnKey = isForeignKey;
                col.IsNullable = isNullable;
                col.DataType = dbType;
                col.ColumnName = name;

                if (!Contains(name))
                {
                    this.Add(col);
                }
            }
            public void Add(string name, DbType dbType, bool isNullable)
            {
                Add(name, dbType, isNullable, false, false);
            }


            #endregion

            public TableColumn GetColumn(string columnName)
            {
                TableColumn coll = null;
                foreach (TableColumn child in this)
                {
                    if (child.ColumnName.ToLower().Equals(columnName.ToLower()))
                    {
                        coll = child;
                        break;
                    }
                }
                return coll;
            }

            public TableColumn GetPrimaryKey()
            {
                TableColumn coll = null;
                foreach (TableColumn child in this)
                {
                    if (child.IsPrimaryKey)
                    {
                        coll = child;
                        break;
                    }
                }
                return coll;
            }

        }

        /// <summary>
        /// A helper class to help define the columns in an underlying table
        /// </summary>
        [Serializable]
        public class TableColumn
        {

            public TableColumn()
            {

            }
            public TableColumn(string columnName, DbType dbType, bool isPrimaryKey, bool isForeignKey)
            {
                this.columnName = columnName;
                this.isPrimaryKey = isPrimaryKey;
                this.isForiegnKey = isForeignKey;
                this.dbType = dbType;
            }

            private bool isForiegnKey;
            public bool IsForiegnKey
            {
                get { return isForiegnKey; }
                set { isForiegnKey = value; }
            }


            private bool isPrimaryKey;
            public bool IsPrimaryKey
            {
                get { return isPrimaryKey; }
                set { isPrimaryKey = value; }
            }


            private bool isNullable;
            public bool IsNullable
            {
                get { return isNullable; }
                set { isNullable = value; }
            }

            private DbType dbType;
            public DbType DataType
            {
                get { return dbType; }
                set { dbType = value; }
            }

            private int maxLength;
            public int MaxLength
            {
                get { return maxLength; }
                set { maxLength = value; }
            }

            private string columnName;
            public string ColumnName
            {
                get { return columnName; }
                set { columnName = value; }
            }

        }
    }
}
