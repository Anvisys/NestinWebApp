<%@ WebHandler Language="C#" Class="GetImages" %>

using System;
using System.Web;
using System.Drawing;
using System.Data.SqlClient;
using System.IO;


public class GetImages : IHttpHandler {

    //string strcon = ConfigurationManager.AppSettings["ConnectionString"].ToString();
    public void ProcessRequest(HttpContext context)
    {
        context.Response.Clear();
        String imageid = context.Request.QueryString["ImID"];

        if (imageid != null && imageid != "")
        {

            try
            {
                using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))
                {

                    con1.Open();
                    //  SqlCommand command = new SqlCommand("select Image from Image where ImageID=" + imageid, con1);
                    SqlCommand command = new SqlCommand("select VendorIcon from Vendors where  ID=" + imageid, con1);
                    SqlDataReader dr = command.ExecuteReader();

                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            context.Response.BinaryWrite((Byte[])dr[0]);
                            con1.Close();
                            context.Response.Flush();
                        }
                    }

                    else
                    {

                    }

                }
            }
            catch(Exception ex)
            {
                int a = 1;
            }

        }



        try
        {
            String resID = context.Request.QueryString["ResID"];
            if (resID != null && resID != "")
            {
                string userName = context.Request.QueryString["Name"];
                string userType = context.Request.QueryString["UserType"];
                String Savepath = context.Request.PhysicalApplicationPath + "ImageServer\\User";
                string filePath = string.Format(Savepath + "\\" + resID + ".png");
                using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))
                {
                    byte[] data = null;
                    con1.Open();

                    SqlCommand command = new SqlCommand("select Profile_image from dbo.ViewUserImage where  ResID=" + resID, con1);
                    SqlDataReader dr = command.ExecuteReader();
                    dr.Read();
                   if(!dr.HasRows || dr[0] is System.DBNull)
                        {
                            string basePath = context.Request.PhysicalApplicationPath + "Images\\Icon\\";

                            var userIcon = new UserDefaultIcon(userName);
                            String defImgPath = basePath + userIcon.BackgroundImageName;
                            Brush textBrush = userIcon.TextBrush;

                            if (File.Exists(defImgPath))
                            {
                                Utility.SaveImageWithText(defImgPath, filePath, userName.Substring(0,1).ToUpper(),textBrush);
                                using( FileStream fStream = new FileStream(filePath, FileMode.Open, FileAccess.Read))
                                {
                                    BinaryReader br = new BinaryReader(fStream);
                                    data = br.ReadBytes((int)fStream.Length);
                                }

                            }
                        }
                        else
                        {
                            data = (Byte[])dr[0];
                        }
                    con1.Close();
                    context.Response.BinaryWrite(data);
                    context.Response.End();

                }

            }
        }

        catch(Exception ex)
        {

        }



        try
        {
            String userID = context.Request.QueryString["UserID"];
            if (userID != null && userID != "")
            {
                string userName = context.Request.QueryString["Name"];
                string userType = context.Request.QueryString["UserType"];
                String Savepath = context.Request.PhysicalApplicationPath + "ImageServer\\User";
                string filePath = string.Format(Savepath + "\\" + userID + ".png");
                if (File.Exists(filePath))
                {
                    byte[] data = null;
                    using ( FileStream fStream = new FileStream(filePath, FileMode.Open, FileAccess.Read))
                    {
                        BinaryReader br = new BinaryReader(fStream);
                        data = br.ReadBytes((int)fStream.Length);
                        context.Response.BinaryWrite(data);
                    }

                }
                else
                {
                    using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))
                    {
                        con1.Open();

                        SqlCommand command = new SqlCommand("select Profile_image from dbo.ViewUserImage where  UserID=" + userID, con1);
                        SqlDataReader dr = command.ExecuteReader();
                        dr.Read();
                        Byte[] data= null;

                        if(!dr.HasRows || dr[0] is System.DBNull)
                        {
                            string basePath = context.Request.PhysicalApplicationPath + "Images\\Icon\\";

                            var userIcon = new UserDefaultIcon(userName);
                            String defImgPath = basePath + userIcon.BackgroundImageName;
                            Brush textBrush = userIcon.TextBrush;

                            if (File.Exists(defImgPath))
                            {
                                Utility.SaveImageWithText(defImgPath, filePath, userName.Substring(0,1).ToUpper(),textBrush);
                                using( FileStream fStream = new FileStream(filePath, FileMode.Open, FileAccess.Read))
                                {
                                    BinaryReader br = new BinaryReader(fStream);
                                    data = br.ReadBytes((int)fStream.Length);
                                }

                            }
                        }
                        else
                        {
                            data = (Byte[])dr[0];
                        }

                        context.Response.BinaryWrite(data);
                        con1.Close();
                        try
                        {
                            using (System.IO.FileStream stream = new System.IO.FileStream(filePath, System.IO.FileMode.Create))
                            {
                                stream.Write(data, 0, data.Length);
                                stream.Flush();
                            }
                        }
                        catch (Exception ex)
                        {

                        }
                        context.Response.End();
                    }
                }

            }
        }

        catch(Exception ex)
        {

        }




        try
        {
            String firstFlat = context.Request.QueryString["firstFlat"];

            if (firstFlat != null && firstFlat != "")
            {
                using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))
                {
                    con1.Open();
                    SqlCommand command = new SqlCommand("select FirstImage from ViewThreadSummary where  firstFlat ='" + firstFlat + "'", con1);
                    SqlDataReader dr = command.ExecuteReader();
                    dr.Read();
                    context.Response.BinaryWrite((Byte[])dr[0]);
                    con1.Close();
                    context.Response.End();
                }
            }
        }

        catch(Exception ex)
        {

        }

        try
        {
            String lastFlat = context.Request.QueryString["lastFlat"];

            if (lastFlat != null && lastFlat != "")
            {
                using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))
                {
                    con1.Open();
                    SqlCommand command = new SqlCommand("select LastImage from ViewThreadSummary where  lastFlat='" + lastFlat + "'", con1);
                    SqlDataReader dr = command.ExecuteReader();
                    dr.Read();
                    context.Response.BinaryWrite((Byte[])dr[0]);
                    con1.Close();
                    context.Response.End();
                }
            }

        }
        catch(Exception ex)
        {

        }

        try
        {
            String NotifiImID = context.Request.QueryString["NotifiImID"];

            if (NotifiImID != null && NotifiImID != "")
            {
                using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))
                {
                    con1.Open();
                    SqlCommand command = new SqlCommand("select ImageData,AttachType from dbo.Notifications  where  ID ='" + NotifiImID + "'", con1);
                    SqlDataReader dr = command.ExecuteReader();
                    dr.Read();
                    context.Response.BinaryWrite((Byte[])dr[0]);
                    con1.Close();
                    context.Response.End();
                }
            }

        }
        catch (Exception ex)
        {

        }

        finally
        {

        }

        // vendor images
        try
        {
            String vendorId = context.Request.QueryString["VendorID"];

            if (vendorId != null && vendorId != "")
            {
                String Savepath = context.Request.PhysicalApplicationPath + "ImageServer\\Vendor";
                string filePath = string.Format(Savepath + "\\" + vendorId + ".png");
                if (File.Exists(filePath))
                {
                    byte[] data = null;

                    FileStream fStream = new FileStream(filePath, FileMode.Open, FileAccess.Read);
                    BinaryReader br = new BinaryReader(fStream);
                    data = br.ReadBytes((int)fStream.Length);
                    context.Response.BinaryWrite(data);
                }
                else
                {



                    using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))
                    {
                        con1.Open();
                        // String DatalistQuery = "Select ID, ShopCategory, VendorName, ContactNum,ContantNumber2, Address,Address2 from dbo.Vendors order by ShopCategory asc ";
                        SqlCommand command = new SqlCommand("select VendorIcon from dbo.Vendors  where  ID ='" + vendorId + "'", con1);
                        SqlDataReader dr = command.ExecuteReader();
                        dr.Read();
                        Byte[] data= null;
                        if(dr[0] is System.DBNull)
                        {
                            String defImgPath = context.Request.PhysicalApplicationPath + "Images\\Icon\\downloadbg.png";

                            if (File.Exists(defImgPath))
                            {
                                using (FileStream fStream = new FileStream(defImgPath, FileMode.Open, FileAccess.Read))
                                {
                                    BinaryReader br = new BinaryReader(fStream);
                                    data = br.ReadBytes((int)fStream.Length);
                                }

                            }
                        }
                        else
                        {
                            data = (Byte[])dr[0];
                        }

                        context.Response.BinaryWrite(data);
                        con1.Close();

                        using (System.IO.FileStream stream = new System.IO.FileStream(filePath, System.IO.FileMode.Create))
                        {
                            stream.Write(data, 0, data.Length);
                            stream.Flush();
                        }
                        context.Response.End();
                    }
                }
            }

        }
        catch (Exception ex)
        {

        }

        finally
        {
            context.Response.End();
        }



    }



    public bool IsReusable {
        get {
            return false;
        }
    }

}