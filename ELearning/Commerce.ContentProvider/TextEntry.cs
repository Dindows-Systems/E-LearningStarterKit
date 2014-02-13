using System;
using System.Data;

namespace Commerce.Providers {

    public class TextEntry
    {

        public TextEntry()
        {

        }

        public bool IsLoaded = false;
        #region private vars

        int _ContentID;
        string _ContentGUID;
        string _Title;
        string _ContentName;
        DateTime _CreatedOn;
        DateTime _LastUpdated;
        string _Content;
        string _IconPath;
        DateTime _DateExpires;
        int _ContentGroupID;
        string _CreatedBy;
        string _LastEditedBy;
        string _ExternalLink;
        string _CallOut;
        int _ListOrder;
        string _Status;
        private string modifiedBy;

        public string ModifiedBy
        {
            get { return modifiedBy; }
            set { modifiedBy = value; }
        }
        private DateTime  modifiedOn;

        public DateTime  ModifiedOn
        {
            get { return modifiedOn; }
            set { modifiedOn = value; }
        }
	
        #endregion

        #region Public Props
        public int ContentID
        {
            get { return _ContentID; }
            set { _ContentID = value; }
        }
        public string ContentGUID
        {
            get { return _ContentGUID; }
            set { _ContentGUID = value; }
        }
        public string Title
        {
            get { return _Title; }
            set { _Title = value; }
        }
        public string ContentName
        {
            get { return _ContentName; }
            set { _ContentName = value; }
        }
        public DateTime CreatedOn   
        {
            get { return _CreatedOn; }
            set { _CreatedOn = value; }
        }

        public string Content
        {
            get { return _Content; }
            set { _Content = value; }
        }
        public string IconPath
        {
            get { return _IconPath; }
            set { _IconPath = value; }
        }
        public DateTime DateExpires
        {
            get { return _DateExpires; }
            set { _DateExpires = value; }
        }
        public int ContentGroupID
        {
            get { return _ContentGroupID; }
            set { _ContentGroupID = value; }
        }
        public string CreatedBy
        {
            get { return _CreatedBy; }
            set { _CreatedBy = value; }
        }
        public string LastEditedBy
        {
            get { return _LastEditedBy; }
            set { _LastEditedBy = value; }
        }
        public string ExternalLink
        {
            get { return _ExternalLink; }
            set { _ExternalLink = value; }
        }
        public string CallOut
        {
            get { return _CallOut; }
            set { _CallOut = value; }
        }
        public int ListOrder
        {
            get { return _ListOrder; }
            set { _ListOrder = value; }
        }
        public string Status
        {
            get { return _Status; }
            set { _Status = value; }
        }
        #endregion

        public void Load(IDataReader rdr)
        {
            if (rdr.Read())
            {
                IsLoaded = true;
                _ContentID = GetInt(rdr["ContentID"]);
                _ContentGUID = GetString(rdr["ContentGUID"]);
                _Title = GetString(rdr["Title"]);
                _ContentName = GetString(rdr["ContentName"]);
                _CreatedOn = GetDateTime(rdr["CreatedOn"]);
                _Content = GetString(rdr["Content"]);
                _IconPath = GetString(rdr["IconPath"]);
                _DateExpires = GetDateTime(rdr["DateExpires"]);
                _ContentGroupID = GetInt(rdr["ContentGroupID"]);
                _CreatedBy = GetString(rdr["CreatedBy"]);
                _LastEditedBy = GetString(rdr["LastEditedBy"]);
                _ExternalLink = GetString(rdr["ExternalLink"]);
                _CallOut = GetString(rdr["CallOut"]);
                _ListOrder = GetInt(rdr["ListOrder"]);
                _Status = GetString(rdr["Status"]);
            }
        }
        public void Load(DataTable table)
        {
            DataRow dr = table.Rows[0];
            if (table.Rows.Count > 0)
                IsLoaded = true;
            _ContentID = GetInt(dr["ContentID"]);
            _ContentGUID = GetString(dr["ContentGUID"]);
            _Title = GetString(dr["Title"]);
            _ContentName = GetString(dr["ContentName"]);
            _CreatedOn = GetDateTime(dr["CreatedOn"]);
            _Content = GetString(dr["Content"]);
            _IconPath = GetString(dr["IconPath"]);
            _DateExpires = GetDateTime(dr["DateExpires"]);
            _ContentGroupID = GetInt(dr["ContentGroupID"]);
            _CreatedBy = GetString(dr["CreatedBy"]);
            _LastEditedBy = GetString(dr["LastEditedBy"]);
            _ExternalLink = GetString(dr["ExternalLink"]);
            _CallOut = GetString(dr["CallOut"]);
            _ListOrder = GetInt(dr["ListOrder"]);
            _Status = GetString(dr["Status"]);
        }
        public void Load(DataRow dr)
        {
            IsLoaded = true;
            _ContentID = GetInt(dr["ContentID"]);
            _ContentGUID = GetString(dr["ContentGUID"]);
            _Title = GetString(dr["Title"]);
            _ContentName = GetString(dr["ContentName"]);
            _CreatedOn = GetDateTime(dr["CreatedOn"]);
            _Content = GetString(dr["Content"]);
            _IconPath = GetString(dr["IconPath"]);
            _DateExpires = GetDateTime(dr["DateExpires"]);
            _ContentGroupID = GetInt(dr["ContentGroupID"]);
            _CreatedBy = GetString(dr["CreatedBy"]);
            _LastEditedBy = GetString(dr["LastEditedBy"]);
            _ExternalLink = GetString(dr["ExternalLink"]);
            _CallOut = GetString(dr["CallOut"]);
            _ListOrder = GetInt(dr["ListOrder"]);
            _Status = GetString(dr["Status"]);
        }
        public override string ToString()
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("ContentID: " + this.ContentID.ToString() + "<br>");
            sb.Append("ContentGUID: " + this.ContentGUID + "<br>");
            sb.Append("Title: " + this.Title + "<br>");
            sb.Append("ContentName: " + this.ContentName + "<br>");
            sb.Append("Datecreated: " + this.CreatedOn.ToString() + "<br>");
            sb.Append("Content: " + this.Content + "<br>");
            sb.Append("IconPath: " + this.IconPath + "<br>");
            sb.Append("DateExpires: " + this.DateExpires.ToString() + "<br>");
            sb.Append("ContentGroupID: " + this.ContentGroupID.ToString() + "<br>");
            sb.Append("CreatedBy: " + this.CreatedBy + "<br>");
            sb.Append("LastEditedBy: " + this.LastEditedBy + "<br>");
            sb.Append("ExternalLink: " + this.ExternalLink + "<br>");
            sb.Append("CallOut: " + this.CallOut + "<br>");
            sb.Append("ListOrder: " + this.ListOrder.ToString() + "<br>");
            sb.Append("Status: " + this.Status + "<br>");
            return sb.ToString();
        }

        #region helpers
        byte GetByte(object oVal)
        {
            try
            {
                return (byte)oVal;
            }
            catch
            {
                return 0;
            }
        }

        int GetInt(object iVal)
        {

            try
            {
                return (int)iVal;
            }
            catch
            {
                return 0;
            }
        }
        bool GetBool(object oVal)
        {
            try
            {
                return (bool)oVal;
            }
            catch
            {
                return false;
            }
        }
        decimal GetDecimal(object iVal)
        {
            try
            {
                return (decimal)iVal;
            }
            catch
            {
                return 0;
            }
        }
        DateTime GetDateTime(object dVal)
        {
            try
            {
                return (DateTime)dVal;
            }
            catch
            {
                return DateTime.Parse("1/1/1900");
            }

        }
        double GetDouble(object dVal)
        {
            try
            {
                return (double)dVal;
            }
            catch
            {
                return 0;
            }
        }
        string GetString(object oVal)
        {
            return oVal.ToString();
        }
        #endregion
    }

}