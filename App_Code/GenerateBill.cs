using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for GenerateBill
/// </summary>
public class GenerateBill
{
    public int PayID;
    public int FlatID;
    public int SocietyBillID;
    //public String FlatNumber;
    public int BillTypeID;
    public int ResID;

    public int CurrentBillAmount { get; set; }
    public String CycleType;
    public DateTime PaymentDueDate;
    public int AmountTobePaid;
    public int PreviousMonthBalance { get; set; }
    public DateTime AmountPaidDate;
    public int AmountPaid;
    public String PaymentMode;
    public String TransactionID;
    public String InvoiceID;
    public int CurrentMonthBalance;
    public DateTime ModifiedAt;
    public String BillDescription;
    public DateTime BillStartDate { get; set; }
    public DateTime BillEndDate { get; set; }
    public DateTime BillMonth;
    public int SocietyID;
    public String ActionType;
    public int Activated;

    public int op_Applyto;
    public String op_BillType { get; set; }
    public string op_AmountPaidDate;
    public DateTime op_CycleStartDate;
    public DateTime op_CycleEndDate;
    public String op_ChargeType;
    public Double op_Rate;
    public int op_FlatArea;
    public int op_Days;
    public String op_FlatNumber { get; set; }




    public GenerateBill()
    {
        //
        // TODO: Add constructor logic here
        //
    }


}