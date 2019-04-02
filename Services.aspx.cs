using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Services : System.Web.UI.Page
{
    User muser;
    protected void Page_Load(object sender, EventArgs e)
    {
        muser = SessionVariables.User;

        SessionVariables.CurrentPage = "Services.aspx";
        if (muser == null)
        {

            Response.Redirect("Login.aspx");

        }
    }
}