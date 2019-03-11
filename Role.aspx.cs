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

    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static bool AddInSociety(int FlatId)
    {

        Resident newResident = new Resident();

        bool result = newResident.AddSocietyUser(mUser.UserID, FlatId);
        return result;


    }

    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static String GetFlatNumber(FlatSearch flat)
    {
        List<string> Emp = new List<string>();

        Flat srcFlat = new Flat();
       
        string query = string.Format("Select * from dbo.Flats where SocietyID = "+ flat.SocietyId + " and FlatNumber like '" + flat.FlatNumber + "%'");
        DataAccess da = new DataAccess();
        DataSet ds = da.GetData(query);
        return JsonConvert.SerializeObject(ds.Tables[0]);
       
    }

    public class FlatSearch {
        public int SocietyId;
        public string FlatNumber;

    }


}