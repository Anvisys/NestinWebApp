using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class visitor : System.Web.UI.Page
{
    User muser;
    protected void Page_Load(object sender, EventArgs e)
    {
        muser = (User)Session["User"];
        SessionVariables.CurrentPage = "visitor.aspx";
        if (muser == null)
        {
            Response.Redirect("Login.aspx");
        }
    }



    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static bool AddVisitor(guest vd)
    {
        bool success = false;
        User muser = new User();
        try
        {

            String insertQuery = "INSERT INTO [dbo].[Guest_EntryRequest] ([Name],[MobileNo],[Address],[Purpose],[StartTime],[EndTime])" +
                                  "VALUES('" + vd.Name + "','" + vd.MobileNo + "','" + vd.Address + "','" + vd.Purpose  + "','" + vd.StartTime + "','" + vd.EndTime + "');";
            DataAccess da = new DataAccess();
            success = da.Update(insertQuery);

        }
        catch (Exception ex)
        {

        }
        return success;
    }
}