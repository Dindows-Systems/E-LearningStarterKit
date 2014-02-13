using System;
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

public partial class Modules_Products_AttributeSelection : System.Web.UI.UserControl
{
    private Commerce.Common.Attributes selectedAttributes;

    public Commerce.Common.Attributes SelectedAttributes
    {
        get { 
        
            //loop through the controls and 
            //create an attribute selection from them
            Commerce.Common.Attribute selectedAttribute;
            Commerce.Common.AttributeSelection selection;
            decimal priceAdjustment = 0;

            if (product.Attributes != null)
            {
                foreach (Commerce.Common.Attribute att in product.Attributes)
                {
                    //pull the control out
                    //and set the values/price adjustments
                    selectedAttribute=new Commerce.Common.Attribute();
                    selectedAttribute.SelectionType = att.SelectionType;
                    selectedAttribute.Selections = new System.Collections.Generic.List<AttributeSelection>();
                    selectedAttribute.Name = att.Name;
                    selectedAttribute.Description = att.Description;
                    //based on the type, pull out the selection
                    switch (att.SelectionType)
                    {
                        case AttributeType.SingleSelection:
                            DropDownList ddl = (DropDownList)pnlAttControls.FindControl(att.Name);
                            selection = new AttributeSelection();
                            
                            selection.Value = ddl.SelectedValue;
                            selection.PriceAdjustment = att.GetPriceAdjustment(selection.Value);
                            selectedAttribute.Selections.Add(selection);
                            break;
                        case AttributeType.MultipleSelection:
                            CheckBoxList chk = (CheckBoxList)pnlAttControls.FindControl(att.Name);
                            foreach (ListItem item in chk.Items)
                            {
                                if (item.Selected)
                                {
                                    selection = new AttributeSelection();
                                    selection.Value = item.Text;

                                    selection.PriceAdjustment = att.GetPriceAdjustment(selection.Value);
                                    selectedAttribute.Selections.Add(selection);
                                }
                            }
                            break;
                        case AttributeType.UserInput:
                            TextBox t = (TextBox)pnlAttControls.FindControl(att.Name);
                            selection = new AttributeSelection();

                            selection.Value = t.Text;
                            selectedAttribute.Selections.Add(selection);
                            break;
                        default:
                            break;
                    }
                    selectedAttributes.Add(selectedAttribute);
                }
            }


            return selectedAttributes;
        
        }
        set { selectedAttributes = value; }
    }
    private Commerce.Common.Product product;

    public Commerce.Common.Product Product
    {
        get { return product; }
        set { 
            product = value;
        }
    }
    
    void LoadControls()
    {
        HtmlTable tbl = new HtmlTable();
        tbl.ID = "lips";
        HtmlTableRow tr;
        HtmlTableCell td;
        int indexer = 0;
        if (product.Attributes != null)
        {
            selectedAttributes = new Attributes();
            foreach (Commerce.Common.Attribute att in product.Attributes)
            {
                tr = new HtmlTableRow();
                td = new HtmlTableCell();

                Label lblSingle = new Label();
                lblSingle.Text = "<br><b>" + att.Name + ":</b>";
                if (att.Description != string.Empty)
                {
                    lblSingle.Text += "<br><span class=smalltext>" + att.Description+"</span><br>";
                }
                lblSingle.ID = "lbl" + att.Name+indexer.ToString();
                td.Controls.Add(lblSingle);
                indexer++;
                switch (att.SelectionType)
                {
                    case AttributeType.SingleSelection:
                        lblSingle.Text += "&nbsp;";
                        DropDownList ddl = new DropDownList();
                        ddl.ID = att.Name;
                        ddl.DataSource = att.Selections;
                        ddl.DataTextField = "FormattedValue";
                        ddl.DataValueField = "Value";
                        ddl.DataBind();
                        ddl.SelectedIndex = 0;
                        td.Controls.Add(ddl);

                        break;
                    case AttributeType.MultipleSelection:
                        lblSingle.Text += "<br>";
                        CheckBoxList chkList = new CheckBoxList();
                        chkList.ID = att.Name;
                        chkList.DataSource = att.Selections;
                        chkList.DataTextField = "Value";
                        chkList.DataValueField = "Value";
                        chkList.DataBind();
                        td.Controls.Add(chkList);
                        break;
                    case AttributeType.UserInput:
                        lblSingle.Text += "<br>";
                        TextBox t = new TextBox();
                        t.ID = att.Name;
                        t.TextMode = TextBoxMode.MultiLine;
                        t.Height = Unit.Pixel(80);
                        t.Width = Unit.Pixel(120);
                        td.Controls.Add(t);

                        break;
                }
                tr.Cells.Add(td);
                tbl.Rows.Add(tr);
            }
            pnlAttControls.Controls.Add(tbl);
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!Page.IsPostBack)
            LoadControls();
    }
}
