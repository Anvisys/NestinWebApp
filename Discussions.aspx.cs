using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;

using Newtonsoft.Json;

public partial class Discussions : System.Web.UI.Page
{
   static User muser;

    public string UserNameFirstLetter
    {
        get { return SessionVariables.User.FirstName.Substring(0, 1); }
    }


    public string UserType
    {
        get { return SessionVariables.User.currentResident.UserType; }
    }
    public int UserID
    {
        get
        {
            return muser.UserID;
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {


        muser = SessionVariables.User;
        SessionVariables.CurrentPage = "Discussions.aspx";
        if (muser == null)
        {

            Response.Redirect("Login.aspx");

        }


    }


    [System.Web.Services.WebMethod]
    public static string GetForumData(int StartIndex, int EndIndex)
    {
        try
        {
            List<string> Emp = new List<string>();
            string query = string.Format("select * from dbo.ViewThreadSummaryNoImageCount   order by UpdatedAt desc OFFSET " + StartIndex + " ROWS FETCH NEXT " + (EndIndex - StartIndex) + " ROWS ONLY");

            DataAccess da = new DataAccess();
            DataSet ds = da.GetData(query);
            return JsonConvert.SerializeObject(ds.Tables[0]);
        }
        catch (Exception ex)
        {
            return "{'result:''Error'}";
        }


    }

    [System.Web.Services.WebMethod]
    public static string GetByResID(int ResID)
    {
        try
        {
            List<string> Emp = new List<string>();
            string query = string.Format("select * from dbo.ResidentImage where ResID = '" + ResID + "'");

            DataAccess da = new DataAccess();
            DataSet ds = da.GetData(query);
            return JsonConvert.SerializeObject(ds.Tables[0]);
        }
        catch (Exception ex)
        {
            return null;
        }

    }
}