using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Role : System.Web.UI.Page
{
   static User mUser;
    protected void Page_Load(object sender, EventArgs e)
    {
        SessionVariables.CurrentPage = "Role.aspx";
        mUser = SessionVariables.User;
    }


    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static int AddHouse(House house)
    {

        int result = house.InsertHouse(mUser.UserID);
        if (result>0)
        {
            mUser.GetResidentInfo();
            return result;
        }
        else
        {
            return result;
        }


    }



}