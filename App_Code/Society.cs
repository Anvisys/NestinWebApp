using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Transactions;
/// <summary>
/// Summary description for Society
/// </summary>
public class Society
{
    public int SocietyID { get; set; }
    public String SocietyName { get; set; }
    public int TotalFlats { get; set; }
    public String Sector { get; set; }
    public String City { get; set; }
    public String PinCode { get; set; }
    public String State { get; set; }
    public int ContactUserId { get; set; }
    public int Status { get; set; }

    public Society()
    {
    }

    public int InsertSociety()
    {
        int SocietyID = 0;
        try
        {
            DataAccess dacess = new DataAccess();

            String checkQuery = "Select * from " + CONSTANTS.Table_Society + " Where SocietyName like '%" + SocietyName + "%' and City = '" + City + "'";

            DataSet ds = dacess.GetData(checkQuery);
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                SocietyID = -1;
            }
            else
            {
                
                String UpdateQuery = "Insert into " + CONSTANTS.Table_Society
                    + " (SocietyName, TotalFlats,Sector,City,PinCode,State,ContactUserId,Status) output INSERTED.SocietyID Values('"
                     + SocietyName + "'," + TotalFlats + ",'" + Sector + "','" + City + "','" + PinCode + "','" + State + "'," + ContactUserId
                     + "," + Status + ")";

                SocietyID = Convert.ToInt32(dacess.GetIDFromSocietyDB(UpdateQuery));
            }
        }
        catch (Exception ex)
        {
            SocietyID = 0;
        }
        return SocietyID;
    }


    public DataSet GetSocietyRequest(int userID)
    {
        DataSet ds =null;
        try
        {
            DataAccess dacess = new DataAccess();

            String checkQuery = "Select * from " + CONSTANTS.Table_Society + " Where ContactUserId = " + userID ;

            ds = dacess.GetData(checkQuery);
          
        }
        catch (Exception ex)
        {
            int a = 1;
        }
        return ds;
    }

    public DataSet GetSocieties()
    {
        DataSet ds = null;
        try
        {
            DataAccess dacess = new DataAccess();

            String checkQuery = "Select * from " + CONSTANTS.View_Society ;

            ds = dacess.GetData(checkQuery);

        }
        catch (Exception ex)
        {
            int a = 1;
        }
        return ds;
    }


    public bool ApproveSociety( int SocietyID)
    {
        try {

            int rowAffected = 0;
            
            using (TransactionScope tran = new TransactionScope())
            {
                string connString = Utility.SocietyConnectionString;
                using (SqlConnection dbConnection = new SqlConnection(connString))
                {

                    String getUserID = "Select ContactUserId from " + CONSTANTS.Table_Society + " Where SocietyID = " + SocietyID;

                    dbConnection.Open();
                    SqlCommand sqlComm = new SqlCommand();
                    sqlComm = dbConnection.CreateCommand();
                    sqlComm.CommandText = getUserID;
                    int userId = (int)sqlComm.ExecuteScalar();



                    String newUserQuery = "Update " + CONSTANTS.Table_Society + " set Status = 2 Where SocietyID = " + SocietyID;
                    sqlComm.CommandText = newUserQuery;

                    rowAffected = (int)sqlComm.ExecuteNonQuery();


                    if (rowAffected > 0)
                    {
                        String societyUserQuery = "Insert Into " + CONSTANTS.Table_SocietyUser + " (UserID,FlatID,Type,ServiceType,CompanyName,ActiveDate, SocietyID,Status,HouseID) output INSERTED.ResID Values('" +
                                                                             userId + "','0','Admin','0','0','" + DateTime.UtcNow + "','" + SocietyID + "','" + 2 + "',0)";

                        sqlComm.CommandText = societyUserQuery;

                        rowAffected = (int)sqlComm.ExecuteScalar();
                    }

                }
                tran.Complete();
                if (rowAffected > 0)
                    return true;
                else
                    return false;
            }


        }
        catch (Exception ex) {
            return false;
        }

    }

    public bool RejectSociety(int SocietyID)
    {
        try
        {

            int rowAffected = 0;

            using (TransactionScope tran = new TransactionScope())
            {
                string connString = Utility.SocietyConnectionString;
                using (SqlConnection dbConnection = new SqlConnection(connString))
                {

                 
                    dbConnection.Open();
                    SqlCommand sqlComm = new SqlCommand();
                    sqlComm = dbConnection.CreateCommand();
                 

                    String newUserQuery = "Update " + CONSTANTS.Table_Society + " set Status = 3 Where SocietyID = " + SocietyID;
                    sqlComm.CommandText = newUserQuery;

                    rowAffected = (int)sqlComm.ExecuteNonQuery();


                    if (rowAffected > 0)
                    {
                        String societyUserQuery = "Update " + CONSTANTS.Table_SocietyUser + " set Status = 3 Where SocietyID = " + SocietyID;

                        sqlComm.CommandText = societyUserQuery;

                        rowAffected = (int)sqlComm.ExecuteNonQuery();
                    }

                }
                tran.Complete();
                if (rowAffected > 0)
                    return true;
                else
                    return false;
            }


        }
        catch (Exception ex)
        {
            return false;
        }

    }

}