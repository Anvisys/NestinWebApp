using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MainPage : System.Web.UI.Page
{
    User muser;
    protected void Page_Load(object sender, EventArgs e)
    {
        muser = (User)Session["User"];
        if (muser == null)
        {
            Response.Redirect("Login.aspx");
        }

       

        if (!IsPostBack)
        {
            UserTypeMethod();
        }
    }


    public void UserTypeMethod()
    {

       

         if (muser.currentResident.UserType == "Admin")
        {
            lblsocietyname.Text = muser.currentResident.SocietyName;
            lblAdmin.Text = muser.UserLogin;
            lblUType.Text = muser.currentResident.UserType;
            GetProfileImage();

            ImgProfileIcon.ImageUrl = "Images/Temp/" + muser.currentResident.ResID + ".png";
            ImgProfileIcon.Attributes["onerror"] = "this.src='Images/Icon/profile.jpg';";
        }

        else if (muser.currentResident.UserType == "Owner" || muser.currentResident.UserType == "Tenant")
        {
            lblsocietyname.Text = muser.currentResident.SocietyName + ", " + muser.currentResident.FlatID;
            lblAdmin.Text = muser.UserLogin;
            lblUType.Text = muser.currentResident.UserType;
            ImgProfileIcon.ImageUrl = "Images/Temp/" + muser.currentResident.ResID + ".png";
            ImgProfileIcon.Attributes["onerror"] = "this.src='Images/Icon/profile.jpg';";
            GetProfileImage();

        }
        if (muser.currentResident.UserType == "Employee")
        {
            lblAdmin.Text = muser.strFirstName + " " + muser.strLastName;
            lblUType.Text = muser.currentResident.UserType;
            ImgProfileIcon.ImageUrl = "Images/Temp/" + muser.EmpID + ".png";
            ImgProfileIcon.Attributes["onerror"] = "this.src='Images/Icon/profile.jpg';";

        }
    }

    public void GetProfileImage()
    {
        //DataAccess dacess = new DataAccess();

        ImgProfileIcon.Attributes["src"] = "GetImages.ashx?ResID=" + muser.currentResident.ResID.ToString();
        //ImgProfileIcon.Attributes["onerror"] = "this.src='AppImage/Default_Icon/profile.jpg';";
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
}