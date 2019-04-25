using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Collections;

using System.Text;
using System.Web.UI.HtmlControls;

using Newtonsoft.Json; 

public partial class Viewcomplaints : System.Web.UI.Page
{

    /*  This Total  code  is  licenced
    Developed By Anvisys Technologies Pvt Ltd.
    
    Copyright © 2016 Anvisys Technologies Pvt. Ltd.All rights reserved.
    */
    PagedDataSource adsource;
    int pos;
    User muser;
    private static DataTable ComplaintStatusOptions;

    int selectedSeverity;
    string severity;

    int selectedType;
    string compType;

    int selectedStatus;
    string status;

    int empID;
    string EmpName;
    public int UserID { get { return muser.UserID; } }
    private static DataSet dsComplaint;
    private int newComplaintResidentID = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        //Added by Aarshi on 18 auh 2017 for session storage
        //muser = (User)Session["User"];
        muser = SessionVariables.User;

        
        SessionVariables.CurrentPage = "Viewcomplaints.aspx";
        if (muser == null)
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            this.ViewState["vs"] = 0;
            pos = (int)this.ViewState["vs"];   
            Utility.Initializehashtables();
            UserTypeCheck();
           
           // FillGriddataIntiated();
            FillCompStatusFiltercombo();
            //   drpVCompStatusF.SelectedIndex = 0;
            FillCombo();
            //FillComplaintData();
            LoadComplaintsDataList();
        }

        //ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "ShowAPopup()", true);


        txtComplaintdescription.Attributes.Add("onkeyup", "return GetCount(" + txtComplaintdescription.ClientID + ");");
        txtComplaintdescription.Attributes.Add("onChange", "return GetCount(" + txtComplaintdescription.ClientID + ");");


    }

    public void LoadComplaintsDataList()
    {
        try
        {
            String FlatNumber = txtVcompFlatSrch.Text;
            String ComplaintStatus = drpVCompStatusF.SelectedItem.Text;
            String month = "All";// drpComplaintDateFilter.SelectedItem.Text;
            Complaint complainData = new Complaint();
         
            if (muser.currentResident.UserType == "Employee")
            {
                dsComplaint = complainData.GetComplaintsForEmployee(Convert.ToInt32(muser.EmpID), FlatNumber, "", ComplaintStatus, month);
            }
            else if (muser.currentResident.UserType == "Owner" || muser.currentResident.UserType == "Tenant")
            {
                dsComplaint = complainData.GetComplaints( muser.currentResident.SocietyID , muser.currentResident.FlatNumber, "", ComplaintStatus, month);
            }
            else
            {
                dsComplaint = complainData.GetComplaints(muser.currentResident.SocietyID, muser.currentResident.FlatNumber, "", ComplaintStatus, month);
            }

            if (dsComplaint.Tables.Count > 0)
            {
                adsource = new PagedDataSource();
                adsource.DataSource = dsComplaint.Tables[0].DefaultView;
                adsource.PageSize = 5;
                adsource.AllowPaging = true;
                adsource.CurrentPageIndex = pos;
                dataListComplaint.DataSource = adsource;
                btnprevious.Visible = !adsource.IsFirstPage;
                btnnext.Visible = !adsource.IsLastPage;
                //dataListComplaint.DataSource = ds;
                dataListComplaint.DataBind();
                TemplateControl tc;
                

                lblPage.Text = "Page " + (adsource.CurrentPageIndex +1) + " of " + adsource.PageCount;
            }
        }
        catch (Exception ex)
        { }
        MultiView1.ActiveViewIndex =0;
    }

    protected void btnprevious_Click(object sender, EventArgs e)
    {
        pos = (int)this.ViewState["vs"];
        pos -= 1;
        this.ViewState["vs"] = pos;
        LoadComplaintsDataList();
    }

    protected void btnnext_Click(object sender, EventArgs e)
    {
        pos = (int)this.ViewState["vs"];
        pos += 1;
        this.ViewState["vs"] = pos;
        LoadComplaintsDataList();
    }


    public void UserTypeCheck()
    {

        if (muser.currentResident.UserType == "Owner" || muser.currentResident.UserType == "Tenant")
        {

          
            String FirstName = muser.FirstName;

            String FlatNumber = muser.currentResident.FlatNumber;
            txtVcompFlatSrch.Text = FlatNumber;
            txtVcompFlatSrch.Enabled = false;
            

            //Added by Aarshi on 18 auh 2017 for session storage
            SessionVariables.FName = FirstName;
            SessionVariables.FlatNumber = FlatNumber;

        }
    }





    public void HideFields()
    {
        btnCompHistory.Visible = false;
        // btnEdit.Visible = false;
      
        drpVCompStatusF.Visible = false;
        txtVcompFlatSrch.Visible = false;
        lblEmptyDataText.Visible = true;
        lblEmptyDataText.Text = "Hello! Welcome to the complaint Section,There is  no  complaint.";
       
        ImgCompSearch.Visible = false;
    }

    public void showfields()
    {
        btnCompHistory.Visible = true;
       
        drpVCompStatusF.Visible = true;
        txtVcompFlatSrch.Visible = true;
        lblEmptyDataText.Visible = false;
    
        ImgCompSearch.Visible = true;
    }
   
    public void FillCompStatusFiltercombo()
    {
        try
        {

            if (muser.currentResident.UserType == "Owner" || muser.currentResident.UserType == "Tenant")
            {
                drpVCompStatusF.Items.Add(new ListItem("Open", "10"));
                drpVCompStatusF.Items.Add(new ListItem("Closed", "11"));
            
            }
            else
            {
                if (ComplaintStatusOptions == null)
                {
                    DataAccess dacess = new DataAccess();
                    String CompstatusQuery = "Select * from lukComplaintStatus";
                    ComplaintStatusOptions = dacess.ReadData(CompstatusQuery).Tables[0];
                }
                drpVCompStatusF.DataSource = ComplaintStatusOptions;
                drpVCompStatusF.DataTextField = "CompStatus";
                drpVCompStatusF.DataValueField = "StatusID";
                drpVCompStatusF.DataBind();
                drpVCompStatusF.Items.Add(new ListItem("All", "-1"));
                drpVCompStatusF.SelectedIndex = 0;
            }
        }
        catch (Exception ex)
        { }
    }



    protected void txtVcompFlatSrch_TextChanged(object sender, EventArgs e)
    {
        // String Flat = txtVcompFlatSrch.Text;
        //  FlatsFilter(Flat);
    }

    protected void btnCompHistory_Click(object sender, EventArgs e)
    {
        try
        {
            //Added by Aarshi on 27-Sept-2017
            String CompID = HiddenCompID.Value;
            String FlatNumber = HiddenFlatNumber.Value;


            txtCompHistFlatNumber.Text = FlatNumber;
            DataAccess dacess = new DataAccess();

            String CompHistoryQuery = "Select * from dbo.ViewComplaintHistory where CompID = '" + CompID + "'  ";

            DataSet ds = dacess.GetData(CompHistoryQuery);
            if (ds.Tables.Count > 0)
            {
                HiddenCompHistID.Value = CompID;

                dacess.ReadData(CompHistoryQuery);
                CompHistorygrid.DataSource = ds;
                CompHistorygrid.DataBind();

            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "HideCompHistEmptyDataLabel()", true);
                lblEmptyDataText.Text = "Data is  Not avilable";
            }


        }

        catch (Exception ex)
        {
            Utility.log("ViewComplaints :btnCompHistory_Click" + ex.Message);

        }
        finally
        {

        }
    }
    protected void btnVCShowall_Click(object sender, EventArgs e)
    {

     
        User currentUser = SessionVariables.User;

        if (currentUser.currentResident.UserType == "ResidentAdmin")
        {
           // FillGridAll();
            LoadComplaintsDataList();
        }

        else
        {
            //FillComplaintData();
            LoadComplaintsDataList();
        }

        var text = txtVcompFlatSrch.Text;
        txtVcompFlatSrch.Text = "";
        drpVCompStatusF.SelectedValue = drpVCompStatusF.Items.FindByText("Initiated").Value;

        // btnVCNewcomp.Visible = true;
    }
    protected void btnVCNewcomp_Click(object sender, EventArgs e)
    {
        Response.Redirect("Addcomplaint.aspx");
    }
 
   
    public void FillCombo()
    {
       
        drpComplaintcategory.DataSource = Utility.ComplaintType;
        drpComplaintcategory.DataTextField = "Key";
        drpComplaintcategory.DataValueField = "value";
        drpComplaintcategory.DataBind();
        drpComplaintcategory.Items.Insert(0, new ListItem("Select", "NA"));

        drpAddcomAssign.Items.Insert(0, new ListItem("Select", "NA"));
        if (muser.currentResident.UserType == "Resident")
        {
            drpAddcomAssign.Items.Insert(0, new ListItem("Admin", "Admin"));
        }
    }

    public void Employee()
    {

        DataAccess dacess = new DataAccess();
        String DataAssignedTypeQuery = "Select * from dbo.ViewEmployee where ServiceType = '" + drpComplaintcategory.SelectedItem.Text 
            + "' and SocietyID = " + muser.currentResident.SocietyID;
        DataSet ds = dacess.ReadData(DataAssignedTypeQuery);

        if (ds == null || ds.Tables[0].Rows.Count == 0)
        {
            DataAssignedTypeQuery = "Select * from dbo.Employee where ServiceType = 6 and SocietyID = " + SessionVariables.SocietyID;
            dacess = new DataAccess();
            ds = dacess.ReadData(DataAssignedTypeQuery);

        }

        if (ds == null)
        {


            drpAddcomAssign.Items.Clear();
            drpAddcomAssign.Items.Insert(0, new ListItem("No Employee Data", "NA"));
            drpAddcomAssign.DataTextField = "";
            drpAddcomAssign.DataValueField = "";
        }
        else
        {
            drpAddcomAssign.Items.Clear();
            //drpAddcomAssign.Items.Insert(0, new ListItem("Select", "NA"));
            drpAddcomAssign.DataTextField = "FirstName";
            drpAddcomAssign.DataValueField = "ID";
            drpAddcomAssign.DataSource = dacess.ReadData(DataAssignedTypeQuery).Tables[0];
            drpAddcomAssign.DataBind();

        }

    }



    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static String GetEmployeeForService(String service)
    {
        string JSONString = string.Empty;
        try
        {
            DataAccess dacess = new DataAccess();
            String DataAssignedTypeQuery = "Select * from dbo.ViewSocietyUsers where ServiceType = '" + service + "' and SocietyID = " + SessionVariables.SocietyID;
            DataSet ds = dacess.ReadData(DataAssignedTypeQuery);
            
            if (ds==null || ds.Tables[0].Rows.Count == 0)
            {
                DataAssignedTypeQuery = "Select * from dbo.ViewSocietyUsers where Type = 'Admin' and SocietyID = " + SessionVariables.SocietyID;
                dacess = new DataAccess();
                ds = dacess.ReadData(DataAssignedTypeQuery);

            }
          
            JSONString = JsonConvert.SerializeObject(ds.Tables[0]);
         

        }
        catch (Exception ex)
        { 
        
        
        }
        return JSONString;
    }

    protected void btnAddcomplaintsubmit_Click(object sender, EventArgs e)
    {

        if (btnAddcomplaintsubmit.Text == "Reset")
        {
           
            lblCompstatus.Text = "";
            btnAddcomplaintsubmit.Text = "Submit";
        }

        else
        {
            try
            {                   
                    Complaint newComp = new Complaint();

                    newComp.CompTypeID = Convert.ToInt32(drpComplaintcategory.SelectedItem.Value);
                   newComp.Assignedto = GetAvailableEmployee(newComp.CompTypeID);


                    //newComp.Assignedto = 4;

                    newComp.SeverityID = 2;
                    newComp.FlatNumber = txtAddcompFlat.Text;
                    newComp.CurrentStatus = 1;
                    newComp.Descrption = txtComplaintdescription.Text;

                if (muser.currentResident.UserType == "ResidentAdmin")
                {
                 
                    newComp.ResidentID = muser.currentResident.ResID;
                }
                else
                {
                    newComp.ResidentID = muser.currentResident.ResID;

                }
                    bool result = newComp.AddNewComplaint();

             
                    if (result == true)
                    {
                        drpComplaintcategory.SelectedIndex = 0;
                        txtComplaintdescription.Text = "";

                        //Added by Aarshi on 11-Sept-2017 for bug fix
                        drpAddcomAssign.Items.Clear();
                        drpAddcomAssign.Items.Insert(0, new ListItem("Select", "NA"));
                        txtAddcompFlat.Text = string.Empty;
                        txtComplaintername.Text = string.Empty;
                        LoadComplaintsDataList();
                        ClientScript.RegisterStartupScript(GetType(), "SetFocusScript", "<Script>self.close();</Script>");//code to close window
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:alert('Complaint Submitted Sucessfully')", true);
                        //FillComplaintData();
                       

                    }
                    else
                    {
                        lblCompstatus.ForeColor = System.Drawing.Color.Red;
                        lblCompstatus.Text = " Add complaint failed try later. ";
                        lblEmptyDataText.Visible = true;
                        lblEmptyDataText.Text = "Add complaint failed try later";
                    }
               
               
            }
            catch (Exception ex)
            {

            }

            finally
            {

            }
        }
    }



    private int GetAvailableEmployee(int CompType)
    {
        int id = 0;
        try {
            String strQuery = "Select ResID from dbo.ViewSocietyUsers where ServiceType = " + CompType + " and SocietyID = " + muser.currentResident.SocietyID;

            DataAccess da = new DataAccess();
             id =  da.GetSingleValue(strQuery);

             if (id == 0)
             {
                 strQuery = "Select ResID from dbo.ViewSocietyUsers where Type = 'Admin' and SocietyID = " + muser.currentResident.SocietyID;
                    da = new DataAccess();
                 id = da.GetSingleValue(strQuery);
             
             }
        }
        catch (Exception ex)
        { 
        
        
        }
        return id;
    }


    protected void txtAddcompFlat_TextChanged(object sender, EventArgs e)
    {
        if (muser.currentResident.UserType == "ResidentAdmin" || muser.currentResident.UserType == "Admin")
        {
            DataAccess dacess = new DataAccess();
            String ComplainternameQuery = "Select * from dbo.ViewSocietyUsers where  Type = 'Owner' and FlatNumber = '" + txtAddcompFlat.Text +
                                            "' and SocietyID = " + muser.currentResident.SocietyID;
            DataSet ds = dacess.ReadData(ComplainternameQuery);
            if (ds == null)
            {
                lblcomperror.Text = "Flat do not Exist";
            }
            else if (ds.Tables[0].Rows.Count == 0)
            {
                lblcomperror.Text = "Flat do not Exist";
            }
            else
            {
                txtComplaintername.Text = ds.Tables[0].Rows[0]["FirstName"].ToString() + ds.Tables[0].Rows[0]["LastName"].ToString();
                newComplaintResidentID =  Convert.ToInt32(ds.Tables[0].Rows[0]["ResID"].ToString());
                lblcomperror.Text = "";
            }
            

        }
    }
    protected void drpComplaintcategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (muser.currentResident.UserType == "ResidentAdmin")
        {
            Employee();
        }


    }




    /* ----------------------------------------------------------------- Edit Complaint section----------------------------------------------------------------------------------------- */



    //Added by Aarshi on 22-Sept-2017 for bug fix
    public void SendNotification()
    {
        Notification notification = new Notification();
        String GCMRegIDs = GetRegIDS();
        if (GCMRegIDs != "")
        {
            string message = "Complaint raised for  " + " test " + " is " + " Test ";
            notification.SendNotification(GCMRegIDs, message);
        }
    }

    //Added by Aarshi on 22-Sept-2017 for bug fix
    private String GetRegIDS()
    {
        String RegIDS = "";
        try
        {

            using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))
            {
                int i = 0;

                DataTable dt = new DataTable();
                con1.Open();
                SqlDataReader myReader = null;
                //SqlCommand myCommand = new SqlCommand("Select distinct RegID from dbo.GCMList GList INNER JOIN Resident Res ON Res.MobileNo = GList.MobileNo inner join ResidentNotification on Res.ResID = ResidentNotification.ResID WHERE ResidentNotification.ComplaintNotification = 1 AND Res.ResID=" + HiddenField5.Value, con1);
                SqlCommand myCommand = new SqlCommand("Select distinct RegID from dbo.GCMList GList INNER JOIN Resident Res ON Res.MobileNo = GList.MobileNo inner join ResidentNotification on Res.ResID = ResidentNotification.ResID WHERE ResidentNotification.BillingNotification = 1 AND Res.FlatID = '" + HiddenResID.Value + "'", con1);
                myReader = myCommand.ExecuteReader();

                StringBuilder sb = new StringBuilder();

                while (myReader.Read())
                {
                    sb.Append(myReader["RegID"].ToString().Trim());
                    sb.Append("\",\"");
                }
                if (sb.Length > 10)
                {
                    sb.Remove(sb.Length - 3, 3);

                    RegIDS = sb.ToString();
                }

            }

            return RegIDS;
        }
        catch (Exception ex)
        {
            return RegIDS;
        }

    }


    //Added by Aarshi on 22-Sept-2017 for bug fix
    public void SendMail()
    {
        string EmailID = string.Empty;
        string EmailSubject = string.Empty;
        string EmailBody = string.Empty;
        string FirstName = string.Empty;
        try
        {

            DataAccess da = new DataAccess();
            DataSet ds = da.GetData("Select EmailId,FirstName from dbo.Resident inner join ResidentNotification on Resident.ResID = ResidentNotification.ResID WHERE ResidentNotification.ComplaintMail = 1 AND Resident.ResID =" + HiddenResID.Value);
            if(ds != null)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    EmailID = EmailID+ ds.Tables[0].Rows[i]["EmailId"].ToString() +",";
               
                }
                EmailID = EmailID.Substring(0, EmailID.Length - 1);

                EmailSubject = "Complaint is " + " Test ";

                StringBuilder result = new StringBuilder();
                result.Append("Hi ");
                result.AppendLine();
                result.AppendLine();
                result.Append("Complaint raised for  " + " Test " + " is " + "  test ");
                result.AppendLine();
                result.AppendLine();
                result.Append("This is auto generated mail please do not reply.");

                EmailBody = Convert.ToString(result);

                Notification notification = new Notification();
                notification.SendMail(EmailID, EmailSubject, EmailBody);
            }
            /*
            using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))
            {
                int i = 0;

                DataTable dt = new DataTable();
                con1.Open();
                SqlDataReader myReader = null;
                SqlCommand myCommand = new SqlCommand("Select EmailId,FirstName from dbo.Resident inner join ResidentNotification on Resident.ResID = ResidentNotification.ResID WHERE ResidentNotification.ComplaintMail = 1 AND Resident.ResID =" + HiddenResID.Value, con1);

                myReader = myCommand.ExecuteReader();

                StringBuilder sb = new StringBuilder();

                if (myReader.HasRows)
                {
                    while (myReader.Read())
                    {
                        EmailID = myReader["EmailId"].ToString();
                        FirstName = myReader["FirstName"].ToString();
                    }

                    EmailSubject = "Complaint is " + drpNewStatus.SelectedItem.Text;

                    StringBuilder result = new StringBuilder();
                    result.Append("Hi " + FirstName + ",");
                    result.AppendLine();
                    result.AppendLine();
                    result.Append("Complaint raised for  " + drpEditCompType.SelectedItem.Text + " is " + drpNewStatus.SelectedItem.Text);
                    result.AppendLine();
                    result.AppendLine();
                    result.Append("This is auto generated mail please do not reply.");

                    EmailBody = Convert.ToString(result);

                    Notification notification = new Notification();
                    notification.SendMail(EmailID, EmailSubject, EmailBody);
                }
            }*/
        }
        catch(Exception ex) {
            int a = 1;
        
        }
    }




    protected void ImgCompSearch_Click(object sender, EventArgs e)
    {
        LoadComplaintsDataList();

    }

    protected void drpEditCompType_SelectedIndexChanged(object sender, EventArgs e)
    {
        //String CompType = drpEditCompType.SelectedItem.Text;

        //DataAccess dacess = new DataAccess();
        //String DataAssignedTypeQuery = "Select * from dbo.ViewEmployee where ServiceType = '" + CompType + "'";
        //DataSet ds = dacess.ReadData(DataAssignedTypeQuery);

        //if (ds == null)
        //{
        //    drpEditCompAssgned.Items.Clear();
        //    drpEditCompAssgned.Items.Insert(0, new ListItem("No Employee Data", "NA"));
        //    drpEditCompAssgned.DataTextField = "";
        //    drpEditCompAssgned.DataValueField = "";
        //}

        //else
        //{
        //    drpEditCompAssgned.Items.Clear();
        //    //drpAddcomAssign.Items.Insert(0, new ListItem("Select", "NA"));
        //    drpEditCompAssgned.DataTextField = "FirstName";
        //    drpEditCompAssgned.DataValueField = "ID";
        //    drpEditCompAssgned.DataSource = dacess.ReadData(DataAssignedTypeQuery).Tables[0];
        //    drpEditCompAssgned.DataBind();
        //}
    }
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        String CompStatus = drpVCompStatusF.SelectedItem.Text;
        String FlatNumber = txtVcompFlatSrch.Text;


        if (CompStatus == "" || FlatNumber == "")
        {
            args.IsValid = false;
        }
    }


    [System.Web.Services.WebMethod]
    public static List<string> GetFlatNumber(string FlatNumber)
    {
        List<string> Emp = new List<string>();
        try
        {
            string query = string.Format("Select distinct FlatNumber from dbo.ViewComplaintSummary where FlatNumber like'" + FlatNumber + "%'");
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
        }
        catch (Exception ex)
        { 
        
        }
        return Emp;
    }


    protected void drpComplaintDateFilter_SelectedIndexChanged(object sender, EventArgs e)
    {
        
        String ComplaintDateFilter = drpComplaintDateFilter.SelectedItem.Text;
        String FlatNumber = txtVcompFlatSrch.Text;
        String ComplaintStatus = drpVCompStatusF.SelectedItem.Text;
        Complaint ComplaintView = new Complaint();
        DataSet dataset = ComplaintView.GetComplaints(muser.currentResident.SocietyID, muser.currentResident.FlatNumber, "", ComplaintStatus, ComplaintDateFilter);
                
        if (dataset.Tables.Count > 0)
                {
                    //VComplaintsGrid.DataSource = dataset;
                    //VComplaintsGrid.DataBind();
                }
 
    }


    protected void Complaint_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = e.Row.DataItem as DataRowView;
                String status = drv["LastStatus"].ToString();

                if (muser.currentResident.UserType == "ResidentAdmin")
                { }
                else if (muser.currentResident.UserType == "Owner" || muser.currentResident.UserType == "Owner")
                { }
            }
          
        }
        catch (Exception ex)
        {
            int a = 1;
        }
    }
    protected void DataListComplaint_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadComplaintsDataList();
        //FillComplaintData();
    }
    protected void DataListComplaint_ItemDataBound(object sender, DataListItemEventArgs e)
    {

        try
        {
            if ((e.Item.ItemType == ListItemType.Item)|| e.Item.ItemType == ListItemType.AlternatingItem)
            {
                    HtmlButton btnOpen = (HtmlButton)e.Item.FindControl("btnOpen");
                    HtmlButton btnClose = (HtmlButton)e.Item.FindControl("btnClose");
                 HtmlButton btnComplete = (HtmlButton)e.Item.FindControl("btnComplete");
                 HtmlButton btnAssign = (HtmlButton)e.Item.FindControl("btnAssign");
                Label lblClosedDate = (Label)e.Item.FindControl("lblClosedDate");

                DataRowView drv = e.Item.DataItem as DataRowView;
                String CompSTatus = drv["LastStatus"].ToString();
                if (CompSTatus != "New")
                {
                    lblClosedDate.Visible = true;
                }
                else
                {
                    lblClosedDate.Visible = false;
                }
                if (muser.currentResident.UserType == "ResidentAdmin"|| muser.currentResident.UserType == "Admin")
                        {
                       
                      if (CompSTatus == "Complete" || CompSTatus == "Closed") {
                           btnClose.Visible=false;
                           btnOpen.Visible=false;
                           btnComplete.Visible=false;
                           btnAssign.Visible=false;
                        }
                      else if(CompSTatus == "New" || CompSTatus == "InProgress"||CompSTatus == "Assigned")
                         {
                           btnClose.Visible=false;
                           btnOpen.Visible=false;
                           btnComplete.Visible=true;
                           btnAssign.Visible=true;
                         }
               
            }
                else if (muser.currentResident.UserType == "Owner" ||muser.currentResident.UserType == "Tenant")
                {
                      if (CompSTatus == "Complete" ) {
                               btnClose.Visible=false;
                               btnOpen.Visible=true;
                               btnComplete.Visible=false;
                               btnAssign.Visible=false;
                            }
                          else if(CompSTatus == "New" || CompSTatus == "InProgress"||CompSTatus == "Assigned")
                             {
                               btnClose.Visible=true;
                               btnOpen.Visible=false;
                               btnComplete.Visible=false;
                               btnAssign.Visible=false;
                             }
                }
                        else if (muser.currentResident.UserType == "Employee")
                        {
                            btnClose.Visible = false;
                            btnOpen.Visible = false;
                            btnComplete.Visible = true;
                            btnAssign.Visible = false   ;
                        }
            
            }

        }
        catch (Exception ex)
        {
            int a = 1;
        }
    }
    protected void DataListComplaint_ItemCommand(object source, DataListCommandEventArgs e)
    {
                 if (e.CommandName == "OpenComplaint")
            {
        
                int CompID = Convert.ToInt32(e.CommandArgument);

                //ScriptManager.RegisterStartupScript(this.GetType(), "alert('')", "ShowCloseConfirmation()", true);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "ShowCloseConfirmation()", true);
        
            }
    }

    protected void btnUpdate_Click2(object sender, EventArgs e)
    {
    }
        protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            Complaint updateComplaint = new Complaint();
            updateComplaint.ExistingComplaintID = Convert.ToInt32(HiddenCompID.Value);
            updateComplaint.Assignedto = Convert.ToInt32(HiddenEmployeeID.Value);
            updateComplaint.CurrentStatus = Convert.ToInt32(HiddenCompStatus.Value);
            updateComplaint.Descrption = txtComplaintdescription.Text;
       
            bool result = updateComplaint.UpdateComplaint(updateComplaint.ExistingComplaintID, updateComplaint.Descrption, updateComplaint.Assignedto, updateComplaint.CurrentStatus);

            if (result)
            {
                //Response.Redirect(Request.RawUrl);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "UpdateSuccessfully()", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "alert('fail')", true);
            }
        }
        catch(Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "alert('fail')", true);

        }

    }
}
