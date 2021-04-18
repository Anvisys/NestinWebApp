using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for BillPlan
/// </summary>
public class BillPlan
{
 

   

    private static String Table_Name = "dbo.Societybillplans";
	public BillPlan()
	{
		//
		// TODO: Add constructor logic here
		//
	}
   
    public DataSet GetPlans(int SocietyID)
    {
        try
        {
            
            DataAccess dacess = new DataAccess();
            //String VendorQuery = "Select * from dbo.aSocietybillplans";
            String VendorQuery = "Select * from "+ Table_Name+ " where SocietyID ='" + SocietyID + "' ";
            DataSet ds = dacess.GetData(VendorQuery);
            return ds;
        }
        catch(Exception ex)
        {
            return null;
        }
    }

    public SocietyBillPlan GetPlan(int BillTypeID, int SocietyID)
    {
        try
        {
            SocietyBillPlan societyBillPlan = new SocietyBillPlan();
            DataAccess dacess = new DataAccess();
            //String VendorQuery = "Select * from dbo.aSocietybillplans";
            String billPlanQuery = "Select * from " + Table_Name + " where BillTypeID = " + BillTypeID + "and  SocietyID ='" + SocietyID + "' ";
            DataSet ds = dacess.GetData(billPlanQuery);
            societyBillPlan.SocietyBillID = Convert.ToInt32(ds.Tables[0].Rows[0]["SocietyBillID"].ToString());
            societyBillPlan.BillTypeID = Convert.ToInt32(ds.Tables[0].Rows[0]["BillTypeID"].ToString());
            societyBillPlan.BillType = ds.Tables[0].Rows[0]["BillType"].ToString();
            societyBillPlan.ChargeType = ds.Tables[0].Rows[0]["ChargeType"].ToString();
            societyBillPlan.Applyto = Convert.ToInt32(ds.Tables[0].Rows[0]["Applyto"].ToString());
            societyBillPlan.SocietyID = Convert.ToInt32(ds.Tables[0].Rows[0]["SocietyID"].ToString());
            societyBillPlan.BillPlanDate = Convert.ToDateTime(ds.Tables[0].Rows[0]["BillPlanDate"].ToString());
            return societyBillPlan;
        }
        catch (Exception ex)
        {
            return null;
        }
    }



    public SocietyBillPlan GetPlanDetails(String BillType)
    {
        DataAccess dacess = new DataAccess();
        SocietyBillPlan socBillPlan = new SocietyBillPlan();
        try {
            String BillTypeDescp = "Select * from "+Table_Name+" where Billtype ='" + BillType + "'";
            SqlConnection dbConnect = dacess.ConnectSocietyDB();
            SqlCommand cmd = new SqlCommand(BillTypeDescp, dbConnect);
            SqlDataReader rdr = cmd.ExecuteReader();

          
            if (rdr.HasRows)
            {
                while (rdr.Read())
                {
                    socBillPlan.ChargeType = rdr["ChargeType"].ToString();
                    socBillPlan.Rate = rdr["Rate"].ToString();
                    socBillPlan.BillTypeID = Convert.ToInt32(rdr["BillTypeID"].ToString());
                }
            }
            return socBillPlan;
        }
        catch (Exception ex)
        {

            return socBillPlan;
        }
    }

    public DataSet GetActiveBillType(int SocietyID)
    {
        try
        {
            DataAccess dacess = new DataAccess();
            String FillBillType = "Select distinct BillTypeID, BillType, SocietyBillId from " + Table_Name + " Where SocietyID = " + SocietyID ;
            return dacess.ReadData(FillBillType);
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    public DataSet GetBillTypeForCalculation(int SocietyID)
    {
        try
        {
            DataAccess dacess = new DataAccess();
            String FillBillType = "Select distinct BillTypeID, BillType, SocietyBillId from " + Table_Name + " Where ChargeType != 'Manual' SocietyID = " + SocietyID;
            return dacess.ReadData(FillBillType);
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    public bool AddSocietyBillPlan(int BillTypeID , String BillType, String ChargeType, String Rate, String CycleType, int Applyto, int SocietyID)
    {
        int ID=0;
        DataAccess dacess = new DataAccess();
        String BillingQuery = "Insert into "+ Table_Name+ " (BillTypeID, BillType,ChargeType,Rate,CycleType,Applyto,SocietyID) Values('"
          + BillTypeID + "','" + BillType + "','" + ChargeType + "','" + Rate + "','" + CycleType + "','" + Applyto + "','" + SocietyID + "')";
        bool result = dacess.Update(BillingQuery);
       

        return result;
    }

    public int GetBillID(string BillType)
    {
        DataAccess dacess = new DataAccess();
        String GetBillIdQuery = "Select SocietyBillID from " + Table_Name + " where BillType ='" + BillType + "'";
        int billID = dacess.GetSingleValue(GetBillIdQuery);
        return billID;
    }

    public bool UpdateSocietyBillPlan(string ChargeType, string BillRate, string CycleType, int ApplyTo, string billID)
    {
        DataAccess dacess = new DataAccess();
        String DelSocietyPlanQuery = "Update " + Table_Name + " set ChargeType ='" + ChargeType + "', Rate ='" + BillRate + "', CycleType ='" + CycleType +
            "', ApplyTo ='" + ApplyTo + "' where SocietyBillID = '" + billID + " '";
        bool result = dacess.Update(DelSocietyPlanQuery);
        return result;
    }

    public bool DeactiveSocietyBillPlan(string billID)
    {
        DataAccess dacess = new DataAccess();
        String DelSocietyPlanQuery = "Delete from  dbo.SocietyBillPlans where SocietyBillID = '" + billID + "' ";
        bool result = dacess.Update(DelSocietyPlanQuery);
        return result;
    }
}



public class SocietyBillPlan
{
    public int SocietyBillID { get; set; }
    public int BillTypeID { get; set; }
    public String BillType { get; set; }
    public String ChargeType { get; set; }
    public String Rate { get; set; }
    public String CycleType { get; set; }
    public int Applyto { get; set; }
    public int SocietyID { get; set; }
    public DateTime BillPlanDate { get; set; }
}