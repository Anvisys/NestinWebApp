using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;

public partial class NewFlats : System.Web.UI.Page
{
    User muser;
    static User newUser;
    static bool ExistingUser = false;
    static int ExistingUserID = 0;
    PagedDataSource adsource;
    int pos;
    protected void Page_Load(object sender, EventArgs e)
    {
        muser = SessionVariables.User;

        SessionVariables.CurrentPage = "NewFlats.aspx";
        if (muser == null)
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            assignFlatNumber.Enabled = false;
            assignFlatFloor.Enabled = false;
            assignFlatBlock.Enabled = false;
            this.ViewState["vs"] = 0;
            pos = (int)this.ViewState["vs"];
            FillFlatdata();
           
        }
    }


    public void FillFlatdata()
    {
        String FlatNumber = txtFlatNumberSearch.Text;
        String OwnerName = txtFlltsOwnernme.Text;
        DataAccess dacess = new DataAccess();

        String querystring = "";

        if (OwnerName == "" & FlatNumber != "")
        {
            querystring = "Select * from dbo.ViewNewFlats where FlatNumber like  '" + FlatNumber + "%' and  SocietyId = " + muser.currentResident.SocietyID;
        }

        else if (OwnerName != "" & FlatNumber == "")
        {
            querystring = "Select * from dbo.ViewNewFlats where OwnerFirstName like  '%" + OwnerName.Split(' ')[0] + "' or OwnerLastName like  '%" + OwnerName.Split(' ')[1] +
                "%' and SocietyId = " + muser.currentResident.SocietyID;
        }

        else if (OwnerName != "" & FlatNumber != "")
        {
            querystring = "Select * from dbo.ViewNewFlats where FlatNumber like  '" + FlatNumber + "%'  and OwnerFirstName like  '%" + OwnerName + "' or OwnerLastName like  '%" + OwnerName +
                "%'  and  SocietyId = " + muser.currentResident.SocietyID;
        }
        else
        {
            querystring = "Select * from dbo.ViewNewFlats where SocietyId = " + muser.currentResident.SocietyID + "order by ID Desc ";
        }

        DataSet ds = dacess.GetData(querystring);
        if (ds != null)
            if (ds.Tables.Count > 0)
            {


                if (ds.Tables[0].Rows.Count == 0)
                {
                    lblFlatGridEmptyText.Text = "Hello! Welcome to  the Society Flats, Add a Flat Here.";
                }

                else
                {
                  
                    adsource = new PagedDataSource();
                    adsource.DataSource = ds.Tables[0].DefaultView;
                    adsource.PageSize = 5;
                    adsource.AllowPaging = true;
                    adsource.CurrentPageIndex = pos;
                    dataListFlats.DataSource = adsource;
                    //dataListFlats.DataSource = ds;
                    btnprevious.Visible = !adsource.IsFirstPage;
                    btnnext.Visible = !adsource.IsLastPage;
                    dataListFlats.DataBind();

                    lblPage.Text = "Page " + (adsource.CurrentPageIndex + 1) + " of " + adsource.PageCount;
                }
            }
            else
            {
                lblFlatGridEmptyText.Text = "Unable to retrieve data.";
            }
        else
        {
            lblFlatGridEmptyText.Text = "Unable to retrieve data.";
        }
        string TotalCountQuery = "select count(FlatNumber) from dbo.Flats";
        lblTotalFlats.Text = (dacess.GetSingleValue(TotalCountQuery)).ToString();
    }


    protected void btnFlatnumbrSrch_Click(object sender, EventArgs e)
    {
        try
        {
            FillFlatdata();
        }
        catch (Exception ex)
        {
        }
    }

    protected void btnprevious_Click(object sender, EventArgs e)
    {
        pos = (int)this.ViewState["vs"];
        pos -= 1;
        this.ViewState["vs"] = pos;
        FillFlatdata();
    }

    protected void btnnext_Click(object sender, EventArgs e)
    {
        pos = (int)this.ViewState["vs"];
        pos += 1;
        this.ViewState["vs"] = pos;
        FillFlatdata();
    }

    protected void txtAddfltMobile_TextChanged(object sender, EventArgs e)
    {
        DataAccess dacess = new DataAccess();
        try
        {
            String MobileNoCheckQuery = "select *  from dbo.TotalUsers where MobileNo= '" + newOwnerMobile.Text + "'";
            DataSet dUser = dacess.GetUserData(MobileNoCheckQuery);

            if (dUser == null || dUser.Tables[0].Rows.Count == 0)
            {
                lblUserCheck.Text = "Mobile Number is not registered";
                ExistingUser = false;
                newOwnerMobile.Focus();
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
                newOwnerEmail.Focus();
            }
        }

        catch (Exception ex)
        {
            lblUserCheck.Text = ex.Message;
        }
        return;
    }


    protected void txtAddfltEmail_TextChanged(object sender, EventArgs e)
    {
        assignFlatNumber.Enabled = false;
        assignFlatBlock.Enabled = false;
        assignFlatFloor.Enabled = false;
        DataAccess dacess = new DataAccess();
        try
        {
            if (ExistingUser == false)
            {
                lblUserCheck.Text = "Enter Mobile Number";

            }

            else if (ExistingUser == true)
            {
                if (newOwnerEmail.Text.ToLower() == newUser.EmailID.ToLower())
                {
                    ExistingUserID = newUser.ID;
                    newOwnerName.Text = newUser.FirstName + " " + newUser.LastName;

                    newOwnerParentName.Text = newUser.ParentName;
                    newOwnerAddress.Text = newUser.Address;
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

    protected void DataListFlat_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        try
        {
            if ((e.Item.ItemType == ListItemType.Item) || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                HtmlButton btnAssign = (HtmlButton)e.Item.FindControl("btnAssign");
                HtmlButton btnRemove = (HtmlButton)e.Item.FindControl("btnRemove");
                HtmlButton btnApprove = (HtmlButton)e.Item.FindControl("btnApprove");

                DataRowView drv = e.Item.DataItem as DataRowView;
                int OwnerUserID = Convert.ToInt32(drv["OwnerUserID"].ToString());

                int OwnerStatusID = Convert.ToInt32(drv["OwnerStatusID"].ToString());

                if (OwnerUserID == 0 || (OwnerStatusID != 2 && OwnerStatusID != 1))
                {
                    btnAssign.Visible = true;
                    btnRemove.Visible = false;
                    btnApprove.Visible = false;
                }
                else if (OwnerUserID != 0 && OwnerStatusID == 1)
                {

                    btnAssign.Visible = false;
                    btnRemove.Visible = false;
                    btnApprove.Visible = true;
                }
                else
                {
                    btnAssign.Visible = false;
                    btnRemove.Visible = true;
                    btnApprove.Visible = false;
                }



                HtmlButton btnAssignTenant = (HtmlButton)e.Item.FindControl("btnAssignTenant");
                HtmlButton btnRemoveTenant = (HtmlButton)e.Item.FindControl("btnRemoveTenant");
                HtmlButton btnApproveTenant = (HtmlButton)e.Item.FindControl("btnApproveTenant");

              
                int TenantUserID = Convert.ToInt32(drv["TenantUserID"].ToString());

                int TenantStatusID = Convert.ToInt32(drv["TenantStatusID"].ToString());

                if (TenantUserID == 0 || (TenantStatusID != 2 && TenantStatusID != 1))
                {
                    btnAssignTenant.Visible = true;
                    btnRemoveTenant.Visible = false;
                    btnApproveTenant.Visible = false;
                }
                else if (TenantUserID != 0 && TenantStatusID == 1)
                {

                    btnAssignTenant.Visible = false;
                    btnRemoveTenant.Visible = false;
                    btnApproveTenant.Visible = true;
                }
                else
                {
                    btnAssignTenant.Visible = false;
                    btnRemoveTenant.Visible = true;
                    btnApproveTenant.Visible = false;
                }



            }

        }
        catch (Exception ex)
        {
            int a = 1;
        }
    }


    protected void btnAssignSubmit_Click(object sender, EventArgs e)
    {
        int FlatID = Convert.ToInt32(HiddenField1.Value.ToString());
        int UserID = ExistingUserID;

        String ResidentType = HiddenField3.Value.ToString();

        Resident res = new Resident();

        DataSet owner = res.GetActiveOwner(FlatID, muser.currentResident.SocietyID);

        if (owner != null)
        {
            if (owner.Tables[0].Rows.Count > 0)  
            {
                String Name = "";
                try
                {
                     Name = owner.Tables[0].Rows[0]["FirstName"].ToString() + owner.Tables[0].Rows[0]["LastName"].ToString();
                }
                catch (Exception ex)
                {

                }

                lblUserCheck.Text = "Selected Flat Already has an Active User " + Name;
            }
            else
            {
                res.UserID = ExistingUserID;
                res.FlatID = FlatID;
                res.SocietyID = muser.currentResident.SocietyID;
                res.Status = 2;
                res.UserType = ResidentType;

                bool result = res.AddSocietyUser();

                if (result)
                {
                    FillFlatdata();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:hideAssignFlatModal()", true);
                }
                else
                {
                    lblUserCheck.Text = "Error Updating Owner for Flat, Try Later";
                }
            }
        }
        else
        {
            lblUserCheck.Text = "Error connecting Data Base";
        }
      

    }



    protected void btnAddFlatSubmit_Click(object sender, EventArgs e)
    {
        DataAccess daAccess = new DataAccess();

        Flat newFlat = new Flat();
        newFlat.Block = txtblock.Text;
        newFlat.Floor = txtfloor.Text;
        newFlat.Intercom = Convert.ToInt32(txtintercom.Text);
        newFlat.FlatNumber = txtflatno.Text;
        newFlat.FlatArea = txtfltarea.Text;
        newFlat.BHK = Convert.ToInt32(drpbhk.SelectedItem.Value);
             
        DateTime ActiveDate = Utility.GetCurrentDateTimeinUTC();

        string query = "select * from dbo.Flats where FlatNumber='"+ newFlat.FlatNumber + "' and SocietyID=" +SessionVariables.SocietyID;
        DataSet ds = daAccess.ReadUserData(query);
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            ExistingUser = true;
        }
        else
            ExistingUser = false;
        try
        {
            if (ExistingUser == false)
            {
                int res = newFlat.AddFlat(newFlat);
                // SendMail(newUser.EmailID, newUser.Password, newUser.EmailID, newUser.FirstName);
                if (res > 0)
                    lblassignHeading.Text = "success";
                    FillFlatdata();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:HideAddFlat()", true);
            }
            else
            {
                //newFlat.AddFlat(ExistingUserID);
                //SendMail(newUser.EmailID, newUser.Password, newUser.EmailID, newUser.FirstName);
                //AddBillToFlat(newFlat.FlatNumber, newFlat.FlatArea);
                //GenerateInitialZeroBill(newFlat.FlatNumber, newFlat.FlatArea);
                //FillFlatdata();
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:HideAddFlatModal()", true);
                lblAddFlatMessage.ForeColor = System.Drawing.Color.Red;
                lblAddFlatMessage.Text = "Could not Submit Flat try later or Contact Admin";
            }
        }
        catch (Exception ex)
        {
            Utility.log("Addflat:btnAddflatSubmit_Click Exception" + ex.Message);
            lblAddFlatMessage.ForeColor = System.Drawing.Color.Red;
            lblAddFlatMessage.Text = "Could not Submit  Flat try later or Contact Admin";
            
        }
    }

    protected void btnRemoveOwnerSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            int ResID = Convert.ToInt32(HiddenField1.Value);
            int UserID = Convert.ToInt32(HiddenField2.Value);

            Resident res = new Resident();

            bool result = res.DeactivateResident(DateTime.UtcNow, ResID);

            if (result)
            {
                FillFlatdata();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:HideRemoveOwner()", true);
            }
            else {
                lblRemoveOwnerMessage.ForeColor = System.Drawing.Color.Red;
                lblRemoveOwnerMessage.Text = "Could not remove owner try later or Contact Admin";
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void btnApproveOwnerSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            int ResID = Convert.ToInt32(HiddenField1.Value);
            int UserID = Convert.ToInt32(HiddenField2.Value);

            Resident res = new Resident();

            bool result = res.ApproveResident(DateTime.UtcNow, ResID);

            if (result)
            {
                FillFlatdata();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:HideRemoveOwner()", true);
            }
            else
            {
                lblRemoveOwnerMessage.ForeColor = System.Drawing.Color.Red;
                lblRemoveOwnerMessage.Text = "Could not remove owner try later or Contact Admin";
            }
        }
        catch (Exception ex)
        {

        }
    }




    [System.Web.Services.WebMethod]
    public static List<string> GetFlatNumber(string FlatNumber)
    {
        List<string> Emp = new List<string>();
        string query = string.Format("Select FlatNumber from dbo.Flats where FlatNumber like '" + FlatNumber + "%'");
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




    protected void removeno_Click(object sender, EventArgs e)
    {
        try
        {
            int resid = Convert.ToInt32(HiddenField1.Value);
            int userid = Convert.ToInt32(HiddenField2.Value);

            Resident deactresident = new Resident();
            bool result = deactresident.DeactivateResident(DateTime.UtcNow, resid);

            if (result)
            {
                FillFlatdata();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:HideRemoveOwner()", true);
            }
            else
            {
                lblRemoveOwnerMessage.ForeColor = System.Drawing.Color.Red;
                lblRemoveOwnerMessage.Text = "Could not remove owner try later or Contact Admin";
            }
        }
        catch (Exception ex)
        {

            
        }
    }
}