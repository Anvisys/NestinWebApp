﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Threading;
using System.IO;
using System.Data.OleDb;
using System.Configuration;
using System.Web.UI.HtmlControls;
using System.Text;

public partial class LatestBill : System.Web.UI.Page
{
    User muser;
    DataSet dsLatestBillData;
    static DataSet dsBillType;
   static GenerateBill previousBill = null;
    static GenerateBill newBill = null;
    Bill bill= null;
    protected void Page_Load(object sender, EventArgs e)
    {

        muser = SessionVariables.User;
        SessionVariables.CurrentPage = "LatestBill.aspx";
        if (muser == null)
        {

            Response.Redirect("Login.aspx");

        }

        if (!IsPostBack)
        {
            LoadBillTypeDropdown(drpCurrentBillType, drpGenBillForOnLatest);
            LoadLatestBillData();
            MultiView1.ActiveViewIndex = 0;
        }

       
    }

    #region CurrentBill
    
    public void CurrentBill()
    {
        //Added by Aarshi on 3 Aug 2017
        LoadBillTypeDropdown(drpCurrentBillType, drpGenBillForOnLatest);
        LoadLatestBillData();
        MultiView1.ActiveViewIndex = 0;
        
    }

    public void LoadLatestBillData(string cmdname="")
    {
        try
        {
            muser = (User)SessionVariables.User;
            String BillType = drpCurrentBillType.SelectedItem.Text;
            String FlatNumber = txtLatestFlatFilter.Text;
            int SocietyID = muser.currentResident.SocietyID;
            Bill bill = new Bill();
            GridView grd = new GridView() ;
            if (cmdname.Equals("History"))
            {
                dsLatestBillData = bill.GetLatestBills(FlatNumber, BillType, "", "");
                grd = GrdDetail;
                lblFlatNumbergrddetails.Text = dsLatestBillData.Tables[0].Rows[0].ItemArray[29].ToString();
                lblbilltypegrddetails.Text = dsLatestBillData.Tables[0].Rows[0].ItemArray[3].ToString();
                lblchargetypegrddetails.Text=dsLatestBillData.Tables[0].Rows[0].ItemArray[4].ToString();
                lblRategrddetails.Text = dsLatestBillData.Tables[0].Rows[0].ItemArray[6].ToString();

                MultiView1.ActiveViewIndex = 1;
            }
            else
            {
                dsLatestBillData = bill.GetLatestBills(FlatNumber, BillType, "", "");//Added by Aarshi on 13-Sept-2017 for bug fix
                grd = GridlatestBills;
            }

            if (dsLatestBillData != null && dsLatestBillData.Tables.Count > 0)
            {
                grd.DataSource = dsLatestBillData;
                grd.DataBind();

                lblLatestBillCount.Text = dsLatestBillData.Tables[0].Rows.Count.ToString();

                //GridlatestBills.Columns[5].Visible = false;
                //GridlatestBills.Columns[6].Visible = false;
                //GridlatestBills.Columns[7].Visible = false;
                //GridlatestBills.Columns[8].Visible = false;
            }
        }
        catch (Exception ex)
        {
            int a = 1;
        }
    }

    protected void btnGenerateLatestBill_Click(object sender, EventArgs e)
    {
        String BilltypeLatest = drpGenBillForOnLatest.SelectedItem.Text;
        GenerateBillPreview(BilltypeLatest);
    }

    protected void BillsUploadSubmit_Click(object sender, EventArgs e)
    {
        String strTime = Utility.GetCurrentDateTimeinUTC().ToLongTimeString();
        strTime = strTime.ToString().Replace(':', '-');
        string path = strTime + "-" + BillsUpload.PostedFile.FileName;
        String Extension = Path.GetExtension(BillsUpload.PostedFile.FileName);
        path = Server.MapPath(Path.Combine("~/Data/", path));
        BillsUpload.SaveAs(path);
        ImportBillsFromExcel(path, Extension);
    }

    public void ImportBillsFromExcel(String path, String Extension)
    {
        OleDbConnection Connection = null;
        try
        {
            String Connectionstring = String.Empty;

            switch (Extension)
            {
                case ".xls":

                    Connectionstring = ConfigurationManager.ConnectionStrings["Excel03ConString"].ConnectionString;
                    break;

                case ".xlsx":

                    Connectionstring = ConfigurationManager.ConnectionStrings["Excel07conString"].ConnectionString;
                    break;
            }

            Connectionstring = String.Format(Connectionstring, path);

            //Session["Path"] = path;
            //Added by Aarshi on 18 auh 2017 for session storage
            SessionVariables.Path = path;

            Connection = new OleDbConnection(Connectionstring);

            Connection.Open();

            String insertQuery = "select * from [Sheet1$]";

            OleDbDataAdapter adp = new OleDbDataAdapter(insertQuery, Connection);

            DataTable DataExcel = new DataTable();

            adp.Fill(DataExcel);
            //Session["ExcelData"] = DataExcel;
            //Added by Aarshi on 18 auh 2017 for session storage
            SessionVariables.ExcelData = DataExcel;
            //---------------------------------------------------------------------------New Entry Values------------------------------------------------------------------------------//


            //Changed by aarshi

            DataAccess dacess = new DataAccess();
            String PickDbData = "select * from dbo.Flats";

            DataSet dtFlatData = dacess.ReadData(PickDbData);
            DataTable DBFlatData = new DataTable();

            if (dtFlatData == null)
            {

            }
            else
            {
                DBFlatData = dtFlatData.Tables[0];
            }

            DataTable NewDataExcel = DataExcel.AsEnumerable().Where(ra => DBFlatData.AsEnumerable().Any(rb => rb.Field<string>("FlatNumber") 
                                   == ra.Field<string>("FlatNumber"))).CopyToDataTable();

            if (NewDataExcel.Rows.Count > 0)
            {

                DataTable tempBillCycle = new DataTable();
                tempBillCycle.Columns.Add("ID", typeof(int));
                tempBillCycle.Columns.Add("FlatNumber");
                tempBillCycle.Columns.Add("BillID", typeof(int));
                tempBillCycle.Columns.Add("PreviousEndDate", typeof(DateTime));
                tempBillCycle.Columns.Add("BillStartDate", typeof(DateTime));
                tempBillCycle.Columns.Add("BillEndDate", typeof(DateTime));
                tempBillCycle.Columns.Add("PreviousBalance", typeof(int));
                tempBillCycle.Columns.Add("CurrentBillAmount", typeof(int));

                foreach (DataRow ExcelRow in NewDataExcel.Rows)
                {
                    int ID = Convert.ToInt32(ExcelRow["ID"]);
                    String Flat = ExcelRow["FlatNumber"].ToString();
                    int BillID = Convert.ToInt32(ExcelRow["BillID"]);
                    GenerateBill LastBill = Bill.GetLastGeneratedBill(Flat, BillID);
                    DateTime PreviousEndDate = Convert.ToDateTime(LastBill.BillEndDate);
                    int PreviousBalance = Convert.ToInt32(LastBill.CurrentMonthBalance);
                    DateTime BillStartDate = Convert.ToDateTime(ExcelRow["BillStartDate"]);
                    DateTime BillEndDate = Convert.ToDateTime(ExcelRow["BillEndDate"]);
                    int CurrentBillAmount = Convert.ToInt32(ExcelRow["CurrentBillAmount"]);
                    tempBillCycle.Rows.Add(ID, Flat, BillID, PreviousEndDate, BillStartDate, BillEndDate, PreviousBalance, CurrentBillAmount);
                }

               
                SessionVariables.SocietyBillPlans = tempBillCycle;
      
                ImportNewRecordGrid.DataSource = tempBillCycle;
                ImportNewRecordGrid.DataBind();

              

                ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "PopupImportBill()", true);

            }

            else
            {
                //lblNewvalues.Visible = false;
                //NewValueScroll_Div.Visible = false;
            }
            //Ends here


        }
        catch (Exception ex)
        {
            //lblNewvalues.Visible = false;
            //NewValueScroll_Div.Visible = false;
            String message = ex.Message;
        }

        finally
        {
            if (Connection.State == ConnectionState.Open)
            {
                Connection.Close();
            }
            Connection = null;
        }
    }

    protected void searchLatestGenBill_Click(object sender, EventArgs e)
    {
        LoadLatestBillData();
    }

    protected void chckLatestBills_CheckedChanged(object sender, EventArgs e)
    {
        if (chckLatestBills.Checked)
        {
            GridlatestBills.Columns[5].Visible = true;
            GridlatestBills.Columns[6].Visible = true;

            GridlatestBills.Width = new Unit("90%");
        }
        else
        {

            GridlatestBills.Columns[5].Visible = false;
            GridlatestBills.Columns[6].Visible = false;
            GridlatestBills.Width = new Unit("90%");
        }



    }

    protected void linkLatestBill_Click(object sender, EventArgs e)
    {
       
      
        ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "CurrentBillClick()", true);

    }

    protected void GridlatestBills_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridlatestBills.PageIndex = e.NewPageIndex;

        String FlatNumber = txtLatestFlatFilter.Text;
        String BillType = drpCurrentBillType.SelectedItem.Text;

        if (FlatNumber != "" || BillType != "Select")
        {
            LoadLatestBillData();
        }

        else
        {
            LoadLatestBillData();
        }
    }

    protected void GridlatestBills_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            //GridViewRow row = GridlatestBills.SelectedRow;
            //btnBillPay.CommandArgument = row.RowIndex.ToString();

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = e.Row.DataItem as DataRowView;
                //DateTime BillDate = Convert.ToDateTime(drv["BillDate"].ToString());
                int Amount = Convert.ToInt32(drv["CurrentMonthBalance"].ToString());
                int Balance = Convert.ToInt32(drv["PreviousMonthBalance"].ToString());
                DateTime PaymentDate = Convert.ToDateTime(drv["PaymentDueDate"].ToString());
                int PayID = Convert.ToInt32(drv["PayID"].ToString());

                txtLatestFlatFilter.Text = drv["FlatNumber"].ToString();
                Button btnBillPay = (Button)e.Row.FindControl("btnBillPay");

                Button btnBillHistory = (Button)e.Row.FindControl("btnBillHistory");

                //if (Amount <= 0)
                //{
                //    e.Row.BackColor = System.Drawing.Color.White;
                //}
                //else if (Balance > 0)
                //{
                //    e.Row.BackColor = System.Drawing.Color.Salmon;
                //}

                //else if (DateTime.Compare(Utility.GetCurrentDateTimeinUTC(), BillDate) > 0 && DateTime.Compare(Utility.GetCurrentDateTimeinUTC(), PaymentDate) < 0 && Amount > 0)
                //{
                //    e.Row.BackColor = System.Drawing.Color.LightYellow;
                //}

                //else if (DateTime.Compare(Utility.GetCurrentDateTimeinUTC(), PaymentDate) > 0 && Amount > 0)
                //{
                //    e.Row.BackColor = System.Drawing.Color.Salmon;
                //}


                e.Row.ToolTip = (e.Row.DataItem as DataRowView)["BillDescription"].ToString();

                //TableCell statusCell = e.Row.Cells[15];
                //statusCell.Text = (e.Row.DataItem as DataRowView)["BillDescription"].ToString().Substring(0, 5) + "..";
                if (PayID == 0)
                {
                    btnBillPay.Visible = false;
                    btnBillHistory.Visible = false;
                }

            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void btnBillHistory_Click(object sender, EventArgs e)
    {
        string FlatNumber = HiddenFlatNumberHistory.Value;
        string BillType = HiddenBillTypeHistory.Value;
       String text =  HiddenGeneratedBillData.Value;

        //Added by Aarshi on 13-Sept-2017 for bug fix
        string StartDate = DateTime.Now.AddMonths(-2).ToString("yyyy-MM-dd");
        string EndDate = DateTime.Now.ToString("yyyy-MM-dd");

        MultiView1.ActiveViewIndex = 1;
        //OldLoadGeneratedBillData(FlatNumber, BillType, StartDate, EndDate);
        LoadBillTypeDropdown(drpGeneratedBillType);
        txtGenBillsFlatfilter.Text = FlatNumber;
        drpGeneratedBillType.Items.FindByText(BillType).Selected = true;

        txtStartDate.Text = StartDate;
        txtEndDate.Text = EndDate;
    }


    protected void btnLatestGenBill_Click(object sender, EventArgs e)
    {
        try
        {
            String Flat = HiddenFlatNumberHistory.Value;
            String BillType = HiddenBillTypeHistory.Value;

            DateTime CurrentBillEndDate = Utility.GetCurrentDateTimeinUTC();
            String GenerateCycle = "Manual";
            btnSingleFlatGenerate.Text = "Generate Bill";
            lblFlatNuber.Text = Flat;
            lblBillType.Text = BillType;



            previousBill = Bill.GetLastGeneratedBill(Flat, 0);

            if (previousBill != null)
            {
                newBill = Bill.CalculateNewBill(previousBill, GenerateCycle, CurrentBillEndDate,0);

                if (newBill.op_Days <= 0)
                {
                   
                    lblBillDuplicate.Text = "Bill is Already Generated";
                    //btnSingleFlatGenerate.BackColor = new System.Drawing.Color(#b3b3ff);
                    btnSingleFlatGenerate.Visible = false;
                }

                else
                {
                    lblBillDuplicate.Text = "";
                }

                lblFlatArea.Text = newBill.op_FlatArea.ToString();
                lblRate.Text = newBill.op_Rate.ToString();
                lblChargeType.Text = newBill.op_ChargeType;
                lblNewBillType.Text = BillType;
                lblFromDate.Text = newBill.BillStartDate.ToShortDateString();
                txtFlatBillAmt.Visible = true;
                txtFlatBillAmt.Text = newBill.CurrentBillAmount.ToString();
                txtBillDate.Text = newBill.BillEndDate.ToShortDateString();
                lblPreviousBalance.Text = newBill.PreviousMonthBalance.ToString();
                txtBillGenSingleFlatdesc.Text = string.Empty;//Added by Aarshi on 11-Sept-2017 for bug fix
            }
            else
            {
                lblBillDuplicate.Text = "Error retreiving previous Bill";
            }
            ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "ShowGenerateDeActivateBillForm()", true);
        }
        catch (Exception ex)
        {
            int a = 1;
        }

    }

    protected void btnpaymannual_Click(object sender, EventArgs e)
    {
        try
        {
            int paid = Convert.ToInt32(lblAmountPaid.Text);
            int Amount = Convert.ToInt32(txtAmt.Text);
            String mode = drpPayMode.SelectedValue.ToString();
            string TransID = txtTransaID.Text;
            string InvoiceID = txtInvID.Text;
            int FlatID = Convert.ToInt32(lblFlat.Text);
            string FlatNumber = lblFlatNuber.Text;
            int CurrentMonthBal = Convert.ToInt32(lblCurrentmonthbal.Text);

            GenerateBill genBill = new GenerateBill();
  
            genBill.AmountPaid = Amount;
            genBill.AmountPaidDate = DateTime.Now;
            genBill.BillDescription = "Payment";
            genBill.BillEndDate = DateTime.UtcNow;
            genBill.BillMonth = DateTime.UtcNow;
            genBill.BillTypeID = 5;
            genBill.BillStartDate = DateTime.UtcNow;
            genBill.CurrentBillAmount = 0;
            genBill.ActionType = "Payment";
            genBill.Activated = 1;
            genBill.CycleType = "Quaterly";
            genBill.FlatID = FlatID;
            genBill.op_FlatNumber = FlatNumber;
            genBill.InvoiceID = InvoiceID.ToString();
            genBill.ModifiedAt = DateTime.UtcNow;
            genBill.PaymentDueDate = DateTime.UtcNow;
            genBill.PaymentMode = mode;
            genBill.PreviousMonthBalance = 0;
            string s = lblsocietybillid.Text;
            genBill.SocietyID = SessionVariables.SocietyID;
            genBill.SocietyBillID = Convert.ToInt32(s);
            genBill.TransactionID = TransID.ToString();
            genBill.CurrentMonthBalance = CurrentMonthBal;

            genBill.op_BillType = "";

            Bill bill = new Bill();

            bool result = bill.InsertNewBillPay(genBill);

          //  Bill bill = new Bill();
           // bool result = bill.UpdatePayment(InvoiceID, Amount, mode, TransID, paid);                //bool result = true;

            if (result)
            {
                MultiView1.ActiveViewIndex = 0;
                LoadLatestBillData();
                ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "alert('Payment updated successfully')", true);

                Button btn = new Button();
                string arg = btn.CommandArgument;
                GridlatestBills.Rows[Convert.ToInt32(arg)].Dispose();

            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "alert('Payment failed')", true);
            }

            //Ends here

        }
        catch (Exception ex)
        {
        }
    }





    [System.Web.Services.WebMethod]
    public static List<string> GetLatestFlatNumber(string FlatNumber)
    {
        Bill bill = new Bill();
        List<string> Emp = new List<string>();
        Emp = bill.GetLatestFlatNumber(FlatNumber);
        return Emp;

    }

    protected void btnbillCaluclate_Click(object sender, EventArgs e)
    {
        int updatePass = 0;
        int updateFail = 0;
        int TotalUpdate = 0;

        if (btnbillCaluclate.Text == "Import")
        {
            String FileName = uploadBill.PostedFile.FileName;
        }

        else
        {
            try
            {

                String BillType = lblBilltypeDes.Text;
                Bill bill = new Bill();
                DataSet FlatsData = bill.GetLatestBills("", BillType, "", "");//Added by Aarshi on 13-Sept-2017 for bug fix

                if (FlatsData != null)
                {
                    DataTable dataBills = FlatsData.Tables[0];
                    TotalUpdate = dataBills.Rows.Count;
                    for (int i = 0; i < dataBills.Rows.Count; i++)
                    {
                        GenerateBill previousBill = new GenerateBill();
                        previousBill.PayID = Convert.ToInt32(dataBills.Rows[i]["PayID"].ToString());
                        previousBill.op_FlatNumber = dataBills.Rows[i]["FlatNumber"].ToString();
                        previousBill.op_FlatArea = Convert.ToInt32(dataBills.Rows[i]["FlatArea"]);
                        previousBill.op_ChargeType = dataBills.Rows[i]["ChargeType"].ToString();
                        previousBill.CycleType = dataBills.Rows[i]["CycleType"].ToString();
                        previousBill.op_Rate = Convert.ToDouble(dataBills.Rows[i]["Rate"]);
                        if (previousBill.PayID > 0)
                        {
                            previousBill.BillStartDate = Convert.ToDateTime(dataBills.Rows[i]["BillStartDate"]);
                            previousBill.BillEndDate = Convert.ToDateTime(dataBills.Rows[i]["BillEndDate"]);
                        }
                        else
                        {
                            DateTime FlatAddDate = Convert.ToDateTime(dataBills.Rows[i]["FlatAddDate"]);
                            DateTime BillPlanDate = Convert.ToDateTime(dataBills.Rows[i]["BillPlanDate"]);

                            previousBill.BillStartDate = FlatAddDate > BillPlanDate ? FlatAddDate : BillPlanDate;
                            previousBill.BillEndDate = FlatAddDate > BillPlanDate ? FlatAddDate : BillPlanDate;
                        }
                        previousBill.SocietyBillID = Convert.ToInt32(dataBills.Rows[i]["SocietyBillID"]);
                        previousBill.CurrentMonthBalance = Convert.ToInt32(dataBills.Rows[i]["CurrentMonthBalance"]);

                        GenerateBill newBill = Bill.CalculateNewBill(previousBill, "Auto", Utility.GetCurrentDateTimeinUTC(),0);

                        if (newBill.op_Days > 0)
                        {
                            bool result = bill.InsertNewBill(newBill);

                            if (result == true)
                            {
                                updatePass = updatePass + 1;
                            }
                            else
                            {
                                updateFail = updateFail + 1;
                            }
                        }
                    }
                    //  lblBillGeneraStatus.Text = "Total: " + TotalUpdate + ", Success : " + updatePass + ", Unsuccess: " + updateFail;
                    LoadLatestBillData();

                }
                else
                {
                    // lblBillGeneraStatus.Text = "No  data  to Generate  a  Bill";
                }
                ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "ShowGenerateBillPreview()", true);
            }
            catch (Exception ex)
            {
                // lblBillGeneraStatus.Text = ex.Message;
            }
        }
    }

    protected void ImportNewRecordGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView drv = e.Row.DataItem as DataRowView;
            DateTime PreviousEndDate = Convert.ToDateTime(drv["PreviousEndDate"].ToString());
            DateTime BillStartDate = Convert.ToDateTime(drv["BillStartDate"].ToString());

            double dtCmpr = BillStartDate.Subtract(PreviousEndDate).TotalDays;

            if (dtCmpr > 1)
            {
                e.Row.BackColor = System.Drawing.Color.DarkRed;
            }

        }
    }//Current Bill

    protected void ExportLatestToExcel(object sender, EventArgs e)
    {
        try
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=LatestBillExport.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                GridlatestBills.AllowPaging = false;
                this.LoadLatestBillData();

                GridlatestBills.HeaderRow.BackColor = System.Drawing.Color.White;
                foreach (TableCell cell in GridlatestBills.HeaderRow.Cells)
                {
                    cell.BackColor = GridlatestBills.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in GridlatestBills.Rows)
                {
                    row.BackColor = System.Drawing.Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = GridlatestBills.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = GridlatestBills.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                GridlatestBills.RenderControl(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
        }
        catch(Exception ex)
        {
            int a = 1;
        }
    }//Current bill

    protected void btnselsectdata_Click(object sender, EventArgs e)//Current Bill
    {
        try
        {
            DataTable New_Bills = new DataTable();

            //New_Bills = (DataTable)Session["NewBills"];
       
            String SqlSocietyString = Utility.SocietyConnectionString;
            SqlConnection sqlCon = new SqlConnection(SqlSocietyString);
            sqlCon.Open();
            using (SqlBulkCopy Billdata = new SqlBulkCopy(sqlCon))
            {
                Billdata.DestinationTableName = "GeneratedBill";
                Billdata.ColumnMappings.Add("FlatNumber", "FlatNumber");
                Billdata.ColumnMappings.Add("BillID", "BillID");
                Billdata.ColumnMappings.Add("CurrentBillAmount", "CurrentBillAmount");
                Billdata.ColumnMappings.Add("CycleType", "CycleType");
                Billdata.ColumnMappings.Add("BillMonth", "BillMonth");
                Billdata.ColumnMappings.Add("PreviousMonthBalance", "PreviousMonthBalance");
                Billdata.ColumnMappings.Add("BillDescription", "BillDescription");
                Billdata.ColumnMappings.Add("BillStartDate", "BillStartDate");
                Billdata.ColumnMappings.Add("BillEndDate", "BillEndDate");
                Billdata.ColumnMappings.Add("PaymentDueDate", "PaymentDueDate");
                Billdata.WriteToServer(New_Bills);
            }
            sqlCon.Close();
            LoadLatestBillData();
        }
        catch (Exception ex)
        {

            int a = 1;
        }

    }
    #endregion

    public void LoadBillTypeDropdown(params DropDownList[] controls)
    {
        BillPlan billPlan = new BillPlan();
        dsBillType = billPlan.GetActiveBillType(muser.currentResident.SocietyID);

        if (dsBillType != null) {
            drpCurrentBillType.DataSource = dsBillType;
            drpCurrentBillType.DataTextField = "BillType";
            drpCurrentBillType.DataValueField = "BillTypeID";
            drpCurrentBillType.DataBind();
            drpCurrentBillType.Items.Add(new ListItem("Show All", "-1"));
            drpCurrentBillType.SelectedIndex = dsBillType.Tables[0].Rows.Count;
        }

   
        dsBillType = billPlan.GetActiveBillType(muser.currentResident.SocietyID);

        if (dsBillType != null)
        {
            drpGenBillForOnLatest.DataSource = dsBillType;
            drpGenBillForOnLatest.DataTextField = "BillType";
            drpGenBillForOnLatest.DataValueField = "BillTypeID";
            drpGenBillForOnLatest.DataBind();
    
        }


        /*

        if (dsBillType == null)
        {
            BillPlan billPlan = new BillPlan();
            dsBillType = billPlan.GetActiveBillType( muser.currentResident.SocietyID);
        }
        if (dsBillType != null)
        {
            foreach (ListControl ctrl in controls)
            {
                ctrl.Items.Clear();
                foreach (DataRow dtRow in dsBillType.Tables[0].Rows)
                {
                    ctrl.Items.Add(new ListItem(dtRow["BillType"].ToString(), dtRow["BillTypeID"].ToString()));
                }

                if (ctrl.ID == "drpCurrentBillType" || ctrl.ID == "drpActivatedBillType" || ctrl.ID == "drpGeneratedBillType")
                    ctrl.Items.Insert(0, new ListItem("Show All", "NA"));
                else
                    ctrl.Items.Insert(0, new ListItem("Select", "NA"));
            }
        }

        */
    }

    #region GeneratedBill

    protected void ChckBillsGenerated_CheckedChanged(object sender, EventArgs e)
    {
        if (/*ChckBillsGenerated.Checked*/true)
        {
            GeneratedBillsGrid.Columns[3].Visible = true;
            GeneratedBillsGrid.Columns[4].Visible = true;
            GeneratedBillsGrid.Columns[5].Visible = true;
            GeneratedBillsGrid.Columns[6].Visible = true;
        }

        else
        {
            GeneratedBillsGrid.Columns[3].Visible = false;
            GeneratedBillsGrid.Columns[4].Visible = false;
            GeneratedBillsGrid.Columns[5].Visible = false;
            GeneratedBillsGrid.Columns[6].Visible = false;
        }


    }

    protected void searchGenerateBill_Click(object sender, EventArgs e)
    {
        String BillType = drpGeneratedBillType.SelectedItem.Text;
        String FlatNumber = txtGenBillsFlatfilter.Text;

        //Added by Aarshi on 13-Sept-2017 for bug fix
        string StartDate = txtStartDate.Text;
        string EndDate = txtEndDate.Text;


        DateTime dtStartDate = DateTime.ParseExact(txtStartDate.Text, "dd-MM-yyyy", System.Globalization.CultureInfo.InvariantCulture);
        DateTime dtEndDate = DateTime.ParseExact(txtEndDate.Text, "dd-MM-yyyy", System.Globalization.CultureInfo.InvariantCulture); 
        TimeSpan span = dtEndDate - dtStartDate;
        double year = span.TotalDays / 365.25;

        if (year > 1)
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:alert('Please select date in one year')", true);
       // else
           // OldLoadGeneratedBillData(FlatNumber, BillType, StartDate, EndDate);
        //Ends here
    }


    protected void BillBack_Click(object sender, EventArgs e)
    {

        CurrentBill();
    }

    protected void PayNow_Click(object sender, EventArgs e)
    { }


    protected void GeneratedBillsGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GeneratedBillsGrid.PageIndex = e.NewPageIndex;

        String BillType = drpGeneratedBillType.SelectedItem.Text;
        String FlatNumber = txtGenBillsFlatfilter.Text;

        //Added by Aarshi on 13-Sept-2017 for bug fix
        string StartDate = txtStartDate.Text;
        string EndDate = txtEndDate.Text;

       // if (FlatNumber != "Select" || BillType != "Select")
         //   OldLoadGeneratedBillData(FlatNumber, BillType, StartDate, EndDate);
     //   else
          //  OldLoadGeneratedBillData("", "Show All", "", "");
        //Ends here
    }

    protected void GeneratedBillsGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton lnk = (LinkButton)e.Row.FindControl("lnkFlatNumber");
            string page = "Bills";
            string url = "OwnerResidentDet.aspx?FlatNumber=" + lnk.Text + "&PageSOurce=" + page;
            lnk.Attributes.Add("onClick", "JavaScript: window.open('" + url + "','','_blank','width=50,height=30,left=0,right=0,top=40')");
        }
    }

    ///////ActivatedBills Generate Bill button click /////
    protected void btnFlatbillGen_Click(object sender, EventArgs e)
    {
        DateTime CurrentBillEndDate = Utility.GetCurrentDateTimeinUTC();
        String GenerateCycle = "Manual";
        //btnSingleFlatGenerate.Text = "Generate Bill";
        //lblFlatNuber.Text = HiddenField1.Value;
        //lblBillType.Text = HiddenField2.Value;



        //previousBill = Bill.GetLastGeneratedBill(lblFlatNuber.Text, lblBillType.Text);

        //newBill = Bill.CalculateNewBill(previousBill, GenerateCycle, CurrentBillEndDate);

        //if (newBill.Days <= 0)
        //{
        //    lblBillDuplicate.Text = "Bill is Already Generated";
        //}

        //else
        //{
        //    lblBillDuplicate.Text = "";
        //}

        //lblFlatArea.Text = newBill.FlatArea.ToString();
        //lblRate.Text = newBill.Rate.ToString();
        //lblChargeType.Text = newBill.ChargeType;
        //lblFromDate.Text = newBill.BillStartDate.ToShortDateString();
        //txtFlatBillAmt.Visible = true;
        //txtFlatBillAmt.Text = newBill.CurrentBillAmount.ToString();
        //txtBillDate.Text = newBill.BillEndDate.ToShortDateString();
        //lblPreviousBalance.Text = newBill.PreviousMonthBalance.ToString();

        ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "ShowGenerateDeActivateBillForm()", true);
    }

    ///////Activated Bills Deactivate button click method //////


    [System.Web.Services.WebMethod]
    public static List<string> GetGenBillsFlatNumber(string FlatNumber)
    {
        //Added by Aarshi on 17 Aug 2017 for code restructuring
        List<string> Emp = new List<string>();
        Bill bill = new Bill();
        bill.GetLatestFlatNumber(FlatNumber);
        return Emp;

    }

    protected void ExportToExcel(object sender, EventArgs e)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=GridViewExport.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            //To Export all pages
            GeneratedBillsGrid.AllowPaging = false;
           // this.OldLoadGeneratedBillData("", "Electricity", "", "");

            GeneratedBillsGrid.HeaderRow.BackColor = System.Drawing.Color.White;
            foreach (TableCell cell in GeneratedBillsGrid.HeaderRow.Cells)
            {
                cell.BackColor = GeneratedBillsGrid.HeaderStyle.BackColor;
            }
            foreach (GridViewRow row in GeneratedBillsGrid.Rows)
            {
                row.BackColor = System.Drawing.Color.White;
                foreach (TableCell cell in row.Cells)
                {
                    if (row.RowIndex % 2 == 0)
                    {
                        cell.BackColor = GeneratedBillsGrid.AlternatingRowStyle.BackColor;
                    }
                    else
                    {
                        cell.BackColor = GeneratedBillsGrid.RowStyle.BackColor;
                    }
                    cell.CssClass = "textmode";
                }
            }

            GeneratedBillsGrid.RenderControl(hw);

            //style to format numbers to string
            string style = @"<style> .textmode { } </style>";
            Response.Write(style);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }
    }//Generated bill

    protected void PayLink_Click(object sender, CommandEventArgs e)
    {
        int PayID = Convert.ToInt32(e.CommandArgument.ToString());
        ShowPaymentForm(PayID);
        //Label1.Text = e.CommandArgument.ToString();

    }

    protected void btnBillPay_Click(object sender, EventArgs e)
    {
        int PayID = Convert.ToInt32(hiddenSelectedPayID.Value);
        ShowPaymentForm(PayID);
    }

    #endregion

    # region Payment

    private void ShowPaymentForm(int PayID)
    {
        DateTime Date = Utility.GetCurrentDateTimeinUTC();
        DataAccess dacess = new DataAccess();
        String BillPaidCheck = "select * From dbo.ViewLatestFlatBill where PayID = '" + PayID + "'";
        //String BillPaidCheck = "select AmountPaidDate,TransactionID,InvoiceID From dbo.GeneratedBill where PayID = '" + PayID + "'";
        DataSet dscheck = dacess.ReadData(BillPaidCheck);
        String PaidDateFormat = "";
        DataTable dtcheck = dscheck.Tables[0];
        lblFlatNuber.Text = dtcheck.Rows[0]["FlatNumber"].ToString();
        lblCurrentmonthbal.Text = dtcheck.Rows[0]["CurrentMonthBalance"].ToString();
        String TransactionID = dtcheck.Rows[0]["TransactionID"].ToString();
        String InvoiceID = dtcheck.Rows[0]["InvoiceID"].ToString();

          //String BillsQuery = " select BillType,FlatNumber,CurrentBillAmount,PreviousMonthBalance,BillMonth,PaymentDueDate,CycleType,AmountTobePaid,Rate,ChargeType,FlatArea from dbo.ViewLatestGeneratedBill where PayID ='" + PayID + "' ";
            //DataSet ds = dacess.ReadData(BillsQuery);
            if (dscheck != null)
            {
                DateTime tempDate;
                DataTable dt = dscheck.Tables[0];
                lblBillType.Text = dt.Rows[0]["BillType"].ToString();
                lblFlat.Text = dt.Rows[0]["FlatNumber"].ToString();
                lblBillAmount.Text = dt.Rows[0]["CurrentBillAmount"].ToString();
                lblBalance.Text = dt.Rows[0]["PreviousMonthBalance"].ToString();

                lblTotalPay.Text = dt.Rows[0]["AmountTobePaid"].ToString();
                tempDate = DateTime.Parse(dt.Rows[0]["BillMonth"].ToString());
                lblDueFor.Text = tempDate.ToString("dd MMM yyyy"); 

                tempDate = DateTime.Parse(dt.Rows[0]["PaymentDueDate"].ToString());
                lblDueDate.Text = tempDate.ToString("dd MMM yyyy");
                //lblDueDate.Text =  dt.Rows[0]["PaymentDueDate"].ToString("dd MMM YYYY");
                lblCycletype.Text = dt.Rows[0]["CycleType"].ToString();
            lblsocietybillid.Text = dt.Rows[0]["SocietyBillID"].ToString();

            Iblpyamt.Text = dt.Rows[0]["AmountTobePaid"].ToString();

            //Added by Aarshi on 18 auh 2017 for session storage
            SessionVariables.Rate = dt.Rows[0]["Rate"].ToString();
                SessionVariables.ChargeType = dt.Rows[0]["ChargeType"].ToString();
                SessionVariables.FlatArea = dt.Rows[0]["FlatArea"].ToString();

                lblCurrentTime.Text = Date.ToString();
               // int camt=Convert.ToInt32(dt.Rows[0]["CurrentMonthBalance"])+Convert.ToInt32(dt.Rows[0]["CurrentMonthBalance"])
                txtAmt.Text = dt.Rows[0]["CurrentMonthBalance"].ToString();
                txtTransaID.Text = "";
                MultiView1.ActiveViewIndex = 3;
                if (TransactionID == "" || InvoiceID == "")
                {
                    lblAmountPaid.Text = 0.ToString();
                    lblPaidDate.Text = "";
                    txtAmt.Text = dt.Rows[0]["AmountTobePaid"].ToString();
                    txtInvID.Text = dt.Rows[0]["PayID"].ToString();
                }

                else
                {
                    String invoice = dt.Rows[0]["InvoiceID"].ToString();

                    char[] split = "_".ToCharArray();

                    String[] invoiceArr = invoice.Split(split);
                    String newInvoice = "";
                    if(invoiceArr.Length==2)
                    {
                    newInvoice = invoiceArr[0] + "_" +(Convert.ToInt32(invoiceArr[1]) + 1).ToString();
                    }
                    else
                    {
                        newInvoice = invoiceArr[0] + "_" + 1.ToString();
                    }
                    txtInvID.Text = newInvoice;
                    lblAmountPaid.Text = dt.Rows[0]["AmountPaid"].ToString();
                    txtAmt.Text = dt.Rows[0]["AmountTobePaid"].ToString();
                    tempDate = DateTime.Parse(dt.Rows[0]["AmountPaidDate"].ToString());
                    lblPaidDate.Text = tempDate.ToString("dd MMM yyyy");
                      
                    lblPayment.Text = lblBillType.Text + "  " + "Bill  is Already Paid. Pay Advance ";
                }
         
            }
            else
            {
                lblLatestBillGrid.Text = "Unable to retreive data, Try Again ";
            }
     
    }


    protected void btnpayCancel_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;

        CurrentBill();
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;

        CurrentBill();

    }

    #endregion
    protected void PayLink_Click(object sender, EventArgs e)
    {
        int PayID = Convert.ToInt32(hiddenSelectedPayID.Value);
        ShowPaymentForm(PayID);
    }

    protected void btnCalculateOnEnddate_Click(object sender, EventArgs e)
    {
        try
        {
            String GenerateCycle = "Manual";
            DateTime BillEnddate = DateTime.ParseExact(txtBillDate.Text, "dd-MM-yyyy", System.Globalization.CultureInfo.InvariantCulture);  

            if (previousBill != null)
            {
                newBill = Bill.CalculateNewBill(previousBill, GenerateCycle, BillEnddate,0);
            }

            txtFlatBillAmt.Text = newBill.CurrentBillAmount.ToString();
        }
        catch (Exception ex)
        { 
        
        }

        ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "ShowAddBillPopup()", true);
    }

    protected void btnSingleFlatGenerate_Click(object sender, EventArgs e)
    {
        if (bill != null)
        {
            return;
        }
        else
        {
            bill = new Bill();
        }

        int BillID = newBill.SocietyBillID;
        DateTime BillEndDate = DateTime.ParseExact(txtBillDate.Text, "dd-MM-yyyy", System.Globalization.CultureInfo.InvariantCulture); 
        String FlatNumber = lblFlatNuber.Text;
        Double PrevBalance =  Convert.ToDouble(lblPreviousBalance.Text);
        Double CurrentAmount = Convert.ToDouble(txtFlatBillAmt.Text);
      //  String CycleType = HiddenFieldCycleType.Value;
        DateTime BillStartDate = DateTime.ParseExact(lblFromDate.Text, "dd-MM-yyyy", System.Globalization.CultureInfo.InvariantCulture); 
       // String ChargeType = HiddenFieldChargeType.Value;
        String BillDescription = txtBillGenSingleFlatdesc.Text;


        if (newBill != null)
        {

            if (btnSingleFlatGenerate.Text == "De Activate")
            {
                bool result2 = bill.InsertNewBill(newBill);

                if (result2)
                {
                    bool result1 = DeActivateBill(newBill.SocietyBillID, newBill.op_FlatNumber, newBill.BillEndDate);

                    //Added by aarshi on 11-Sept-2017 for bug fix
                    if (result1)
                    {
                        ClientScript.RegisterStartupScript(GetType(), "SetFocusScript", "<Script>self.close();</Script>");
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:alert('Bill Deactivated Successfully')", true);
                    }

                }
            }

            else if (btnSingleFlatGenerate.Text == "Generate Bill")
            {
                newBill.PaymentDueDate = DateTime.ParseExact(txtDueDate.Text, "dd-MM-yyyy", System.Globalization.CultureInfo.InvariantCulture);
                newBill.CurrentBillAmount = Convert.ToInt32(txtFlatBillAmt.Text);
                newBill.BillDescription = txtBillGenSingleFlatdesc.Text;
                bool result = bill.InsertNewBill(newBill);
                //bool result = true;
                if (result)
                {                          
                    string PaymentDueDate = newBill.PaymentDueDate.ToString("dd-MM-yyyy");

                    SendNotification(lblBillType.Text, PaymentDueDate);
                    SendMail();
                    LoadLatestBillData();

                    ClientScript.RegisterStartupScript(GetType(), "SetFocusScript", "<Script>self.close();</Script>");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:alert('Bill Generates Successfully')", true);

                }

                else
                {
                    //lblBillDuplicate.Text = "Bill Generated Failed";
                    Response.Write("<script>alert('Bill Generated Failed')</script>");
                }
            }
            bill = null;

        }
        //ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "ShowGenerateDeActivateBillForm()", true);
    }


    private bool DeActivateBill(int BillID, String FlatNumber, DateTime DeactivationDate)
    {
        try
        {
            //Added by Aarshi on 16 Aug 2017 for Placing Sql Code in Bill Cycle Class
            //DataAccess dacess = new DataAccess();
            //String deactivatePlan = "update dbo.aBillCycle set CycleEnd = '" + DeactivationDate + "'  where BillID = '" + billid + "' and FlatID = '" + FlatNumber + "'";
            //bool result = dacess.Update(deactivatePlan);

            //Added by Aarshi on 16 Aug 2017 for Placing Sql Code in Bill Cycle Class
            BillCycle billCycle = new BillCycle();
            bool result = billCycle.UpdateDeactiveBill(DeactivationDate, BillID, FlatNumber);

            if (result == true)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:alert('plan deactivated Sucessfully')", true);
                //lblbilltypeexist.Text = "plan deactivated Sucessfully";
            }

            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertmessage", "javascript:alert('plan deactivated failed')", true);
               // lblbilltypeexist.Text = "plan deactivated failed";
            }

            return true;
        }

        catch (Exception ex)
        {
            return false;
        }



    }

    //Added by Aarshi on 14-Sept-2017 for bug fix
    public void SendNotification(string BillType, string PaymentDueDate)
    {
        Notification notification = new Notification();
        String GCMRegIDs = GetRegIDS();
        if (GCMRegIDs != "")
        {
            string message = "Bill for " + BillType + " is created.Due by " + PaymentDueDate;
            notification.SendNotification(GCMRegIDs, message);
        }
    }

    //Added by Aarshi on 14-Sept-2017 for bug fix
    public void SendMail()
    {
        string EmailID = string.Empty;
        string EmailSubject = string.Empty;
        string EmailBody = string.Empty;
        string FirstName = string.Empty;
        try
        {

            using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))
            {
                int i = 0;

                DataTable dt = new DataTable();
                con1.Open();
                SqlDataReader myReader = null;
                SqlCommand myCommand = new SqlCommand("Select Resident.EmailId,Resident.FirstName from dbo.Resident inner join ResidentNotification on Resident.ResID = ResidentNotification.ResID WHERE ResidentNotification.BillingMail = 1 AND (DeActiveDate IS NULL OR DeActiveDate > GETDATE()) AND Resident.FlatID = '" + HiddenFlatNumberHistory.Value + "'", con1);

                myReader = myCommand.ExecuteReader();

                StringBuilder sb = new StringBuilder();

                if (myReader.HasRows)
                {
                    while (myReader.Read())
                    {
                        EmailID = myReader["EmailId"].ToString();
                        FirstName = myReader["FirstName"].ToString();

                        EmailSubject = "Bill for " + lblBillType.Text + " is created.";

                        StringBuilder result = new StringBuilder();
                        result.Append("Hi " + FirstName + ",");
                        result.AppendLine();
                        result.AppendLine();
                        result.Append("For flat " + HiddenFlatNumberHistory.Value + ",bill for " + lblBillType.Text + " is created.");
                        result.AppendLine();
                        result.Append("Do the payment by " + newBill.PaymentDueDate.ToString("dd-MM-yyyy") + ".");
                        result.AppendLine();
                        result.AppendLine();
                        result.Append("This is auto generated mail please do not reply.");

                        EmailBody = Convert.ToString(result);

                        Notification notification = new Notification();
                        notification.SendMail(EmailID, EmailSubject, EmailBody);
                    }
                }
            }
        }
        catch (Exception ex) { }
    }

    //Added by Aarshi on 14-Sept-2017 for bug fix
    private String GetRegIDS()
    {
        String RegIDS = "";
        try
        {

            using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))
            {
                int i = 0;

                DataTable dt = new DataTable();
                con1.Open();
                SqlDataReader myReader = null;
                SqlCommand myCommand = new SqlCommand("Select distinct RegID from dbo.GCMList GList INNER JOIN Resident Res ON Res.MobileNo = GList.MobileNo inner join ResidentNotification on Res.ResID = ResidentNotification.ResID WHERE ResidentNotification.BillingNotification = 1 AND Res.FlatID = '" + HiddenFlatNumberHistory.Value + "'", con1);

                myReader = myCommand.ExecuteReader();

                StringBuilder sb = new StringBuilder();

                while (myReader.Read())
                {
                    sb.Append(myReader["RegID"].ToString().Trim());
                    sb.Append("\",\"");
                }
                if (sb.Length > 10)
                {
                    sb.Remove(sb.Length - 3, 3);

                    RegIDS = sb.ToString();
                }

            }

            return RegIDS;
        }
        catch (Exception ex)
        {
            return RegIDS;
        }

    }


    //Ends here

    public override void VerifyRenderingInServerForm(Control control)
    {
        return;
    }

    private void GenerateBillPreview(String BillType)
    {
        //try
        //{
        //    String ChargeType = "";
        //    DataAccess dacess = new DataAccess();
        //    if (BillType == "Select")
        //    {
        //        uploadBill.Visible = false;
        //        btnbillCaluclate.Visible = false;
        //        //lblBillGeneraStatus.Text = "Please select a Bill Type to be generated"; //Commented by Aarshi on 3 aug 2014 for code structuring as this code is implemented on client side

        //    }
        //    else
        //    {
        //        btnbillCaluclate.Visible = true;
        //        lblBilltypeDes.Text = BillType;
        //        BillPlan billPlan = new BillPlan();
        //        SocietyBillPlan result = billPlan.GetPlanDetails(BillType);
        //        if (result == true)
        //        {
        //            lblchargetypeDes.Text = billPlan.ChargeType;
        //            lblrateDes.Text = billPlan.Rate;
        //            //HiddenBillDescp.Value = billPlan.BillID.ToString();

        //            if (billPlan.ChargeType == "Manual")
        //            {
        //                uploadBill.Visible = true;
        //                lblBillGeneraStatus.Text = "Manual Charge need to be imported from Excel";
        //                btnbillCaluclate.Text = "Import";

        //            }
        //            else
        //            {
        //                uploadBill.Visible = false;
        //                //commented by Aarshi on 15 Aug 2017 for code restructuring
        //                //String GetBillQuery = "Select count(FlatID) from BillCycle where Cyclestart != CycleEnd and CycleEnd >= getdate() and  BillID =" + billPlan.BillID + "";
        //                //int count = dacess.GetSingleValue(GetBillQuery);

        //                //Added by Aarshi on 15 Aug 2017 for code restructuring
        //                BillCycle billCycle = new BillCycle();
        //                int count = billCycle.GetSingleValueBillCycle(billPlan.BillID);

        //                lblRowsEffectDes.Text = count.ToString();
        //                btnbillCaluclate.Text = "Generate Bill";
        //                lblBillGeneraStatus.Text = "";

        //            }
        //        }
        //        else
        //        {
        //            lblBillGeneraStatus.Text = "Bil Plan do not exist, or connection problem";
        //        }

        //    }
        //}
        //catch (Exception ex)
        //{ }

        ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "ShowGenerateBillPreview()", true);
    }

    protected void LatestBill_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int rowIndex = Convert.ToInt32(e.CommandArgument);

       

        GridViewRow row = GridlatestBills.Rows[rowIndex];

        if (e.CommandName == "History")
        {
            GridViewRow gvr = (GridViewRow)(((Button)e.CommandSource).NamingContainer);

            int RowIndex = gvr.RowIndex;
            //Determine the RowIndex of the Row whose Button was clicked.


            //Fetch value of Name.
            string BillType = (row.FindControl("lblBillType") as Label).Text;
            drpCurrentBillType.SelectedItem.Text = BillType;

            //string FlatID = ((HiddenField)row.FindControl("hdnFlatId")).Value;

            //Fetch value of Country
            string FlatNumber = (row.FindControl("lblFlatNumar") as Label).Text;
            txtLatestFlatFilter.Text = FlatNumber;
            //Added by Aarshi on 13-Sept-2017 for bug fix
            string StartDate = DateTime.Now.AddMonths(-2).ToString("dd-MM-yyyy");
            string EndDate = DateTime.Now.ToString("dd-MM-yyyy");

            MultiView1.ActiveViewIndex = 1;
            //OldLoadGeneratedBillData(FlatNumber, BillType, StartDate, EndDate);

            LoadLatestBillData(e.CommandName);
            LoadBillTypeDropdown(drpGeneratedBillType);
            txtGenBillsFlatfilter.Text = FlatNumber;
            drpGeneratedBillType.Items.FindByText(BillType).Selected = true;

            txtStartDate.Text = StartDate;
            txtEndDate.Text = EndDate;


        }
        else if (e.CommandName == "Pay")
        {
            int PayID = Convert.ToInt32((row.FindControl("lblPayID") as Label).Text);
       
            ShowPaymentForm(PayID);

        }

        else if (e.CommandName == "Generate")
        {
            String Flat = (row.FindControl("lblFlatNumar") as Label).Text;
            String BillType = (row.FindControl("lblBillType") as Label).Text;
            String BillTypeID = (row.FindControl("lblBillTypeID") as Label).Text; 

            DateTime CurrentBillEndDate = Utility.GetCurrentDateTimeinUTC();
            String GenerateCycle = "Manual";
            btnSingleFlatGenerate.Text = "Generate Bill";
            lblFlatNuber.Text = Flat;
            lblBillType.Text = BillType;

            txtDueDate.Text = CurrentBillEndDate.AddDays(7).ToString("dd-MM-yyyy");

            previousBill = Bill.GetLastGeneratedBill(Flat, Convert.ToInt32(BillTypeID));

            if (previousBill != null)
            {
                newBill = Bill.CalculateNewBill(previousBill, GenerateCycle, CurrentBillEndDate,0);

                if (newBill.op_Days <= 0)
                {
                    lblBillDuplicate.Text = "Bill is Already Generated";

                }

                else
                {
                    lblBillDuplicate.Text = "";
                }

                lblFlatArea.Text = newBill.op_FlatArea.ToString();
                lblRate.Text ="Rs. "+ newBill.op_Rate.ToString();
                lblChargeType.Text = newBill.op_ChargeType;
                lblNewBillType.Text = BillType;
                lblFromDate.Text = newBill.BillStartDate.ToShortDateString();
                txtFlatBillAmt.Visible = true;
               // txtFlatBillAmt.Text = newBill.CurrentBillAmount.ToString();
                txtBillDate.Text = newBill.BillEndDate.ToShortDateString();
                lblPreviousBalance.Text = newBill.PreviousMonthBalance.ToString();
                txtBillGenSingleFlatdesc.Text = string.Empty;//Added by Aarshi on 11-Sept-2017 for bug fix
                lblCycle.Text = newBill.CycleType;
                lblsocietybillid.Text = newBill.SocietyBillID.ToString();
                lblCurrentmonthbal.Text = "Rs."+newBill.CurrentMonthBalance.ToString();
            }
            else
            {
                lblBillDuplicate.Text = "Error retreiving previous Bill";
            }
            ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "ShowGenerateDeActivateBillForm()", true);
        }
        
    }

    protected void GrdDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        int[] arrindex = { 3,6,7 ,9 ,10 };
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            for (int i = 0; i > e.Row.Cells.Count; i++)
            {
              //  e.Row.Cells[i].CssClass = "columnscss";
            }
            
            foreach(int index in arrindex)
            {
                TableCell tcell = e.Row.Cells[index];
                int amt = Convert.ToInt32(tcell.Text);
                if (amt < 0)
                {
                    tcell.Text = amt * -1 + "  Paid in Advance.";
                }
            }
        }
    }
}