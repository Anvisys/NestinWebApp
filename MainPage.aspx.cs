using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MainPage : System.Web.UI.Page
{
    User muser;
    //Resident currentResident;

    public string UserID
    {
        get { return muser.strUserID; }
    }

    public string UserFirstName
    {
        get { return muser.strFirstName; }
    }

    public string UserType
    {
        get { return muser.currentResident.UserType; }
    }



    protected void Page_Load(object sender, EventArgs e)
    {

        muser = (User)Session["User"];

        if (muser == null)
        {
            Response.Redirect("Login.aspx");
        }
        else
        {
            if (!IsPostBack)
            {


                //currentResident = (Resident)muser.AllResidents[0];
                if (muser.AllResidents.Count > 0)
                {
                    muser.currentResident = (Resident)muser.AllResidents[0];
                    initializePageControl(muser.currentResident);
                }
              
            }

        }

    }

    private void initializePageControl(Resident current)
    {

        SessionVariables.UserType = current.UserType;
        SessionVariables.SocietyName = current.SocietyName;
        SessionVariables.SocietyID = current.SocietyID;
        SessionVariables.ResiID = current.ResID;

        if (current.UserType == "Owner" || current.UserType == "Tenant" || current.UserType == "ResidentAdmin")
        {
            SessionVariables.FlatNumber = current.FlatNumber;
            SessionVariables.FlatID = current.FlatID;

        }
        else if (current.UserType == "Employee")
        {
            SessionVariables.ServiceType = current.ServiceType;

        }


        if (muser.AllResidents.Count > 1)
        {
            try
            {
                List<KeyValuePair<string, Resident>> data = new List<KeyValuePair<string, Resident>>();
                foreach (var item in muser.AllResidents)
                {
                    if (current == item)
                        continue;
                    var ot = item.UserType;
                    var sn = item.SocietyName;
                    var fn = item.FlatNumber;
                    string key = ot;
                    key += string.IsNullOrEmpty(sn) ? "" : ", " + sn;
                    key += string.IsNullOrEmpty(fn) ? "" : ", " + fn;
                    data.Add(new KeyValuePair<string, Resident>(key, item));

                }
                dlRoles.DataSource = data;
                dlRoles.DataBind();

            }
            catch (Exception ex)
            {

            }

        }
        else
        {
            ChangeFlat.Visible = false;
        }


        SetTopHeader();
    }

    private void SetTopHeader()
    {
        if (muser.currentResident.UserType == "Admin")
        {
            lblsocietyname.Text = muser.currentResident.SocietyName ;

            lblUserName.Text = muser.strFirstName +" as " + muser.currentResident.UserType;
           
            GetProfileImage(muser.strUserID);

           
        }
        else if (muser.currentResident.UserType == "Owner" || muser.currentResident.UserType == "Tenant" || muser.currentResident.UserType == "ResidentAdmin")
        {
            lblsocietyname.Text = muser.currentResident.SocietyName ;

            lblUserName.Text = muser.strFirstName + " as " + muser.currentResident.UserType; ;
            
            GetProfileImage(muser.strUserID);

        }
        if (muser.currentResident.UserType == "Employee")
        {

            lblUserName.Text = muser.strFirstName + " as " + muser.currentResident.UserType;
            
            GetProfileImage(muser.strUserID);
        }

    }


    public void GetProfileImage(string id)
    {

        string name = muser.strFirstName.Substring(0, 1).ToUpper() ;
        ImgProfileIcon.Attributes["src"] = "GetImages.ashx?UserID=" + id + "&Name=" + name + "&UserType=" + muser.currentResident.UserType;
        
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
            muser = null;
        }
    }

    protected void lnkRole_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)(sender);
        var param = btn.CommandArgument;

        Resident currentResident = (Resident)muser.AllResidents.FirstOrDefault(f=>f.ResID.ToString() == param );
        if (currentResident != null)
        {
            muser.currentResident = currentResident;
            initializePageControl(currentResident);
           
        }
    }
}