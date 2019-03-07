﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Net;
using System.IO;


/*  This Total  code  is  licenced
    Developed By Anvisys Technologies Pvt Ltd.
    
    Copyright © 2016 Anvisys Technologies Pvt. Ltd.All rights reserved.
    */
/// <summary>
/// Summary description for User
/// </summary>
public class User
{
    public int ID;
    public string strUserID;
    public string Password;
    public string strFirstName;
    public string strMiddleName;
    public string strLastName;
    public string strMobileNumber;
    public string strEmailID="";
    public string Address;
    public string EmpAddress;
  
    public string UserLogin;
    public string EmpID;
    public string EmpUserID;
    public string EmpName;
    public string EmpMobile;
    public string EmpEmailID;
    public string EmpActiveDate;
    public string ActiveDate, DeActiveDate;
    public string IntercomNumber;
    
  
    public string TotalFlats;
    public String ParentName;
    public String Gender;
    public Resident currentResident;

   private List<Resident> allResidents = new List<Resident>();

    public List<Resident> AllResidents
    {
        get { return allResidents; }
    }


    //public static String MasterDBString = "Data Source=208.91.198.59; Initial Catalog=MasterDB; User Id=Nagaraju; Password=Nagaraju@123;Integrated Security=no;";

    //commented by aarshi on 2-aug-2017 for web.config connectionstring
    //public static String MasterDBString = "Data Source=148.72.232.168; Initial Catalog=SocietyDB; User Id=Society; Password=Society@123;Integrated Security=no;";

    //string strPassword;
    DataAccess dbAccess = new DataAccess();
	public User()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public SqlConnection ConnectUserDB()
    {
        SqlConnection dbConnection;
        try
        {
            string connString = Utility.MasterDBString;
            dbConnection = new SqlConnection(connString);
            dbConnection.Open();
            return dbConnection;
        }

        catch (Exception ex)
        {
            throw;
        }
    }

    public bool Validate(string userID, string userPWD)
    {
        try
        {
            string strQuery = "";
            // bool isValid = userID.Length == 10 && userID.All(char.IsDigit);

            using (SqlConnection sqlConn = new SqlConnection())
            {
                //commented and added by aarshi on 2-aug-2017 for web.config connectionstring
                //sqlConn.ConnectionString = MasterDBString;
                sqlConn.ConnectionString = Utility.MasterDBString;
                sqlConn.Open();
                if (userID.All(char.IsDigit))
                {
                    //userid is number
                    strQuery = "select UserLogin from dbo.TotalUsers where MobileNo = '" + userID + "'";

                    userID = dbAccess.GetStringValue(strQuery);

                    if (userID == null || userID == "")
                    {
                        return false;
                    }

                }

                int n;

                if (int.TryParse(userID, out n))
                {
                    strQuery = "select Emailid from dbo.TotalUsers where MobileNo = '" + userID ;
                    DataAccess da = new DataAccess();
                    userID =   da.GetSingleValue(strQuery).ToString();
                }

                string encryptPWD = EncryptPassword(userID.ToLower(), userPWD);
               // String alternatePWD = EncryptPassword(strEmailID.ToLower(), userPWD);

                strQuery = "select * from dbo.TotalUsers where UserLogin = '" + userID + "' and Password = '" 
                    + encryptPWD + "'";

                SqlCommand cmd = new SqlCommand(strQuery, sqlConn);
                SqlDataReader rdr = cmd.ExecuteReader();

                if (!rdr.HasRows)
                {
                    return false;
                }
                else if (rdr.HasRows)
                {
                    while (rdr.Read())
                    {
                        strUserID = rdr["UserID"].ToString();
                        Password = rdr["Password"].ToString();
                        strFirstName = rdr["FirstName"].ToString();
                        strMiddleName = rdr["MiddleName"].ToString();
                        strLastName = rdr["LastName"].ToString();
                        strMobileNumber = rdr["MobileNo"].ToString();
                        strEmailID = rdr["EmailID"].ToString();
                        UserLogin = rdr["UserLogin"].ToString();
                        Address = rdr["Address"].ToString().Trim();
                     }
                    rdr.Close();
                }

               
            }

            return true;
        }

        catch (Exception ex)
        {

            return false;

        }
    }


    public IEnumerable<Resident> GetResidentInfo()
    {
        String strQuery = "";
        try
        {

            using (SqlConnection societyConn = new SqlConnection())
            {
                societyConn.ConnectionString = Utility.SocietyConnectionString;
                societyConn.Open();

                strQuery = "select * from dbo.ViewSocietyUsers where UserID = " + strUserID + " and DeActiveDate > GetDate()";

                DataAccess da = new DataAccess();
                 DataSet ds =  da.GetData(strQuery);

                if (ds == null)
                {

                    return null;
                }
                else if (ds.Tables[0].Rows.Count == 0)
                {
                    allResidents = new List<Resident>();
                    return allResidents;

                }
                else 
                {
                    allResidents = new List<Resident>();
                    foreach (DataRow item in ds.Tables[0].Rows)
                    {
                        string strResID = item["ResID"].ToString();
                        var activeDate = item["ActiveDate"].ToString();
                        var deActiveDate = item["DeActiveDate"].ToString();
                        var userType = item["Type"].ToString();
                        var intercomNumber = item["IntercomNumber"].ToString();
                        int flatID = 0;
                        string flatNumber = "";
                        int serviceType = 0;
                        string compName = "";
                        if (userType == "Owner" || userType == "Tenant")
                        {
                            flatID = Convert.ToInt32(item["FlatID"]);
                            flatNumber = item["FlatNumber"].ToString();
                        }
                        else if (userType == "ResidentAdmin")
                        {
                            flatID = Convert.ToInt32(item["FlatID"]);
                            flatNumber = item["FlatNumber"].ToString();
                        }
                        else if (userType == "Employee" || userType == "Admin")
                        {
                            int.TryParse( item["ServiceType"].ToString(),out serviceType);
                            compName = item["CompanyName"].ToString();
                        }
                        else
                        { continue; }

                        allResidents.Add(new Resident() {

                            ResID = Convert.ToInt32(strResID),
                            UserType = userType,
                            SocietyID = Convert.ToInt32(item["SocietyID"]),
                            SocietyName = item["SocietyName"].ToString(),
                            ActiveDate = activeDate!= string.Empty ? Convert.ToDateTime(activeDate).ToString("dd/MM/yyyy"): null,                        
                            DeActiveDate = deActiveDate != string.Empty ? Convert.ToDateTime(deActiveDate).ToString("dd/MM/yyyy"): null,
                            FlatID = flatID,
                            FlatNumber = flatNumber,
                            CompanyName = compName,
                            ServiceType = serviceType,
                            IntercomNumber = intercomNumber


});
                    }

                    return allResidents;


                }
                //else if (ds.Tables[0].Rows.Count == 1)
                //{

                //    string strResID = ds.Tables[0].Rows[0]["ResID"].ToString();
                //    ResiID = Convert.ToInt32(strResID);
                //    UserType = ds.Tables[0].Rows[0]["Type"].ToString();
                //    SocietyID = Convert.ToInt32(ds.Tables[0].Rows[0]["SocietyID"]);
                //    ActiveDate = ds.Tables[0].Rows[0]["ActiveDate"].ToString();
                //    ActiveDate = Convert.ToDateTime(ActiveDate).ToString("dd/MM/yyyy");
                //    DeActiveDate = ds.Tables[0].Rows[0]["DeActiveDate"].ToString();
                //    DeActiveDate = Convert.ToDateTime(DeActiveDate).ToString("dd/MM/yyyy");

                //    if (UserType == "Owner" || UserType == "Tenant")
                //    {
                //        FlatNumber = ds.Tables[0].Rows[0]["FlatID"].ToString();


                //    }
                //    else if (UserType == "ResidentAdmin")
                //    {
                //        FlatNumber = ds.Tables[0].Rows[0]["FlatID"].ToString();

                //    }
                //    else if (UserType == "Employee" || UserType == "EmployeeAdmin")
                //    {
                //        ServiceType = ds.Tables[0].Rows[0]["ServiceType"].ToString();
                //        CompName = ds.Tables[0].Rows[0]["CompanyName"].ToString();
                //    }
                //    else
                //    { return null; }
                //}

              }


            //return new List<Resident>() { this};
        }
        catch (Exception ex)
        {

            return null;
        }

    }


    public bool SetUserInfo()
    {
        String strQuery = "";
        try
        {

            using (SqlConnection societyConn = new SqlConnection())
            {
                societyConn.ConnectionString = Utility.SocietyConnectionString;
                societyConn.Open();

                if (currentResident.UserType == "Owner" || currentResident.UserType == "Tenant" || currentResident.UserType == "Admin")
                {
                    strQuery = "select * from dbo.ViewResidents where UserID = " + strUserID + "";
                    SqlCommand newCmd = new SqlCommand(strQuery, societyConn);
                    SqlDataReader newRdr = newCmd.ExecuteReader();

                    if (newRdr.HasRows)
                    {
                        while (newRdr.Read())
                        {
                            string strResID = newRdr["ResID"].ToString();
                            //ResiID = Convert.ToInt32(strResID);
                            //FlatNumber = newRdr["FlatNumber"].ToString();
                            //ResType = newRdr["Type"].ToString();
                            ActiveDate = newRdr["ActiveDate"].ToString();
                            ActiveDate = Convert.ToDateTime(ActiveDate).ToString("dd/MM/yyyy");
                            IntercomNumber = newRdr["IntercomNumber"].ToString();

                        }

                    }
                }
                else if (currentResident.UserType == "Employee")
                {
                    strQuery = "select * from dbo.ViewEmployee where UserID = " + strUserID + "";
                    SqlCommand newCmd = new SqlCommand(strQuery, societyConn);
                    SqlDataReader newRdr = newCmd.ExecuteReader();

                    if (newRdr.HasRows)
                    {
                        while (newRdr.Read())
                        {
                            EmpID = newRdr["ID"].ToString();
                            EmpUserID = newRdr["UserID"].ToString();
                            EmpName = newRdr["Firstname"].ToString();
                            //ServiceType = newRdr["ServiceType"].ToString();
                            //CompName = newRdr["CompanyName"].ToString();
                            //EmpAddress = newRdr["Address"].ToString();
                            EmpMobile = newRdr["MobileNo"].ToString();
                            EmpEmailID = newRdr["EmailId"].ToString();
                            EmpActiveDate = newRdr["ActiveDate"].ToString();
                        }

                    }
                }
            }


            return true;
        }
        catch (Exception ex)
        {

            return false;
        }

    }
    public bool UpdatePassword(string userLogin, string userPWD)
    {
        try
        {
            string strNewPassword = EncryptPassword(userLogin, userPWD);
            string strUpdateQuery = "UPDATE dbo.TotalUsers SET Password= '" + strNewPassword + "' WHERE UserLogin= '" + userLogin + "'";
            DataAccess dAccess = new DataAccess();
            return dAccess.UpdateUser(strUpdateQuery);
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    public void SendMailToUsers(string UserLogin, string password, string EmailID, string FirstName)
    {
        try
        {
            string URI = "http://www.kevintech.org/NewAccountMailer.php";
            WebRequest request = WebRequest.Create(URI);
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            string postData = "ToMail=" + EmailID + "&Password=" + password + "&Username=" + UserLogin + "&FirstName=" + FirstName;
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
        catch (Exception ex)
        { }

    }
    public string EncryptPassword(string userID, string userPWD)
    {
        MD5CryptoServiceProvider encoder = new MD5CryptoServiceProvider();
        byte[] bytDataToHash = Encoding.UTF8.GetBytes(userID + userPWD);
        byte[] bytHashValue = new System.Security.Cryptography.MD5CryptoServiceProvider().ComputeHash(bytDataToHash);
        return BitConverter.ToString(bytHashValue).Replace("-", "");
    }

    public string DecryptPassword(string userID, string Password)
    {
        UTF8Encoding UTF8 = new UTF8Encoding();
        MD5CryptoServiceProvider decoder = new MD5CryptoServiceProvider();
        byte[] bytedata = decoder.ComputeHash(UTF8.GetBytes(userID + Password));
        byte[] byvalue = new System.Security.Cryptography.MD5CryptoServiceProvider().ComputeHash(bytedata);
        return Password;
    }


}