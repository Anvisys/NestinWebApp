using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for GeneratedBillController
/// </summary>
public class GeneratedBillController
{
    public GeneratedBillController()
    {
        //
        // TODO: Add constructor logic here
        //
    }




    public void AddBill(GenerateBill previousBill, String GenerateCycle)
    {
        GenerateBill newBill = new GenerateBill();
        // String GenerateCycle = "";
        DateTime newstartdate = previousBill.BillEndDate.AddDays(1);
        int day = previousBill.op_CycleEndDate.Day;

        if (GenerateCycle == "Manual")
        {
            newBill.BillEndDate = new DateTime(Utility.GetCurrentDateTimeinUTC().Year, Utility.GetCurrentDateTimeinUTC().Month, day);

        }

        else if (GenerateCycle == "Auto")
        {
            if (newBill.CycleType == "Yearly")
            {
                newBill.BillEndDate = newBill.BillStartDate.AddYears(1);
            }

            else if (newBill.CycleType == "Quaterly")
            {
                newBill.BillEndDate = newBill.BillStartDate.AddMonths(3);

            }

            else if (newBill.CycleType == "Monthly")
            {
                DateTime newEndDate = newBill.BillStartDate.AddMonths(1);

            }

        }

        int days = Utility.GetDifferenceinDays(newBill.BillStartDate, newBill.BillEndDate);
        DateTime DueDate = newBill.BillEndDate.AddDays(7);


        if (newBill.BillEndDate.Year != Utility.GetCurrentDateTimeinUTC().Year && newBill.BillEndDate.Month != Utility.GetCurrentDateTimeinUTC().Month)
        {
            days = 0;
        }


        if (days != 0)
        {

            Double Amount = 1;


            if (newBill.op_ChargeType == "Fixed")
            {
                Amount = Convert.ToDouble(newBill.op_Rate);

                if (newBill.CycleType == "Monthly")
                {
                    Amount = Convert.ToDouble(newBill.op_Rate) / 30 * days;
                }
                else if (newBill.CycleType == "Yearly")
                {
                    Amount = Convert.ToDouble(newBill.op_Rate) / 365 * days;

                }
            }

            if (newBill.op_ChargeType == "Rate")
            {
                if (newBill.CycleType == "Monthly")
                {
                    Amount = Amount = Convert.ToDouble(newBill.op_Rate) * Convert.ToDouble(newBill.op_FlatArea) / 30 * days;
                }
                else if (newBill.CycleType == "Yearly")
                {
                    Amount = Amount = Convert.ToDouble(newBill.op_Rate) * Convert.ToDouble(newBill.op_FlatArea) / 365 * days;

                }
            }
            if (newBill.op_ChargeType == "Mannual")
            {
                Amount = 0;
            }


            Amount = Math.Round(Amount, 2);


            newBill.ModifiedAt = Utility.GetCurrentDateTimeinUTC();

            newBill.PreviousMonthBalance = previousBill.CurrentMonthBalance;

            // insert Query
        }
        else
        {

        }
    }


    public  List<GenerateBill> GetLatestBills(int BillTypeID, int SocietyID)
    {
        List<GenerateBill> listGeneratedBill = new List<GenerateBill>();
        try
        {
            DataAccess dacess = new DataAccess();
         
            String LatestBill = "Select * from " + CONSTANTS.View_LatestFlatBill + " where BillTypeID = '" + BillTypeID + "' and SocietyID = '" + SocietyID + "'";

            DataSet FlatsData = dacess.ReadData(LatestBill);

            if (FlatsData != null)
            {
                DataTable dataBills = FlatsData.Tables[0];

                for (int i = 0; i < dataBills.Rows.Count; i++)
                {
                    GenerateBill LastBill = new GenerateBill();
                    LastBill.PayID = Convert.ToInt32(dataBills.Rows[i]["PayID"]);
                    LastBill.FlatID = Convert.ToInt32(dataBills.Rows[i]["FlatID"].ToString());
                    LastBill.op_FlatNumber = dataBills.Rows[i]["FlatNumber"].ToString();
                    LastBill.op_FlatArea = Convert.ToInt32(dataBills.Rows[i]["FlatArea"]);
                    LastBill.op_ChargeType = dataBills.Rows[i]["ChargeType"].ToString();
                    LastBill.CycleType = dataBills.Rows[i]["CycleType"].ToString();
                    LastBill.op_Rate = Convert.ToDouble(dataBills.Rows[i]["Rate"]);
                    if (LastBill.PayID > 0)
                    {
                        LastBill.BillStartDate = Convert.ToDateTime(dataBills.Rows[i]["BillStartDate"]);
                        LastBill.BillEndDate = Convert.ToDateTime(dataBills.Rows[i]["BillEndDate"]);
                    }
                    else
                    {
                        DateTime FlatAddDate = Convert.ToDateTime(dataBills.Rows[i]["FlatAddDate"]);
                        DateTime BillPlanDate = Convert.ToDateTime(dataBills.Rows[i]["BillPlanDate"]);

                        LastBill.BillStartDate = FlatAddDate > BillPlanDate ? FlatAddDate : BillPlanDate;
                        LastBill.BillEndDate = FlatAddDate > BillPlanDate ? FlatAddDate : BillPlanDate;
                    }
                    LastBill.op_Applyto = Convert.ToInt32(dataBills.Rows[i]["Applyto"]);
                    LastBill.Activated = Convert.ToInt32(dataBills.Rows[i]["Activated"]);
                    LastBill.SocietyBillID = Convert.ToInt32(dataBills.Rows[i]["SocietyBillID"]);
                    LastBill.CurrentMonthBalance = Convert.ToInt32(dataBills.Rows[i]["CurrentMonthBalance"]);
                    listGeneratedBill.Add(LastBill);
                }

            }

            return listGeneratedBill;
        }

        catch (Exception ex)
        {

            return null;
        }

    }
}