<%@ Application Language="C#" %>

<script runat="server">

    
    void Application_Start(Object sender, EventArgs e) {

        try
        {
            // Load the site's configuration
            SiteConfig.Load();

            //static category list
            CategoryController.Load();
            
        }
        catch
        {
            //the system's not installed yet, so redirect them
            System.Web.HttpContext.Current.Response.Redirect("~/install/default.aspx");
        }
    }
    
    void Application_End(Object sender, EventArgs e) {
        //  Code that runs on application shutdown

    }
        
    void Application_Error(Object sender, EventArgs e) { 
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(Object sender, EventArgs e) {
        // Code that runs when a new session is started

    }

    void Session_End(Object sender, EventArgs e) {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
    string GetAppRoot(string pagePath)
    {
        string appRoot = "";

        appRoot = pagePath;
        
        //strip out the page
        appRoot = appRoot.Replace(System.IO.Path.GetFileName(appRoot), "");


        //strip the "content" directory

        return appRoot;
    }
    protected void Application_BeginRequest(Object sender, EventArgs e)
    {
        // Setup currency
        SiteConfig.SetupCurrency();
        
        string strCurrentPath = Request.Path;
        //make sure that it ends with aspx.  This is some quick validation on the path. 
        //This will shortcut processing for images and other files (WebResource.axd, for example). 
        if (System.IO.Path.GetExtension(strCurrentPath).EndsWith(
			"aspx", true, System.Globalization.CultureInfo.InvariantCulture))
        {
            string strCustomPath;
            string qString = Request.QueryString.ToString();
            if (qString != string.Empty)
                qString = "&" + qString;
            strCurrentPath = strCurrentPath.ToLowerInvariant();
            string appRoot = GetAppRoot(strCurrentPath);
            //string pageName = "";
            // the URL contains this folder name
            //Response.Write(strCurrentPath);
            if (strCurrentPath.IndexOf("catalog/", StringComparison.InvariantCultureIgnoreCase) > -1)
            {
                
                appRoot = appRoot.Replace("catalog/", "");
                strCustomPath = appRoot + "catalog.aspx?n=" + System.IO.Path.GetFileNameWithoutExtension(strCurrentPath) + qString;

                // rewrite the URL
                Context.RewritePath(strCustomPath, false);
            }
            else if (strCurrentPath.IndexOf("product/", StringComparison.InvariantCultureIgnoreCase) > -1)
            {
                appRoot = appRoot.Replace("product/", "");

                strCustomPath = appRoot + "product.aspx?n=" + System.IO.Path.GetFileNameWithoutExtension(strCurrentPath);
                // rewrite the URL

                Context.RewritePath(strCustomPath, false);
            }
        }
    }
    public void Profile_OnMigrateAnonymous(object sender, ProfileMigrateEventArgs args)
    {
        
        ProfileCommon anonymousProfile = Profile.GetProfile(args.AnonymousID);

        OrderController.MigrateCart(anonymousProfile.UserName,Profile.UserName);
        

        ////////
        // Delete the anonymous profile. If the anonymous ID is not 
        // needed in the rest of the site, remove the anonymous cookie.

        ProfileManager.DeleteProfile(args.AnonymousID);
        AnonymousIdentificationModule.ClearAnonymousIdentifier();
         
    }

</script>
