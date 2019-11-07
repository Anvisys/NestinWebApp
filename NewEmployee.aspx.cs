using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;

public partial class NewEmployee : System.Web.UI.Page
{

    User muser;
    static User newUser;
    static bool ExistingUser = false;
    static int ExistingUserID = 0;
    static int FlatID = 0;


    protected void Page_Load(object sender, EventArgs e)
    {

        SessionVariables.CurrentPage = "NewEmployee.aspx";
        muser = SessionVariables.User;
        if (muser == null)
        {

            Response.Redirect("Login.aspx");

        }

        if (!IsPostBack)
        {
            Fillcombo();
            FillEmployeeData();
        }
    }


    public void FillEmployeeData()
    {
        try
        {
            int ServiceTypeID = Convert.ToInt32(drpServiceTypeFilter.SelectedValue);

            String EmployeeName = txtEmployeeFilter.Text.ToString();


            Resident res = new Resident();
            DataSet ds = res.GetEmployee(muser.currentResident.SocietyID, ServiceTypeID, EmployeeName);


            if (ds.Tables.Count > 0)
            {
                EmployeeGrid.DataSource = ds;
                EmployeeGrid.DataBind();
               // btnEmpShwall.Visible = false;
                //String EmpTotalCountQuery = "  select count(UserID) from dbo.ViewEmployee where SocietyID = " + muser.currentResident.SocietyID.ToString();
                //lblTotalEmployees.Text = daAccess.GetSingleValue(EmpTotalCountQuery).ToString();


               // lblTotalEmployees.Text = ds.Tables[0].Rows.Count.ToString();
                if (ds.Tables[0].Rows.Count == 0)
                {
                    // txtEmpNamesrch.Visible = false;
                    // drpEmpServtFilter.Visible = false;

                }
                else
                {
                    // txtEmpNamesrch.Visible = true;
                    drpServiceTypeFilter.Visible = true;

                }

            }
            else
            {
            }


            //ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "ShowEmployePopup();", true);
        }
        catch (Exception ex)
        {
        }
    }

    public void Fillcombo()
    {

        drpServiceTypeFilter.DataSource = Utility.ComplaintType;
        drpServiceTypeFilter.DataTextField = "Key";
        drpServiceTypeFilter.DataValueField = "value";
        drpServiceTypeFilter.DataBind();
        drpServiceTypeFilter.Items.Insert(0, new ListItem("All", "-1"));



        drpServiceType.DataSource = Utility.ComplaintType;
        drpServiceType.DataTextField = "Key";
        drpServiceType.DataValueField = "value";
        drpServiceType.DataBind();
        drpServiceType.Items.Insert(0, new ListItem("All", "-1"));
    }


    protected void txtEmployeeMobile_TextChanged(object sender, EventArgs e)
    {

        DataAccess dacess = new DataAccess();
        try
        {
            String MobileNoCheckQuery = "select *  from dbo.TotalUsers where MobileNo= '" + employeeMobile.Text + "'";
            DataSet dUser = dacess.GetUserData(MobileNoCheckQuery);

            if (dUser == null || dUser.Tables[0].Rows.Count == 0)
            {
                lblUserCheck.Text = "Mobile Number is not registered";
                ExistingUser = false;
                employeeMobile.Focus();
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
                newUser.EmailID = usertable.Rows[0]["EmailId"].ToString();

                lblUserCheck.ForeColor = System.Drawing.Color.Red;
                lblUserCheck.Text = "Enter User Email";
                ExistingUser = true;
                employeeEmail.Focus();
            }
        }

        catch (Exception ex)
        {
            lblUserCheck.Text = ex.Message;
        }
        return;
    }

    protected void txtEmployeeEmail_TextChanged(object sender, EventArgs e)
    {
        //assignFlatNumber.Enabled = false;
        //assignFlatBlock.Enabled = false;
        //assignFlatFloor.Enabled = false;
        DataAccess dacess = new DataAccess();
        try
        {
            if (ExistingUser == false)
            {
                lblUserCheck.Text = "Enter Mobile Number";

            }

            else if (ExistingUser == true)
            {
                if (employeeEmail.Text.ToLower() == newUser.EmailID.ToLower())
                {
                    ExistingUserID = newUser.ID;
                    employeeName.Text = newUser.FirstName + " " + newUser.LastName;

                    employeeParentName.Text = newUser.ParentName;
                    employeeAddress.Text = newUser.Address;
                    lblUserCheck.Text = "Verify User Detail and Submit";
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:EmailExist(false)", true);
                }
                else
                {
                    lblUserCheck.Text = "Email and Mobile do not belong to same user";

                }
            }
        }

        catch (Exception ex)
        {
            //lblEmailCheck.Text = ex.Message;
        }
    }

    protected void btnEmployeeAdd_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtEmployeeCompanyName.Text == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:alert('Wrong Flat ID')", true);
                return;
            }

            String CompanyName = txtEmployeeCompanyName.Text;


            int SetrviceType  = Convert.ToInt32(drpServiceType.SelectedValue);



            int UserID = ExistingUserID;

            String ResidentType = "Employee";

            Resident res = new Resident();

            res.UserID = ExistingUserID;
            res.FlatID = 0;
            res.SocietyID = muser.currentResident.SocietyID;
            res.Status = 2;
            res.UserType = ResidentType;
            res.ServiceType = SetrviceType;
            res.DeActiveDate = DateTime.UtcNow.AddYears(5);

            if (!res.IsUserExist())
            {
                bool result = res.AddSocietyUser();
                if (result)
                {
                    FillEmployeeData();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:hideAddEmployeeModal()", true);
                }
                else
                {
                    lblUserCheck.Text = "Error Updating Employee";
                }
            }
            else {
                lblUserCheck.Text = "Employee already Exist";

            }

           
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:alert(Error)", true);
        }


    }

    protected void btnRemoveEmployee_Click(object sender, EventArgs e)
    {
        try
        {
            int ResID = 0;
            if (HiddenField1.Value.ToString() != "")
            {
                ResID = Convert.ToInt32(HiddenField1.Value.ToString());

                Resident res = new Resident();

              bool result =   res.DeactivateResident(DateTime.UtcNow, ResID);
                if (result)
                {
                    FillEmployeeData();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:hideRemoveEmployeeModal()", true);
                }
                else {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:alert(Error)", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:alert(Empty Employee)", true);
            }
        }
        catch (Exception ex)
        {


        }
    }

    protected void btnEmployeeSearch_Click(object sender, EventArgs e)
    {

        FillEmployeeData();


    }
}