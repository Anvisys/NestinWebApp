using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Transactions;
using System.Web;

/// <summary>
/// Summary description for DemoUserRepository
/// </summary>
public class DemoUserRepository : UserEncryption, IUserRepository
{
    public DemoUserRepository()
    {
        //
        // TODO: Add constructor logic here
        //
    }


    public int AddUser(IUser user)
    {
        int result = 0;
        try
        {
            DataAccess dacess = new DataAccess();

            String checkQuery = "Select * from " + CONSTANTS.Table_Users + " Where MobileNo = " + user.MobileNo + " or EmailId = '" + user.EmailId + "'";

            DataSet ds = dacess.GetData(checkQuery);
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                result = -1;
            }
            else
            {
                using (TransactionScope tran = new TransactionScope())
                {
                    string connString = Utility.SocietyConnectionString;
                    using (SqlConnection dbConnection = new SqlConnection(connString))
                    {
                        dbConnection.Open();
                        SqlCommand sqlComm = new SqlCommand();
                        sqlComm = dbConnection.CreateCommand();


                        string strEncPassword = this.EncryptPassword(user.EmailId, user.Password);
                        String newUserQuery = "Insert into " + CONSTANTS.Table_Users
                            + " (FirstName, MiddleName,LastName,MobileNo,EmailId,Gender,Parentname,UserLogin, Password,Address) output INSERTED.UserID Values('"
                             + user.FirstName + "','" + user.MiddleName + "','" + user.LastName + "','" + user.MobileNo + "','" + user.EmailId + "','" + user.Gender + "','" + user.Parentname
                             + "','" + user.UserLogin + "','" + strEncPassword + "','" + user.Address + "')";


                        sqlComm.CommandText = newUserQuery;
                        int UserID = (int)sqlComm.ExecuteScalar();


                        var FlatNumber = user.FirstName.Substring(0, 1) + user.LastName.Substring(0, 1) + user.MobileNo.Substring(7, 3);
                        var BHK = 3;
                        var Block = user.FirstName.Substring(0, 1);
                        var FlatArea = "1200";
                        var Floor = Convert.ToInt32(user.MobileNo.Substring(9, 1));
                        var IntercomNumber = Convert.ToInt32(user.MobileNo.Substring(5, 5));
                        var SocietyID = 1;

                        String flatUpdateQuery = "Insert into dbo.Flats (FlatNumber,FlatArea,Floor,Block,BHK,IntercomNumber,UserID,SocietyID) output INSERTED.ID values ('" +
                        FlatNumber + "' ,'" + FlatArea + "','" + Floor + "'  ,'" + Block + "' ,'" + BHK + "' ,'" + IntercomNumber + "','" + UserID + "','" + SocietyID + "')";


                        sqlComm.CommandText = flatUpdateQuery;
                        int flatId = (int)sqlComm.ExecuteScalar();

                        String societyUserQuery = "Insert Into dbo.SocietyUser  (UserID,FlatID,Type,ServiceType,CompanyName,ActiveDate, SocietyID, Status, HouseID) output INSERTED.ResID Values('" +
                                                                                 UserID + "','" + flatId + "','Owner','0','NA','" + DateTime.UtcNow.ToString("MM-dd-yyyy HH:MM:ss") + "','" + SocietyID +
                                                                                   "',0,0)";

                        sqlComm.CommandText = societyUserQuery;
                        int societyUserId = (int)sqlComm.ExecuteScalar();
                    }
                    tran.Complete();
                    result = 1;
                }
            }
        }
        catch (Exception ex)
        {
            result = 0;
        }

        return result;
    }
}