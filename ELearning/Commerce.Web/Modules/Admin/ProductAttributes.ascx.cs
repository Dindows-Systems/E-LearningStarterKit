using System;
using System.Collections.Generic;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Commerce.Common;

public partial class Modules_Admin_ProductAttributes : System.Web.UI.UserControl {
    protected Product thisProduct;
    protected void Page_Load(object sender, EventArgs e) {

    }
    public void LoadAttributes(Commerce.Common.Product product) {

        //get the attributes for this product
        lblID.Text = product.ProductID.ToString();

        //get the atts, if they exist for this product
        ViewState["atts"]=product.Attributes;
        BindAttList(product.Attributes);

        LoadAttributeTemplates();
        
    }

    protected void btnAddAttribute_Click(object sender, EventArgs e) {

        Commerce.Common.Attribute att = new Commerce.Common.Attribute();
        att.Name = txtAttributeNew.Text.Trim();
        att.Description = txtAttNewDesc.Text.Trim();
        att.SelectionType = (AttributeType)int.Parse(ddlAttNewSelectionType.SelectedValue);
        
        //get the selections from the viewstate
        ArrayList aList = GetSelections();
        att.Selections = new System.Collections.Generic.List<AttributeSelection>();
        
        if (att.SelectionType != AttributeType.UserInput)
        {
            for (int i = 0; i < aList.Count; i++)
            {
                att.Selections.Add((AttributeSelection)aList[i]);
            }

        }
        else
        {
            AttributeSelection sel = new AttributeSelection();
            sel.Value = "";
            sel.PriceAdjustment = 0;
            att.Selections.Add(sel);
        }


        //a product can have one or more attribute selections
        //like "size" and "color"
        //store these into the viewstate as they are saved
        //and synch them with the product bits as well
        Commerce.Common.Attributes atts = null;
        if (ViewState["atts"] == null)
        {
            atts = new Attributes();
        }
        else
        {
            atts = (Attributes)ViewState["atts"];
        }
        atts.Add(att);


        //put it back the ViewState
        ViewState["atts"] = atts;

        //and set it to the product, which will serialize it down
        //to XML
        ProductController.UpdateProductAttributes(int.Parse(lblID.Text), atts);
        //bind up the grid
        BindAttList(atts);

    }
    protected void btnSaveAttTemplate_Click(object sender, EventArgs e) {
		Commerce.Common.Attribute att = new Commerce.Common.Attribute();
		Attributes atts = new Attributes();
        AttributeTemplate attributeTemplate = new AttributeTemplate();
        attributeTemplate.AttributeName = txtAttributeNew.Text.Trim();
		attributeTemplate.AttributeTypeID = int.Parse(ddlAttNewSelectionType.SelectedValue);
		ArrayList aList = GetSelections();
		if(aList != null) {
			if(aList.Count > 0) {
				att.Selections = new System.Collections.Generic.List<AttributeSelection>();
				for(int i = 0;i < aList.Count;i++) {
					att.Selections.Add((AttributeSelection)aList[i]);
				}
			}
		}
		atts.Add(att);
		attributeTemplate.SelectionList = Utility.ObjectToXML(typeof(Attributes), atts);
		attributeTemplate.Description = txtAttNewDesc.Text.Trim();
		attributeTemplate.Save(Page.User.Identity.Name);
		lblTemplateSaved.Text = "&nbsp;Template Saved";
        LoadAttributeTemplates();
    }
    protected void DeleteAtt(object source, DataGridCommandEventArgs e) {
        //pull the attributes out of the ViewState
        if (ViewState["atts"] != null)
        {
            Attributes atts = (Attributes)ViewState["atts"];
            int itemIndex = e.Item.ItemIndex;
            atts.RemoveAt(itemIndex);

            //save it back and rebind
            ViewState["atts"] = atts;

            //update the product
            ProductController.UpdateProductAttributes(int.Parse(lblID.Text), atts);

            BindAttList(atts);
        }


    }
    void BindAttList(Attributes atts){
        dgAtts.DataSource = atts;
        dgAtts.DataBind();
    }
    protected void btnSetTemplate_Click(object sender, EventArgs e) {
        string sTemplate = ddlAttTemplates.SelectedValue;
        AttributeTemplate template = new AttributeTemplate(int.Parse(sTemplate));
        txtAttributeNew.Text = template.AttributeName;
        txtAttNewDesc.Text = template.Description;
        ddlAttNewSelectionType.SelectedValue = template.AttributeTypeID.ToString();
        Commerce.Common.Attributes attributes =
            (Attributes)Utility.XmlToObject(typeof(Attributes), template.SelectionList);
        ArrayList aList = new ArrayList();
        foreach (AttributeSelection selection in attributes[0].Selections)
        {
            aList.Add(selection);
        }
        BindSells(aList);
        ViewState["aList"] = aList;
    }
    ArrayList GetSelections()
    {
        ArrayList aList = null;
        if (ViewState["aList"] != null)
        {
            aList = (ArrayList)ViewState["aList"];
        }
        return aList;
    }
    void LoadAttributeTemplates() {

        ddlAttTemplates.DataSource = AttributeTemplate.FetchAll();
        ddlAttTemplates.DataTextField = "attributeName";
        ddlAttTemplates.DataValueField = "templateID";
        ddlAttTemplates.DataBind();
    }
    protected void btnAddAtt_Click(object sender, EventArgs e)
    {
        //create an attribute list
        ArrayList aList = GetSelections();
        if (aList == null)
            aList = new ArrayList();
        
        //create a new selection and add it
        Commerce.Common.AttributeSelection sel = new AttributeSelection();
        sel.PriceAdjustment = decimal.Parse(txtPriceAdjustment.Text);
        sel.Value = txtSelectionAdd.Text;
        
        aList.Add(sel);
        BindSells(aList);

        ViewState["aList"] = aList;
    }
    void BindSells(ArrayList aList)
    {
        dgSells.DataSource = aList;
        dgSells.DataBind();

    }
    protected void removeSelection(object source, DataGridCommandEventArgs e)
    {
        ArrayList aList = GetSelections();
        int itemIndex = e.Item.ItemIndex;
        if (aList != null)
        {
            aList.RemoveAt(itemIndex);
        }
        BindSells(aList);

    }
    protected void ddlAttNewSelectionType_SelectedIndexChanged(object sender, EventArgs e)
    {
        pnlSelections.Visible = ddlAttNewSelectionType.SelectedValue != "2";
    }
}
