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


    public int UserID
    {
        get { return mUser.UserID; }
    }

    public String UserName
    {
        get { return mUser.FirstName; }
    }

    public String UserLastName
    {
        get { return mUser.LastName; }
    }

    public String UserMobile
    {
        get { return mUser.MobileNumber; }
    }

    public String UserEmail
    {
        get { return mUser.EmailID; }
    }

    public int ResCount
    {
        get { return mUser.AllResidents.Count; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
       // SessionVariables.CurrentPage = "Role.aspx";
        mUser = SessionVariables.User;
      
        if (mUser == null)
        {
            Response.Redirect("Login.aspx");
        }
        else
        {
            //ShowRequests();
        }
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
    public static int AddNewSociety(Society Society)
    {
        int result = Society.InsertSociety();

        return result;


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

    protected void gridRequest_DataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView drv = e.Row.DataItem as DataRowView;
            int status = Convert.ToInt32(drv["Status"].ToString());
            DateTime ActiveDate = Convert.ToDateTime(drv["ActiveDate"].ToString());
            DateTime InActiveDate = Convert.ToDateTime(drv["DeActiveDate"].ToString());
            String txtStatus = "Active";
            if (status == 0 && InActiveDate > DateTime.Now)
            {
                txtStatus = "Active";
            }
            else
            {
                txtStatus = "InActive";
            }
            TableCell statusCell = e.Row.Cells[6];
            statusCell.Text = txtStatus;
        }

    }

    [System.Web.Services.WebMethod]
    public static string GetUserData(String userLogin)
    {
        try
        {
            List<string> Emp = new List<string>();
            string query = string.Format("select * from dbo.TotalUsers where UserLogin ='" + userLogin + "'");

            DataAccess da = new DataAccess();
            DataSet ds = da.GetData(query);
            return JsonConvert.SerializeObject(ds.Tables[0]);
        }
        catch (Exception ex)
        {
            return "{'result:''Error'}";
        }


    }


}