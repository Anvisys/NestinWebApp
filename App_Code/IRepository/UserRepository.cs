using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

/// <summary>
/// Summary description for UserRepository
/// </summary>
public class UserRepository : UserEncryption, IUserRepository
{
    string connString;
    public UserRepository()
    {
        //
        // TODO: Add constructor logic here
        //
        connString = Utility.MasterDBString;
    }

    public void AddEmployee(IUser user)
    {
        throw new NotImplementedException();
    }

    public void AddResident(IUser user)
    {
        throw new NotImplementedException();
    }

    public int AddUser(IUser user)
    {
        using (SqlConnection dbConnection = new SqlConnection(connString))
        {
            DataAccess dacess = new DataAccess();

            String checkQuery = "Select * from " + CONSTANTS.Table_Users + " Where MobileNo = " + user.MobileNo + " or EmailId = '" + user.EmailId + "'";

            DataSet ds = dacess.GetData(checkQuery);
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
               return -1;
            }


            dbConnection.Open();
            SqlCommand sqlComm = new SqlCommand();
            sqlComm = dbConnection.CreateCommand();

            string strEncPassword = this.EncryptPassword(user.EmailId, user.Password);
            String newUserQuery = "Insert into " + CONSTANTS.Table_Users
                + " (FirstName, MiddleName,LastName,MobileNo,EmailId,Gender,Parentname,UserLogin, Password,Address) output INSERTED.UserID Values('"
                 + user.FirstName + "','" + user.MiddleName + "','" + user.LastName + "','" + user.MobileNo + "','" + user.EmailId + "','" + user.Gender + "','" + user.Parentname
                 + "','" + user.UserLogin + "','" + strEncPassword + "','" + user.Address + "')";


            sqlComm.CommandText = newUserQuery;
            user.UserId = (int)sqlComm.ExecuteScalar();
        }
        return user.UserId;
    }


    private int AddSocietyUser(IUser user)
    {
        int societyUserId = 0;
        using (SqlConnection dbConnection = new SqlConnection(connString))
        {
            dbConnection.Open();
            SqlCommand sqlComm = new SqlCommand();
            sqlComm = dbConnection.CreateCommand();
            String societyUserQuery = "Insert Into dbo.SocietyUser  (UserID,FlatID,Type,ServiceType,CompanyName,ActiveDate, SocietyID, Status, HouseID) output INSERTED.ResID Values('" +
                                                             user.UserId + "','" + user.FlatId + "','Owner','0','NA','" + DateTime.UtcNow.ToString("MM-dd-yyyy HH:MM:ss") + "','" + user.SocietyID +
                                                               "',0,0)";

            sqlComm.CommandText = societyUserQuery;
            societyUserId = (int)sqlComm.ExecuteScalar();
        }
        return societyUserId;
    }


}