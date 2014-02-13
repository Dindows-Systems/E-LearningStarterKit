using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using System.Xml;
using System.Xml.Serialization;
using WekeRoad.Tools;

namespace Commerce.Common
{

    /// <summary>
    /// A collection of attributes. 
    /// </summary>
    [Serializable]
    public class Attributes : System.Collections.CollectionBase
    {

        public void Add(Attribute att)
        {
            List.Add(att);
        }

        public void Remove(int itemIndex)
        {
            List.RemoveAt(itemIndex);
        }
        /// <summary>
        /// Indexer for this collection. Returns the CSK_Store_Attribute object in the specified position.
        /// </summary>
        public Attribute this[int index]
        {
            get { return (Attribute)List[index]; }
        }

        public override string ToString()
        {
            string attSelections = "";
            foreach (Attribute att in this)
            {
                attSelections += "<b>"+att.Name + "</b>: " + att.SelectionList+"<br>";
            }
            return attSelections;

        }
        public string ToXML()
        {
            return Utility.ObjectToXML(typeof(Attributes), this);
        }

    }
    
    /// <summary>
    /// A class that describes a product attribute, such as "Size"
    /// </summary>
    [Serializable]
    public class Attribute
    {
        private string name;

        public string Name
        {
            get { return name; }
            set { name = value; }
        }
        private string  description;

        public string  Description
        {
            get { return description; }
            set { description = value; }
        }
        public decimal GetPriceAdjustment(string selection)
        {
            decimal dOut=0;
            foreach (AttributeSelection sel in this.selections)
            {
                if(sel.Value.ToLower().Equals(selection.ToLower())){
                    dOut=sel.PriceAdjustment;
                    break;
                }
            }
            return dOut;
        }
        public string SelectionList
        {
            get
            {
                string sOut = "";
                if (this.selections != null)
                {
                    foreach (AttributeSelection sel in this.selections)
                    {
                        sOut += sel.Value + ", ";
                    }
                    if (sOut.Length > 1)
                        sOut = sOut.Remove(sOut.Length - 2, 2);
                }
                return sOut;
            }
        }
        private List<AttributeSelection> selections;

        public List<AttributeSelection> Selections
        {
            get { return selections; }
            set { selections = value; }
        }
	

        private AttributeType selectionType;

        public AttributeType SelectionType
        {
            get { return selectionType; }
            set { selectionType = value; }
        }

    }

    /// <summary>
    /// A class representing the selections for an attribute. Example: "Large", "Small", etc
    /// </summary>
    [Serializable]
    public class AttributeSelection
    {
        private string  selectionValue;
        public string FormattedValue
        {
            get
            {
                //if there is a price adjustment we want to show it
                //you can alter this however needed.
                string sOut = selectionValue;
                if (priceAdjustment != 0)
                {
                    sOut += " ";
                    if (priceAdjustment > 0)
                        sOut += "+";

                    sOut += priceAdjustment.ToString("c");

                }
                return sOut;

            }
            set { selectionValue = value; }
        }
        public string  Value
        {
            get {
                return selectionValue; 
            
            }
            set { selectionValue = value; }
        }

        private string imageFile;

        public string ImageFile
        {
            get { return imageFile; }
            set { imageFile = value; }
        }
	

        private decimal priceAdjustment;

        public decimal PriceAdjustment
        {
            get { return priceAdjustment; }
            set {
                priceAdjustment = value; 
            
            }
        }
	
    }
}
