using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OpenFile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String NoticeID = Request.QueryString["NoticeID"].ToString();
        String filename = Request.QueryString["FileName"].ToString();
      String[] fileArray = filename.Split('.');

     
        if (NoticeID != null && filename != null)
        {
            bool exists = System.IO.Directory.Exists(System.Web.Hosting.HostingEnvironment.MapPath("~/AppImage/Notice") + "//" + NoticeID);
            if (!exists)
            {
                System.IO.Directory.CreateDirectory(System.Web.Hosting.HostingEnvironment.MapPath("~/AppImage/Notice") + "//" + NoticeID);
            }
            String path = System.Web.Hosting.HostingEnvironment.MapPath("~/AppImage/Notice" + "//" + NoticeID);
            String file = path + "\\" + filename;

            WebClient client = new WebClient();
            Byte[] buffer = client.DownloadData(file);
            if (fileArray[1] == "doc" || fileArray[1] == "docx")
            { Response.ContentType = "application/msword"; }
            else if (fileArray[1] == "pdf")
            {
                Response.ContentType = "application/pdf";
            }
            else if (fileArray[1] == "jpeg" || fileArray[1] == "jpg" || fileArray[1] == "png")
            {
                Response.ContentType = "application/jpeg";
            }
            else if (fileArray[1] == "xls" || fileArray[1] == "xlsx")
            {
                Response.ContentType = "application/msexcel";
            }
            else {
                ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "javascript:alert('Unknown File Type')", true);
                return;
            }
            Response.AppendHeader("Content-Disposition", "inline; filename=" + filename);
            Response.AddHeader("content-length", buffer.Length.ToString());
            Response.BinaryWrite(buffer);
           // Response.Flush();
        }
    }
}