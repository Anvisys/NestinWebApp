using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Collections;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Drawing.Drawing2D;

/// <summary>
/// Summary description for Utility
/// </summary>
public static class Utility
{
    public static Hashtable ComplaintType;
    public static Hashtable Complaintseverity;
    public static Hashtable ShopCategory;
    public static Hashtable ComplaintStatus;
    public static Hashtable Descrption;
    public static Hashtable Employee;
   // public static String SocietyConnectionString;

    public static string MasterDBString = ConfigurationManager.ConnectionStrings["MasterDBString"].ConnectionString;//Added by aarshi on 2-aug-2017 to use connection from different pages
    public static String SocietyConnectionString = ConfigurationManager.ConnectionStrings["MasterDBString"].ConnectionString;//Added by aarshi on 2-aug-2017 to use connection from different pages

    private static string FileName = System.Web.HttpContext.Current.Server.MapPath(@"~\Content\log.txt");

    public static void log(String Message)
    {
        StreamWriter errWriter = new StreamWriter(FileName, true);
        errWriter.WriteLine(Message + DateTime.Now.ToUniversalTime().ToString());
        errWriter.Close();
    }

    public static DateTime GetCurrentDateTimeinUTC()
    {
        DateTime date = new DateTime();
        try
        {

            date = System.DateTime.Now.ToUniversalTime();
        }
        catch (Exception ex)
        {
            return date;

        }
        return date;
    }



    public static int GetDifferenceinDays(DateTime EarlierDate, DateTime LaterDate)
    {
        return (LaterDate - EarlierDate).Days;
    }



    public static void Initializehashtables()
    {
        ComplaintType = new Hashtable(10);
        Complaintseverity = new Hashtable(10);
        ShopCategory = new Hashtable(10);
        ComplaintStatus = new Hashtable(10);
        Descrption = new Hashtable(50);
        Employee = new Hashtable(10);

        try
        {
            // Read this Data

            //  using (SqlConnection con1 = new SqlConnection("Data Source= ANVISYS; Initial Catalog= Gayathri Good Life; Integrated Security=SSPI; Persist Security Info = False"))

            using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))


            //using (SqlConnection con1 = new SqlConnection("Data Source=208.91.198.59; Initial Catalog=SPM; User Id=Anvisys; Password=Anvisys@123;Integrated Security=no;"))
            {
                con1.Open();

                SqlDataReader myReader = null;

                SqlCommand myCommand = new SqlCommand("select * from dbo.lukComplaintType", con1);

                myReader = myCommand.ExecuteReader();

                while (myReader.Read())
                {
                    ComplaintType.Add(myReader["CompType"], myReader["CompTypeID"]);
                }
                myReader.Close();


                myCommand = new SqlCommand("select * from dbo.lukComplaintSeverity", con1);
                myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    Complaintseverity.Add(myReader["Severity"], myReader["SeverityID"]);
                }
                myReader.Close();

                myCommand = new SqlCommand("select * from dbo.lukVendorCategory", con1);
                myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    ShopCategory.Add(myReader["ShopCategory"], myReader["ID"]);
                }
                myReader.Close();


                myCommand = new SqlCommand("select * from dbo.lukComplaintStatus", con1);
                myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    ComplaintStatus.Add(myReader["CompStatus"], myReader["StatusID"]);
                }
                myReader.Close();

                myCommand = new SqlCommand("select * from dbo.ViewEmployee", con1);
                myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    Employee.Add(myReader["FirstName"], myReader["ID"]);
                }
                myReader.Close();

                myCommand = new SqlCommand("select * from dbo.ViewComplaintSummary where societyID = " + SessionVariables.SocietyID.ToString() , con1);
                myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    Descrption.Add(myReader["InitialComment"], myReader["CompID"]);
                }
                myReader.Close();
                con1.Close();
            }

        }
        catch (Exception ex)
        {
        }
    }

    public static void SaveImageWithText(string imageFilePath,string outImagePath, string text, Brush textBrush)
    {
        //string firstText = "Hello";
        //string secondText = "World";

        PointF firstLocation = new PointF(7f, 7f);       

        //string imageFilePath = @"path\picture.bmp";
        Bitmap bitmap = (Bitmap)Image.FromFile(imageFilePath);//load the image file
        Bitmap tempBitmap = new Bitmap(bitmap.Width,bitmap.Height);

        using (Graphics graphics = Graphics.FromImage(tempBitmap))
        {
            graphics.SmoothingMode = SmoothingMode.AntiAlias;
            graphics.DrawImage(bitmap, 0, 0, bitmap.Width, bitmap.Height);
            using (Font arialFont = new Font("Arial", 18))
            {
                graphics.DrawString(text, arialFont, textBrush, firstLocation);
                
            }
        }

        tempBitmap.Save(outImagePath, System.Drawing.Imaging.ImageFormat.Png);//save the image file
        bitmap.Dispose();
        tempBitmap.Dispose();
    }

    
   
}