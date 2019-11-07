using Microsoft.Office.Interop.Excel;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataTable = System.Data.DataTable;

public partial class BillGeneration : System.Web.UI.Page
{
    User muser;
    int SocietyID;
    int ResID;
    private static DataTable tableGeneratedBill;
    DateTime baseDate;

    protected void Page_Load(object sender, EventArgs e)
    {
        muser = SessionVariables.User;
        baseDate = new DateTime(1999, 01, 01);
        SessionVariables.CurrentPage = "BillGeneration.aspx";
        if (muser == null)
        {

            Response.Redirect("Login.aspx");

        }
        else {
            SocietyID = muser.currentResident.SocietyID;
            ResID = muser.currentResident.ResID;
                }
        if (!IsPostBack)
        {
            LoadBillTypeDropdown();
            tableGeneratedBill = new DataTable();
            tableGeneratedBill.Columns.Add("FlatID", typeof(int));
            tableGeneratedBill.Columns.Add("FlatNumber", typeof(String));
            tableGeneratedBill.Columns.Add("BillTypeID", typeof(int));
            tableGeneratedBill.Columns.Add("BillType", typeof(String));
            tableGeneratedBill.Columns.Add("BillStartDate", typeof(DateTime));
            tableGeneratedBill.Columns.Add("BillEndDate", typeof(DateTime));
            tableGeneratedBill.Columns.Add("PaymentDueDate", typeof(DateTime));
            tableGeneratedBill.Columns.Add("PreviousMonthBalance", typeof(int));
            tableGeneratedBill.Columns.Add("CurrentBillAmount", typeof(int));
            tableGeneratedBill.Columns.Add("SocietyBillID", typeof(int));
            tableGeneratedBill.Columns.Add("CycleType", typeof(String));
            tableGeneratedBill.Columns.Add("BillDescription", typeof(String));
            tableGeneratedBill.Columns.Add("BillMonth", typeof(DateTime));
            tableGeneratedBill.Columns.Add("SocietyID", typeof(int));
            tableGeneratedBill.Columns.Add("ActionType", typeof(String));
            tableGeneratedBill.Columns.Add("Activated", typeof(int));
            tableGeneratedBill.Columns.Add("ResID", typeof(int));
            tableGeneratedBill.Columns.Add("AmountPaidDate", typeof(DateTime));

            //tableGeneratedBill = new DataTable();
            //tableGeneratedBill.Columns.Add("FlatID", typeof(int));
            //tableGeneratedBill.Columns.Add("FlatNumber", typeof(String));
            //tableGeneratedBill.Columns.Add("BillType", typeof(String));
            //tableGeneratedBill.Columns.Add("BillStartDate", typeof(String));
            //tableGeneratedBill.Columns.Add("BillEndDate", typeof(String));
            //tableGeneratedBill.Columns.Add("PaymentDueDate", typeof(String));
            //tableGeneratedBill.Columns.Add("PreviousMonthBalance", typeof(int));
            //tableGeneratedBill.Columns.Add("CurrentBillAmount", typeof(int));
            //tableGeneratedBill.Columns.Add("SocietyBillID", typeof(int));
            //tableGeneratedBill.Columns.Add("CycleType", typeof(String));
            //tableGeneratedBill.Columns.Add("BillDescription", typeof(String));
            //tableGeneratedBill.Columns.Add("BillMonth", typeof(String));
            //tableGeneratedBill.Columns.Add("SocietyID", typeof(int));
            //tableGeneratedBill.Columns.Add("ActionType", typeof(String));
            //tableGeneratedBill.Columns.Add("Activated", typeof(int));
            //tableGeneratedBill.Columns.Add("ResID", typeof(int));
        }
    }


    public void LoadBillTypeDropdown(params DropDownList[] controls)
    {
        BillPlan billPlan = new BillPlan();
    

        DataSet  dsBillType = billPlan.GetActiveBillType(muser.currentResident.SocietyID);

        if (dsBillType != null)
        {
            drpGenBillForOnLatest.DataSource = dsBillType;
            drpGenBillForOnLatest.DataTextField = "BillType";
            drpGenBillForOnLatest.DataValueField = "BillTypeID";
            drpGenBillForOnLatest.DataBind();

        }



    }


    protected void btnGenerateLatestBill_Click(object sender, EventArgs e)
    {
        try
        {
           
            int countCalulatedBill = 0;
            int countInActiveBill = 0;
            String BillType = drpGenBillForOnLatest.SelectedItem.Text;
            String stringEndDate = newBillDate.Text;
            DateTime billEndDate;
            int BillTypeID = Convert.ToInt32(drpGenBillForOnLatest.SelectedItem.Value);


            if (stringEndDate == "")
            {
                lblmessage.Text = "Select the Bill End Date";
                return;
            }
            else {
                billEndDate = DateTime.ParseExact(stringEndDate, "dd-MM-yyyy", null);
            }

            GeneratedBillController billController = new GeneratedBillController();

            List<GenerateBill> LatestBill = billController.GetLatestBills(BillTypeID, muser.currentResident.SocietyID);
            List<GenerateBill> listCalculatedBill = new List<GenerateBill>();

            for (int i = 0; i < LatestBill.Count; i++)
            {
                GenerateBill previousBill = LatestBill[i];

               

                if (previousBill.op_Applyto == 1 || (previousBill.op_Applyto == 0 && previousBill.Activated == 2))
                {
                    if (previousBill.BillEndDate > billEndDate)
                    {
                        countInActiveBill = countInActiveBill + 1;
                    }
                    else
                    {

                        GenerateBill calculatedBill = Bill.CalculateNewBill(previousBill, "Manual", billEndDate, 0);
                        listCalculatedBill.Add(calculatedBill);

                        tableGeneratedBill.Rows.Add(calculatedBill.FlatID, calculatedBill.op_FlatNumber, BillTypeID, BillType, calculatedBill.BillStartDate, calculatedBill.BillEndDate,
                            calculatedBill.PaymentDueDate, calculatedBill.PreviousMonthBalance, calculatedBill.CurrentBillAmount,
                           calculatedBill.SocietyBillID, calculatedBill.CycleType, "Bulk Generate", DateTime.Today, SocietyID, "Generate", 2, calculatedBill.ResID,
                           baseDate);

                        countCalulatedBill = countCalulatedBill + 1;
                    }
                }
                else
                {
                   
                }


            }

            if (countCalulatedBill == 0)
            {
                lblmessage.Text = countCalulatedBill + " Bill calculated. " + countInActiveBill + " Bill not in date range";
            }
            else
            {
                lblmessage.Text = countCalulatedBill + " Bill calculated. " + countInActiveBill + " Bill not in date range";
                NewGeneratedBill.DataSource = tableGeneratedBill;
                NewGeneratedBill.DataBind();

                ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "ShowGenerateBillPreview()", true);
            }


        }
        catch (Exception ex)
        {
            lblmessage.Text= "Error displaying calculated data";
        }

    }

    protected void BillsUploadSubmit_Click(object sender, EventArgs e)
    {
        OleDbConnection Connection = null;
        try
        {
            int countCalulatedBill = 0;
            int countInActiveBill = 0;

            if (BillsUpload.PostedFile.FileName == "")
            {
                lblmessage.Text = "Please Select a file.";
                return;

            }

            String strTime = Utility.GetCurrentDateTimeinUTC().ToLongTimeString();
            strTime = strTime.ToString().Replace(':', '-');
            string path = strTime + "-" + BillsUpload.PostedFile.FileName;
            String Extension = Path.GetExtension(BillsUpload.PostedFile.FileName);
            path = Server.MapPath(Path.Combine("~/Data/", path));
            BillsUpload.SaveAs(path);
           

            String Connectionstring = String.Empty;

            switch (Extension)
            {
                case ".xls":

                     Connectionstring = ConfigurationManager.ConnectionStrings["Excel03ConString"].ConnectionString;

                  //  Connectionstring = ConfigurationManager.ConnectionStrings["Excel07conString"].ConnectionString;
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


            if (DataExcel.Rows.Count > 0)
            {

                foreach (DataRow ExcelRow in DataExcel.Rows)
                {
                    try
                    {
                        int previousBillTypeID = 0;
                        SocietyBillPlan socBillPlan = new SocietyBillPlan();

                        int FlatID = Convert.ToInt32(ExcelRow["FlatID"]);
                        String FlatNumber = ExcelRow["FlatNumber"].ToString();
                        int BillTypeID = Convert.ToInt32(ExcelRow["BillTypeID"]);
                        String BillType = ExcelRow["BillType"].ToString();
                        DateTime BillStartDate = Convert.ToDateTime(ExcelRow["BillStartDate"]);
                        DateTime BillEndDate = Convert.ToDateTime(ExcelRow["BillEndDate"]);
                        DateTime PaymentDueDate = Convert.ToDateTime(ExcelRow["PaymentDueDate"]);
                        int PreviousMonthBalance = Convert.ToInt32(ExcelRow["PreviousMonthBalance"]);
                        int CurrentBillAmount = Convert.ToInt32(ExcelRow["CurrentBillAmount"]);
                        DateTime BillMonth = Convert.ToDateTime(ExcelRow["BillMonth"]);
                        int billResID = Convert.ToInt32(ExcelRow["ResID"]);
                        if (BillTypeID != previousBillTypeID)
                        {
                            BillPlan billPlan = new BillPlan();
                            socBillPlan = billPlan.GetPlan(BillTypeID, SocietyID);
                        }

                        previousBillTypeID = BillTypeID;

                        tableGeneratedBill.Rows.Add(FlatID, FlatNumber, BillTypeID, BillType, BillStartDate, BillEndDate, PaymentDueDate, PreviousMonthBalance, CurrentBillAmount,
                           socBillPlan.SocietyBillID, socBillPlan.CycleType, "Bulk Import", DateTime.Today.Date, SocietyID, "Import", 2, billResID, baseDate);

                        countCalulatedBill = countCalulatedBill + 1;
                    }
                    catch (Exception ex)
                    {
                        countInActiveBill = countInActiveBill + 1;
                    }
                }

            
                if (countCalulatedBill == 0)
                {
                    lblmessage.Text = countCalulatedBill + " Bill calculated. " + countInActiveBill + " Bill not in date range";
                }
                else
                {
                    lblmessage.Text = countCalulatedBill + " Bill calculated. " + countInActiveBill + " Bill not in date range";
                    NewGeneratedBill.DataSource = tableGeneratedBill;
                    NewGeneratedBill.DataBind();

                    ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "ShowGenerateBillPreview()", true);
                }


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
            lblmessage.Text = "Please check the file and data format. Error Detail: ex.Message";
            //lblNewvalues.Visible = false;
            //NewValueScroll_Div.Visible = false;
            String message = ex.Message;
        }

        finally
        {
            if (Connection != null)
            {
                if (Connection.State == ConnectionState.Open)
                {
                    Connection.Close();
                }
                Connection = null;
            }
        }
    }


    protected void btnUpdateDB_OnClick(object sender, EventArgs e)
    {
        try
        {
            String SqlSocietyString = Utility.SocietyConnectionString;
            SqlConnection sqlCon = new SqlConnection(SqlSocietyString);
            sqlCon.Open();
            using (SqlBulkCopy Billdata = new SqlBulkCopy(sqlCon))
            {
                Billdata.DestinationTableName = "dbo.GeneratedBill";
                Billdata.ColumnMappings.Add("FlatID", "FlatID");
               // Billdata.ColumnMappings.Add("FlatNumber", "FlatNumber");
                Billdata.ColumnMappings.Add("SocietyBillID", "SocietyBillID");
                Billdata.ColumnMappings.Add("CurrentBillAmount", "CurrentBillAmount");
                Billdata.ColumnMappings.Add("CycleType", "CycleType");
                Billdata.ColumnMappings.Add("PaymentDueDate", "PaymentDueDate");
                //Amount to be paid is calculated
                Billdata.ColumnMappings.Add("PreviousMonthBalance", "PreviousMonthBalance");
                //Billdata.ColumnMappings.Add("ModifiedAt", "ModifiedAt");
                Billdata.ColumnMappings.Add("BillDescription", "BillDescription");
                Billdata.ColumnMappings.Add("BillStartDate", "BillStartDate");
                Billdata.ColumnMappings.Add("BillEndDate", "BillEndDate");
                Billdata.ColumnMappings.Add("BillMonth", "BillMonth");
                Billdata.ColumnMappings.Add("SocietyID", "SocietyID");
                Billdata.ColumnMappings.Add("ActionType", "ActionType");
                Billdata.ColumnMappings.Add("Activated", "Activated");
                Billdata.ColumnMappings.Add("ResID", "ResID");
                Billdata.ColumnMappings.Add("AmountPaidDate", "AmountPaidDate");
                Billdata.WriteToServer(tableGeneratedBill);

            }
            sqlCon.Close();

            NewGeneratedBill.DataSource = null;
            NewGeneratedBill.DataBind();
            tableGeneratedBill.Clear();
            lblmessage.Text = "The Data has been uploaded successfully.";
            ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "HideGenerateBillPreview()", true);
        }
        catch (Exception ex)
        {
            lblmessage.Text = "Error updating data base";
            int a = 1;
        }
    }

    protected void btnSaveExcel_OnClick(object sender, EventArgs e)
    {
        try
        {
            DataTableToExcel();

            lblmessage.Text = "The Excel has been downloaded successfull.";
        }
        catch (Exception ex)
        {
            lblmessage.Text = "Failed to create Excel.";
        }
    }

    /*

    private void ExportExcel1() {
        HttpResponse response = HttpContext.Current.Response;
        String FileName = "NewExcel.xls";
        response.Clear();
        response.ClearContent();
        response.ClearHeaders();
        response.Buffer = true;
        response.ContentType = "application/ms-excel";
        response.AddHeader("content-disposition", "attachment;filename="+ FileName );
        response.AddHeader("Content-Type", "application/Excel");
        response.Charset = "";
        
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            //To Export all pages
            NewGeneratedBill.AllowPaging = false;
            // this.LoadLatestBillData();

            NewGeneratedBill.HeaderRow.BackColor = System.Drawing.Color.White;
            foreach (TableCell cell in NewGeneratedBill.HeaderRow.Cells)
            {
                cell.BackColor = NewGeneratedBill.HeaderStyle.BackColor;
            }
            foreach (GridViewRow row in NewGeneratedBill.Rows)
            {
                row.BackColor = System.Drawing.Color.White;
                foreach (TableCell cell in row.Cells)
                {
                    if (row.RowIndex % 2 == 0)
                    {
                        cell.BackColor = NewGeneratedBill.AlternatingRowStyle.BackColor;
                    }
                    else
                    {
                        cell.BackColor = NewGeneratedBill.RowStyle.BackColor;
                    }
                    cell.CssClass = "textmode";
                }
            }

            NewGeneratedBill.RenderControl(hw);

            //style to format numbers to string
            //string style = @"<style> .textmode { } </style>";
            //response.Write(style);
            response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }
    }

    private void ExportExcel2() {
        Response.Clear();
        Response.ClearContent();
     //   Response.ContentType = "application/octet-stream";
     //   Response.AddHeader("Content-Disposition", "attachment; filename=ExcelFile.xls");


        NewGeneratedBill.RenderControl(new HtmlTextWriter(Response.Output));

        Response.Flush();
        Response.End();

    }

    private void ExportExcel3() {
     
    }
    */

    public void DataTableToExcel()
    {
        try
        {
            HttpResponse response = HttpContext.Current.Response;
            response.Clear();
            response.ClearHeaders();
            response.ClearContent();
            response.Charset = Encoding.UTF8.WebName;
            response.AddHeader("content-disposition", "attachment; filename=" + DateTime.Now.ToString("yyyy-MM-dd") + ".xls");
            response.AddHeader("Content-Type", "application/Excel");
            response.ContentType = "application/vnd.xlsx";
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter htw = new HtmlTextWriter(sw))
                {
                    tableGeneratedBill.TableName = "Sheet1";
                    GridView gridView = new GridView();
                    gridView.DataSource = tableGeneratedBill;
                    gridView.DataBind();
                    gridView.RenderControl(htw);
                    response.Write(sw.ToString());
                    gridView.Dispose();
                    tableGeneratedBill.Dispose();
                    response.End();
                }
            }

        }
        catch(Exception ex)
        {
            throw new Exception();
        }
    }

    protected void btnClearGrid_OnClick(object sender, EventArgs e)
    {
        try
        {
            NewGeneratedBill.DataSource = null;
            NewGeneratedBill.DataBind();
            tableGeneratedBill.Clear();
            lblmessage.Text = "";
            ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "HideGenerateBillPreview()", true);
        }
        catch (Exception ex)
        {
            lblmessage.Text = "Error Clearing Data";
        }
    }
}