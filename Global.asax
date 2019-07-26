<%@ Application Language="C#" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Threading" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup

    }

    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown

    }

    void Application_Error(object sender, EventArgs e)
    {
        // Code that runs when an unhandled error occurs
        Exception ex = Server.GetLastError();
        string path = "";
        if(sender is HttpApplication)
        {
            path = ((HttpApplication)sender).Request.Url.PathAndQuery;
        }
        string arg = String.Format("<br>Path :{0} </br>",path);
        Server.Transfer("~/Custom-Error/Error1.aspx?handler="+ex ,true);
    }

    void Session_Start(object sender, EventArgs e)
    {
        // Code that runs when a new session is started

    }
    void Application_OnPostAuthenticateRequest(object sender, EventArgs e)
    {
        // Get a reference to the current User
        IPrincipal usr = HttpContext.Current.User;

        // If we are dealing with an authenticated forms authentication request
        if (usr.Identity.IsAuthenticated && usr.Identity.AuthenticationType == "Forms")
        {

            FormsIdentity fIdent = usr.Identity as FormsIdentity;

            // Create a CustomIdentity based on the FormsAuthenticationTicket
            NestinIdentity ni = new NestinIdentity(fIdent.Ticket);

            // Create the CustomPrincipal
            NestinPrincipal p = new NestinPrincipal(ni);

            // Attach the CustomPrincipal to HttpContext.User and Thread.CurrentPrincipal
            HttpContext.Current.User = p;
            Thread.CurrentPrincipal = p;

        }
    }

    void Session_End(object sender, EventArgs e)
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }

</script>
