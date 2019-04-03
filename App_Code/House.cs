using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Transactions;

/// <summary>
/// Summary description for House
/// </summary>
public class House
{
    public int HouseId;
    public String HouseNumber;
    public String Sector;
    public String City;
    public String State;
    public int PinCode;


    public House()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public int InsertHouse(int UserId)
    {
        
        try
        {
            DataAccess dacess = new DataAccess();

            String checkQuery = "Select * from " + CONSTANTS.Table_IndependentHouse + " Where HouseNumber = '" + HouseNumber + "' and Sector = '" + Sector 
                               + "' and City = '" + City + "'";

            DataSet ds = dacess.GetData(checkQuery);
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                HouseId = -1;
            }
            else
            {
                using (TransactionScope tran = new TransactionScope())
                {
                    string connString = Utility.SocietyConnectionString;
                    using (SqlConnection dbConnection = new SqlConnection(connString))
                    {
                        String UpdateHouse = "Insert into " + CONSTANTS.Table_IndependentHouse +
                                             " (HouseNumber, Sector,City,State,PinCode) output INSERTED.ID Values('"
                                               + HouseNumber + "','" + Sector + "','" + City + "','" + State + "'," + PinCode + ")";

                        dbConnection.Open();

                        SqlCommand sqlComm = new SqlCommand();
                        sqlComm = dbConnection.CreateCommand();
                        sqlComm.CommandText = UpdateHouse;
                        int HouseId = (int)sqlComm.ExecuteScalar();


                        String societyUserQuery = "Insert Into "+ CONSTANTS.Table_SocietyUser 
                            + " (UserID,FlatID,Type,HouseID,ServiceType,CompanyName,ActiveDate, SocietyID,Status) output INSERTED.ResID Values('" +
                                UserId + "','0','Individual','" + HouseId + "','0','NA','" + DateTime.UtcNow.ToString("MM-dd-yyyy HH:MM:ss") + "','0',0)";
                        sqlComm.CommandText = societyUserQuery;

                        HouseId = (int)sqlComm.ExecuteScalar();


                    }
                    tran.Complete();
                  }

            }
        }
        catch (Exception ex)
        {
            HouseId = 0;
        }
        return HouseId;
    }
}