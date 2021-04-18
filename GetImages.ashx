<%@ WebHandler Language="C#" Class="GetImages" %>

using System;
using System.Web;
using System.Drawing;
using System.Data.SqlClient;
using System.IO;


public class GetImages : IHttpHandler {

    HttpContext context;

    //string strcon = ConfigurationManager.AppSettings["ConnectionString"].ToString();
    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        context.Response.Clear();

        try
        {
            String ImageType = context.Request.QueryString["Type"];
            switch (ImageType)
            {
                case "Vendor":
                    String VendorID = context.Request.QueryString["ID"];
                    string VendorCategor = context.Request.QueryString["Category"];
                    GetVendorImage(VendorID, VendorCategor);
                    break;
                case "User":
                    String userID = context.Request.QueryString["ID"];
                    string userName = context.Request.QueryString["Name"];
                    GetUserImage(userID, userName);
                    break;
                case "Resident":
                    String ResID = context.Request.QueryString["ID"];
                    string ResName = context.Request.QueryString["Name"];

                    GetResidentImage(ResID, ResName);
                    break;
                case "Notice":
                    String NoticeID = context.Request.QueryString["ID"];
                    GetNoticeImage(NoticeID);
                    break;
                default:
                    Console.WriteLine("Default case");
                    break;
            }


        }
        catch (Exception ex)
        {
        }
    }


    private void GetFirstFlatImage() {
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

        catch (Exception ex)
        {

        }

    }

    private void GetLastFlatImage() {
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
        catch (Exception ex)
        {

        }
    }

    private void GetNoticeImage(String NoticeID)
    {
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

    }


    private void GetVendorImage(String vendorId, String VendorCategory)
    {
        try
        {


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
                        Byte[] data = null;
                        if (dr[0] is System.DBNull)
                        {
                            String defImgPath = context.Request.PhysicalApplicationPath + "Images\\Icon\\"+ VendorCategory +".png";

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

                            using (FileStream stream = new FileStream(filePath, FileMode.Create))
                            {
                                stream.Write(data, 0, data.Length);
                                stream.Flush();
                            }
                        }

                        context.Response.BinaryWrite(data);
                        con1.Close();


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

    private void GetResidentImage(String ResidentID, String ResidentName)
    {

        using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))
        {
            byte[] data = null;
            con1.Open();

            SqlCommand command = new SqlCommand("select UserID, Profile_image from dbo.ViewUserImage where  ResID=" + ResidentID, con1);
            SqlDataReader dr = command.ExecuteReader();
            dr.Read();


            if(!dr.HasRows || dr[1] is System.DBNull)
            {
                String UserID = dr[0].ToString();
                String Savepath = context.Request.PhysicalApplicationPath + "ImageServer\\User";
                string filePath = string.Format(Savepath + "\\" + UserID + ".png");

                if (File.Exists(filePath))
                {

                    using (FileStream fStream = new FileStream(filePath, FileMode.Open, FileAccess.Read))
                    {
                        BinaryReader br = new BinaryReader(fStream);
                        data = br.ReadBytes((int)fStream.Length);
                        context.Response.BinaryWrite(data);
                    }
                }
                else {
                        Image img = CreateProfilePicture();
                     
                         using (var ms = new MemoryStream())
                           {
                              img.Save(ms,img.RawFormat);
                              data =  ms.ToArray();
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

    private void GetUserImage(String UserID, String UserName)
    {
        String Savepath = context.Request.PhysicalApplicationPath + "ImageServer\\User";
        string filePath = string.Format(Savepath + "\\" + UserID + ".png");
        if (File.Exists(filePath))
        {
            byte[] data = null;
            using (FileStream fStream = new FileStream(filePath, FileMode.Open, FileAccess.Read))
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

                SqlCommand command = new SqlCommand("select Profile_image from dbo.ViewUserImage where  UserID=" + UserID, con1);
                SqlDataReader dr = command.ExecuteReader();
                dr.Read();
                Byte[] data = null;

                if (!dr.HasRows || dr[0] is System.DBNull)
                {
                    string basePath = context.Request.PhysicalApplicationPath + "Images\\Icon\\";

                    var userIcon = new UserDefaultIcon(UserName);
                    String defImgPath = basePath + userIcon.BackgroundImageName;
                    Brush textBrush = userIcon.TextBrush;

                    if (File.Exists(defImgPath))
                    {
                        Utility.SaveImageWithText(defImgPath, filePath, UserName.Substring(0, 1).ToUpper(), textBrush);
                        using (FileStream fStream = new FileStream(filePath, FileMode.Open, FileAccess.Read))
                        {
                            BinaryReader br = new BinaryReader(fStream);
                            data = br.ReadBytes((int)fStream.Length);
                        }

                    }
                }
                else
                {
                    data = (Byte[])dr[0];
                    using (FileStream stream = new System.IO.FileStream(filePath, FileMode.Create))
                    {
                        stream.Write(data, 0, data.Length);
                        stream.Flush();
                    }
                }

                context.Response.BinaryWrite(data);
                con1.Close();

                context.Response.End();

            }
        }

    }

    public Image CreateProfilePicture()
    {
        Font font = new Font(FontFamily.GenericSerif, 25, FontStyle.Bold);
        Color fontcolor = ColorTranslator.FromHtml("#FFF");
        Color bgcolor = ColorTranslator.FromHtml("#83B869");
        Image iconImage = Utility.GenerateAvtarImage("A", font, fontcolor, bgcolor, "test");
            return iconImage;
    }


    public bool IsReusable {
        get {
            return false;
        }
    }

}