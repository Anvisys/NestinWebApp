using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;

using System.Net;
using System.IO;
using System.Web.Query;
using System.Windows;

using System.Text;
using System.Drawing;
using System.Drawing.Imaging;
using System.Collections;
using System.Collections.Generic;
using System.Web.UI.HtmlControls;

public partial class Notifications : System.Web.UI.Page
{

    /*  This Total  code  is  licenced
    Developed By Anvisys Technologies Pvt Ltd.
    
    Copyright © 2016 Anvisys Technologies Pvt. Ltd.All rights reserved.
    */

    User muser;
    DateTime Notice_time_stamp;
    Dictionary<int,String> ImageDictionary = new Dictionary<int,String>();

    PagedDataSource adsource;
    int pos;
    static string status = "";
    private String VIEW_NOTIFICATION = "dbo.ViewNotifications";
    private String TABLE_NOTIFICATION = "dbo.Notifications";

    protected void Page_Load(object sender, EventArgs e)
    {
        //muser = (User)Session["User"];
        //Added by Aarshi on 18 auh 2017 for session storage
        muser = SessionVariables.User;
        SessionVariables.CurrentPage = "Notifications.aspx";
        if (muser == null)
        {
            Response.Redirect("Login.aspx");
        }

        //Added by aarshi on 21-Sept-2017 for bug fix
        //txtNotificationText.Attributes.Add("onkeyup", "return GetCount(" + txtNotificationText.ClientID + "," + lblNotificationCount.ClientID + ");");
        txtNotificationText.Attributes.Add("onkeyup", "return GetCount(" + txtNotificationText.ClientID + "," + lblNotificationCount.ClientID + ");");
        txtNotificationText.Attributes.Add("onChange", "return GetCount(" + txtNotificationText.ClientID + "," + lblNotificationCount.ClientID + ");");
       
        if (!IsPostBack)
        {
            this.ViewState["vs"] = 0;
            pos = (int)this.ViewState["vs"];   


            FillNotificationData(muser.currentResident.SocietyID);

           

        }
    }
    protected void openbtn_Click(object sender, EventArgs e)
    {
        
    }

    public void FillNotificationData(int SocietyID)
    {
        try
        {
            DataAccess dacess = new DataAccess();

            String DatalistQuery = "SELECT * FROM "+ VIEW_NOTIFICATION+ "  where SocietyID ='" + SocietyID + "' and EndDate  >= getDate() order by date desc";


            if (status == "Open")
            {
                DatalistQuery = "SELECT * FROM " + VIEW_NOTIFICATION + "  where SocietyID ='" + SocietyID + "' and  EndDate >= getDate() order by date desc";
            }
            else if (status == "Closed")
            {
                DatalistQuery = "Select * from " + VIEW_NOTIFICATION + " where SocietyID ='" + SocietyID + "' and  EndDate <= getDate() order by date desc ";
            }
            else if (status == "All")
            {
                DatalistQuery = " Select * from " + VIEW_NOTIFICATION + " Where SocietyID ='" + SocietyID + "'  order by date desc ";
            }

            DataSet ds = dacess.ReadData(DatalistQuery);

            if (ds == null)
            {
                drpNotifiFilter.Visible = false;
                lblEmptyTitle.Visible = true;
                lblEmptyTitle.Text = "Hello ! Welcome  to the Notifications, Here you  will get  all the  Notifications Regarding  this  Society sent  by Admin.";
            }

            else
            {
                DataTable dt = ds.Tables[0];

                if (ds.Tables.Count > 0)
                {

                    //DataNotifications.DataSource = ds;
                    //DataNotifications.DataBind();
                    DataNotifications.Visible = true;
                    lblEmptyTitle.Visible = false;


                    adsource = new PagedDataSource();
                    adsource.DataSource = ds.Tables[0].DefaultView;
                    adsource.PageSize = 5;
                    adsource.AllowPaging = true;
                    adsource.CurrentPageIndex = pos;
                    DataNotifications.DataSource = adsource;
                    btnprevious.Visible = !adsource.IsFirstPage;
                    btnnext.Visible = !adsource.IsLastPage;
                    //dataListComplaint.DataSource = ds;
                    DataNotifications.DataBind();

                    lblPage.Text = "Page " + (adsource.CurrentPageIndex + 1) + " of " + adsource.PageCount;





                }
                else
                {
                }

              // showOpen.CssClass.Remove("Active");
                showOpen.Attributes["class"] = "Active";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert('')", " SetActiveClass('Open')", true);
            }          
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
        FillNotificationData(muser.currentResident.SocietyID);
    }

    protected void btnnext_Click(object sender, EventArgs e)
    {
        pos = (int)this.ViewState["vs"];
        pos += 1;
        this.ViewState["vs"] = pos;
        FillNotificationData(muser.currentResident.SocietyID);
    }

    protected void btnNotificationsSend_Click(object sender, EventArgs e)
    {
        String GCMRegIDs = GetRegIDS();
        
        int NoticeID = -99;

        NoticeID = AttachmentUploadNew();
        if (NoticeID > 0)
        {
            if (GCMRegIDs != "")
            {

               // SendNotification(GCMRegIDs, NoticeID);
            }
            FillNotificationData(muser.currentResident.SocietyID);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:alert('Failed to send Notification')", true);
        }
    }

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
                //Added by Aarshi on 21 - Sept - 2017 for bug fix
               SqlCommand myCommand = new SqlCommand("Select distinct RegID from dbo.GCMList", con1);
               // SqlCommand myCommand = new SqlCommand("Select ResidentNotification.Notice, Resident.ResID, *from dbo.GCMList INNER JOIN Resident ON Resident.MobileNo = GCMList.MobileNo Left JOIN ResidentNotification ON Resident.ResID = ResidentNotification.ResID WHERE ResidentNotification.Notice =1 OR ResidentNotification.Notice IS NULL", con1);
                

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


    public void SendNotification(string receiverID, int notice_id)
    {
        try
        {
            int has_attachment = 0;
            String fileName = "a";
            if (FileNotifications.HasFile)
            {
                has_attachment = 1;
                fileName = FileNotifications.PostedFile.FileName;
            }
            else
            {
                has_attachment = 0;
                fileName = "a";

            }
            String date_time = String.Format("{0:s}", Notice_time_stamp);
            String TillDate = ValidTill.Value;

            //Added by Aarshi on 14 - Sept - 2017 for bug fix

            String Message = notice_id + "&" + txtNotificationText.Text  + "&" + TillDate + "&" + date_time + "&" + has_attachment 
                + "&" + fileName + "&" + muser.currentResident.ResID;
            Notification noti = new Notification();
           // noti.SendNotification(receiverID, Message);


          
        }
        catch (Exception ex)
        {

            int a = 1;
        }
    }


    public int AttachmentUploadNew()
    {
        int newItemID = -99;
        //string TillDate = ValidTill.Value;
     
        DateTime TillDate = Convert.ToDateTime(ValidTill.Value);
        Notice_time_stamp = Utility.GetCurrentDateTimeinUTC();

        try
        {
            using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))
            {
                int UpdateCount = 0;
                con1.Open();
                if (FileNotifications.HasFile)
                {
                    
                    String Filename = FileNotifications.PostedFile.FileName;
                    string extension = Path.GetExtension(Filename);
                    String FileType = FileNotifications.PostedFile.ContentType;
                    int Length = FileNotifications.PostedFile.ContentLength;
                    byte[] data = null;
                    HttpPostedFile file = FileNotifications.PostedFile;
                    data = new byte[Length];
                    file.InputStream.Read(data, 0, Length);
                    String path = System.Web.Hosting.HostingEnvironment.MapPath("~/ImageServer/Notice");


                    if ((extension == ".pdf") || (extension == ".doc") || (extension == ".docx") || (extension == ".xls") || (extension == ".xlsx"))
                    {
                        String strQuery = "Insert Into "+ TABLE_NOTIFICATION+" (Notification,EndDate,send_by,Date,AttachName,SocietyID) Values ('" + txtNotificationText.Text + "','" 
                            + Utility.ChangeDateTimeLocalToSQLServerFormat(TillDate) + "','" + muser.currentResident.ResID + "','" + Utility.ChangeDateTimeLocalToSQLServerFormat(Notice_time_stamp) + "','" + Filename + "','" + muser.currentResident.SocietyID + "')";
                        SqlCommand cmd = new SqlCommand(strQuery, con1);
                        UpdateCount = cmd.ExecuteNonQuery();
                        if (UpdateCount > 0)
                        {
                            String query = "select max(ID) from " + TABLE_NOTIFICATION ;
                            SqlCommand IDcmd = new SqlCommand(query, con1);
                            newItemID = Convert.ToInt32(IDcmd.ExecuteScalar());

                            String ImagePath = path + "\\" + newItemID;
                            bool exists = System.IO.Directory.Exists(ImagePath);
                            if (!exists)
                            {
                                System.IO.Directory.CreateDirectory(ImagePath);
                            }
                            file.SaveAs(ImagePath + "\\" + Filename);
                        }
                    }
                    else
                    {
                        String strQuery = "Insert Into "+ TABLE_NOTIFICATION +" (Notification,EndDate,send_by,Date,AttachName,SocietyID) Values ('" + txtNotificationText.Text + "','" 
                            + Utility.ChangeDateTimeLocalToSQLServerFormat(TillDate) + "','" + muser.currentResident.ResID + "','" + Utility.ChangeDateTimeLocalToSQLServerFormat(Notice_time_stamp) + "','" + Filename + "','" + muser.currentResident.SocietyID + "')";
                        SqlCommand cmd = new SqlCommand(strQuery, con1);
                      
                        UpdateCount = cmd.ExecuteNonQuery();
                        if (UpdateCount > 0)
                        {
                            SqlCommand IDcmd = new SqlCommand("select max(ID) from " + TABLE_NOTIFICATION, con1);
                            newItemID = Convert.ToInt32(IDcmd.ExecuteScalar());
                            
                            String ImagePath = path + "\\" + newItemID;
                            bool exists = System.IO.Directory.Exists(ImagePath);
                            if (!exists)
                            {
                                System.IO.Directory.CreateDirectory(ImagePath);
                            }
                            file.SaveAs(ImagePath + "\\" + Filename);
                        }

                        
                    }
                }
                else
                {
                    DataAccess dacess = new DataAccess();

                    string NotificationQuery = "Insert into "+ TABLE_NOTIFICATION   + " (Notification,EndDate,send_by, Date,SocietyID) values('" + txtNotificationText.Text + "','" 
                        + Utility.ChangeDateTimeLocalToSQLServerFormat(TillDate) + "','" + muser.currentResident.ResID + "','" + Utility.ChangeDateTimeLocalToSQLServerFormat(Notice_time_stamp) + "','" + muser.currentResident.SocietyID + "' )";

                    SqlCommand cmd = new SqlCommand(NotificationQuery, con1);
                    UpdateCount = cmd.ExecuteNonQuery();
                    if (UpdateCount > 0)
                    {
                        SqlCommand IDcmd = new SqlCommand("select max(ID) from " + TABLE_NOTIFICATION, con1);
                        newItemID = Convert.ToInt32(IDcmd.ExecuteScalar());

                    }
                }

                if (UpdateCount == 1)
                {
                   
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:alert('Notification Added successfully')", true);
                    // Response
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:alert('Failed to send Notification')", true);
                }
                con1.Close();
            }
        }
        catch (Exception ex)
        {
            int a = 1;
        }
        return newItemID;
    }

    //public void AttachmentUpload()
    //{

    //    if (FileNotifications.HasFile)
    //    {
    //        int Length = FileNotifications.PostedFile.ContentLength;

    //        if (Length > 2048)
    //        {

    //        }
    //        else
    //        {

    //            String Filename = FileNotifications.PostedFile.FileName;
    //            string extension = Path.GetExtension(Filename);
    //            String FileType = FileNotifications.PostedFile.ContentType;

    //            byte[] data = null;
    //            HttpPostedFile file = FileNotifications.PostedFile;
    //            data = new byte[Length];
    //            file.InputStream.Read(data, 0, Length);
    //            String path = System.Web.Hosting.HostingEnvironment.MapPath("~/Images/Temp");

    //            if ((extension == ".pdf") || (extension == ".doc") || (extension == ".docx") || (extension == ".xls") || (extension == ".xlsx"))
    //            {
                    
    //                using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))
    //                {
    //                    con1.Open();
    //                    // SqlCommand cmd = new SqlCommand("INSERT INTO Vendors (ShopCategory,VendorName,ContactNum,Address,VendorIcon,VendorIconFormat) VALUES (@ShopCategory,@VendorName,@ContactNum,@Address,@VendorIcon,@VendorIconFormat)", con1);
    //                    SqlCommand cmd = new SqlCommand("Insert Into dbo.Notifications (Notification,send_by,Date,AttachData,AttachType,SocietyID) Values ('" + txtNotificationText.Text + "','" 
    //                        + muser.currentResident.ResID +"','" + Utility.GetCurrentDateTimeinUTC() + "',@AttachedImage,'" + FileType + "','" + muser.currentResident.SocietyID + "')", con1);
    //                    cmd.Parameters.Add("@AttachedImage", SqlDbType.VarBinary, 2048).Value = data;
    //                    int count = cmd.ExecuteNonQuery();
    //                    con1.Close();
    //                    if (count == 1)
    //                    {
    //                        HiddenNotificationSuccess.Value = "Success";
    //                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:alert('" + Filename + "  Added successfully')", true);
    //                        // Response
    //                    }
    //                    else
    //                    {
    //                        HiddenNotificationSuccess.Value = "Fail";
    //                    }
    //                }

    //            }


    //            else
    //            {
    //                using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))
    //                {
    //                    con1.Open();
    //                    // SqlCommand cmd = new SqlCommand("INSERT INTO Vendors (ShopCategory,VendorName,ContactNum,Address,VendorIcon,VendorIconFormat) VALUES (@ShopCategory,@VendorName,@ContactNum,@Address,@VendorIcon,@VendorIconFormat)", con1);
    //                    SqlCommand cmd = new SqlCommand("Insert Into dbo.Notifications (Notification,send_by,Date,ImageData,AttachType) Values ('" + txtNotificationText.Text + "','" 
    //                        + muser.currentResident.ResID + "','" + Utility.GetCurrentDateTimeinUTC() + "',@AttachedImage,'" + FileType + "')", con1);
    //                    cmd.Parameters.Add("@AttachedImage", SqlDbType.Image).Value = data;
    //                    int count = cmd.ExecuteNonQuery();
    //                    con1.Close();
    //                    if (count == 1)
    //                    {
    //                        HiddenNotificationSuccess.Value = "Success";
    //                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:alert('" + Filename + "  Added successfully')", true);
    //                        // Response
    //                    }
    //                    else
    //                    {

    //                        HiddenNotificationSuccess.Value = "Fail";
    //                    }

    //                    ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "alert('Format is not supported')", true);
    //                }



    //            }
    //        }
    //    }

    //    else
    //    {

    //        DataAccess dacess = new DataAccess();

    //        string NotificationQuery = "Insert into dbo.Notifications(Notification,send_by, date) values('" + txtNotificationText.Text 
    //            + "','" +muser.currentResident.ResID +"','" + Utility.GetCurrentDateTimeinUTC() + "' )";

    //        bool result = dacess.Update(NotificationQuery);
    //        lblNotifistatus.Visible = true;
    //        if (result == true)
    //        {
    //           // lblNotifistatus.Text = "Notification added sucessfully";
    //            HiddenNotificationSuccess.Value = "Success";
               
    //        }

    //        else
    //        {
    //            //lblNotifistatus.Text = "failed to  add notification, try later";
    //            HiddenNotificationSuccess.Value = "Fail";
    //        }
        
    //    }


    //    FillNotificationData();
        
    //}


  


    protected void btnNofificancel_Click(object sender, EventArgs e)
    {
       // MultiView1.ActiveViewIndex = -1;


    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        FillNotificationData(muser.currentResident.SocietyID);
    }
    protected void Addnotifi_Click(object sender, EventArgs e)
    {
       
    }


    protected void txtNotificationText_TextChanged(object sender, EventArgs e)
    {
        if (txtNotificationText.Text != "")
        {

            btnNotificationsSend.Visible = true;
        }
    }

    protected void drpNotifiFilter_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataAccess dacess = new DataAccess();

        String Date = drpNotifiFilter.SelectedItem.Text;
        String DateFilter = "";

        System.DateTime startDate = new DateTime();
        System.DateTime endDate = new DateTime();


        if (Date == "All")
        {
            FillNotificationData(muser.currentResident.SocietyID);
            lblEmptyTitle.Visible = false;
        }

        else
        {

            if (Date == "This Month")
            {
                // System.DateTime date = System.DateTime.Now;
                DateTime date = Utility.GetCurrentDateTimeinUTC();
                int month = date.Month;
                int year = date.Year;
                int days = System.DateTime.DaysInMonth(year, month);
                startDate = new DateTime(year, month, 1);
                endDate = new DateTime(year, month, days);
            }

            if (Date == "Last Month")
            {
                // System.DateTime date = System.DateTime.Now;

                DateTime date = Utility.GetCurrentDateTimeinUTC();

                System.DateTime prevDate = date.AddMonths(-1);

                int month = prevDate.Month;
                int year = prevDate.Year;

                int days = System.DateTime.DaysInMonth(year, month);

                startDate = new DateTime(year, month, 1);
                endDate = new DateTime(year, month, days);
            }

            if (Date == "This Year")
            {
                DateTime CurrentDate = Utility.GetCurrentDateTimeinUTC();

                int year = CurrentDate.Year;
                startDate = new DateTime(year, 1, 1);
                endDate = new DateTime(year, 12, 31);
            }

            DateFilter = "Select * from "+ VIEW_NOTIFICATION +" where Date between  '" + startDate + "' and '" + endDate + "' ";
            DataSet ds = dacess.ReadData(DateFilter);
            if (ds == null)
            {
                DataNotifications.Visible = false;
                lblEmptyTitle.Text = "Selected Data is  not  Found.";
                lblEmptyTitle.Visible = true;
            }

            else
            {
                DataNotifications.Visible = true;
                lblEmptyTitle.Text = "";
                DataTable dta = ds.Tables[0];

                if (dta.Rows.Count != 0)
                {

                    DataNotifications.DataSource = ds;
                    DataNotifications.DataBind();

                }
            }
        }
    }

           
   

    protected void DataNotifications_SelectedIndexChanged(object sender, EventArgs e)
    {
      
    }

    protected void DataNotifications_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView drv = e.Item.DataItem as DataRowView;
                ImageButton ImgeAtach = (ImageButton)e.Item.FindControl("ImageAttachemnt");
                ImgeAtach.Visible = false;

                HtmlControl attachment = (HtmlControl)e.Item.FindControl("attachment");
                String File_Name = drv["AttachName"].ToString();
                if (File_Name == null || File_Name =="")
                {
                    
                   
                    attachment.Visible = false;
                    System.Web.UI.WebControls.Image imgFiles = (System.Web.UI.WebControls.Image)e.Item.FindControl("ImageFile");
                    imgFiles.Visible = false;
                    Label lblFileName = (Label)e.Item.FindControl("lblFileName");
                    lblFileName.Visible = false;
                }
                else {
                   
                    
                    String[] fileArray = File_Name.Split('.');
                    if (fileArray[1] == "jpeg" || fileArray[1] == "jpg" || fileArray[1] == "png")
                        {
                        attachment.Visible = false;
                        String FileName = drv["AttachName"].ToString();
                               String Notice_ID = drv["ID"].ToString();
                              

                               String path = System.Web.Hosting.HostingEnvironment.MapPath("~/ImageServer/Notice") + "//" + Notice_ID;
                                 System.Web.UI.WebControls.Image imgFile = (System.Web.UI.WebControls.Image)e.Item.FindControl("ImageFile");
                                 imgFile.ImageUrl = "~/ImageServer/Notice/" + Notice_ID + "/" + FileName;

                                 Label lblFileName = (Label)e.Item.FindControl("lblFileName");
                                 lblFileName.Visible = false;
                        }
                else 
                {
                    System.Web.UI.WebControls.Image imgFile = (System.Web.UI.WebControls.Image)e.Item.FindControl("ImageFile");
                    imgFile.Visible = false;
                        attachment.Visible = true;

                    }
            }

                // Set Administrator Image
             //int id = Convert.ToInt32(drv["send_by"]);

             //   if (ImageDictionary.ContainsKey(id))
             //   {
             //       System.Web.UI.WebControls.Image userImage = (System.Web.UI.WebControls.Image)e.Item.FindControl("user_image");
             //       userImage.ImageUrl = "data:image/jpeg;charset=utf-8;base64," + ImageDictionary[id];
             //   }
             //   else
             //   {
             //       String ImageQuery = "Select Profile_image from dbo.ViewUserImage where ResID = " + id;

             //       DataAccess dAccess = new DataAccess();
             //       byte[] bytes = (byte[])dAccess.GetImage(ImageQuery);
             //       String imgString = Convert.ToBase64String(bytes, 0, bytes.Length);
                    
             //       ImageDictionary.Add(id, imgString);
             //       System.Web.UI.WebControls.Image UserImage = (System.Web.UI.WebControls.Image)e.Item.FindControl("user_image");
                   
             //      UserImage.ImageUrl = "data:image/png;base64," + imgString;
             //   }
                

            }
        }
        catch (Exception ex)
        {
            int a = 1;
        }
    }


    protected void showOpen_Click(object sender, EventArgs e)
    {
        try
        {
            status = "Open";
            FillNotificationData(muser.currentResident.SocietyID);
            // DataAccess dacess = new DataAccess();
            // string NotificationQuery = " Select * from "+ VIEW_NOTIFICATION + " where SocietyID ='" + muser.currentResident.SocietyID + "' and EndDate >= getDate() order by date desc";

            // DataSet Filterds = dacess.ReadData(NotificationQuery);
            //DataNotifications.DataSource = Filterds;
            //DataNotifications.DataBind();
            ClientScript.RegisterStartupScript(this.GetType(), "alert('')", " SetActiveClass('Open')", true);
        }

        catch (Exception ex)
        {

        }
    }
    protected void showClose_Click(object sender, EventArgs e)
    {
        try
        {
            status = "Closed";
            FillNotificationData(muser.currentResident.SocietyID);
            //DataAccess dacess = new DataAccess();
            //string NotificationQuery = "Select * from " + VIEW_NOTIFICATION + " where EndDate <= getDate() order by date desc";

            //DataSet Filterds = dacess.ReadData(NotificationQuery);
            //DataNotifications.DataSource = Filterds;
            //DataNotifications.DataBind();
            ClientScript.RegisterStartupScript(this.GetType(), "alert('')", " SetActiveClass('Close')", true);
        }

        catch (Exception ex)
        {

        }
    }

    protected void showAll_Click(object sender, EventArgs e)
    {
        try
        {
            status = "All";
            FillNotificationData(muser.currentResident.SocietyID);

            //DataAccess dacess = new DataAccess();
            //string NotificationQuery = " Select * from " + VIEW_NOTIFICATION + " order by date desc";

            //DataSet Filterds = dacess.ReadData(NotificationQuery);
            //DataNotifications.DataSource = Filterds;
            //DataNotifications.DataBind();
            ClientScript.RegisterStartupScript(this.GetType(), "alert('')", " SetActiveClass('All')", true);
        }

        catch (Exception ex)
        {

        }
    }
}
    
    

