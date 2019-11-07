using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.IO;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;

using Newtonsoft.Json;

public partial class Userprofile : System.Web.UI.Page
{
    /*  This Total  code  is  licenced
    Developed By Anvisys Technologies Pvt Ltd.
    
    Copyright © 2016 Anvisys Technologies Pvt. Ltd.All rights reserved.
    */

    User muser;

    public string UserNameFirstLetter
    {
        get { return muser.FirstName.Substring(0, 1); }
    }


    public string UserType
    {
        get {
            if (muser.AllResidents.Count > 0)
                return muser.currentResident.UserType;
            else return "";
        }
    }
    public int UserID
    {
        get
        {
            return muser.UserID;
        }
    }

    public String UserName
    {
        get
        {
            return muser.FirstName +" "+ muser.LastName;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        
        //Added by Aarshi on 18 auh 2017 for session storage
        //muser = (User)Session["User"];
        SessionVariables.CurrentPage = "Userprofile.aspx";
        muser = SessionVariables.User;

        if (muser.AllResidents.Count == 0)
        {

        }
        if (muser == null)
        {

            Response.Redirect("Login.aspx");

        }

        if (!IsPostBack)
        {
            lbluser.Text = muser.FirstName;
            FillData();
            Editdata();
           //  GetProfileImage();


        }
       
      
    }

  
    public void Editdata()
    {
        using (SqlConnection con1 = new SqlConnection(Utility.MasterDBString))
        {

            DataTable dt = new DataTable();

            con1.Open();

            SqlDataReader myReader = null;

            String strQuery = "select * from dbo.TotalUsers where UserLogin ='" + muser.UserLogin + "'";

            SqlCommand myCommand = new SqlCommand(strQuery, con1);

            myReader = myCommand.ExecuteReader();

            while (myReader.Read())
            {

               txtUFName.Text = (myReader["FirstName"].ToString().Trim());

                txtUMName.Text = myReader["MiddleName"].ToString();


                txtULName.Text = myReader["LastName"].ToString();


                txtUMobile.Text = myReader["MobileNo"].ToString().Trim();


                txtUEmail.Text = myReader["Emailid"].ToString();
                txtUAddress.Text = myReader["Address"].ToString().Trim();

            }
            con1.Close();
        }
    }

    public void FillData()
    {
        if (muser.AllResidents.Count > 0)
        {
            lblUsrResType.Text = muser.currentResident.UserType;
            lblActivedate.Text = muser.currentResident.ActiveDate;
            lblFlatNo.Text = muser.currentResident.FlatNumber;
            lblIntercom.Text = muser.currentResident.IntercomNumber;

            lblsocietyname.Text = muser.currentResident.SocietyName;
        }
        txtUFName.Enabled = false;
        txtUMName.Enabled = false;
        txtULName.Enabled = false;
        txtUMobile.Enabled = false;
        txtUEmail.Enabled = false;
        txtUAddress.Enabled = false;

       // btnUsrPrfileSubmit.Visible = false;

    }

    public void DisableDetails()
    {

        //lblUFName.Visible = false;
        //lblUMName.Visible = false;
        //lblULName.Visible = false;
        //lblUsrMobile.Visible = false;
        //lblUsrEmail.Visible = false;
        //lblUsrAddress.Visible = false;
        //lblUFName.Width = 0;
        //lblUsrMobile.Width = 0;
        //lblUsrEmail.Width = 0;
        //lblUsrAddress.Width = 0;
    }

    public void EnableDetails()
    {
        //txtUFName.Visible = true;
        //txtUMName.Visible = true;
        //txtULName.Visible = true;
        //txtUMobile.Visible = true;
        //txtUEmail.Visible = true;
        //txtUAddress.Visible = true;

        //txtUFName.Text = lblUFName.Text;
        //txtUMName.Text = lblUMName.Text;
        //txtULName.Text = lblULName.Text;
        //txtUMobile.Text = lblUsrMobile.Text;
        //txtUEmail.Text = lblUsrEmail.Text;
        //txtUAddress.Text = lblUsrAddress.Text;

    }


    protected void btnUsrEditProfile_Click(object sender, EventArgs e)
    {
        DisableDetails();
        EnableDetails();
        // btnUsrEditProfile.Visible = false;
      //  btnUsrEprofileCncel.Visible = true;
       // btnUsrPrfileSubmit.Visible = true;
       // btnUsrUpdateP.Visible = false;
       // btnUsrEditProfile.Visible = false;




    }



    protected void btnUsrPassSubmit_Click(object sender, EventArgs e)
    {
        if (txtUsrNwPass.Text == txtUsrConfirmPass.Text)
        {
            DataAccess dacess = new DataAccess();
            string Userid = muser.UserLogin;
            string Password = txtUsrNwPass.Text;
          String enrcyptPassword =  muser.EncryptPassword(Userid, Password);


            String Updatepasswordquery = "update  dbo.TotalUsers set Password = '" + enrcyptPassword + "' where UserLogin = '" + Userid + "' ";

            if (dacess.UpdateUser(Updatepasswordquery))
            {
                User newUser = new User();
                newUser.UpdatePassword(Userid, Password);
            }

            userprofilevalidator.Text = "Password Changed  Sucessfully";
            passstatus.ForeColor = System.Drawing.Color.Green;
            passstatus.Text = "Password Changed  Sucessfully";
        }
        else
        {
            passstatus.Text = "Password is not matching";
            userprofilevalidator.Text = "Password is not matching";
        }
    }
    protected void btnUprofilePasscancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Userprofile.aspx");
    }


    protected void btnUsrEprofileCncel_Click1(object sender, EventArgs e)
    {
        Response.Redirect("UserProfile.aspx");
    }

    protected void btnUsrPrfileSubmit_Click1(object sender, EventArgs e)
    {
        try
        {
            DataAccess dacess = new DataAccess();

            String UpdateQuery = "Update dbo.TotalUsers  SET MiddleName='" + txtUMName.Text + "', FirstName='" + txtUFName.Text + "', LastName='" + txtULName.Text + "',Emailid='" + txtUEmail.Text + "' ,Address='" + txtUAddress.Text + "',MobileNo='" + txtUMobile.Text + "' WHERE UserLogin ='" + muser.UserLogin + "'";
            if (dacess.UpdateUser(UpdateQuery))
                //Response.Redirect("Userprofile.aspx");
                ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "alert('Updated Successfully')", true);
            else
                ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "alert('Could not Update, Try later')", true);
        }
        catch (Exception ex)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "alert('Could not Update, Try later')", true);
        }
    }



    protected void btnupload_Click(object sender, EventArgs e)
    {

        if (UserProfileUpload.HasFile)
        {
            if (UserProfileUpload.PostedFile.ContentLength < 20728650)
            {
               

                try
                {

                   // String Savepath = Request.PhysicalApplicationPath + "ImageServer\\Temp\\";
                    String ImagePath = Request.PhysicalApplicationPath + "ImageServer\\User\\";
                   // UserProfileUpload.SaveAs(ImagePath + UserProfileUpload.FileName);
                    //image = System.Drawing.Image.FromFile(ImagePath + UserProfileUpload.FileName);

                    ImageFormat format = ImageFormat.Png;
                    
                   
                    String ImageName = muser.UserID.ToString();
                    string filePath = string.Format(ImagePath + ImageName + ".{0}", format.ToString());

                    string base64 = Request.Form["imgCropped"];
                    byte[] bytesImages = Convert.FromBase64String(base64.Split(',')[1]);

                    using (System.IO.FileStream stream = new System.IO.FileStream(filePath, System.IO.FileMode.Create))
                    {
                        stream.Write(bytesImages, 0, bytesImages.Length);                        
                        stream.Flush();                       
                    }
                  
                    using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))
                    {
                        con1.Open();
                        String selectQuery = "Select UserID from " + CONSTANTS.Table_User_Image +" where UserID = '" + muser.UserID + "'";
                        DataAccess da = new DataAccess();
                        int id = da.GetSingleValue(selectQuery);
                        String UpdateImageQuery = "";
                        SqlCommand cmd;
                        if (id == 0)
                        {
                            UpdateImageQuery = "insert into "+ CONSTANTS.Table_User_Image + " (UserID,Profile_image) values(@UserID, @ProfileIcon )";
                            cmd = new SqlCommand(UpdateImageQuery, con1);
                            cmd.Parameters.Add("@ProfileIcon", SqlDbType.Image).Value = bytesImages;
                            cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = Convert.ToInt32(muser.UserID);
                        }
                        else
                        {
                            UpdateImageQuery = "Update  " + CONSTANTS.Table_User_Image + "  set Profile_image = @ProfileIcon where UserID = '" + muser.UserID + "'";
                            cmd = new SqlCommand(UpdateImageQuery, con1);
                            cmd.Parameters.Add("@ProfileIcon", SqlDbType.Image).Value = bytesImages;
                        }
                       

                        int count = cmd.ExecuteNonQuery();
                        con1.Close();
                        if (count == 1)
                        {

                          
                            // ClientScript.RegisterStartupScript(this.GetType(), "tmp;", "LoadMainpage()", true);
                            // ClientScript.RegisterClientScriptBlock(this.GetType(), "tmp", "LoadMainpage();", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "LoadMainpage(" + muser.currentResident.ResID + ");", true);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:alert('Could Not Change Profile Image, Try Later')", true);
                        }
                    }


                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert()", "alert('Could not Update Image, Try Later')", true);
                }

                finally
                {

                   // Response.Redirect("UserProfile.aspx");
                    //image.Dispose();
                }
            }
        }
        else
        {
            lblProfileimgErr.Text = "File size exceeds maximum limit 20 MB.";
        }
    }

    private void UpdateEmployeeImage(System.Drawing.Image EditedImage)
    {

             
                try
                {
                    String Savepath = Request.PhysicalApplicationPath + "ImageTest\\";
                    String ImagePath = Request.PhysicalApplicationPath + "AppImage\\Userimages\\";
                    ImageFormat format = ImageFormat.Png;
                    String ImageName = "";

                    ImageName = muser.EmpID;

                    string filePath = string.Format(ImagePath + "\\" + ImageName + ".{0}", format.ToString());
                    EditedImage.Save(filePath, format);

                    byte[] data = null;

                    FileStream fStream = new FileStream(filePath, FileMode.Open, FileAccess.Read);
                    BinaryReader br = new BinaryReader(fStream);
                    data = br.ReadBytes((int)fStream.Length);
                    using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))
                    {
                        con1.Open();
                        String selectQuery = "Select UserID from dbo.EmployeeImage where EmpID = '" + muser.EmpID + "'";
                        DataAccess da = new DataAccess();
                        int id = da.GetSingleValue(selectQuery);
                        String UpdateImageQuery = "";
                        SqlCommand cmd;
                        if (id == 0)
                        {
                            UpdateImageQuery = "insert into dbo.EmployeeImage (EmpID,UserID,Profile_image) values(@EmpID,@UserID, @ProfileIcon )";
                            cmd = new SqlCommand(UpdateImageQuery, con1);
                            cmd.Parameters.Add("@ProfileIcon", SqlDbType.Image).Value = data;
                            cmd.Parameters.Add("@EmpID", SqlDbType.Int).Value = muser.currentResident.ResID;
                            cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = Convert.ToInt32(muser.UserID);
                        }
                        else
                        {
                            UpdateImageQuery = "Update dbo.EmployeeImage set Profile_image = @ProfileIcon where EmpID = '" + muser.EmpID + "'";
                            cmd = new SqlCommand(UpdateImageQuery, con1);
                            cmd.Parameters.Add("@ProfileIcon", SqlDbType.Image).Value = data;
                        }


                        int count = cmd.ExecuteNonQuery();
                        con1.Close();
                        if (count == 1)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert();", "LoadMainpage()", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:alert('image inserted successfully')", true);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:alert('Could Not Change Profile Image, Try Later')", true);
                        }
                    }

                
                    Removefiles(EditedImage);

                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert()", "alert('Could not Update Image, Try Later')", true);
                }

                finally
                {

                    Response.Redirect("UserProfile.aspx");
                    EditedImage.Dispose();
                }
           
    
        
    }
    public void Removefiles(System.Drawing.Image EditedImage)
    {
        try
        {
            String path = Server.MapPath("~/ImageTest/");
            if (Directory.Exists(path))
            {
                foreach (string file in Directory.GetFiles(path))
                {
                    File.Delete(file);
                }
            }

            String Folderpath = Server.MapPath("~/ImageTest/Resized");
            if (Directory.Exists(Folderpath))
            {
                EditedImage.Dispose();
                foreach (string file in Directory.GetFiles(Folderpath))
                {
                    File.Delete(file);
                }
            }
        }

        catch (Exception ex)
        {

        }
    }


    [System.Web.Services.WebMethod]
    public static string GetUserData(String userLogin)
    {
        try
        {
            List<string> Emp = new List<string>();
            string query = string.Format("select * from dbo.TotalUsers where UserLogin ='" + userLogin + "'");

            DataAccess da = new DataAccess();
            DataSet ds = da.GetData(query);
            return JsonConvert.SerializeObject(ds.Tables[0]);
        }
        catch (Exception ex)
        {
            return "{'result:''Error'}";
        }


    }
    protected void btnUpdateSetting_Click(object sender, EventArgs e)
    {
        try
        {
            int complaintNotice = Convert.ToInt32(chkComplaintNotice.Checked);
            int complaintMail = Convert.ToInt32(chkComplaintMail.Checked);
            int forumNotice = Convert.ToInt32(chkComplaintNotice.Checked);
            int forumMail = Convert.ToInt32(chkComplaintMail.Checked);
            int BillingNotice = Convert.ToInt32(chkComplaintNotice.Checked);
            int BillingMail = Convert.ToInt32(chkComplaintMail.Checked);


            if (muser.UpdateUserSetting(BillingNotice, BillingMail, forumNotice, forumMail, complaintNotice, complaintMail, muser.currentResident.ResID))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "alert('Updated Successfully')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "alert('Could not Update, Try later')", true);
            }
        }
        catch (Exception ex)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "alert('Could not Update, Try later')", true);
        }
    }

    [System.Web.Services.WebMethod]
    public static string GetUserSetting(int ResID)
    {
        try
        {
            List<string> Emp = new List<string>();
            string query = string.Format("select * from dbo.ViewUserSetting where ResID =" + ResID );

            DataAccess da = new DataAccess();
            DataSet ds = da.GetData(query);
            return JsonConvert.SerializeObject(ds.Tables[0]);
        }
        catch (Exception ex)
        {
            return "{'result:''Error'}";
        }


    }
}