using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Transactions;
using System.Web;

/// <summary>
/// Summary description for Flat
/// </summary>
public class Flat
{

    public String FlatNumber { get; set; }
    public String Block { get; set; }
    public String Floor { get; set; }
    public int Intercom { get; set; }
    public int BHK { get; set; }
   
    public String FlatArea { get; set; }
    public int SocietyID { get; set; }

    public Flat()
    {
        //
        // TODO: Add constructor logic here
        //
    }


    public void AddFlat(int ExisitingUserID)
    {
    
            String flatUpdateQuery = "Insert into dbo.Flats(FlatNumber,FlatArea,Floor,Block,BHK,IntercomNumber,UserID,SocietyID) output INSERTED.ID values ('" +
                     FlatNumber + "' ,'" + FlatArea + "','" + Floor + "'  ,'" + Block + "' ,'" + BHK + "' ,'" + Intercom +  "','" + ExisitingUserID + "','" + SessionVariables.SocietyID + "')";


          //  String SocietyUserQuery = "Insert Into dbo.SocietyUser  (UserID,FlatID,Type,ServiceType,CompanyName,ActiveDate, SocietyID) output INSERTED.ResID values('" +
                                                                 //ExisitingUserID + "','" + FlatNumber + "','Owner','0','NA','" + DateTime.UtcNow + "','" + SessionVariables.SocietyID + "')";

        using (TransactionScope tran = new TransactionScope())
        {
            string connString = Utility.SocietyConnectionString;
            using (SqlConnection dbConnection = new SqlConnection(connString))
            {
                dbConnection.Open();
            

                SqlCommand sqlComm;

                sqlComm = dbConnection.CreateCommand();

                sqlComm.CommandText = flatUpdateQuery;

                int flatId = (int)sqlComm.ExecuteScalar();

                String societyUserQuery = "Insert Into dbo.SocietyUser  (UserID,FlatID,Type,ServiceType,CompanyName,ActiveDate, SocietyID) output INSERTED.ResID values('" +
                                                                     ExisitingUserID + "','" + flatId + "','Owner','0','NA','" + DateTime.UtcNow + "','" + SessionVariables.SocietyID + "')";
                sqlComm.CommandText = societyUserQuery;

                int societyUserId = (int)sqlComm.ExecuteScalar();

            }
            tran.Complete();
        }
    }

    public void AddFlatWithUser(User newUser)
    {

            String EncryptPassword = newUser.EncryptPassword(newUser.UserLogin.ToLower(), newUser.Password);

            String newUserQuery =
                "Insert Into dbo.TotalUsers  (FirstName, MiddleName,LastName,MobileNo,EmailId,Gender,Parentname,UserLogin, Password,Address,UserType,SocietyID) output INSERTED.UserID values('" +
                newUser.FirstName + "','','" + newUser.LastName + "','" + newUser.MobileNumber + "','" + newUser.EmailID + "','" + newUser.Gender + "','" + newUser.ParentName + "','" + newUser.UserLogin + "','" + EncryptPassword + "','" + newUser.Address + "','Owner','" + SessionVariables.SocietyID + "')";
               
                using (TransactionScope tran = new TransactionScope())
                {
                    string connString = Utility.SocietyConnectionString;
                    using (SqlConnection dbConnection = new SqlConnection(connString))
                    {
                        dbConnection.Open();
                       
                        SqlCommand sqlComm = new SqlCommand();
                        sqlComm = dbConnection.CreateCommand();
                        sqlComm.CommandText = newUserQuery;
                        int userId = (int)sqlComm.ExecuteScalar();
                        String flatUpdateQuery = "Insert into dbo.Flats(FlatNumber,FlatArea,Floor,Block,BHK,IntercomNumber,UserID,SocietyID,OwnerName,Address,MobileNo) output INSERTED.ID values('" +
                             FlatNumber + "' ,'" + FlatArea + "','" + Floor + "'  ,'" + Block + "' ,'" + BHK + "' ,'" + Intercom + "'," + userId + ",'" + SessionVariables.SocietyID + "','NA','NA','NA')";
                        sqlComm.CommandText = flatUpdateQuery;

                        int flatId = (int)sqlComm.ExecuteScalar();

                        String societyUserQuery = "Insert Into dbo.SocietyUser  (UserID,FlatID,Type,ServiceType,CompanyName,ActiveDate, SocietyID) output INSERTED.ResID Values('" +
                                                                             userId + "','" + flatId + "','Owner','0','NA','" + newUser.ActiveDate + "','" + SessionVariables.SocietyID + "')";
                        sqlComm.CommandText = societyUserQuery;

                        int societyUserId = (int)sqlComm.ExecuteScalar();
                    }
            tran.Complete();
        }

 
           
    }

    public int AddFlat(Flat newFlat)
    {
        string connString = Utility.SocietyConnectionString;
        using ( SqlConnection dbConnection = new SqlConnection(connString))
        {
            dbConnection.Open();
            string querystring = "Insert into dbo.Flats(FlatNumber,FlatArea,Floor,Block,BHK,IntercomNumber,UserID,SocietyID) output INSERTED.ID values('" +
                                newFlat.FlatNumber + "' ,'" + newFlat.FlatArea + "'," + newFlat.Floor + "  ,'" + newFlat.Block + "' ," + newFlat.BHK + " ," + newFlat.Intercom + "," + 0 + "," + SessionVariables.SocietyID + ")";

            SqlCommand cmd = new SqlCommand(querystring ,dbConnection);
            int result = (int)cmd.ExecuteScalar();
            return result;
        }
    }

}