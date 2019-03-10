using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MyFlat : System.Web.UI.Page
{
    User muser;

    public int UserID
    {
        get { return muser.UserID; }
    }

    public string UserFirstName
    {
        get { return muser.FirstName; }
    }

    public string UserType
    {
        get { return muser.currentResident.UserType; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        muser = SessionVariables.User;
        if  (UserType ==  "Admin") {
            Response.Redirect("Flats.aspx");
        } 
        
        
        SessionVariables.CurrentPage = "MyFlat.aspx";
        if (muser == null)
        {

            Response.Redirect("Login.aspx");

        }

    }

}