using System;

public partial class MyFlat : System.Web.UI.Page
{
    User muser;

    public int UserID
    {
        get { return muser.UserID; }
    }

    public int ResID
    {
        get { return muser.currentResident.ResID; }
    }
    public int SocietyID
    {
        get { return muser.currentResident.SocietyID; }
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
        muser = SessionVariables.User;
        if (muser == null)
        {

            Response.Redirect("Login.aspx");

        }
        else if (UserType == "Admin")
        {
            Response.Redirect("Flats.aspx");
        }
        else
        {

            SessionVariables.CurrentPage = "MyFlat.aspx";
        }
        

    }

}