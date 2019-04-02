using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
/// <summary>
/// Summary description for Society
/// </summary>
public class Society
{
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

}