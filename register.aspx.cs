using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Net;
using System.IO;
using System.Data;
using System.Text;
using Newtonsoft.Json;

public partial class register : System.Web.UI.Page
{
    User muser;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

 

    public static string RandomPassword(int length)
    {


        string Charactersallowed = "";
        Charactersallowed = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        Charactersallowed += "abcdefghijklmnopqrstuvwxyz";
        Charactersallowed += "0123456789@#$%&";
        char[] chars = new char[length];
        int aloowedchars = Charactersallowed.Length;
        Random rdm = new Random();


        for (int i = 0; i < 8; i++)
        {
            chars[i] = Charactersallowed[rdm.Next(0, aloowedchars)];

        }

        return new string(chars);
    }


    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static int AddUser(User user)
    {
       
        int UserId = user.InsertUserResident();
        if (UserId > 0)
        {
            SessionVariables.User = user;
            return UserId;
        }
        else
        {
            return UserId;
        }

       
    }


    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static int AddDemoUser(User user)
    {
       
        int UserId = user.CreateDemoUser();
        if (UserId > 0)
        {
            user.SetResidentInfo();
            SessionVariables.User = user;
            return UserId;
        }
        else
        {
            return UserId;
        }


    }

}
