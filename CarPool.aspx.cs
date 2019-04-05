using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CarPool : System.Web.UI.Page
{
    User muser;

    public int UserID
    {
        get { return muser.UserID; }
    }

    public int ResID
    {
        get { return muser.currentResident.ResID; }
    }

    public int SocietyID
    {
        get { return muser.currentResident.SocietyID; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        muser = (User)Session["User"];

        SessionVariables.CurrentPage = "CarPool.aspx";
        if (muser == null)
        {
            Response.Redirect("Login.aspx");
        }
    }
}