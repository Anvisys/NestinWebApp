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
            return muser.FirstName + " " + muser.LastName;
        }
    }

    public string MobileNumber
    {
        get
        {
            return muser.MobileNumber;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        muser = (User)Session["User"];

        
    }
}