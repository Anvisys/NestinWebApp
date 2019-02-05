using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class NotificationImage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Testimage();
        GetPdfDoc();
        //GetExcelDoc();
    }


    public void Testimage()
    {
        try
        {
            if (Request.QueryString["ID"] != null && Request.QueryString["ID"] != "")
            {

                String NotifiImgID = Request.QueryString["ID"];
                ImageMap1.Attributes["src"] = "GetImages.ashx?NotifiImID=" + NotifiImgID.ToString();
            }
        }

        catch(Exception ex)
        {

        }
    }


    public void GetPdfDoc()
    {

        try
        {

            if (Request.QueryString["NotifFileID"] != null && Request.QueryString["NotifFileID"] != "")
            {
                String ID = Request.QueryString["NotifFileID"].ToString();

                String strCon = Utility.SocietyConnectionString;
                SqlConnection sqlcon = new SqlConnection(strCon);
                sqlcon.Open();
                SqlCommand sqlcmd = new SqlCommand("select  AttachData,AttachType from dbo.NotificationsData where Notice_ID ='" + ID + "' and AttachType ='application/pdf'", sqlcon);
                SqlDataReader dr = sqlcmd.ExecuteReader();
                if (dr.Read())
                {
                    Byte[] buffer = ((Byte[])dr[0]);
                    String attachType = dr[1].ToString();
                    if (attachType == "application/pdf")
                    {
                        Response.ContentType = "application/pdf";
                        Response.AddHeader("content-length", buffer.Length.ToString());
                        Response.BinaryWrite(buffer);
                    }
                    else if ((attachType == "application/msword") || (attachType == "application/octet-stream"))
                    {
                        Response.ContentType = "application/msword";
                        Response.AddHeader("content-length", buffer.Length.ToString());
                        Response.BinaryWrite(buffer);
                    }
                }
            }
        }
        catch(Exception ex)
        {

        }
    }

    public void GetExcelDoc()
    {
        try
        {
            if (Request.QueryString["NotifFileID"] != null && Request.QueryString["NotifFileID"] != "")
            {
                String ID = Request.QueryString["NotifFileID"].ToString();

                String strCon = Utility.SocietyConnectionString;
                SqlConnection sqlcon = new SqlConnection(strCon);
                sqlcon.Open();
                SqlCommand sqlcmd = new SqlCommand("select  AttachData,AttachType from dbo.NotificationsData where Notice_ID ='" + ID + "'  and AttachType ='application/msword'", sqlcon);
                SqlDataReader dr = sqlcmd.ExecuteReader();
                if (dr.Read())
                {
                    Byte[] buffer = ((Byte[])dr[0]);                 
                    Response.ContentType = "application/msword";
                    Response.AddHeader("content-length", buffer.Length.ToString());
                    Response.BinaryWrite(buffer);
                }
            }
        }
        catch (Exception ex)
        {

        }
    }
}