﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Net;
using System.IO;
using System.Data;
using System.Text;
using Newtonsoft.Json;

public partial class Login : System.Web.UI.Page
{

    User muser;
    protected void Page_Load(object sender, EventArgs e)
    {
        SessionVariables.API_URL = "http://www.Nestin.online/NestinWebApi";
    }

    protected void btnForgotpass_Click(object sender, EventArgs e)
    {
        String UserLogin = txtForgotText.Text;
        String NewPassword = RandomPassword(8);
        DataAccess dacess = new DataAccess();
        String UserExistQuery = "select max(UserID) from dbo.TotalUsers where UserLogin ='" + UserLogin + "' or EmailId =  '" + UserLogin + "'";

        int User = dacess.GetSingleUserValue(UserExistQuery);

        if (User != 0)
        {
            String ForgotPassQuery = "Update dbo.TotalUsers set Password = '" + NewPassword + "' where UserLogin = '" + UserLogin + "'";
            bool result = dacess.UpdateUser(ForgotPassQuery);

            if (result == true)
            {
                String UserLoginQuery = "Select EmailId from dbo.TotalUsers where UserLogin= '" + UserLogin + "'";
                String EmailId = dacess.GetStringValue(UserLoginQuery);

                User muser = new User();

                bool result1 = muser.UpdatePassword(UserLogin, NewPassword);
                if (result1 == true)
                {
                    try
                    {
                        SendMailForgot(UserLogin, NewPassword, EmailId);
                        lblres.Text = "Password  link  is sent  to  your EmailId.";
                        lblPasswordRes.ForeColor = System.Drawing.Color.Gray;
                        lblPasswordRes.Visible = true;
                        lblPasswordRes.Text = "Your  new password  is sent to your Registered EmailId";
                        lblerror.Visible = false;
                    }

                    catch
                    {
                        lblPasswordRes.Text = "Some  problem  with  our  server, try later.";
                        lblerror.Visible = false;
                    }
                }
            }
            else
            {
            }
        }
        else
        {
            lblPasswordRes.Text = "Please Enter Valid UserID";
        }
    
    }

    public void SendMailForgot(string UserLogin, string password, string EmailID)
    {

        string URI = "http://www.Nestin.Online/mailserver.php";
        WebRequest request = WebRequest.Create(URI);
        request.Method = "POST";
        request.ContentType = "application/x-www-form-urlencoded";
        string postData = "ToMail=" + EmailID + "&Password=" + password + "&Username=" + UserLogin;
        Stream dataStream = request.GetRequestStream();
        byte[] byteArray = Encoding.UTF8.GetBytes(postData);
        dataStream.Write(byteArray, 0, byteArray.Length);
        dataStream.Close();
        WebResponse response = request.GetResponse();

        StreamReader reader = new StreamReader(response.GetResponseStream());
        reader.Close();
        dataStream.Close();
        response.Close();

    }

    public static string RandomPassword(int length)
    {


        string Charactersallowed = "";
        Charactersallowed = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        Charactersallowed += "abcdefghijklmnopqrstuvwxyz";
        Charactersallowed += "0123456789@#$%&";
        char[] chars = new char[length];
        int aloowedchars = Charactersallowed.Length;
        Random rdm = new Random();


        for (int i = 0; i < 8; i++)
        {
            chars[i] = Charactersallowed[rdm.Next(0, aloowedchars)];

        }

        return new string(chars);
    }
    protected void lnkForgotPass_Click(object sender, EventArgs e)
    {
        String UserLogin = TxtUserID.Text;

        //Session["UserLogin"] = UserLogin;
        SessionVariables.UserLogin = UserLogin;

        if (Session != null)
        {

            txtForgotText.Text = UserLogin;
        }

    }



    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static int ValidateUser(Users user)
    {
        User muser = new User();
        if (muser.Validate(user.Username, user.Password))
        {
           var residents = muser.SetResidentInfo();
            if (residents == null)
            {

                return -2;
            }
            else if (residents.Count() == 0)
            {
                //added by aarshi to test session
                SessionVariables.User = muser;
                //SessionVariables.UserType = muser.UserType;
                //SessionVariables.ResiID = muser.strUserID;
                SessionVariables.UserLogin = muser.UserLogin;
                //SessionVariables.SocietyName = muser.SocietyName;
                //SessionVariables.FlatNumber = muser.FlatNumber;
                SessionVariables.LName = muser.LastName;
                SessionVariables.FName = muser.FirstName;
                //SessionVariables.SocietyID = muser.SocietyID;
                SessionVariables.CurrentPage = "Userprofile.aspx";
                return 0;
            }
            else
            {
                Utility.Initializehashtables();

                //added by aarshi to test session
                SessionVariables.User = muser;
                //SessionVariables.UserType = muser.UserType;
                //SessionVariables.ResiID = muser.strUserID;
                SessionVariables.UserLogin = muser.UserLogin;
                //SessionVariables.SocietyName = muser.SocietyName;
                //SessionVariables.FlatNumber = muser.FlatNumber;
                SessionVariables.LName = muser.LastName;
                SessionVariables.FName = muser.FirstName;
                //SessionVariables.SocietyID = muser.SocietyID;
                if (muser.currentResident.UserType == "Individual")
                {
                    SessionVariables.CurrentPage = "MyHouse.aspx";
                }
                else
                {
                    SessionVariables.CurrentPage = "Dashboard.aspx";
                }

                return 1;
            }
          
          
           
        
        }
        else
            return -1;

    }
    public class Users
    {
        public string Username { get; set; }
        public string Password { get; set; }
    }
}