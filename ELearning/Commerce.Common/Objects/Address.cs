using System;
using System.Text;
using System.Data;
using System.Data.Common;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Xml;
using System.Xml.Serialization;
using Microsoft.Practices.EnterpriseLibrary.Data;
using WekeRoad.Tools;

namespace Commerce.Common
{
    [Serializable]
    public class AddressCollection : ActiveList<Address>
    {

    }
    /// <summary>
    /// A Persistable class that uses Generics to store it's state
    /// in the database. This class maps to the CSK_Store_Address table.
    /// </summary>
    [Serializable]
    public class Address : ActiveRecord<Address>
    {

        #region .ctors
        /// <summary>
        /// Sets the static Table property from our Base class. This property tells
        /// the base class how to create the CRUD queries, etc.
        /// </summary>
        void SetSQLProps()
        {

            if (Table == null)
            {
                Table = Query.BuildTableSchema("CSK_Store_Address");
            }

            //set the default values
            this.SetColumnValue("addressID", 0);
            this.SetColumnValue("userName", string.Empty);
            this.SetColumnValue("firstName", string.Empty);
            this.SetColumnValue("lastName", string.Empty);
            this.SetColumnValue("email", string.Empty);
            this.SetColumnValue("address1", string.Empty);
            this.SetColumnValue("address2", string.Empty);
            this.SetColumnValue("city", string.Empty);
            this.SetColumnValue("stateOrRegion", string.Empty);
            this.SetColumnValue("zip", string.Empty);
            this.SetColumnValue("country", string.Empty);

            //state properties - these are set automagically 
            //during save
            this.SetColumnValue("createdOn", DateTime.Now);
            this.SetColumnValue("createdBy", string.Empty);
            this.SetColumnValue("modifiedOn", DateTime.Now);
            this.SetColumnValue("modifiedBy", string.Empty);

        }

        public static TableSchema.Table GetTableSchema()
        {
            //instance an object to make sure
            //the table schema has been created
            Address item = new Address();
            return Address.Table;
        }

        public Address()
            : base()
        {
            SetSQLProps();
        }
        public Address(int addressID)
        {
            SetSQLProps();
            base.LoadByKey(addressID);

        }

        #endregion

        #region Custom - not in db

        public string FullAddress
        {
            get { return this.ToHtmlString(); }
        }
	

        //Used for ExpressCheckouts
        private string _PayPalPayerID;
        private string _PayPalToken;

        public string PayPalToken
        {
            get
            {
                return _PayPalToken;
            }
            set
            {
                _PayPalToken = value;
            }
        }

        public string PayPalPayerID
        {
            get
            {
                return _PayPalPayerID;
            }
            set
            {
                _PayPalPayerID = value;
            }
        }
        #endregion

        #region ToString() Override
        /// <summary>
        /// Override the base ToString() so that it will format nicely for a web-page
        /// </summary>
        /// <returns></returns>
        public override string ToString()
        {

            string sOut = FirstName + " " + LastName + "\r\n" +
                Address1 + "\r\n";
            if (!String.IsNullOrEmpty(Address2))
            {
                sOut += Address2 + "\r\n";
            }
            sOut += City + ", " + StateOrRegion + "  " + Zip + " " + Country;
            return sOut;
        }
        public string ToHtmlString()
        {
            string sOut = "<table>";
            sOut += "<tr><td><b>"+FirstName + " " + LastName + "</b></td></tr>" +
                "<tr><td>" + Address1 + "</td></tr>";
            if (!String.IsNullOrEmpty(Address2))
            {
                sOut += "<tr><td>" + Address2 + "</td></tr>";
            }
            sOut += "<tr><td>" + City + ", " + StateOrRegion + "  " + Zip + " " + Country + "</td></tr>";
            sOut += "</table>";
            return sOut;
        }	
        #endregion

        #region Public Props
        [XmlAttribute("AddressID")]
        public int AddressID
        {
            get
            {
                return int.Parse(this.GetColumnValue("addressID").ToString());
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("addressID", value);

            }
        }
        [XmlAttribute("UserName")]
        public string UserName
        {
            get
            {
                return this.GetColumnValue("userName").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("userName", value);

            }
        }
        [XmlAttribute("FirstName")]
        public string FirstName
        {
            get
            {
                return this.GetColumnValue("firstName").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("firstName", value);

            }
        }
        [XmlAttribute("LastName")]
        public string LastName
        {
            get
            {
                return this.GetColumnValue("lastName").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("lastName", value);

            }
        }
        [XmlAttribute("Email")]
        public string Email
        {
            get
            {
                return this.GetColumnValue("email").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("email", value);

            }
        }
        [XmlAttribute("Address1")]
        public string Address1
        {
            get
            {
                return this.GetColumnValue("address1").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("address1", value);

            }
        }
        [XmlAttribute("Address2")]
        public string Address2
        {
            get
            {
                return this.GetColumnValue("address2").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("address2", value);

            }
        }
        [XmlAttribute("City")]
        public string City
        {
            get
            {
                return this.GetColumnValue("city").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("city", value);

            }
        }
        [XmlAttribute("StateOrRegion")]
        public string StateOrRegion
        {
            get
            {
                return this.GetColumnValue("stateOrRegion").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("stateOrRegion", value);

            }
        }
        [XmlAttribute("Zip")]
        public string Zip
        {
            get
            {
                return this.GetColumnValue("zip").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("zip", value);

            }
        }
        [XmlAttribute("Country")]
        public string Country
        {
            get
            {
                return this.GetColumnValue("country").ToString();
            }
            set
            {
                this.MarkDirty();
                this.SetColumnValue("country", value);

            }
        }

        #endregion

        #region Comparisons
        public bool Equals(Address compareAddress)
        {
            bool bOut = false;
            //if the first, last, address1, city, state, etc are equal return true
            if(compareAddress.FirstName.ToLower().Equals(this.FirstName.ToLower()) &&
                compareAddress.LastName.ToLower().Equals(this.LastName.ToLower()) &&
                compareAddress.Address1.ToLower().Equals(this.Address1.ToLower()) &&
                compareAddress.City.ToLower().Equals(this.City.ToLower()) &&
                compareAddress.StateOrRegion.ToLower().Equals(this.StateOrRegion.ToLower())
                ){
                bOut=true;
            }
            return bOut;
        }
        #endregion


        #region ObjectDataSource Support

        public static void Add(string userName, string firstName, string lastName, string email, string address1, string address2, string city, string stateOrRegion, string zip, string country)
        {
            Address address = new Address();

            address.UserName = userName;
            address.FirstName = firstName;
            address.LastName = lastName;
            address.Email = email;
            address.Address1 = address1;
            address.Address2 = address2;
            address.City = city;
            address.StateOrRegion = stateOrRegion;
            address.Zip = zip;
            address.Country = country;
            string uName = System.Web.HttpContext.Current.User.Identity.Name;
            address.Save(uName);
        }

        public static void Update(int addressID, string userName, string firstName, string lastName, string email, string address1, string address2, string city, string stateOrRegion, string zip, string country)
        {
            Address address = new Address(addressID);

            address.AddressID = addressID;
            address.UserName = userName;
            address.FirstName = firstName;
            address.LastName = lastName;
            address.Email = email;
            address.Address1 = address1;
            address.Address2 = address2;
            address.City = city;
            address.StateOrRegion = stateOrRegion;
            address.Zip = zip;
            address.Country = country;
            string uName = System.Web.HttpContext.Current.User.Identity.Name;
            address.Save(uName);
        }
        #endregion
    }
}
