using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Data;
using System.Configuration;

public partial class Totalusers : System.Web.UI.Page
{

    /*  This Total  code  is  licenced
    Developed By Anvisys Technologies Pvt Ltd.
    
    Copyright © 2016 Anvisys Technologies Pvt. Ltd.All rights reserved.
    */
    PagedDataSource adsource;
    int pos;
    User muser;
 

    private static User newUser;
     private static bool ExistingUser;
    protected void Page_Load(object sender, EventArgs e)
    {
        
         muser = (User)SessionVariables.User;
        //Added by Aarshi on 18 auh 2017 for session storage
        SessionVariables.CurrentPage = "Totalusers.aspx";
        if (muser == null)
        {
            Response.Redirect("Login.aspx");
        }
        if (!IsPostBack)
        {
            //Filldata();
            this.ViewState["vs"] = 0;
            pos = (int)this.ViewState["vs"];
            Utility.Initializehashtables();

            LoadResidentData(); //Changed name by Aarshi on 4 aug 2017
            //btnResShwall.Visible = false; //Changed by Aarshi on 4 Aug 2017
            btnResidentShowAll.Visible = false;
        }

       ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "ShowUserPopup();", true);
    }

    public void LoadResidentData()
    {
        String societyName = muser.currentResident.SocietyName;
        String residentType = drpResidentFilter.SelectedValue.ToString();
        if (residentType == "Owner & Tenant")
        {
            residentType = "All";
        }


        String flatNumber = txtFlatNoFilter.Text.ToString();


        //Added by Aarshi on 4 Aug 2017 for Placing Sql Code in Resident Class
        Resident res = new Resident();
        //DataSet dsResidentAll = res.GetResidentAll();

        DataSet dsResidentAll = res.GetResident(flatNumber, residentType, muser.currentResident.SocietyID);
        if (dsResidentAll != null)
        {
            if (dsResidentAll.Tables.Count > 0)
            {
                adsource = new PagedDataSource();
                adsource.DataSource = dsResidentAll.Tables[0].DefaultView;
                adsource.PageSize = 5;
                adsource.AllowPaging = true;
                adsource.CurrentPageIndex = pos;
                residentsDataList.DataSource = adsource;
                btnprevious.Visible = !adsource.IsFirstPage;
                btnnext.Visible = !adsource.IsLastPage;


                //residentsDataList.DataSource = dsResidentAll;
                residentsDataList.DataBind();
                //UserGrid.DataSource = dsResidentAll;
                //UserGrid.DataBind();
                //btnResShwall.Visible = false; //Changed by Aarshi on 4 Aug 2017
                // btnResidentShowAll.Visible = false;
                lblPage.Text = "Page " + (adsource.CurrentPageIndex + 1) + " of " + adsource.PageCount;
                if (dsResidentAll.Tables[0].Rows.Count == 0)
                {
                    
                    txtUserSrch.Visible = false;
                  
                    lblGridEmptyDataText.Text = "Hello! welcome to the Residents Section, No resident  available  at this point of time.  ";
                }
                else
                {
                   
                    txtUserSrch.Visible = true;
                   
                }
                //Added by Aarshi on 4 Aug 2017 for Placing Sql Code in Resident Class
                lblTotalResidents.Text = dsResidentAll.Tables[0].Rows.Count.ToString();

            }
            else
            {
                lblGridEmptyDataText.Text = "Hello! welcome to the Residents Section, No resident  available  at this point of time.  ";
            }
        }
        else
        {
            lblGridEmptyDataText.Text = "Unable to retreive data.";
        }
        
    }
    protected void btnprevious_Click(object sender, EventArgs e)
    {
        pos = (int)this.ViewState["vs"];
        pos -= 1;
        this.ViewState["vs"] = pos;
        LoadResidentData();
    }

    protected void btnnext_Click(object sender, EventArgs e)
    {
        pos = (int)this.ViewState["vs"];
        pos += 1;
        this.ViewState["vs"] = pos;
        LoadResidentData();
    }
    protected void btnResidentShowAll_Click(object sender, EventArgs e)
    {
        //Filldata();
        LoadResidentData(); //Changed name by Aarshi on 4 aug 2017
        var txt = txtUserSrch.Text;
        txtUserSrch.Text = "";

        drpUserResTypeFilter.SelectedValue = drpUserResTypeFilter.Items.FindByText("Select").Value;
    }

    protected void btnUsersDeactive_Click(object sender, EventArgs e)
    {
        HiddenCompDeactiveID.Value = HiddenField1.Value;
        String Datetime = HiddenDeactivedate.Value;
        if (HiddenDeactivedate.Value != "" && HiddenCompDeactiveID.Value !=null)
        {
            DateTime DeactvieDate = Convert.ToDateTime(Datetime);         
            DateTime Date = Utility.GetCurrentDateTimeinUTC();

            if(DeactvieDate != null)
            {
                if(DeactvieDate < Date)
                {
                    lblCheckDeactive.Text = "Selected User is Already Deactivated";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "HideUserLabel()", true);
                    HiddenCompDeactiveID.Value = "";
                }
            }
        }
    }


    protected void btnDeactiveUserConfirm_Click(object sender, EventArgs e)
    {
        DataAccess Dacess = new DataAccess();

        String UserID = HiddenField1.Value;
        String FlatNumber = HiddenField2.Value;
        DateTime Date = System.DateTime.Now;
       

        Resident res = new Resident();
        res.UpdateResidentDeactive(Date, UserID);
        Response.Redirect("Totalusers.aspx");
    }

    

    //check this button in aspx page
    protected void btnUserSearch_Click(object sender, EventArgs e)
    {
        String Username = "";
        String FlatNumber = "";
      Username =  drpUserResTypeFilter.SelectedValue;

      if (txtUserSrch.Text != "")
          Username = txtUserSrch.Text;

        //if (txtFlatSerch.Text != "")
        //    FlatNumber = txtFlatSerch.Text;


        //Added by Aarshi on 4 Aug 2017 for Placing Sql Code in Resident Class
        Resident res = new Resident();
        DataSet dsResidentFilter = res.GetResidentUserFlat(Username, FlatNumber);

        if (dsResidentFilter.Tables.Count > 0)
        {
            //UserGrid.DataSource = dsResidentFilter;
            //UserGrid.DataBind();
            //btnResShwall.Visible = true; //Changed by Aarshi on 4 Aug 2017
           // btnResidentShowAll.Visible = true;

            residentsDataList.DataSource = dsResidentFilter;
            residentsDataList.DataBind();
        }
    }
   
    protected void UserGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //UserGrid.PageIndex = e.NewPageIndex;
        //Filldata();
        LoadResidentData(); //Changed name by Aarshi on 4 aug 2017
        //System.Web.UI.ScriptManager.RegisterStartupScript(UpdatePanel13,this.GetType(), "alert('')", "javascript:PageIndexChange();", true);
    }
    protected void btndemo_Click(object sender, EventArgs e)
    {

    }

    protected void btnusersEdit_Click(object sender, EventArgs e)
    {

        String UserID = HiddenField1.Value;
        String FlatNumber = HiddenField2.Value;

        //Session["UserID"] = UserID;
        //Session["FlatNumber"] = FlatNumber;
        //Added by Aarshi on 18 auh 2017 for session storage
        SessionVariables.UserID = UserID;
        SessionVariables.FlatNumber = FlatNumber;


      //  Response.Redirect("Editusers.aspx");

        CheckDeactiveDate(UserID, FlatNumber);
    }
  
    protected void btncancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Totalusers.aspx");
    }


    protected void radioResActive_CheckedChanged(object sender, EventArgs e)
    {
        DataAccess dacess = new DataAccess();

        String Activequery = "select * from ViewResidents order by DeActiveDate ASC  ";
   
        DataTable dt = new DataTable();
        DataAccess daAccess = new DataAccess();
        DataSet ds = daAccess.GetData(Activequery);
        if (ds.Tables.Count > 0)
        {
            //UserGrid.DataSource = ds;
            //UserGrid.DataBind();
            //btnResShwall.Visible = false; //Changed by Aarshi on 4 Aug 2017
            btnResidentShowAll.Visible = false;

        }
    }
    protected void radioResDeactive_CheckedChanged(object sender, EventArgs e)
    {
        DataAccess dacess = new DataAccess();

        String DeActivequery = " Select * from dbo.ViewResidents where DeActiveDate > ActiveDate";
        DataTable dt = new DataTable();
        DataAccess daAccess = new DataAccess();
        DataSet ds = daAccess.GetData(DeActivequery);
        if (ds.Tables.Count > 0)
        {
            //UserGrid.DataSource = ds;
            //UserGrid.DataBind();
            //btnResShwall.Visible = false; //Changed by Aarshi on 4 Aug 2017
            btnResidentShowAll.Visible = false;
        }
    }

    protected void btnAddRes_Click(object sender, EventArgs e)
    {
        Response.Redirect("Adduser.aspx");
    }
    

    protected void ImgFltSearch_Click(object sender, EventArgs e)
    {
        String FlatNumber = txtUserSrch.Text;
        DataAccess dacess = new DataAccess();
        String ResType = drpUserResTypeFilter.SelectedItem.Text;
        if (ResType == "Owner & Tenant")
            ResType = "";

        Resident res = new Resident();
        DataSet ds = res.GetResident(FlatNumber, ResType, muser.currentResident.SocietyID);
        if (ds != null)
        {
            if (ds.Tables.Count > 0)
            {
                //UserGrid.DataSource = ds;
                //UserGrid.DataBind();
                //btnResShwall.Visible = true; //Changed by Aarshi on 4 Aug 2017
                btnResidentShowAll.Visible = true;
                lblTotalResidents.Text = ds.Tables[0].Rows.Count.ToString();//Added by Aarshi on 15 Aug 2017 to show correct resident count
            }
        }
    }

    protected void btnusersEdit1_Click(object sender, EventArgs e)
    {

    }


    /*---------------------------------------------------------   Addd User Section----------------------------------------------------------------- */


    public void Datasubmit()
    {
        //DataAccess daAccess = new DataAccess();
        try
        {
            String Gender = drpAddusrGendr.SelectedItem.Text;
            String FirstName = txtFirstname.Text;
            String newName = "";
            String MiddleName = txtMiddleName.Text;
            String LastName = txtLastname.Text;
            String MobileNo = txtMobileno.Text;
            String EmailId = txtEmailId.Text;
            String Parentname = txtParentname.Text;
            String UserLogin = txtEmailId.Text;
            String Password = "Password@123";
           // String Password = txtAddusrPasswrd.Text;
          //  String Confirmpassword = txtAddusrConfirmpaswrd.Text;
            String Address = txtAddress.Text;
            //String UserType = drpAddusertype.SelectedItem.Text;
            //String ConnectionString = Utility.SocietyConnectionString;
            //String SocietyName = muser.currentResident.SocietyName;
            //string SocietyID = muser.currentResident.SocietyID.ToString();//Added by Aarshi on 15 aug 2017

            if (Gender == "" || FirstName == "" || MobileNo == ""|| EmailId==""|| UserLogin=="" || Password=="")
            {
                lblstatus.Text = "Fields can not be empty";
                return;
            }
            else if (FirstName == newName)
            { return; }
            newName = FirstName;

           
            //Added by Aarshi on 15 Aug 2017 for code restructuring
            Resident res = new Resident();
            bool assuserresult = res.InsertUserResident(FirstName, LastName, MobileNo, EmailId, Password, Gender, Parentname, UserLogin, Address, "Owner", muser.currentResident.SocietyID.ToString());

            if (assuserresult == true)                             
            {
                lblstatus.Text = "User added  sucessfully. ";


                //User newUser = new User();
                ////bool result = newUser.UpdatePassword(EmailId, Password);
                //if (result == true)
                //{
                //    lblstatus.ForeColor = System.Drawing.Color.Red;
                //     lblstatus.Text = "User added  sucessfully, password is not  encrypted. ";
                //}

                //if (result == true)
                //{
                //   // ClientScript.RegisterStartupScript(this.GetType(), "alert()", "alert('User Added Sucessfully')", true);
                //    lblstatus.Text = "User Added Successfully";
                //    //Filldata();
                //    LoadResidentData(); //Changed name by Aarshi on 4 aug 2017
                //}
                //else
                //{
                //    lblstatus.ForeColor = System.Drawing.Color.Red;
                //    lblstatus.Text = "User added  sucessfully, password is not  encrypted. ";


                //}
            }

            else
            {
                lblstatus.Text = "User Added Failed";
               
            }
        }
        catch (Exception ex)
        {

            //Utility.log("Adduser:btnAdduser_Click Exception " + ex.Message);
            lblstatus.Text = ex.Message;
        }

        finally
        {

        }

    }
    protected void btnAddUserResident_Click(object sender, EventArgs e)
    {
        //btnAdduserres.Enabled = false;
        
        if (lblusravailblerr.Text == "")
        {
            Datasubmit();
        }

        else
        {
            lblstatus.Text = "UserLogin  already Registered";
        }

        btnAddUserResident.Enabled = true;
    }


   

    

    protected void txtMobileno_TextChanged(object sender, EventArgs e)
    {
        if (ExistingUser)
        {
            if (txtMobileno.Text == newUser.MobileNumber)
            {
                txtFirstname.Text = newUser.FirstName;
                txtMiddleName.Text = newUser.MiddleName;
                txtLastname.Text = newUser.LastName;
                txtAddress.Text = newUser.Address;
                drpAddusrGendr.Text = newUser.Gender;
                //txtNewusername.Text = newUser.UserLogin;
                txtParentname.Text = newUser.ParentName;
                lblmobileavailbe.Text = string.Empty;//Added by Aarshi on 15 Aug 2017 to clear validation message when entered correct data
            }
            else
            {
                lblmobileavailbe.Text = "Mobile No do not match with User.";
            }
        
        }
        else
        {
            lblmobileavailbe.Text = string.Empty;//Added by Aarshi on 15 Aug 2017 to clear validation message when entered correct data
        }
     
    }

    protected void txtEmailId_TextChanged(object sender, EventArgs e)
    {
       

        //Added by Aarshi on 15 Aug 2017 for code restructuring
        Resident res = new Resident();
        DataSet dUser = res.GetEmailAvailable(txtEmailId.Text);

        if ( dUser == null || dUser.Tables[0].Rows.Count == 0)
        {
            ExistingUser = false;
            lblEmailcheck.Text = " ";
        }
        else
        {
            newUser = new User();
            DataTable usertable = dUser.Tables[0];
            newUser.ID = Convert.ToInt32(usertable.Rows[0]["UserID"]);
            newUser.FirstName = usertable.Rows[0]["FirstName"].ToString();
            newUser.LastName = usertable.Rows[0]["LastName"].ToString();
            newUser.ParentName = usertable.Rows[0]["ParentName"].ToString().Trim();
            newUser.Address = usertable.Rows[0]["Address"].ToString();
            newUser.Gender = usertable.Rows[0]["Gender"].ToString();
            newUser.MobileNumber = usertable.Rows[0]["MobileNo"].ToString();
            lblEmailcheck.Text = "Email already Exist. Enter Mobile for Exising User or use another Email";
            ExistingUser = true;
   
        }
    }

    /* -------------------------------------------------------------Edit User Section   ---------------------------------------------------------------------------*/


    public void CheckDeactiveDate(String UserId, String FlatNumber)
    {
        
        //Added by Aarshi on 15 Aug 2017 for code restructuring
        Resident res = new Resident();
        DataSet ds = res.GetDeactiveCheck(UserId);

        lblCheckDeactive.Text = "";
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            String date = dr["DeActiveDate"].ToString();
            if (date == "")
            {
                Editdata(UserId, FlatNumber);
            }
            else
            {
                DateTime Deactive = Convert.ToDateTime(date);
                //DateTime Currentdate = System.DateTime.Now;
                DateTime Currentdate = Utility.GetCurrentDateTimeinUTC();
                if (Deactive > Currentdate)
                {
                    Editdata(UserId, FlatNumber);
                   
                }

                else
                {
                    lblCheckDeactive.Text = "Selected User is Deactivated";

                    ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "HideUserLabel()", true);

                   
                    

                    //Session["Deactive"] = Deactive;
                    //Added by Aarshi on 18 auh 2017 for session storage
                    SessionVariables.Deactive = Deactive;
                }
            }
        }
    }

    public void Editdata(String UserId, String FlatNumber)
    {
        //Added by Aarshi on 15 Aug 2017 for code restructuring

        Resident res = new Resident();
        User editUSer = new User();
        SessionVariables.EditUser = editUSer;
        editUSer = res.GetEditResidentData(UserId, FlatNumber);
        
        txtEditFlatNumber.Text = editUSer.currentResident.FlatNumber;
        txtEditFirstname.Text = editUSer.FirstName;
        txtEditMiddlename.Text = editUSer.MiddleName;
        txtEditlastname.Text = editUSer.LastName;
        txtEditEmailID.Text = editUSer.EmailID;
        txtEditusrParentN.Text = editUSer.ParentName;
        txtEditMobileNo.Text = editUSer.MobileNumber;
        EditHidedenFlat.Value = FlatNumber;
        lbleditstatus.Text = "";

        
    }


    protected void btnedit_Click(object sender, EventArgs e)
    {
        String Field = hiddenChangeField.Value;
        DataAccess dacess = new DataAccess();

        if (Field == "Password")
        {
            String password = newPassword.Text;
            String confirmPassword = cnfPassword.Text;

            if (password != confirmPassword)
            {
                lbleditstatus.Text = "Password do not match";
                ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "HideUserEdiitLabel()", true);
            }
            else {

              

               // String UserLogin = EditHidedenFlat.Value;
                String UserLogin = txtEditEmailID.Text;
                User edituser = new User();//need to check with Amit
                //Added by Aarshi on 18 auh 2017 for session storage

                bool result = edituser.UpdatePassword(UserLogin, password);
                if (result == true)
                {
                    edituser.SendMailToUsers("", password, edituser.EmailID, edituser.FirstName);
                    lbleditstatus.Text = "Password Updated";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "HideUserEdiitLabel()", true);

                }
                else
                {
                    lbleditstatus.Text = "Password Could not be Updated";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "HideUserEdiitLabel()", true);
                }
            }

        }
        else if (Field == "UserInfo")
        {
            String Firstname = txtEditFirstname.Text;
            String Middlename = txtEditMiddlename.Text;
            String Lastname = txtEditlastname.Text;
            String Emailid = txtEditEmailID.Text;
            String Parentname = txtEditusrParentN.Text;
            String Mobileno = txtEditMobileNo.Text;
            //String UserID = Session["UserID"].ToString();
            //Added by Aarshi on 18 auh 2017 for session storage
            string UserID = HiddenField1.Value.ToString();

        
            //Added by Aarshi on 15 Aug 2017 for code restructuring
            Resident res = new Resident();

            bool result = res.UpdateUserResident(Firstname, Middlename, Lastname, Emailid, Parentname, Mobileno, UserID);

            if (result == true)
            {
       
                //Added by Aarshi on 15 Aug 2017 for code restructuring
                bool result1 = res.UpdateResident(Firstname, Lastname, Emailid, Mobileno, UserID);

                if (result1 == true)
                {
                    lbleditstatus.Text = "Details edited Sucessfully";
                    //Filldata();
                    LoadResidentData(); //Changed name by Aarshi on 4 aug 2017
                    ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "HideUserEdiitLabel()", true);
                }
                else
                {
                    lbleditstatus.Text = "Details edited Failed";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "HideUserEdiitLabel()", true);
                }
            }

        }
    }

    protected void txtEditMobileNo_TextChanged(object sender, EventArgs e)
    {
        
        String UserEditMobileNo = txtEditMobileNo.Text;
        if (UserEditMobileNo != "")
        {
            //Added by Aarshi on 15 Aug 2017 for code restructuring
            Resident res = new Resident();
            int UserId = res.GetEditMobileNoAvailable(UserEditMobileNo);

            if (UserId == 0)
            {
                lblEditMobileCheck.Text = "";
            }
            else
            {
                lblEditMobileCheck.Text = "MobileNo already exists ";
            }
        }
    }
    protected void txtEditEmailID_TextChanged(object sender, EventArgs e)
    {
        
        String UserEditEmailID = txtEditEmailID.Text;
        if (UserEditEmailID != "")
        {
           
            //Added by Aarshi on 15 Aug 2017 for code restructuring
            Resident res = new Resident();
            int UserId = res.GetEditEmailIDAvailable(UserEditEmailID);

            if (UserId == 0)
            {
                lblEditEmailCheck.Text = " ";
            }
            else
            {
                lblEditEmailCheck.Text = "Email already exists ";
            }
        }
    }

    [System.Web.Services.WebMethod]
    public static List<string> GetFlatNumber(string FlatNumber)
   {
        //Added by Aarshi on 15 Aug 2017 for code restructuring
        List<string> Emp = new List<string>();
        Resident res = new Resident();
        Emp = res.GetFlatNumber(FlatNumber);
        return Emp;

        
    }


    protected void btnAddUser_Click(object sender, EventArgs e)
    {
        txtFlat.Text = HiddenField2.Value;
        drpAddusertype.SelectedIndex = 1;
        drpAddusertype.Enabled = false;

        ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "ShowAddTenant()", true);
    }
    protected void ResidentList_DataBound(object sender, EventArgs e)
    {

    }

    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        LoadResidentData();
    }
}



