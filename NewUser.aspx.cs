using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class NewUser : System.Web.UI.Page
{
    User muser;

    public string UserName
    {
        get
        {
            return muser.strFirstName + " " + muser.strLastName;
        }
    }

    public string MobileNumber
    {
        get
        {
            return muser.strMobileNumber;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        muser = (User)Session["User"];

        
    }
}