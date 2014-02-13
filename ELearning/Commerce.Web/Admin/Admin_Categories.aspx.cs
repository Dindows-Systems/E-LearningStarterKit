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
using System.Data.SqlClient;
using Commerce.Common;
using System.Collections.Generic;

public partial class Admin_Admin_Categories : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string delFlag = "";
        if (Request.QueryString["did"] != null)
        {
            delFlag = Request.QueryString["did"].ToString();
        }

        if (delFlag != string.Empty)
        {
            int delID = int.Parse(delFlag);
               //DocumentLibrary.DocumentManager.FolderDelete(delID);
                Response.Redirect("admin_folders.aspx");
        }

        if (!Page.IsPostBack)
        {
            buildTree();
            if (TreeView1.Nodes.Count > 0)
            {
                TreeView1.SelectedNode = TreeView1.Nodes[0];
                LoadCategory(int.Parse(TreeView1.Nodes[0].Value));
            }
        }

    }

    private void buildTree()
    {

        TreeView1.Nodes.Clear();
        DataSet ds = new DataSet();
        ds = CategoryController.GetDataSetList();

        ds.Relations.Add("NodeRelation", ds.Tables[0].Columns["categoryID"], ds.Tables[0].Columns["parentID"], false);

        //if(User.IsInRole("Administrators")){
        foreach (DataRow dbRow in ds.Tables[0].Rows)
        {
					if(int.Parse(dbRow["parentID"].ToString()) == 0)
            {
                ComponentArt.Web.UI.TreeViewNode newNode = CreateNode(dbRow["categoryID"].ToString(), dbRow["categoryName"].ToString(), "root.gif", true);
                TreeView1.Nodes.Add(newNode);
                PopulateSubTree(dbRow, newNode);
            }
        }

    }
    private void PopulateSubTree(DataRow dbRow, ComponentArt.Web.UI.TreeViewNode node)
    {
        foreach (DataRow childRow in dbRow.GetChildRows("NodeRelation"))
        {
            ComponentArt.Web.UI.TreeViewNode childNode = CreateNode(childRow["categoryID"].ToString(), childRow["categoryName"].ToString(), "folder.gif", false);
            //childNode.Text += " <img src=../images/icons/delete.gif align=absmiddle onmouseover=\"this.style.cursor='hand'\" onclick=\"delFolder('" + childNode.Text + "'," + childNode.Value + ")\">";
            node.Nodes.Add(childNode);
            PopulateSubTree(childRow, childNode);
        }
    }

    private ComponentArt.Web.UI.TreeViewNode CreateNode(string folderID, string text, string imageurl, bool expanded)
    {
        ComponentArt.Web.UI.TreeViewNode node = new ComponentArt.Web.UI.TreeViewNode();
        node.Text = text;
        node.Value = folderID;
        //node.ImageUrl = "/gss2/images/tree/icon_clsdfold.gif"; 
        //node.ExpandedImageUrl="/gss2/images/tree/icon_openfold.gif";
        //node.ShowCheckBox = true;
        node.Expanded = expanded;
        //node.NavigateUrl="admin_docfolders.aspx?id="+folderID;
        return node;
    }
    protected void TreeView1_NodeRenamed(object sender, ComponentArt.Web.UI.TreeViewNodeRenamedEventArgs e)
    {
        //feedback.Text = "Renamed '" + e.OldText + "' to '" + e.Node.Text + "'";
        int parentID = 0;
        if (e.Node.ParentNode != null)
        {

            try
            {
                int.Parse(e.Node.ParentNode.Value);
            }
            catch
            {

            }
            Category cat = new Category(int.Parse(e.Node.Value));
            cat.CategoryName=e.Node.Text;
            cat.Save(Utility.GetUserName());
        
        }
        buildTree();
    }
    protected void TreeView1_NodeMoved(object sender, ComponentArt.Web.UI.TreeViewNodeMovedEventArgs e)
    {
        Category cat = new Category(int.Parse(e.Node.Value));
        cat.ParentID = int.Parse(e.Node.ParentNode.Value);
        cat.Save(Utility.GetUserName());
        buildTree();

    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Category cat = new Category();
        cat.CategoryName = txtCatNew.Text;
        cat.ListOrder = 99;
        cat.ParentID = 0;
        cat.Save(Utility.GetUserName());
        buildTree();
    }

    
    void LoadCategory(int categoryID)
    {
        btnDelete.Attributes.Add("onclick", "return CheckDelete();");
        Category cat=new Category(categoryID);
        txtCategoryName.Text = cat.CategoryName;
        txtLongDescription.Text =cat.LongDescription;
        txtShortDescription.Text = cat.ShortDescription;
        txtListOrder.Text = cat.ListOrder.ToString();
        lblID.Text = cat.CategoryID.ToString();
        lblParentID.Text = cat.ParentID.ToString();
        ImagePicker1.SetImage(cat.ImageFile);
    }
    protected void NodeClicked(object sender, ComponentArt.Web.UI.TreeViewNodeEventArgs e)
    {
        LoadCategory(int.Parse(e.Node.Value));
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        
        int delCatID=int.Parse(lblID.Text);
        //see if this category has children
        
        //get all the categories
        CategoryCollection coll = (CategoryCollection)Category.FetchAll();

        //find the one to be deleted
        bool hasKids = false;
        foreach (Category cat in coll)
        {
            if (cat.ParentID == delCatID)
            {
                hasKids = true;
                break;
            }
        }

        if (!hasKids)
        {
            Category.Delete(delCatID);
            buildTree();
        }
        else
        {
            ResultMessage1.ShowFail(Resources.Admin.DeleteChildCategoriesFirst);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        int parentID = 0;
        if(lblParentID.Text!=string.Empty)
            parentID=int.Parse(lblParentID.Text);
        Category cat = new Category(int.Parse(lblID.Text));
        cat.CategoryName = txtCategoryName.Text;
        cat.ImageFile = ImagePicker1.GetSelectedImage();
        cat.ListOrder=int.Parse(txtListOrder.Text);
        cat.ShortDescription=txtShortDescription.Text;
        cat.LongDescription=txtLongDescription.Text;

        cat.Save(Utility.GetUserName());
				LoadCategory(cat.CategoryID);
        buildTree();

    }
}
