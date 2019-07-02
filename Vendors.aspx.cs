using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;

using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;

public partial class Vendors : System.Web.UI.Page
{

    /*  This Total  code  is  licenced
    Developed By Anvisys Technologies Pvt Ltd.
    
    Copyright © 2016 Anvisys Technologies Pvt. Ltd.All rights reserved.
    */

    User muser;
    protected void Page_Load(object sender, EventArgs e)
    {
        muser = (User)Session["User"];
        SessionVariables.CurrentPage = "Vendors.aspx";
        if (muser == null)
        {
            Response.Redirect("Login.aspx");
        }
        if (!IsPostBack)
        {
            FillVendorDataList(muser.currentResident.SocietyID ,muser.currentResident.UserType);
            FillDropDownlist();       
        }

      

        //ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "VendorAuctionPopup()", true);
                 
    }

    public void FillDropDownlist()
    {
        //DataAccess dacess = new DataAccess();
        //String VendorsDataQuery = "select distinct ShopCategory from dbo.vendors ";
        //drpvendorfilter.DataTextField = "ShopCategory";
        //DataSet ds = dacess.ReadData(VendorsDataQuery);
        //if (ds == null)
        //{

        //}
        //else
        //{
        //    drpvendorfilter.DataSource = ds.Tables[0];
        //    drpvendorfilter.DataBind();
        //    drpvendorfilter.Items.Insert(0, new ListItem("All", "NA"));

        //    drpVendorcategory.DataTextField = "ShopCategory";
        //    drpVendorcategory.DataSource = ds.Tables[0];
        //    drpVendorcategory.DataBind();
        //  //  drpVendorcategory.Items.Insert(0, new ListItem("All", "NA"));

        //}

        drpvendorfilter.DataSource = Utility.ShopCategory;
        drpvendorfilter.DataTextField = "Key";
        drpvendorfilter.DataValueField = "value";
        drpvendorfilter.DataBind();
        drpvendorfilter.Items.Insert(0, new ListItem("All", "-1"));

        drpVendorcategory.DataSource = Utility.ShopCategory;
        drpVendorcategory.DataTextField = "Key";
        drpVendorcategory.DataValueField = "value";
        drpVendorcategory.DataBind();
        drpVendorcategory.Items.Insert(0, new ListItem("All", "-1"));

        

    }

  


    [System.Web.Services.WebMethod]
    public void FillVendorDataList(int SocietyID ,String UserType)
    {
        try
        {
            DataAccess dacess = new DataAccess();
            String DatalistQuery;

            if (UserType.Equals("Admin"))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "visiblemang",
       "document.getElementById('Edit_Vendor').style.visibility = 'visible';", true);
            }

            if (UserType.Equals("SuperAdmin"))
                DatalistQuery= "Select ID, ShopCategory, VendorName, ContactNumber,ContactNumber2, Address,Address2 from dbo.Vendors order by ShopCategory asc  ";


            //DatalistQuery = "Select ID, ShopCategory, VendorName, ContactNum,ContantNumber2, Address,Address2 from dbo.Vendors where SocietyID ='" + SocietyID + "' order by ShopCategory asc  ";
            else
            DatalistQuery = "Select ID, ShopCategory, VendorName, ContactNumber,ContactNumber2, Address,Address2 from dbo.Vendors where SocietyID ='" + SocietyID + "' order by ShopCategory asc  ";

            DataSet DatasetVendors = dacess.ReadData(DatalistQuery);

            //String TotalvendorsQuery = "Select Count(ID) from dbo.vendors;";
            int Totalvendors = 0; //dacess.GetSingleValue(TotalvendorsQuery);          

            if (DatasetVendors == null || DatasetVendors.Tables == null || DatasetVendors.Tables.Count==0
                || DatasetVendors.Tables[0].Rows.Count==0)
            {

                drpvendorfilter.Visible = false;
                //lblVendrCatText.Visible = false;
                lblVendrEmptyText.Text = "At this  time  there are  no  Vendors registered in this society";
            }

            else
            {
                drpVendorcategory.Visible = true;
                //lblVendrCatText.Visible = true;
                DataTable dt = DatasetVendors.Tables[0];
                Datavendors.DataSource = dt;
                
                Datavendors.DataBind();
                Totalvendors = dt.Rows.Count;
                //if (dt.Rows.Count > 0)
                //{
                //    if (dt.Rows.Count == 2)
                //    {
                //        Datavendors.Width = new Unit("100%");
                //    }

                //    if (dt.Rows.Count == 1)
                //    {
                //        Datavendors.Width = new Unit("100%");
                //    }
                //    Datavendors.DataSource = dt;
                //    Datavendors.DataBind();
                //    Totalvendors = dt.Rows.Count;
                //}
                lblTotalVendors.Text = Totalvendors.ToString();
            }

           
        }

        catch (Exception ex)
        {

        }
    }





    public void Filterdata(int SocietyID)
    {
        try
        {
            muser = (User)Session["User"];
            DataAccess dacess = new DataAccess();

            if (drpvendorfilter.SelectedItem.Text == "All")
            {
                FillVendorDataList(muser.currentResident.SocietyID , muser.currentResident.UserType);

            }

            else
            {
                String DatalistQuery = "Select * from dbo.Vendors where ShopCategory = '" + drpvendorfilter.SelectedItem.Text + "' and SocietyID ='" + SocietyID + "'";

                DataSet ds = dacess.ReadData(DatalistQuery);
                int Totalvendors = 0;
                if (ds != null && ds.Tables != null && ds.Tables.Count > 0)
                {
                    DataTable data = ds.Tables[0];

                    if (data.Rows.Count == 2)
                    {
                        Datavendors.Width = new Unit("100%");
                    }
                    if (data.Rows.Count == 1)
                    {
                        Datavendors.Width = new Unit("100%");

                    }
                  
                    //String TotalvendorsQuery = "Select Count(ID) from dbo.vendors where ShopCategory = '" + drpvendorfilter.SelectedItem.Text + "'";
                    Totalvendors = ds.Tables[0].Rows.Count; //dacess.GetSingleValue(TotalvendorsQuery);
                   
                }
                else
                {
                    ds = new DataSet();
                }
                Datavendors.DataSource = ds;
                Datavendors.DataBind();
                lblTotalVendors.Text = Totalvendors.ToString();
            }
        }

        catch (Exception ex)
        {

        }

    }

    public void Editdata()
    {
        string VendorID;
        VendorID = Session["VendorID"].ToString();
        try
        {
            // using (SqlConnection con1 = new SqlConnection(" Data Source= ANVISYS; Initial Catalog= SPM; Integrated Security=SSPI; Persist Security Info = False"))

            using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))
            {

                DataTable dt = new DataTable();
                con1.Open();
                SqlDataReader myReader = null;
                SqlCommand myCommand = new SqlCommand("select * from dbo.Vendors where ID ='" + VendorID + "'", con1);

                myReader = myCommand.ExecuteReader();

                while (myReader.Read())
                {
                    drpVendorcategory.SelectedItem.Text = (myReader["ShopCategory"].ToString().Trim());
                    txtvendorname.Text = (myReader["VendorName"].ToString());
                    txtvendromobile.Text = (myReader["ContactNumber"].ToString());
                    txtvendoraddress.Text = (myReader["Address"].ToString());

                }
                con1.Close();
            }
        }
        catch (Exception ex)
        {
            Utility.log("Error found at EditVendors.EditData at " + Utility.GetCurrentDateTimeinUTC().ToString() + ex.Message);         
        }
    }

    protected void btnNewvendor_Click(object sender, EventArgs e)
    {

        if (HiddenVendorEditID.Value != "" && HiddenVendorName.Value != "")
        {
            EditVendor();
            return;
        }
        else if (HiddenVendorEditID.Value == "" && HiddenVendorName.Value == "")
        {
            DataAccess dacess = new DataAccess();
            System.Drawing.Image EditedImage = null;
            System.Drawing.Image image = null;
            //DateTime date = System.DateTime.Now;
            DateTime date = Utility.GetCurrentDateTimeinUTC();
            string VendorCat = drpVendorcategory.SelectedItem.Text;
            string Vendorname = txtvendorname.Text;
            String VendorIconFormat = FileVendorImg.PostedFile.ContentType;
            String contact = txtvendromobile.Text;
            String contact2 = txtMobile2.Text;
            String Address = txtvendoraddress.Text;
            String Address2 = txtvendoraddress2.Text;

            try
            {
                //Condition to check if the file uploaded or not
                if (FileVendorImg.HasFile)
                {
                    if (FileVendorImg.PostedFile.ContentLength < 20728650)
                    {
                        //Save  the  image  to  local  folder
                        String Savepath = Request.PhysicalApplicationPath + "Images/Vendor";
                        //FileVendorImg.SaveAs(Savepath + FileVendorImg.FileName);
                        //image = System.Drawing.Image.FromFile(Savepath + FileVendorImg.FileName);

                        string imagename = Path.GetFileNameWithoutExtension(FileVendorImg.FileName);


                        string base64 = Request.Form["imgCropped"];
                        byte[] bytesImages = Convert.FromBase64String(base64.Split(',')[1]);

                       

                      
                        using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))
                        {
                            con1.Open();
                            // SqlCommand cmd = new SqlCommand("INSERT INTO Vendors (ShopCategory,VendorName,ContactNumber,Address,VendorIcon,VendorIconFormat) VALUES (@ShopCategory,@VendorName,@ContactNum,@Address,@VendorIcon,@VendorIconFormat)", con1);
                            SqlCommand cmd = new SqlCommand("Insert Into Vendors (ShopCategory,VendorName,ContactNumber,ContactNumber2,Address,Address2,VendorIcon,VendorIconFormat,date,SocietyID,CmdType) Values ('" 
                                + VendorCat + "','" + Vendorname + "','" + contact + "','" + contact2 + "','" + Address + "','" + Address2 + "',@VendorIcon,'" + VendorIconFormat + "','" + Utility.ChangeDateTimeLocalToSQLServerFormat(date) + "'," + SessionVariables.SocietyID + ",'Insert')", con1);
                            cmd.Parameters.Add("@VendorIcon", SqlDbType.Image).Value = bytesImages;
                            int count = cmd.ExecuteNonQuery();
                            con1.Close();

                            if (count == 1)
                            {
                                
                                FillVendorDataList(muser.currentResident.SocietyID,muser.currentResident.UserType);
                               
                            }

                            else
                            {
                                ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "VendorActionPopup()", true);
                                lblstatus.Text = "Vendor Added Failed";
                                // lblVendrAuctionlMsg.Text = "Vendor Added Failed";
                            }
                        }
                    }
                }
                else
                {
                    String InsetdataQuery = "Insert Into Vendors (ShopCategory,VendorName,ContactNumber,ContactNumber2,Address,Address2,date,SocietyID, CmdType) Values ('" + VendorCat + "','" + Vendorname + "','" + contact + "','" + contact2 + "','" + Address + "','" + Address2 + "','" + date + "'," + SessionVariables.SocietyID + ",'insert')";
                    bool result = dacess.Update(InsetdataQuery);

                    if (result == true)
                    {
                        Response.AddHeader("REFRESH", "50;URL=Vendors.aspx");
                        Response.Redirect("Vendors.aspx", false);
                    }

                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "Showpopup()", true);
                        lblstatus.Text = "Vendor Added Failed";
                    }
                }

            }

            catch (Exception ex)
            {
                lblstatus.Text = ex.Message;
            }

            finally
            {
                // EditedImage.Dispose();
                // image.Dispose();
                RemoveFiles();
            }
        }
    }

    public static byte[] ImageToByte( System.Drawing.Image image )
    {
        ImageConverter converter = new ImageConverter();
        return (byte[])converter.ConvertTo(image, typeof(byte[]));
    }

    private static System.Drawing.Image resizeImage(System.Drawing.Image imgToResize, Size size)
    {
        //Get the image current width
        int sourceWidth = imgToResize.Width;
        //Get the image current height
        int sourceHeight = imgToResize.Height;

        // float nPercent = 0;
        float nPercentW = 0;
        float nPercentH = 0;
        

        float aspectRatio = ((float)sourceWidth / (float)sourceHeight);

        if (aspectRatio > 1)
        {
            nPercentW = size.Width;
            nPercentH = nPercentW / sourceWidth;
            nPercentH = nPercentH * sourceHeight;
        }

        else
        {
            nPercentH = size.Height;
            nPercentW = ((float)nPercentH / (float)sourceHeight);
            nPercentW = nPercentW * sourceWidth;
        }

        int destWidth = (int)nPercentW;
        int destHeight = (int)nPercentH;

        Bitmap b = new Bitmap(destWidth, destHeight);
        Graphics g = Graphics.FromImage((System.Drawing.Image)b);
        //g.InterpolationMode = InterpolationMode.NearestNeighbor;
        // Draw image with new width and height
        g.DrawImage(imgToResize, 0, 0, destWidth, destHeight);
        g.Dispose();
        return (System.Drawing.Image)b;

    }


    public void RemoveFiles()
    {
        try
        {
            String path = Server.MapPath("~/Images/Temp/");
            if (Directory.Exists(path))
            {
                foreach (string file in Directory.GetFiles(path))
                {
                    File.Delete(file);
                }
            }
          
        }
        catch(Exception ex)
        {

        }

        finally
        {

        }
    }


   

    protected void drpvendorfilter_SelectedIndexChanged(object sender, EventArgs e)
    {
        Filterdata(muser.currentResident.SocietyID);
    }

    protected void Datavendors_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        ImageMap img = (ImageMap)e.Item.FindControl("ImageMap1");


        img.Attributes["onerror"] = "this.src='Images/Icon/downloadbg.png'";



        if (muser.currentResident.UserType.Equals("Admin"))
        {
           vendor_delete
        } 

            
    }

  



    protected void Datavendors_ItemCommand(object source, DataListCommandEventArgs e)
    {
        LinkButton lb = (LinkButton)e.Item.FindControl("lnkPollID");
       

       
    }

    protected void btnVendorsEdit_Click(object sender, EventArgs e)
    {

        int VendorID = Convert.ToInt32(HiddenVendorID.Value);
        String VendorName = HiddenVendorName.Value;
         EditVendorData(VendorID);
    }



    public void EditVendorData(int VendorID)
    {
        DataAccess dacess = new DataAccess();      
        //Session["ID"] = dt.Rows[0][0].ToString();
         String PollsQuery = "select * from dbo.vendors where ID = '" + VendorID + "'";
         SqlConnection dbConnect = dacess.ConnectSocietyDB();
            SqlCommand cmd = new SqlCommand(PollsQuery, dbConnect);
             SqlDataReader rdr = cmd.ExecuteReader();
          
            if (rdr.HasRows)
            {
                while (rdr.Read())
                {
                     //txtVshopCatEdit.Text = rdr["ShopCategory"].ToString();
                     //txtVedrNameEdit.Text = rdr["VendorName"].ToString();
                     //txtVendMobileEdit.Text = rdr["ContactNum"].ToString();
                     //txtVendrAddEdit.Text = rdr["Address"].ToString(); 
                              
                }
                rdr.Close();
                HiddenVendorEditID.Value = VendorID.ToString();
              //  ClientScript.RegisterStartupScript(this.GetType(), "alert()", "VendorAuctionPopup()", true);
            }

        if( HiddenVendorEditID.Value != null)
        {

        }

      
     //  ImgVendor.Attributes["src"] = "GetImages.ashx?ImID=" + VendorID.ToString();

      // ImgVendor.Attributes["onerror"] = "this.src='AppImage/Vendors/default.png'";

     
    }
    protected void btnVendorsDelete_Click(object sender, EventArgs e)
    {      
           int VendorID =Convert.ToInt32(HiddenVendorID.Value);
            String VendorName = HiddenVendorName.Value;

            //VendorDelete(VendorID,VendorName);

            HiddenVendorDelID.Value = VendorID.ToString(); 

            if (VendorID != 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "VendorDeleteConfirm()", true);
            }
    }


    protected void btnVendorDelete_Click(object sender, EventArgs e)
    {
        int VendorID = Convert.ToInt32(HiddenVendorID.Value);
        String VendorName = HiddenVendorName.Value;
        DataAccess dacess = new DataAccess();

        String DeleteVendorQuery = "Delete from dbo.Vendors where ID = '" + VendorID + "'";
        bool result = dacess.Update(DeleteVendorQuery);

        if (result == true)
        {
            FillVendorDataList(muser.currentResident.SocietyID , muser.currentResident.UserType);
            //lblVendrActionlMsg.Text = VendorName + " " + "Deleted Sucessfully";
            String javascriptQuery = "function HideVendorAuctionstatusLabel() { alert(\"working inside javascript\") ; document.getElementById(\"lblVendrActionlMsg\").style.display = \"block\";}";
          //  ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "HideVendorAuctionstatusLabel()", true);
        }

        else
        {
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:alert('" + VendorName + " Deleted Failed,try later')", true);

        }
    }
   
        
     
    protected void btnEditvendorSubmit_Click(object sender, EventArgs e)
    {
        DataAccess dacess = new DataAccess();
        String VendorID = HiddenVendorEditID.Value;
        String VendorName = HiddenVendorName.Value;
       // DateTime Updatedate = System.DateTime.Now;
        DateTime Updatedate = Utility.GetCurrentDateTimeinUTC(); 
        String NewvendorQuery =null;
        try
        {
            //if (FileVendorEdit.HasFile)
            //{
            //    ImportImage(FileVendorEdit);
            //   // lblVendrActionlMsg.Text = VendorName + " " + "Edited Sucessfully";
            //    ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "VendorActionPopup()", true);
            //}

            //else
            //{
            //    //NewvendorQuery = "Update  dbo.Vendors set ShopCategory = '" + txtVshopCatEdit.Text + "',   VendorName= '" + txtVedrNameEdit.Text + "', ContactNum='" + txtVendMobileEdit.Text + "', Address = '" + txtVendrAddEdit.Text + "' ,Date = '" + Updatedate + "' ,CmdType ='Update'   where ID = '" + VendorID + "'";
            //    //bool result = dacess.Update(NewvendorQuery);
            //    //if (result == true)
            //    //{
            //    //    FillVendorDataList();
                    
            //    //}
            //    //else
            //    //{
            //    //    //lblEditResult.Text = VendorName + " " + "Edited Failed";
            //    //    ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "VendorActionPopup()", true);
            //    //    // ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:alert('" + txtVedrNameEdit.Text + " Edited Failed')", true);
            //    //}
            //}
        }
        catch (Exception ex)
        {
            int a = 1;
        }
    }


    private void EditVendor()
    {
        DataAccess dacess = new DataAccess();
        String VendorID = HiddenVendorEditID.Value;
        String VendorName = HiddenVendorName.Value;
        // DateTime Updatedate = System.DateTime.Now;
        DateTime Updatedate = Utility.GetCurrentDateTimeinUTC();
        String NewvendorQuery = null;

        string VendorCat = drpVendorcategory.SelectedItem.Text;
        string Vendorname = txtvendorname.Text;
        String contact = txtvendromobile.Text;
        String Address = txtvendoraddress.Text;

        try
        {
            if (FileVendorImg.HasFile)
            {
                ImportImage(FileVendorImg);
              
            }

            else
            {
                NewvendorQuery = "Update  dbo.Vendors set ShopCategory = '" + VendorCat + "',   VendorName= '" + Vendorname + "', ContactNumber='" + contact + "', Address = '" + Address + "' ,Date = '" + Updatedate + "' ,CmdType ='Update'   where ID = '" + VendorID + "'";
                bool result = dacess.Update(NewvendorQuery);
                if (result == true)
                {
                    FillVendorDataList(muser.currentResident.SocietyID , muser.currentResident.UserType);
                    
                }
                else
                {
                    
                }
            }
        }
        catch (Exception ex)
        {
            int a = 1;
        }

    }
   
    public void ImportImage( FileUpload file)
    {
        DataAccess dacess = new DataAccess();
      
        DateTime date = Utility.GetCurrentDateTimeinUTC();

        string VendorCat = drpVendorcategory.SelectedItem.Text;
        string Vendorname = txtvendorname.Text;
        String contact = txtvendromobile.Text;
        String Address = txtvendoraddress.Text;


        try
        {
            int VendorID = Convert.ToInt32(HiddenVendorEditID.Value);
            String VendorName = HiddenVendorName.Value;
            if (file.HasFile)
            {

                //*****************
                if (file.PostedFile.ContentLength < 20728650)
                {

                    String Savepath = Request.PhysicalApplicationPath + "ImageServer\\Vendor\\";
                    string imagename = VendorID.ToString();
                    //string imagename = Path.GetFileNameWithoutExtension(file.FileName);
                    string base64 = Request.Form["imgCropped"];
                    byte[] bytesImages = Convert.FromBase64String(base64.Split(',')[1]);
                    ImageFormat format = ImageFormat.Png;

                    string filePath = string.Format(Savepath + "\\" + imagename + ".{0}", format.ToString());

                    using (FileStream stream = new FileStream(filePath, FileMode.Create))
                    {
                        stream.Write(bytesImages, 0, bytesImages.Length);
                        stream.Flush();
                    }

                    using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))
                    {
                        con1.Open();
                        String UpdateImageQuery = "Update dbo.Vendors set ShopCategory=@ShopCategory,VendorName=@VendorName,ContactNumber=@ContactNumber,Address= @Address,VendorIcon = @VendorIcon,VendorIconFormat ='" + format + "',Date = '" + date + "',CmdType ='Update'   where ID = '" + VendorID + "'";
                        SqlCommand cmd = new SqlCommand(UpdateImageQuery, con1);
                        cmd.Parameters.Add("@VendorIcon", SqlDbType.Image).Value = bytesImages;
                        cmd.Parameters.Add("@ShopCategory", SqlDbType.VarChar, 50).Value = VendorCat;
                        cmd.Parameters.Add("@VendorName", SqlDbType.VarChar, 50).Value = Vendorname;
                        cmd.Parameters.Add("@ContactNumber", SqlDbType.VarChar, 50).Value = contact;
                        cmd.Parameters.Add("@Address", SqlDbType.VarChar, 50).Value = Address;
                        int result = cmd.ExecuteNonQuery();
                        con1.Close();

                        if (result == 1)
                        {
                            
                            //lblEditResult.Text = VendorName + " " + "Edited Sucessfully";
                            FillVendorDataList(muser.currentResident.SocietyID , muser.currentResident.UserType);
                            ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "UpdateSuccess()", true);
                        }

                        else
                        {
                           // lblEditResult.Text = VendorName + " " + "Edited Sucessfully";
                            ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "UpdateFail()", true);
                        }
                    }
                   
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert()", "alert('Please Select  a  image to upload')", true);
            }
        }
        catch (Exception ex)
        {

        }
        finally
        {
         
            RemoveFiles();
        }

    }
    protected void btnVendrupload_Click(object sender, EventArgs e)
    {
        DataAccess dacess = new DataAccess();
        System.Drawing.Image EditedImage = null;
        System.Drawing.Image image = null;
       // DateTime date = System.DateTime.Now;
        DateTime date = Utility.GetCurrentDateTimeinUTC(); 
        try
        {
            int VendorID = Convert.ToInt32(HiddenVendorID.Value);
            String VendorName = HiddenVendorName.Value;
            //if (FileVendorEdit.HasFile)
            //{
            //    if (FileVendorEdit.PostedFile.ContentLength < 20728650)
            //    {
            //        String VendorIconFormat = FileVendorEdit.PostedFile.ContentType;
                                  
            //        String Savepath = Request.PhysicalApplicationPath + "AppImage\\Vendors\\";
                   
            //        FileVendorEdit.SaveAs(Savepath + FileVendorEdit.FileName);
            //        image = System.Drawing.Image.FromFile(Savepath + FileVendorEdit.FileName);
            //        //compress the image to fixed size
            //        Size size = new Size(300, 300);
            //        int sourceWidth = image.Width;
            //        int sourceHeight = image.Height;
            //        if (sourceWidth > 100 && sourceHeight > 100)
            //        {
            //            EditedImage = resizeImage(image, size);
                       
            //            byte[] data = null;
                  
            //            data = ImageToByte(EditedImage);
            //            using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))
            //            {
            //                con1.Open();
            //                String UpdateImageQuery = "Update dbo.Vendors set VendorIcon = @VendorIcon,VendorIconFormat ='" + VendorIconFormat + "'  where ID = '" + VendorID + "'";
            //                SqlCommand cmd = new SqlCommand(UpdateImageQuery, con1);
            //                cmd.Parameters.Add("@VendorIcon", SqlDbType.Image).Value = data;
            //                int result = cmd.ExecuteNonQuery();
            //                con1.Close();

            //                if (result == 1)
            //                {
                               
            //                }
            //            }
            //        }

            //        else
            //        {

            //        }
            //    }
            //}

            //else
            //{
            //    ClientScript.RegisterStartupScript(this.GetType(), "alert()", "alert('Please Select  a  image to upload')", true);
            //}
        }

        catch (Exception ex)
        {

        }
        finally
        {
            EditedImage.Dispose();
            image.Dispose();
            RemoveFiles();
        }

    }


   
}

