using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MyHouse : System.Web.UI.Page
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

    public int HouseID
    {
        get { return muser.currentResident.HouseID; }
    }

    public string HouseNo
    {
        get { return muser.currentResident.HouseNo; }
    }

    public string Address
    {
        get { return muser.currentResident.Sector; }
    }

    public string City
    {
        get { return muser.currentResident.City; }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        muser = (User)Session["User"];

        SessionVariables.CurrentPage = "MyHouse.aspx";
    }
}