using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for BillCycle
/// </summary>
public class BillCycle
{
    string Table_Name = "dbo.BillCycle";
    //  private static String ViewName = "dbo.ViewLatestBillCycle";

         private static String ViewName = "dbo.ViewLatestFlatBill";

    public BillCycle()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public bool AddSingleFlatBillCycle(int BillID, String FlatID, DateTime startDate, DateTime EndDate, String Comment)
    {
        DataAccess dacess = new DataAccess();
        String BillCycleQuery = "Insert into dbo.BillCycle(BillID,FlatID,CycleStart,CycleEnD,comments, SocietyID) values('" + BillID + "','" + FlatID + "','" + startDate + "','" + EndDate + "','" + Comment + "','" + SessionVariables.SocietyID + "')";
        return dacess.Update(BillCycleQuery);
    }

 
    public bool AddNewBillCycle(int BillID, String FlatID, DateTime startDate, DateTime EndDate)
    {
        try
        {
            DataAccess dacess = new DataAccess();
            String BillCycleQuery = "Update  dbo.BillCycle  set CycleStart ='" + startDate + "', CycleEnD ='" + EndDate + "' where BillID ='" + BillID + "'and  FlatID ='" + FlatID + "'";
            return dacess.Update(BillCycleQuery);
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    public bool AddBillCycleToAllFlats(int BillID, int ApplyTo)
    {
        try
        {
            DateTime CycleStart = new DateTime();
            DateTime CycleEnd = new DateTime();
            if (ApplyTo == 0)
            {
                CycleStart = new DateTime(2000, 1, 1);
                CycleEnd = new DateTime(2000, 1, 1);
            }
            else
            {
                CycleStart = Utility.GetCurrentDateTimeinUTC();
                int year = CycleStart.Year;
                CycleEnd = new DateTime(year + 5, CycleStart.Month, CycleStart.Day);

            }
            DataAccess dacess = new DataAccess();
            String FlatDataQuery = "Select * from dbo.Flats";
            DataSet Data = dacess.ReadData(FlatDataQuery);
            DataTable dataFlat = Data.Tables[0];
            DataTable tempBillCycle = new DataTable();

            tempBillCycle.Columns.Add("FlatNumber");

            tempBillCycle.Columns.Add("BillID", typeof(int));
            tempBillCycle.Columns.Add("CycleStart", typeof(DateTime));
            tempBillCycle.Columns.Add("CycleEnD", typeof(DateTime));

            foreach (DataRow FlatRow in dataFlat.Rows)
            {
                String Flat = FlatRow["FlatNumber"].ToString();
                int BillIDAdd = BillID;
                tempBillCycle.Rows.Add(Flat, BillIDAdd, CycleStart, CycleEnd);
            }

            String SqlSocietyString = String.Empty;
            SqlSocietyString = Utility.SocietyConnectionString; ;
            SqlConnection SocietyCon = new SqlConnection(SqlSocietyString);
            SocietyCon.Open();

            using (SqlBulkCopy FlatBillsData = new SqlBulkCopy(SocietyCon))
            {

                FlatBillsData.DestinationTableName = "BillCycle";
                FlatBillsData.ColumnMappings.Add("FlatNumber", "FlatID");
                FlatBillsData.ColumnMappings.Add("BillID", "BillID");
                FlatBillsData.ColumnMappings.Add("CycleStart", "CycleStart");
                FlatBillsData.ColumnMappings.Add("CycleEnD", "CycleEnD");

                FlatBillsData.WriteToServer(tempBillCycle);
            }
            SocietyCon.Close();
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }

    }

    //Added by aarshi on 7 july 2017 for zero bill
    public void GenerateInitialZeroBillFlat(int BillID, int ApplyTo,string CycleType)
    {
        DateTime CycleStart = new DateTime();
        DateTime CycleEnd = new DateTime();
       
        if (ApplyTo == 1)
        {

            CycleStart = Utility.GetCurrentDateTimeinUTC();
            int year = CycleStart.Year;
            CycleEnd = new DateTime(year + 5, CycleStart.Month, CycleStart.Day);
            


            DataAccess dacess = new DataAccess();
            String FlatDataQuery = "Select * from dbo.Flats";
            DataSet Data = dacess.ReadData(FlatDataQuery);
            DataTable dataFlat = Data.Tables[0];
            DataTable tempBillCycle = new DataTable();

            tempBillCycle.Columns.Add("FlatNumber");
            tempBillCycle.Columns.Add("BillID", typeof(int));
            tempBillCycle.Columns.Add("CurrentBillAmount", typeof(int));
            tempBillCycle.Columns.Add("CycleType", typeof(string));
            tempBillCycle.Columns.Add("PaymentDueDate", typeof(DateTime));
            tempBillCycle.Columns.Add("BillMonth", typeof(string));
            tempBillCycle.Columns.Add("PreviousMonthBalance", typeof(int));
            tempBillCycle.Columns.Add("AmountPaidDate", typeof(string));
            tempBillCycle.Columns.Add("AmountPaid", typeof(int));
            tempBillCycle.Columns.Add("PaymentMode", typeof(string));
            tempBillCycle.Columns.Add("TransactionID", typeof(string));
            tempBillCycle.Columns.Add("InvoiceID", typeof(string));
            tempBillCycle.Columns.Add("ModifiedAt", typeof(DateTime));
            tempBillCycle.Columns.Add("BillDescription", typeof(string));
            tempBillCycle.Columns.Add("BillStartDate", typeof(DateTime));
            tempBillCycle.Columns.Add("BillEndDate", typeof(DateTime));

            foreach (DataRow FlatRow in dataFlat.Rows)
            {

               
                GenerateBill emptyBill = new GenerateBill();
                emptyBill.op_FlatNumber = FlatRow["FlatNumber"].ToString();
                emptyBill.SocietyBillID = BillID;
                emptyBill.CurrentBillAmount = 0;
                emptyBill.CycleType = CycleType;
                emptyBill.PaymentDueDate = Convert.ToDateTime(CycleStart).AddDays(7);
                emptyBill.BillMonth = Convert.ToDateTime(CycleStart);
                emptyBill.PreviousMonthBalance = 0;
                emptyBill.op_AmountPaidDate = null;
                emptyBill.AmountPaid = 0;
                emptyBill.PaymentMode = "0";
                emptyBill.TransactionID = null;
                emptyBill.InvoiceID = null;
                emptyBill.ModifiedAt = Utility.GetCurrentDateTimeinUTC();
                emptyBill.BillDescription = "First Empty Bill";
                emptyBill.BillStartDate = Convert.ToDateTime(CycleStart).AddDays(-1);
                emptyBill.BillEndDate = Convert.ToDateTime(CycleStart).AddDays(-1);
                tempBillCycle.Rows.Add(emptyBill.op_FlatNumber, emptyBill.SocietyBillID, emptyBill.CurrentBillAmount, emptyBill.CycleType, emptyBill.PaymentDueDate, emptyBill.BillMonth, 
                    emptyBill.PreviousMonthBalance, emptyBill.op_AmountPaidDate, emptyBill.AmountPaid, emptyBill.PaymentMode, emptyBill.TransactionID, emptyBill.InvoiceID, emptyBill.ModifiedAt, 
                    emptyBill.BillDescription, emptyBill.BillStartDate, emptyBill.BillEndDate);

            }

            String SqlSocietyString = String.Empty;
            SqlSocietyString = Utility.SocietyConnectionString; ;
            SqlConnection SocietyCon = new SqlConnection(SqlSocietyString);
            SocietyCon.Open();

            using (SqlBulkCopy FlatBillsData = new SqlBulkCopy(SocietyCon))
            {

                FlatBillsData.DestinationTableName = "GeneratedBill";
                FlatBillsData.ColumnMappings.Add("FlatNumber", "FlatNumber");
                FlatBillsData.ColumnMappings.Add("BillID", "BillID");
                FlatBillsData.ColumnMappings.Add("CurrentBillAmount", "CurrentBillAmount");
                FlatBillsData.ColumnMappings.Add("CycleType", "CycleType");
                FlatBillsData.ColumnMappings.Add("PaymentDueDate", "PaymentDueDate");
                FlatBillsData.ColumnMappings.Add("BillMonth", "BillMonth");
                FlatBillsData.ColumnMappings.Add("PreviousMonthBalance", "PreviousMonthBalance");
                FlatBillsData.ColumnMappings.Add("AmountPaidDate", "AmountPaidDate");
                FlatBillsData.ColumnMappings.Add("AmountPaid", "AmountPaid");
                FlatBillsData.ColumnMappings.Add("PaymentMode", "PaymentMode");
                FlatBillsData.ColumnMappings.Add("TransactionID", "TransactionID");
                FlatBillsData.ColumnMappings.Add("InvoiceID", "InvoiceID");
                FlatBillsData.ColumnMappings.Add("ModifiedAt", "ModifiedAt");
                FlatBillsData.ColumnMappings.Add("BillDescription", "BillDescription");
                FlatBillsData.ColumnMappings.Add("BillStartDate", "BillStartDate");
                FlatBillsData.ColumnMappings.Add("BillEndDate", "BillEndDate");

                FlatBillsData.WriteToServer(tempBillCycle);
            }

            SocietyCon.Close();
        }

    }

    public int GetSingleValueBillCycle(int billID)
    {
        DataAccess dacess = new DataAccess();
        String GetBillQuery = "Select count(FlatID) from " + Table_Name + " where Cyclestart != CycleEnd and CycleEnd >= getdate() and  BillID =" + billID + "";
        int UserID = dacess.GetSingleUserValue(GetBillQuery);
        return UserID;
    }

    public bool UpdateDeactiveBill(DateTime DeactivationDate, int BillID, string FlatNumber)
    {
        DataAccess dacess = new DataAccess();
        String deactivatePlan = "update " + Table_Name + " set CycleEnd = '" + DeactivationDate + "'  where BillID = '" + BillID + "' and FlatID = '" + FlatNumber + "'";
        bool result = dacess.Update(deactivatePlan);
        return result;
    }

   

    public List<string> GetFlatNumber(string FlatNumber)
    {
        List<string> Emp = new List<string>();
        string query = string.Format("select distinct FlatNumber from " + ViewName + " where FlatNumber like '" + FlatNumber + "%' order by FlatNumber asc");
        using (SqlConnection con = new SqlConnection(Utility.SocietyConnectionString))
        {
            con.Open();
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    Emp.Add(reader.GetString(0));

                }
            }
        }
        return Emp;
    }

    public int GetFlatID(string FlatNumber)
    {
        DataAccess dacess = new DataAccess();
        String FlatExistCheckQuery = "Select ID from dbo.Flats where FlatNumber ='" + FlatNumber + "'";
        int ID = dacess.GetSingleValue(FlatExistCheckQuery);
        return ID;
    }

    public int GetFlatIDCount(string lablID)
    {
        DataAccess dacess = new DataAccess();
        String CountQuery = "select count (FlatID) as count from  " + ViewName + " where Cyclestart != CycleEnd and CycleEnd >= getdate() and  BillID ='" + lablID + "'";
        int Count = dacess.GetSingleValue(CountQuery);
        return Count;
    }
}