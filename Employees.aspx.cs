using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.HtmlControls;

public partial class Employees : System.Web.UI.Page
{

    /*  This Total  code  is  licenced
    Developed By Anvisys Technologies Pvt Ltd.
    
    Copyright © 2016 Anvisys Technologies Pvt. Ltd.All rights reserved.
    */

    User muser;
    protected void Page_Load(object sender, EventArgs e)
    {
        SessionVariables.CurrentPage = "Employees.aspx";
        muser = SessionVariables.User;
        if (muser == null)
        {

            Response.Redirect("Login.aspx");

        }

         Hidefields();

        if (!IsPostBack)
        {
            Fillcombo();
           
            btnEmpShwall.Visible = false;
            Fillddl();
            FillEmployeeData();
        }
      
    }


    public void Hidefields()
    {
        // muser = (User)Session["User"];
        //Added by Aarshi on 18 auh 2017 for session storage
        muser = SessionVariables.User;
        if (muser == null)
        {
            Response.Redirect("Login.aspx");
        }
        if (muser.currentResident.UserType.Equals("ResidentAdmin")|| muser.currentResident.UserType.Equals("Admin"))
        {
            btnEmployeesDeactive.Visible = true;
            btnEmployeesEdit.Visible = true;
        }

        else if (muser.currentResident.UserType.Equals("Employee"))
        {
            btnEmployeesDeactive.Visible = false;
            btnEmployeesEdit.Visible = true;
           
        }
        else if (muser.currentResident.UserType.Equals("Resident"))
        {
            btnEmployeesDeactive.Visible = false;
            btnEmployeesEdit.Visible = false;
          
        }
    }

    
    public void FillEmployeeData()
    {
        try
        {
            int ServiceTypeID = Convert.ToInt32(drpEmpServtFilter.SelectedValue);

            Resident res = new Resident();
            DataSet ds = res.GetEmployee(muser.currentResident.SocietyID, ServiceTypeID);

      
           if (ds.Tables.Count > 0)
           {
               EmployeeGrid.DataSource = ds;
               EmployeeGrid.DataBind();
               btnEmpShwall.Visible = false;
               //String EmpTotalCountQuery = "  select count(UserID) from dbo.ViewEmployee where SocietyID = " + muser.currentResident.SocietyID.ToString();
               //lblTotalEmployees.Text = daAccess.GetSingleValue(EmpTotalCountQuery).ToString();


                lblTotalEmployees.Text = ds.Tables[0].Rows.Count.ToString();
               if (ds.Tables[0].Rows.Count == 0)
               {
                  // txtEmpNamesrch.Visible = false;
                  // drpEmpServtFilter.Visible = false;
                  
               }
               else
               {
                  txtEmpNamesrch.Visible = true;
                  drpEmpServtFilter.Visible = true;
                  
               }

           }
           else
           {
           }


           //ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "ShowEmployePopup();", true);
       } 
        catch(Exception ex)
        { 
        }
    }

    public void Fillcombo()
    {

        drpEmpServtFilter.DataSource = Utility.ComplaintType;
        drpEmpServtFilter.DataTextField = "Key";
        drpEmpServtFilter.DataValueField = "value";
        drpEmpServtFilter.DataBind();
        drpEmpServtFilter.Items.Insert(0, new ListItem("All", "-1"));
    }




    protected void btnActivateConfirm_Click(object sender, EventArgs e)
    {

        try {
            DataAccess dacess = new DataAccess();

            String UserID = HiddenEmpUserID.Value;
            String FirstName = HiddenEmpFName.Value;
            //DateTime TodayDate = System.DateTime.Now;
            DateTime TodayDate = Utility.GetCurrentDateTimeinUTC();
            String DeactivateResidentQuery = "Update dbo.Employee  set ActiveDate ='" + DateTime.UtcNow + "', DeActiveDate =''   where UserID ='" + UserID + "'";
            bool result = dacess.Update(DeactivateResidentQuery);

            if (result == true)
            {
                FillEmployeeData ();
                lblDeactiveMsg.Text = "Selected Employee  is Activated Sucessfully";
                ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "HideLabel()", true);
                HiddenEmpDeactiveID.Value = "";
            }
        }
        catch (Exception ex)
        {
            lblDeactiveMsg.Text = "Selected Employee Could not be Activated";
            ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "HideLabel()", true);
            HiddenEmpDeactiveID.Value = "";
        }
    
    }
    protected void btnEmployeesDeactive_Click(object sender, EventArgs e)
    {      
        try
        {
            HiddenEmpDeactiveID.Value = HiddenEmpUserID.Value;
            if (HiddenDeactivedate.Value != "" && HiddenEmpDeactiveID.Value != null)
            {
                DateTime DeactiveDate = Convert.ToDateTime(HiddenDeactivedate.Value);
                DateTime DateTime = System.DateTime.Now;

                if(DeactiveDate <= DateTime)
                {
                    lblDeactiveMsg.Text = "Selected Employee  is Already Deactivated";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "HideLabel()", true);
                    HiddenEmpDeactiveID.Value = "";
                }
            }
        }
        catch (Exception ex)
        {
            
        }   
    }

    protected void btnDeactiveEmpConfirm_Click(object sender, EventArgs e)
    {
        DataAccess dacess = new DataAccess();
         String UserID = HiddenEmpUserID.Value;
       
        String FirstName = HiddenEmpFName.Value;
        //DateTime TodayDate = System.DateTime.Now;
        DateTime TodayDate = Utility.GetCurrentDateTimeinUTC();
        String DeactivateResidentQuery = "Update dbo.Employee  set DeActiveDate ='" + TodayDate + "'   where UserID ='" + UserID + "'";
        bool result = dacess.Update(DeactivateResidentQuery);

        if(result == true)
        {
            FillEmployeeData();
            lblDeactiveMsg.Text = "Selected Employee  is Deactivated Sucessfully";
            ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "HideLabel()", true);
            HiddenEmpDeactiveID.Value = "";
        }
    }

    protected void btnEmpShwall_Click(object sender, EventArgs e)
    {
        FillEmployeeData();
        drpEmpServtFilter.SelectedValue = drpEmpServtFilter.Items.FindByText("All").Value;
    }

    protected void btnEmployeesEdit_Click(object sender, EventArgs e)
    {
        
        try
        {
            String UserID = HiddenEmpUserID.Value;
            //Session["UserID"] = UserID;
            //Added by Aarshi on 18 auh 2017 for session storage
            SessionVariables.UserID = UserID;
             // Response.Redirect("EditEmployees.aspx");  
             CheckDeactivedate(UserID);
        }

        catch (Exception ex)
        {
            //Utility.log("Employees :btnEmployeesEdit_Click Exception " + ex.Message);
        }
    }
    protected void drpEmpServtFilter_SelectedIndexChanged(object sender, EventArgs e)
    {

        String Status = "";
        DataAccess dacess = new DataAccess();
        if (drpEmpServtFilter.SelectedItem.Text != "")
        {
            Status = drpEmpServtFilter.SelectedItem.Text;

            string compFilterQuery = "Select * from Dbo.ViewEmployee where ServiceType = '" + Status 
                + "where SocietyID = " + muser.currentResident.SocietyID.ToString() + "'";
            DataSet ds = dacess.GetData(compFilterQuery);
            if (ds.Tables.Count > 0)
            {
                EmployeeGrid.DataSource = ds;
                EmployeeGrid.DataBind();
                btnEmpShwall.Visible = true;

            }
        }
       
    }
    protected void btnEmpnameSrch_Click(object sender, EventArgs e)
    {
         DataAccess dacess = new DataAccess();

        String EmpName = "";
        String ServiceType = "";

        if (txtEmpNamesrch.Text != "")
        {
            EmpName = txtEmpNamesrch.Text;
        }

        if(drpEmpServtFilter.SelectedItem.Text != "Select")
        {
            ServiceType =drpEmpServtFilter.SelectedItem.Text;
        }
            string EmpnamesearchQuery = "Select * from ViewEmployee  where FirstName ='" + EmpName + "'  and ServiceType = '"
            +ServiceType +" where SocietyID = " + muser.currentResident.SocietyID.ToString()    +"'";
            DataSet ds = dacess.GetData(EmpnamesearchQuery);
            if (ds.Tables.Count > 0)
            {
                EmployeeGrid.DataSource = ds;
                EmployeeGrid.DataBind();
                btnEmpShwall.Visible = true;
            }
        }          
    
    protected void EmployeeGrid_SelectedIndexChanged(object sender, EventArgs e)
    {
        var s = EmployeeGrid.SelectedRow;
    }

    protected void EmployeeGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        EmployeeGrid.PageIndex = e.NewPageIndex;

        FillEmployeeData();
    }
     protected void radioEmpActive_CheckedChanged(object sender, EventArgs e)
    {

        String queryString = "select * from ViewEmployee order by DeActiveDate ASC";
        DataAccess daAccess = new DataAccess();
        DataSet ds = daAccess.GetData(queryString);

        if (ds.Tables.Count > 0)
        {
            EmployeeGrid.DataSource = ds;
            EmployeeGrid.DataBind();
            btnEmpShwall.Visible = false;
        }
    }
    protected void radioEmpDeactive_CheckedChanged(object sender, EventArgs e)
    {

        String queryString = " Select * from dbo.ViewEmployee where DeActiveDate > ActiveDate";
        DataAccess daAccess = new DataAccess();
        DataSet ds = daAccess.GetData(queryString);
        if (ds.Tables.Count > 0)
        {
            EmployeeGrid.DataSource = ds;
            EmployeeGrid.DataBind();
            btnEmpShwall.Visible = false;
        }
    }
    protected void btnAddEmp_Click(object sender, EventArgs e)
    {
        Response.Redirect("AddEmployee.aspx");
    }
    protected void ImgFlatSearch_Click(object sender, EventArgs e)
    {

        try
        {
            FillEmployeeData();

            //String EmpName = txtEmpNamesrch.Text;
            //String ServiceType = drpEmpServtFilter.SelectedItem.Text;
            //DataAccess dacess = new DataAccess();

            //String EmpSrchQuery = "";
            
            //if (EmpName == "" & ServiceType != "")
            //{
            //    if (ServiceType == "All")
            //        EmpSrchQuery = "Select * from dbo.ViewEmployee";
            //    else
            //        EmpSrchQuery = "Select * from dbo.ViewEmployee where ServiceType like  '" + ServiceType + "%'";
            //}

            //if (EmpName != "" & ServiceType == "")
            //{
            //    EmpSrchQuery = "Select * from dbo.ViewEmployee where FirstName like  '%" + EmpName + "%'";
            //}

            //if (EmpName != "" & ServiceType != "")
            //{
            //    if (ServiceType == "All")
            //        EmpSrchQuery = "Select * from dbo.ViewEmployee where FirstName like  '%" + EmpName + "%'";
            //    else
            //        EmpSrchQuery = "Select * from dbo.ViewEmployee where ServiceType like  '" + ServiceType + "%'  and FirstName like  '%" + EmpName + "%'";
            //}

            //DataSet ds = dacess.GetData(EmpSrchQuery);

            //if (ds.Tables.Count > 0)
            //{
            //    EmployeeGrid.DataSource = ds;
            //    EmployeeGrid.DataBind();
            //    EmployeeGrid.Visible = true;
            //    btnEmpShwall.Visible = true;                
            //}
            //lblTotalEmployees.Text = EmployeeGrid.Rows.Count.ToString();
        }


        catch (Exception ex)
        {
            //Utility.log("Flats :btnFlatnumbrSrch_Click :" +ex.Message);
        }
    }


    /* ------------------------------------------------------------------Add Employee Section starts from here -------------------------------------------------------------------*/

    public void Fillddl()
    {
        drpAddEmpSType.DataSource = Utility.ComplaintType;
        drpAddEmpSType.DataTextField = "Key";
        drpAddEmpSType.DataValueField = "value";
        drpAddEmpSType.DataBind();
        drpAddEmpSType.Items.Insert(0, new ListItem("Select", "NA"));
    }
    protected void btnAdduserres_Click(object sender, EventArgs e)
    {

        try
        {
            User newUser = new User();
                newUser.FirstName = txtAddEmpFName.Text;
                newUser.MiddleName = "K";
                newUser.LastName = txtAddEmpLName.Text;
                newUser.MobileNumber = txtAddEmpMobile.Text;
                newUser.EmailID = txtAddEmpEmailId.Text;
                newUser.ParentName = txtAddempPName.Text;
                String CompanyName = txtAddempCompName.Text;
                int ServiceType = Convert.ToInt32(drpAddEmpSType.SelectedValue);

                newUser.UserLogin = txtAddEmpEmailId.Text;
                newUser.Password = "Password@123";
       
                newUser.Gender = drpAddempGender.SelectedItem.Text;

                newUser.Address = txtAddEmpAddress.Text;
        

                Resident newEmployee = new Resident();
                bool result = newEmployee.AddEmployeeWithUser(newUser, ServiceType, CompanyName);

                if (result == true)
                {
                txtAddEmpFName.Text ="";
                //txtAddEmpMName.Text="";
                txtAddEmpLName.Text="";
                txtAddEmpMobile.Text="";
                txtAddEmpEmailId.Text = "";
                txtAddempPName.Text="";
                txtAddempCompName.Text="";
                FillEmployeeData();
                  //  ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "EmployeeAdded('true');", true);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:EmployeeAdded('true')", true);

            }
            else
                    {
                  //  ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "EmployeeAdded('false');", true);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:EmployeeAdded('false')", true);

            }



        }         
        catch (Exception ex)
        {
            lblEmpError.Text = ex.Message;
        }
    }

  
    protected void txtAddempCompName_TextChanged(object sender, EventArgs e)
    {

    }
    protected void txtEmpUsrid_TextChanged(object sender, EventArgs e)
    {
        DataAccess dacess = new DataAccess();

        String UserAvailbleQuery = "Select  Max(UserID) from dbo.TotalUsers where UserLogin = '" + txtEmpUsrid.Text + "'";
        int UserId = dacess.GetSingleUserValue(UserAvailbleQuery);

        if (UserId == 0)
        {
            lblEmpError.Text = "";
        }
        else
        {
            lblEmpError.Text = "LoginID  is not available";
        }
    }


    protected void txtAddEmpEmailId_TextChanged(object sender, EventArgs e)
    {
        DataAccess dacess = new DataAccess();

        String EmailAvailbleQuery = "Select  * from dbo.TotalUsers where EmailId = '" + txtAddEmpEmailId.Text + "' and MobileNo= "+ txtAddEmpMobile.Text;
        DataSet Employee = dacess.GetData(EmailAvailbleQuery);
        int UserId =Convert.ToInt32(Employee.Tables[0].Rows[0]["UserID"]);

        if (UserId == 0)
        {
            lblEmpError.Text = "Please Register first to proceed...";
            
        }
        else
        {
            lblEmpError.Text = "Please check details and proceed...";
            txtAddEmpFName.Text = Employee.Tables[0].Rows[0]["FirstName"].ToString();
            txtAddEmpLName.Text = Employee.Tables[0].Rows[0]["LastName"].ToString();
            txtAddempPName.Text = Employee.Tables[0].Rows[0]["ParentName"].ToString();
            drpAddempGender.SelectedValue = Employee.Tables[0].Rows[0]["Gender"].ToString();
            txtAddEmpAddress.Text = Employee.Tables[0].Rows[0]["Address"].ToString();
            txtEmpUsrid.Text = Employee.Tables[0].Rows[0]["UserLogin"].ToString();

        }
    }
    protected void txtAddEmpMobile_TextChanged(object sender, EventArgs e)
        {
        DataAccess dacess = new DataAccess();

        String MobileAvailbleQuery = "Select  Max(UserID) from dbo.TotalUsers where MobileNo = '" + txtAddEmpMobile.Text + "'";
        int UserId = dacess.GetSingleUserValue(MobileAvailbleQuery);

        if (UserId == 0)
        {
            lblEmpError.Text = "";
        }
        else
        {
            lblEmpError.Text = "MobileNo  is not available";
        }
    }


    /* -----------------------------------------------------------------Edit Employee Section ----------------------------------------------------------------------------*/

    public void CheckDeactivedate(String UserID)
    {
        EditHiddenID.Value = "";
        DataAccess Dacess = new DataAccess();
        String CheckDeactiveQuery = "Select DeActiveDate from dbo.Employee where UserID ='" + UserID + "'";
        DataSet ds = Dacess.GetData(CheckDeactiveQuery);

        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            String date = dr["DeActiveDate"].ToString();
            if (date == "")
            {
                Editdata(UserID);
            }
            else
            {
                DateTime Deactive = Convert.ToDateTime(date);
                //DateTime Currentdate = System.DateTime.Now;
                DateTime Currentdate = Utility.GetCurrentDateTimeinUTC();

                String deDate = "1900-01-01 00:00:00.000";
                DateTime Defaultdate = Convert.ToDateTime(deDate);
                if (Deactive > Currentdate || Deactive == Defaultdate)
                {
                    Editdata(UserID);
                    lblDeactiveMsg.Text = "";
                }

                else
                {
                    lblDeactiveMsg.Text = "Selected Employee  is  Deactivated";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "HideLabel()", true);
                    //Session["Deactive"] = Deactive;
                    //Added by Aarshi on 18 auh 2017 for session storage
                    SessionVariables.Deactive = Deactive;
                }
            }

        }


    }

    public void Editdata(String UserID)
    {
        using (SqlConnection con1 = new SqlConnection(Utility.MasterDBString))
        {

            DataTable dt = new DataTable();
            con1.Open();
            SqlDataReader myReader;
            SqlCommand myCommand = new SqlCommand("select * from dbo.TotalUsers where UserID ='" + UserID + "'", con1);

            myReader = myCommand.ExecuteReader();

            while (myReader.Read())
            {
                txtEmpFname.Text = (myReader["FirstName"].ToString());
                txtEmpLname.Text = (myReader["LastName"].ToString());
                txtEditEmpMobile.Text = (myReader["MobileNo"].ToString());
                txtEditEmpEmail.Text = (myReader["Emailid"].ToString());
                txtAddress.Text = (myReader["Address"].ToString());
                //compType = myReader["ServiceType"].ToString();
                //  selectedType = Convert.ToInt32(Utility.ComplaintType[compType]);
                EditHiddenID.Value = UserID;
                //Session["UserID"] = UserID;
                //Added by Aarshi on 18 auh 2017 for session storage
                SessionVariables.UserID = UserID;
                lblEditEmpstatus.Text = "";
            }

            con1.Close();
        }
    }
    
    protected void btneditEmp_Click(object sender, EventArgs e)
    {
        DataAccess dacess = new DataAccess();
        String MobileNo = txtEditEmpMobile.Text;
        String Email = txtEditEmpEmail.Text;
        String Fname = txtEmpFname.Text;
        String Lname = txtEmpLname.Text;
        String Address = txtAddress.Text;
        //String UserID = Session["UserID"].ToString();
        //Added by Aarshi on 18 auh 2017 for session storage
        String UserID = HiddenEmpUserID.Value;
        try
        {
            String UpdateUserQuery = "Update dbo.TotalUsers  SET MobileNo='" + MobileNo + "', EmailId='" + Email + "'  , FirstName='" + Fname + "' , LastName='" + Lname + "',Address = '" + Address + "' WHERE UserID ='" + UserID + "'";
            bool result1 = dacess.UpdateUser(UpdateUserQuery);

            if (result1 == true)
            {
                String UpdateQuery = "Update dbo.Employee  SET MobileNo='" + MobileNo + "', EmailId='" + Email + "'  , FirstName='" + Fname + "' , LastName='" + Lname + "' WHERE UserID ='" + UserID + "'";
                bool result = dacess.Update(UpdateQuery);
                if (result == true)
                {
                    lblEditEmpstatus.Text = " Details edited Sucessfully";
                }
                else
                {
                    lblEditEmpstatus.Text = " Details edited Failed";
                }

            }
            else
            {
                lblEditEmpstatus.ForeColor = System.Drawing.Color.Red;
                lblEditEmpstatus.Text = "Record  not  edited sucessfully";
            }
        }
        catch (Exception ex)
        {
            lblEditEmpstatus.Text = ex.Message;
        }

    }
    protected void txtEditEmpMobile_TextChanged(object sender, EventArgs e)
    {
        DataAccess dacess = new DataAccess();
        String EmployeeEditMobile = txtEditEmpMobile.Text;
        if (EmployeeEditMobile != "")
        {
            String MobileAvailbleQuery = "Select  Max(UserID) from dbo.TotalUsers where MobileNo = '" + EmployeeEditMobile + "'";
            int UserId = dacess.GetSingleUserValue(MobileAvailbleQuery);

            if (UserId == 0)
            {
                lblEditEmpMobChck.Text = "";
            }
            else
            {
                lblEditEmpMobChck.Text = "MobileNo  is already Exists";
            }
        }
    }
    protected void txtEditEmpEmail_TextChanged(object sender, EventArgs e)
    {
        DataAccess dacess = new DataAccess();
        String EmployeeEditEmailID = txtEditEmpEmail.Text;
        if (EmployeeEditEmailID != "")
        {
            String EmailAvailbleQuery = "Select  Max(UserID) from dbo.TotalUsers where EmailId = '" + EmployeeEditEmailID + "'";
            int UserId = dacess.GetSingleUserValue(EmailAvailbleQuery);

            if (UserId == 0)
            {
                lblEditEmailCheck.Text = "";
            }
            else
            {
                lblEditEmailCheck.Text = "EmailID  is already exists";
            }
        }
    }

    [System.Web.Services.WebMethod]
    public static List<string> GetFlatNumber(string FirstName)
    {
        List<string> Emp = new List<string>();
        string query = string.Format("Select FirstName from dbo.ViewEmployee where FirstName like '" + FirstName + "%'");
        using (SqlConnection con = new SqlConnection(Utility.SocietyConnectionString))
        {
            con.Open();
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    Emp.Add(reader.GetString(0));

                }
            }
        }
        return Emp;
    }



    protected void Employee_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = e.Row.DataItem as DataRowView;

                HtmlButton btnEmployeeEdit = (HtmlButton)e.Row.FindControl("btnEmployeeEdit");
                HtmlButton btnEmployeeActivate = (HtmlButton)e.Row.FindControl("btnEmployeeActivate");
                HtmlButton btnEmployeeDeActivate = (HtmlButton)e.Row.FindControl("btnEmployeeDeActivate");

               

                String strDate = drv["DeActiveDate"].ToString();

                if (strDate != "")
                {
                    DateTime deactiveDate = DateTime.Parse(strDate);

                    if (deactiveDate < DateTime.Now)
                    {
                        btnEmployeeActivate.Visible = true;
                        btnEmployeeDeActivate.Visible = false;
                    }
                    else
                    {
                        btnEmployeeActivate.Visible = false;
                        btnEmployeeDeActivate.Visible = true;
                    }
                }
                else
                {
                    btnEmployeeActivate.Visible = false;
                    btnEmployeeDeActivate.Visible = true;
                }
            }



        

        }
        catch (Exception ex)
        {
            int a = 1;
        }
    }
}