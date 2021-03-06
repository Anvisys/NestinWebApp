﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using Newtonsoft.Json;

public partial class SuperAdmin : System.Web.UI.Page
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

    protected void Page_Load(object sender, EventArgs e)
    {
        muser = (User)Session["User"];

        SessionVariables.CurrentPage = "SuperAdmin.aspx";
    }


    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static String GetSocietyRequest()
    {
        Society _society = new Society();
        DataSet result = _society.GetSocieties();
        return JsonConvert.SerializeObject(result.Tables[0]);
    }


    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static bool ApproveSocietyRequest(Society society)
    {
        Society _society = new Society();
        bool result = _society.ApproveSociety(society.SocietyID);

        //Update status to 2
        // Update SocietyUserTable with UserID and SocietyID

        return result;
    }

    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static bool RejectSocietyRequest(Society society)
    {
        Society _society = new Society();
        bool result = _society.RejectSociety(society.SocietyID);

        //Update status to 2
        // Update SocietyUserTable with UserID and SocietyID

        return result;
    }

}