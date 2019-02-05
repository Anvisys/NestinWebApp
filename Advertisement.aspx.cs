using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Advertisement : System.Web.UI.Page
{
    User muser;
    protected void Page_Load(object sender, EventArgs e)
    {
        muser = (User)Session["User"];
        SessionVariables.CurrentPage = "Advertisement.aspx";
        if (muser == null)
        {
            Response.Redirect("Login.aspx");
        }
    }



    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static bool AddAdvertisement(Ads ad)
    {
        bool success = false;
        User muser = new User();
        try {

            String insertQuery = "INSERT INTO [dbo].[Advertisement] ([Owner],[Title],[AdImage],[Description],[Offer],[StartDate],[EndDate])"+
                                  "VALUES('" + ad.Owner + "','" + ad.Title + "','" + ad.AdImage + "','" + ad.Description + "','" + ad.Offer + "','" + ad.StartDate + "','" + ad.EndDate + "');";
            DataAccess da = new DataAccess();
           success = da.Update(insertQuery);
        
        }
        catch (Exception ex)
        {
        
        }
        return success;
    }
}