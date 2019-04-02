using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Newtonsoft.Json;

public partial class Role : System.Web.UI.Page
{
   static User mUser;
    protected void Page_Load(object sender, EventArgs e)
    {
        SessionVariables.CurrentPage = "Role.aspx";
        mUser = SessionVariables.User;

        ShowRequests();
    }


    private void ShowRequests()
    {
        Resident res = new Resident();
        DataSet ds = res.GetResidentForUser(mUser.UserID);

        if (ds != null)
        {
            gridViewRequests.DataSource = ds;
            gridViewRequests.DataBind();
        }
    }

    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static int AddHouse(House house)
    {

        int result = house.InsertHouse(mUser.UserID);
        if (result>0)
        {
            mUser.SetResidentInfo();
            return result;
        }
        else
        {
            return result;
        }
        
    }

    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static bool AddInSociety(SocUser sUser)
    {

        Resident newResident = new Resident();

        bool result = newResident.AddSocietyUser(mUser.UserID, sUser.FlatId, sUser.SocietyId);
        return result;


    }

    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static String GetFlatNumber(FlatSearch flat)
    {
        
        string query = string.Format("Select * from dbo.Flats where SocietyID = "+ flat.SocietyId + " and FlatNumber like '" + flat.FlatNumber + "%'");
        DataAccess da = new DataAccess();
        DataSet ds = da.GetData(query);
        return JsonConvert.SerializeObject(ds.Tables[0]);
       
    }

    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static String GetSocieties(SocietySearch Society)
    {
       
        string query = string.Format("Select * from dbo.Societies where SocietyName like '" + Society.SocietyName + "%'");
        DataAccess da = new DataAccess();
        DataSet ds = da.GetData(query);
        return JsonConvert.SerializeObject(ds.Tables[0]);

    }

    public class FlatSearch {
        public int SocietyId;
        public string FlatNumber;

    }

    public class SocietySearch
    {
        public string SocietyName;
      
    }

    public class SocUser {
        public int FlatId;
        public int SocietyId;
    }


    protected void btnlogout_Click(object sender, EventArgs e)
    {
        try
        {
            btnlogout.Text = "muser";
            Session.Clear();
            Response.Redirect("Login.aspx");
        }

        catch (Exception ex)
        {
            //Utility.log("Home :btnLogout_Click Exception " + ex.Message);
        }
        finally
        {
            mUser = null;
        }
    }
}