using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using System.Data.SqlClient;


/// <summary>
/// Summary description for Bill
/// </summary>
public class Bill
{

    private static String TableName = "dbo.GeneratedBill";
   // private static String ViewName = "dbo.ViewLatestGeneratedBill";
   // private static String ViewName = "dbo.ViewLatestGeneratedBill_Resident";
    private static String ViewName = "dbo.viewLatestFlatBill";
    



    public Bill()
    {
        //
        // TODO: Add constructor logic here
    }

    private static DataSet ReadData(String FlatNumber)
    {

        DataAccess dacess = new DataAccess();
        String BillTypeQuery = "Select FlatID,FlatArea,BillID,BillType,ChargeType,CycleType,DueDay,Rate,CurrentBalance from " + ViewName + " where FlatNumber ='" +FlatNumber +"'";
        DataSet BillTypeData = dacess.ReadData(BillTypeQuery);
        return BillTypeData;
    }

    private static void AddFlat()
    {
    }

    public static DataSet GetSocietyBillTypes() {
        string BillTypeQuery = "Select * from dbo.lukBillType";
        DataAccess dacess = new DataAccess();
        return dacess.GetData(BillTypeQuery);
    }


    public DataSet GetActivatedBill(string BillStatus, string BillType, string FlatNumber)
    {
        String BillStatusCondition = "", FlatCondition, BillCondition;

        if (BillStatus == "Active")
        {
            BillStatusCondition = " and CycleStart <= GETDATE()+1  and GETDATE() < CycleEnD";

        }
        else if (BillStatus == "DeActive")
        {
            BillStatusCondition = " and GETDATE() >= CycleEnD and CycleEnD != CycleStart";

        }
        else if (BillStatus == "InActive")
        {
            BillStatusCondition = " and CycleStart = CycleEnD";

        }
        else if (BillStatus == "Show All")
        {
            BillStatusCondition = "";
        }

        if (FlatNumber == "")
        {

            FlatCondition = " FlatID is not null";
        }
        else
        {
            FlatCondition = " FlatID = '" + FlatNumber + "'";
        }

        if (BillType == "Show All")
        {

            BillCondition = " BillType is not null";
        }
        else
        {
            BillCondition = " BillType = '" + BillType + "'";
        }

        //Added by Aarshi on 14 - Sept - 2017 for bug fix
        String BillGenQuery = "select * from " + ViewName + "  Where ((ApplyTo = 0 and Activated = 1) or ApplyTo = 1) and " + FlatCondition + " and " + BillCondition;// + BillStatusCondition;
        //  BillGenQuery += " Select Count(*) FROM " + ViewName + " WHERE CycleStart <= GETDATE()+1  and GETDATE() < CycleEnD";
        //  BillGenQuery += " Select Count(*) FROM " + ViewName + " WHERE GETDATE() >= CycleEnD and CycleEnD != CycleStart";
        //  BillGenQuery += " Select Count(*) FROM " + ViewName + " WHERE CycleStart = CycleEnD";


        DataAccess dacess = new DataAccess();
        DataSet dsActivatedBill = dacess.GetData(BillGenQuery);
        return dsActivatedBill;
    }


    public DataSet GetDeActivatedBill(string BillStatus, string BillType, string FlatNumber)
    {
        String BillStatusCondition = "", FlatCondition, BillCondition;

        if (FlatNumber == "")
        {

            FlatCondition = " FlatID is not null";
        }
        else
        {
            FlatCondition = " FlatID = '" + FlatNumber + "'";
        }

        if (BillType == "Show All")
        {

            BillCondition = " BillType is not null";
        }
        else
        {
            BillCondition = " BillType = '" + BillType + "'";
        }


        //Added by Aarshi on 14 - Sept - 2017 for bug fix
        String BillGenQuery = "select * from " + ViewName + "  Where (ApplyTo = 0 and Activated != 1) and " + FlatCondition + " and " + BillCondition;// + BillStatusCondition;
        //  BillGenQuery += " Select Count(*) FROM " + ViewName + " WHERE CycleStart <= GETDATE()+1  and GETDATE() < CycleEnD";
        //  BillGenQuery += " Select Count(*) FROM " + ViewName + " WHERE GETDATE() >= CycleEnD and CycleEnD != CycleStart";
        //  BillGenQuery += " Select Count(*) FROM " + ViewName + " WHERE CycleStart = CycleEnD";



        DataAccess dacess = new DataAccess();
        DataSet dsActivatedBill = dacess.GetData(BillGenQuery);
        return dsActivatedBill;
    }

    private static void AddFlatBillCycle(int BillID, int ApplyTo)
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

            FlatBillsData.DestinationTableName = "aBillCycle";
            FlatBillsData.ColumnMappings.Add("FlatNumber", "FlatID");
            FlatBillsData.ColumnMappings.Add("BillID", "BillID");
            FlatBillsData.ColumnMappings.Add("CycleStart", "CycleStart");
            FlatBillsData.ColumnMappings.Add("CycleEnD", "CycleEnD");

            FlatBillsData.WriteToServer(tempBillCycle);
        }
        SocietyCon.Close();


    }

   
    public static bool AddSocietyBillPlan(String BillType, String ChargeType, String Rate, String CycleType, int Applyto)
    {
        DataAccess dacess = new DataAccess();
        String BillingQuery = "Insert into dbo.aSocietybillplans(BillType,ChargeType,Rate,CycleType,Applyto) Values('" + BillType + "','" + ChargeType + "','" + Rate + "','" + CycleType + "','" + Applyto + "')";
        bool result = dacess.Update(BillingQuery);

        if (result == true)
        {
            String GetBillIDQuery = "Select BillID  ,Applyto from dbo.aSocietybillplans  where BillType = '" + BillType + "' ";
            DataSet data = dacess.ReadData(GetBillIDQuery);
            DataTable dta = data.Tables[0];

            int BillId = Convert.ToInt32(dta.Rows[0]["BillID"]);
            int ApplyTO = Convert.ToInt32(dta.Rows[0]["Applyto"]);
            AddFlatBillCycle(BillId, ApplyTO);

        }

        return result;
    }

    public DataSet GetLatestBills(String FlatNumber, String BillType,string StartDate, string EndDate)//Added by Aarshi on 13-Sept-2017 for bug fix
    {
        try
        {
            //Added by Aarshi on 13-Sept-2017 for bug fix
            String LatestBillGenQuery = "";

            String FlatCond, BillTypeCond, DateCond = "";

            if (FlatNumber != "")
            {
                FlatCond = "FlatNumber = '" + FlatNumber + "'";
            }

            else
            {
                FlatCond = "FlatNumber is not null";
            }

            if (BillType != "Show All")
            {
                BillTypeCond = "BillType = '" + BillType + "'";
            }
            else
            {
                BillTypeCond = "BillType is not null";
            }

            if (StartDate != string.Empty && EndDate != string.Empty)
            {
                DateCond = "CAST(BillStartDate AS DATE) >= '" + StartDate + "' and CAST(BillEndDate AS DATE) <= '" + EndDate + "'";
            }
            else
            {
                DateCond = "BillStartDate is not null and BillEndDate is not null";
            }

            //Added by Aarshi on 21-Sept-2017 for bug fix
            LatestBillGenQuery = "select * from " + ViewName + " where ((ApplyTo = 0 and Activated = 1) or ApplyTo = 1) and " + FlatCond + " and " + BillTypeCond + " and " + DateCond;
            //Ends here

           
              

            DataAccess dacess = new DataAccess();
            return dacess.GetData(LatestBillGenQuery);
            
        }       

        catch (Exception ex)
        {
            return null;
        }
    }

    public static BillPlan GetSocietyBillPlan(String Query, String BillType)
    {
        DataAccess dacess = new DataAccess();
        BillPlan plan = new BillPlan();
        DataSet ds = dacess.ReadData(Query);
        DataTable dt = ds.Tables[0];
        plan.ChargeType = dt.Rows[0]["CycleType"].ToString();
        plan.Rate = dt.Rows[0]["Rate"].ToString();
        plan.BillID = Convert.ToInt32(dt.Rows[0]["BillID"]);
        plan.ChargeType = dt.Rows[0]["ChargeType"].ToString();
        plan.Applyto = Convert.ToInt32(dt.Rows[0]["Applyto"]);
        return plan;

    }

  

    public static String CalculateBillingDays(DateTime PreviousBillEndDate, DateTime CycleEndDate, String CycleType)
    {
        String GenerateCycle = "";
        if (GenerateCycle == "Manual")
        {

            DateTime newstartdate = PreviousBillEndDate.AddDays(1);
            int day = CycleEndDate.Day;
            DateTime newEndDate = new DateTime(Utility.GetCurrentDateTimeinUTC().Year, Utility.GetCurrentDateTimeinUTC().Month, day);
            int days = Utility.GetDifferenceinDays(newstartdate, newEndDate);


        }
        else if (GenerateCycle == "Auto")
        {
            if (CycleType == "Yearly")
            {
                DateTime newstartdate = PreviousBillEndDate.AddDays(1);
                int day = CycleEndDate.Day;
                DateTime newEndDate = newstartdate.AddYears(1);
                int days = Utility.GetDifferenceinDays(newstartdate, newEndDate);
                DateTime DueDate = newEndDate.AddDays(7);

                if (newEndDate.Year != Utility.GetCurrentDateTimeinUTC().Year && newEndDate.Month != Utility.GetCurrentDateTimeinUTC().Month)
                {
                    days = 0;
                }

            }

            else if (CycleType == "Quaterly")
            {
                DateTime newstartdate = PreviousBillEndDate.AddDays(1);
                int day = CycleEndDate.Day;

                DateTime newEndDate = newstartdate.AddMonths(3);
                int days = Utility.GetDifferenceinDays(newstartdate, newEndDate);
                DateTime DueDate = newEndDate.AddDays(7);

                if (newEndDate.Year != Utility.GetCurrentDateTimeinUTC().Year && newEndDate.Month != Utility.GetCurrentDateTimeinUTC().Month)
                {
                    days = 0;
                }

            }

            else if (CycleType == "Monthly")
            {
                DateTime newstartdate = PreviousBillEndDate.AddDays(1);
                int day = CycleEndDate.Day;
                DateTime newEndDate = new DateTime(Utility.GetCurrentDateTimeinUTC().Year, Utility.GetCurrentDateTimeinUTC().Month, day);
                int days = Utility.GetDifferenceinDays(newstartdate, newEndDate);
                DateTime DueDate = newEndDate.AddDays(7);
           }

        }

       return "";
    }

    public static GenerateBill CalculateNewBill(int FlatArea, String BillType, String ChargeType, String CycleType, Double Rate, int days)
    {
        GenerateBill bill = new GenerateBill();
        Double Amount = 1;


        if (ChargeType == "Fixed")
        {
            Amount = Convert.ToDouble(Rate);

            if (CycleType == "Monthly")
            {
                Amount = Convert.ToDouble(Rate) / 30 * days;
            }
            else if (CycleType == "Yearly")
            {
                Amount = Convert.ToDouble(Rate) / 365 * days;

            }
        }

        if (ChargeType == "Rate")
        {
            if (CycleType == "Monthly")
            {
                Amount = Amount = Convert.ToDouble(Rate) * Convert.ToDouble(FlatArea) / 30 * days;
            }
            else if (CycleType == "Yearly")
            {
                Amount = Amount = Convert.ToDouble(Rate) * Convert.ToDouble(FlatArea) / 365 * days;

            }
        }
        if (ChargeType == "Mannual")
        {
            Amount = 0;
        }


        Amount = Math.Round(Amount, 2);


        bill.ModifiedAt = Utility.GetCurrentDateTimeinUTC();

        String CurrentMonth = String.Format("{0:y}", DateTime.Now);
        DateTime Date = Convert.ToDateTime(CurrentMonth);

        DateTime EarlierMonth = Date.AddMonths(-1);

        string PrevMonth = String.Format("{0:y}", EarlierMonth);


        bill.PreviousMonthBalance = 0;
        bill.ModifiedAt = Utility.GetCurrentDateTimeinUTC();
        bill.PaymentDueDate = Utility.GetCurrentDateTimeinUTC().AddDays(15);
        bill.BillMonth = Utility.GetCurrentDateTimeinUTC().AddDays(-15);
        //bill.CurrentAmount = (int)(Amount + 05d);
        return bill;

    }




    public bool InsertNewBill(GenerateBill newBill)
    {
        try
        {
            DataAccess dacess = new DataAccess();

            String Generatebill = "Insert into " + TableName + "(FlatID,SocietyBillID ,ActionType ,BillStartDate,BillEndDate,CurrentBillAmount,CycleType,PaymentDueDate,BillMonth,PreviousMonthBalance,AmountPaidDate,ModifiedAt,BillDescription, SocietyID ) Values("
                + newBill.FlatID + "," + newBill.SocietyBillID +",'"+newBill.ActionType+ "','" + DateString(newBill.BillStartDate ,true) + "','" + DateString(newBill.BillEndDate, true) + "'," + newBill.CurrentBillAmount + ",'" + newBill.CycleType + "','" + DateString(newBill.PaymentDueDate ,false) + "','" + DateString(newBill.BillMonth ,false) + "'," + newBill.PreviousMonthBalance + ",'"+DateString(newBill.AmountPaidDate ,true)+"','" + DateString(newBill.ModifiedAt ,true) + "','" + newBill.BillDescription +"'," + SessionVariables.SocietyID + ")";

            return dacess.Update(Generatebill);
        }
        catch(Exception ex)
        {
            return false;
        }
        
    }

    private string DateString(DateTime dateTime ,bool cond)
    {
        string date;
        
            date = dateTime.ToString("yyyy-MM-dd");
        
        return (date);
    }

    public static int oldInsertFirstZeroBill(String FlatNumber, int BillID, String CycleType, String CycleStart)
    {
        GenerateBill emptyBill = new GenerateBill();
        emptyBill.op_FlatNumber = FlatNumber;
        emptyBill.SocietyBillID = BillID;
        emptyBill.CurrentBillAmount = 0;
        emptyBill.CycleType = CycleType;
        emptyBill.PaymentDueDate = Convert.ToDateTime(CycleStart).AddDays(7);
        emptyBill.BillMonth = Convert.ToDateTime(CycleStart);
        emptyBill.PreviousMonthBalance = 0;
        emptyBill.ModifiedAt = Utility.GetCurrentDateTimeinUTC();
        emptyBill.BillDescription = "First Empty Bill";
        emptyBill.BillStartDate = Convert.ToDateTime(CycleStart).AddDays(-1);
        emptyBill.BillEndDate = Convert.ToDateTime(CycleStart).AddDays(-1);
        int count = 0;
        DataAccess dacess = new DataAccess();

        String Generatebill = "Insert into dbo.GeneratedBill(FlatNumber,BillID,BillStartDate,BillEndDate,CurrentBillAmount,CycleType,PaymentDueDate,BillMonth,PreviousMonthBalance,ModifiedAt,BillDescription, SocietyID) Values('" 
            + emptyBill.op_FlatNumber + "','" + emptyBill.SocietyBillID + "','" + emptyBill.BillStartDate + "','" + emptyBill.BillEndDate + "','" + emptyBill.CurrentBillAmount + "','" + emptyBill.CycleType + "','" + emptyBill.PaymentDueDate + "','" + emptyBill.BillMonth 
            + "','" + emptyBill.PreviousMonthBalance + "','" + emptyBill.ModifiedAt + "','" + emptyBill.BillDescription + "','" + SessionVariables.SocietyID + "')";
        bool result = dacess.Update(Generatebill);

        if (result == true)
        {
            count = 1;
        }

        return count;
    }



    public static DataSet GetGenerateBillType()
    {
        try
        {
            DataAccess dacess = new DataAccess();
            String FillBillType = "Select distinct BillType,BillID from SocietyBillplans where ChargeType != 'Manual'";
            return dacess.ReadData(FillBillType);
        }
#pragma warning disable 0168
        catch (Exception ex)
        {

            return null;
        }
#pragma warning restore 0168

    }

    public bool UpdatePayment(int PayID, int Amount, string mode, int TransactionID, int paid)
    {
        try
        {
            DataAccess dacess = new DataAccess();
            DateTime currentDate = DateTime.UtcNow;
            String PayManuual = "";
            if (paid == 0)
            {
                PayManuual = "Update " + TableName + " set AmountPaid =  '" + Amount + "', AmountPaidDate =GetUTCDate() , PaymentMode ='" + mode +
                                    "' ,TransactionID ='" + TransactionID + "' ,InvoiceID = '" + PayID + "'  where PayID = '" + PayID + "'";
            }
            else {
                PayManuual = "INSERT INTO dbo.GeneratedBill (FlatNumber, BillID, CurrentBillAmount, CycleType, PaymentDueDate, PreviousMonthBalance,AmountPaidDate,AmountPaid,PaymentMode, TransactionID, InvoiceID,"+
                             "ModifiedAt, BillDescription, BillStartDate, BillEndDate,BillMonth, SocietyID)"+
                            "SELECT FlatNumber, BillID, CurrentMonthBalance, CycleType, PaymentDueDate, 0, GetUTCDate(), " + Amount + " , "+ mode + ", "+TransactionID+ ", InvoiceID,"+
                            " ModifiedAt, BillDescription, BillStartDate, BillEndDate, BillMonth, SocietyID"+
                              "FROM  dbo.GeneratedBill WHERE  PayID = " + PayID;
            }
            return dacess.Update(PayManuual);
        }
#pragma warning disable 0168
        catch (Exception ex)
        {

            return false;
        }
#pragma warning restore 0168


        
    }


    public bool InsertNewBillPay(GenerateBill newBill)
    {
        try
        {
            DataAccess dacess = new DataAccess();
            String Generatebill = "Insert into " + TableName 
                                + "(FlatID,ActionType,Activated,SocietyBillID,BillStartDate,BillEndDate,CurrentBillAmount,CycleType,PaymentDueDate,BillMonth,PreviousMonthBalance,AmountPaidDate,AmountPaid,PaymentMode,TransactionID,InvoiceID,ModifiedAt,BillDescription,SocietyID) Values('"
                                   + newBill.FlatID + "','" + newBill.ActionType + "','" + newBill.Activated + "','" + newBill.SocietyBillID + "','" + DateString(newBill.BillStartDate,true) + "','" + DateString(newBill.BillEndDate,true) + "','" + newBill.CurrentBillAmount+"','"+newBill.CycleType+ "','"+ DateString(newBill.PaymentDueDate,true) + "','"+ DateString(newBill.BillMonth,true)+ "','" 
                                   + newBill.PreviousMonthBalance + "','" + DateString(newBill.AmountPaidDate,true) + "','" + newBill.AmountPaid+ "','" + newBill.PaymentMode+ "','" + newBill.TransactionID + "','" + newBill.InvoiceID + "','" + DateString(newBill.ModifiedAt,true) + "','" + newBill.BillDescription + "'," + SessionVariables.SocietyID + ")";
            return dacess.Update(Generatebill);
        }


        catch
        {
            return false;
        }

    }

    private void CalculateBalance()
    {

    }

    private void GetBillForFlat(String FlatID)
    {

    }



    public static GenerateBill CalculateNewBill(GenerateBill previousBill, String GenerateCycle, DateTime BillingDate)
    {
        GenerateBill newBill = new GenerateBill();
        int days = 0;
        double BillAmount=0;

        newBill.BillStartDate = previousBill.BillEndDate.AddDays(1);


        if (GenerateCycle == "Manual")
        {
            newBill.BillDescription = "Manually Generated";
            if (BillingDate != null)
            {
                newBill.BillEndDate = BillingDate;
                days = Utility.GetDifferenceinDays(newBill.BillStartDate, newBill.BillEndDate);
            }

        }

        else if (GenerateCycle == "Auto")
        {
            newBill.BillDescription = "Auto Generated";
            if (previousBill.CycleType == "Yearly")
            {
                newBill.BillEndDate = newBill.BillStartDate.AddYears(1);


            }

            else if (previousBill.CycleType == "Quaterly")
            {
                newBill.BillEndDate = newBill.BillStartDate.AddMonths(3);

            }

            else if (previousBill.CycleType == "Monthly")
            {
                newBill.BillEndDate = newBill.BillStartDate.AddMonths(1);

            }


            //Why we have this logic, it gives 0 days if I could not create Bill in December and doing that in Jan next year. Amit 8/02/2018
            // Hence commenting this as of now.
            //if (newBill.BillEndDate.Year != Utility.GetCurrentDateTimeinUTC().Year || newBill.BillEndDate.Month != Utility.GetCurrentDateTimeinUTC().Month)
            //{
            //    days = 0;
            //}
            //else
            //{
            //    days = Utility.GetDifferenceinDays(newBill.BillStartDate, newBill.BillEndDate);
            //}

            days = Utility.GetDifferenceinDays(newBill.BillStartDate, newBill.BillEndDate);
        }
        // End Date should not be greater than Cycle End Date code to be added



        if (days > 0)
        {

            newBill.PaymentDueDate = newBill.BillEndDate.AddDays(7);

            if (previousBill.op_ChargeType == "Fixed")
            {

                if (previousBill.CycleType == "Monthly")
                {
                    BillAmount = Convert.ToDouble(previousBill.op_Rate) / 30 * days + 0.5d;
                }
                else if (previousBill.CycleType == "Quarterly")
                {
                    BillAmount = Convert.ToDouble(previousBill.op_Rate) / (30 * 3) * days;
                }
                else if (previousBill.CycleType == "Yearly")
                {
                    BillAmount = Convert.ToDouble(previousBill.op_Rate) / 365 * days;

                }
            }

            if (previousBill.op_ChargeType == "Rate")
            {
                if (previousBill.CycleType == "Monthly")
                {
                    BillAmount = Convert.ToDouble(previousBill.op_Rate) * Convert.ToDouble(previousBill.op_FlatArea) / 30 * days;
                }

                else if (previousBill.CycleType == "Quarterly")
                {
                    BillAmount = Convert.ToDouble(previousBill.op_Rate) * Convert.ToDouble(previousBill.op_Rate) / (30 * 3) * days;
                }

                else if (previousBill.CycleType == "Yearly")
                {
                    BillAmount = Convert.ToDouble(previousBill.op_Rate) * Convert.ToDouble(previousBill.op_FlatArea) / 365 * days;

                }
            }
            if (previousBill.op_ChargeType == "Manual")
            {
                BillAmount = 0;
            }

        }

        newBill.op_Days = days;
        newBill.SocietyBillID = previousBill.SocietyBillID;
        newBill.op_FlatArea = previousBill.op_FlatArea;
        newBill.op_ChargeType = previousBill.op_ChargeType;
        newBill.CurrentBillAmount = (int)(BillAmount + 0.5d);
        newBill.ModifiedAt = Utility.GetCurrentDateTimeinUTC();
        newBill.PreviousMonthBalance = previousBill.CurrentMonthBalance;
        newBill.op_FlatNumber = previousBill.op_FlatNumber;
        newBill.CycleType = previousBill.CycleType;
        newBill.BillMonth = newBill.BillEndDate;
        newBill.op_Rate = previousBill.op_Rate;
        return newBill;
    }


    public static GenerateBill GetLastGeneratedBill(String FlatNumber, String BillType)
    {
        try
        {
            DataAccess dacess = new DataAccess();
            GenerateBill LastBill = new GenerateBill();

            String FlatsForBillType = "Select * from "+ ViewName +" where BillTYpe = '" + BillType + "' and FlatNumber = '" + FlatNumber + "'";

            DataSet FlatsData = dacess.ReadData(FlatsForBillType);

            if (FlatsData != null)
            {
                DataTable dataBills = FlatsData.Tables[0];

                for (int i = 0; i < dataBills.Rows.Count; i++)
                {
                    GenerateBill previousBill = new GenerateBill();
                    LastBill.op_FlatNumber = dataBills.Rows[i]["FlatNumber"].ToString();
                    LastBill.op_FlatArea = Convert.ToInt32(dataBills.Rows[i]["FlatArea"]);
                    LastBill.op_ChargeType = dataBills.Rows[i]["ChargeType"].ToString();
                    LastBill.CycleType = dataBills.Rows[i]["CycleType"].ToString();
                    LastBill.op_Rate = Convert.ToDouble(dataBills.Rows[i]["Rate"]);
                    LastBill.BillStartDate = Convert.ToDateTime(dataBills.Rows[i]["BillStartDate"]);
                    LastBill.BillEndDate = Convert.ToDateTime(dataBills.Rows[i]["BillEndDate"]);
                    LastBill.SocietyBillID = Convert.ToInt32(dataBills.Rows[i]["SocietyBillID"]);
                    LastBill.CurrentMonthBalance = Convert.ToInt32(dataBills.Rows[i]["CurrentMonthBalance"]);
                    // LastBill.CycleEndDate = Convert.ToDateTime(dataBills.Rows[i]["CycleEnD"]);
                }

            }

            return LastBill;
        }
#pragma warning disable 0168
        catch (Exception ex)
        {

            return null;
        }
#pragma warning restore 0168


    }

    public static GenerateBill GetLastGeneratedBill(String FlatNumber, int BillID)
    {
        try
        {
            DataAccess dacess = new DataAccess();
            GenerateBill LastBill = new GenerateBill();

            String FlatsForBillType = "Select * from "+ ViewName +" where BillID = '" + BillID + "' and FlatNumber = '" + FlatNumber + "'";

            DataSet FlatsData = dacess.ReadData(FlatsForBillType);

            if (FlatsData != null)
            {
                DataTable dataBills = FlatsData.Tables[0];

                for (int i = 0; i < dataBills.Rows.Count; i++)
                {
                    GenerateBill previousBill = new GenerateBill();
                    LastBill.op_FlatNumber = dataBills.Rows[i]["FlatNumber"].ToString();
                    LastBill.op_FlatArea = Convert.ToInt32(dataBills.Rows[i]["FlatArea"]);
                    LastBill.op_ChargeType = dataBills.Rows[i]["ChargeType"].ToString();
                    LastBill.CycleType = dataBills.Rows[i]["CycleType"].ToString();
                    LastBill.op_Rate = Convert.ToDouble(dataBills.Rows[i]["Rate"]);
                    LastBill.BillStartDate = Convert.ToDateTime(dataBills.Rows[i]["BillStartDate"]);
                    LastBill.BillEndDate = Convert.ToDateTime(dataBills.Rows[i]["BillEndDate"]);
                    LastBill.SocietyBillID = Convert.ToInt32(dataBills.Rows[i]["SocietyBillID"]);
                    LastBill.CurrentMonthBalance = Convert.ToInt32(dataBills.Rows[i]["CurrentMonthBalance"]);
                    // LastBill.CycleEndDate = Convert.ToDateTime(dataBills.Rows[i]["CycleEnD"]);
                }

            }

            return LastBill;
        }
       
#pragma warning disable 0168
        catch (Exception ex)
        {

            return null;
        }
#pragma warning restore 0168
    }

    public List<string> GetLatestFlatNumber(string FlatNumber)
    {
        List<string> Emp = new List<string>();
        string query = string.Format("select distinct FlatNumber from " + ViewName + " where FlatNumber like '" + FlatNumber + "%' order by Flatnumber asc");
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
}
