using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.UI.DataVisualization.Charting;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;

public partial class Reports : System.Web.UI.Page
{

    User muser;
    protected void Page_Load(object sender, EventArgs e)
    {
        //muser = (User)Session["User"];
        //Added by Aarshi on 18 auh 2017 for session storage
        muser = SessionVariables.User;
        SessionVariables.CurrentPage = "Reports.aspx";
        if (muser == null)
        {
            string jScript = "window.top.location.href = 'Login.aspx';";

            ScriptManager.RegisterStartupScript(this, this.GetType(), "forceParentLoad", jScript, true);
            // Response.Redirect("Login.aspx");
        }

        if (muser == null)
        {
           // Response.Redirect("Login.aspx");
        }
        Bindchart();
    }


    DataAccess dacess = new DataAccess();
    private void Bindchart()
    {
        bool nocompage = false ,nopiedata=false;
        try
        {
            String BarChartQuery = "";
            if (muser.currentResident.UserType == "ResidentAdmin" || muser.currentResident.UserType == "Admin")
            {
                BarChartQuery = "Select Count(*) as 'Number_Of_Complaints' , Age from dbo.ViewComplaintSummary where LastStatusID=4 Group By Age";
            }
            else if (muser.currentResident.UserType == "Owner" || muser.currentResident.UserType == "Tenant")
            {
                BarChartQuery = "Select Count(*) as 'Number_Of_Complaints' , Age from dbo.ViewComplaintSummary where LastStatusID=4 and FlatNumber = '" 
                    + muser.currentResident.FlatID + "' Group By Age";
            }



            DataSet ds = dacess.ReadData(BarChartQuery);


            if (ds == null)
            {
                ReportBarchart.Visible = false;
                lblbarchart.Text = "Complaints Age data is Empty";
                nocompage = true;
            }
            else
            {
                DataTable dt = ds.Tables[0];
                ReportBarchart.DataSource = dt;

                ReportBarchart.Series["Series1"].XValueMember = "Age";
                ReportBarchart.Series["Series1"].YValueMembers = "Number_Of_Complaints";
                // ReportBarchart.Series[0].Color = System.Drawing.Color.Green;
                //   ReportBarchart.Series[0].BorderColor = System.Drawing.Color.Yellow;
                ReportBarchart.ChartAreas[0].AxisX.Title = "Duration in Days";
                ReportBarchart.ChartAreas[0].AxisY.Title = "number of complaints";
                ReportBarchart.DataBind();
            }





            String PieChartQuery = "";
            if (muser.currentResident.UserType == "ResidentAdmin"|| muser.currentResident.UserType == "Admin")
            {
                PieChartQuery = "Select Count(*) as Number_Of_Complaints , CompType from dbo.ViewComplaintSummary Group By CompType";
            }
            else if (muser.currentResident.UserType == "Owner" || muser.currentResident.UserType == "Tenant")
            {
                PieChartQuery = "Select Count(*) as Number_Of_Complaints , CompType from dbo.ViewComplaintSummary where FlatNumber = '"
                          + muser.currentResident.FlatID + "' Group By CompType";
            }


            DataSet PiechartData = dacess.ReadData(PieChartQuery);
            if (PiechartData != null)
            {
                DataTable dt1 = PiechartData.Tables[0];
                string[] x = new string[dt1.Rows.Count];
                int[] y = new int[dt1.Rows.Count];

                for (int i = 0; i < dt1.Rows.Count; i++)
                {
                    x[i] = dt1.Rows[i][1].ToString();
                    y[i] = Convert.ToInt32(dt1.Rows[i][0]);

                }

                ReportPieChart.Series["Series1"].Points.DataBindXY(x, y);
                ReportPieChart.Series["Series1"].Label = "#PERCENT{P2}";
                this.ReportPieChart.Series[0]["PieLabelStyle"] = "Inside";
                //Title Title = new Title("Percentage Of Complaints", Docking.Top, new Font("Verdana", 12), Color.Black);
                ReportPieChart.Titles.Add(Title);
                ReportPieChart.DataBind();
            }

            else
            {
                ReportPieChart.Visible = false;

                lblpiechart.Text = "Pie Chart Data is Empty";
                nopiedata = true;
            }

            if (nopiedata && nocompage)
            {
                reports.Visible = false;
                lblmessage.Text = "No Rport Data Available!! ";
            }
        }

        catch (Exception ex)
        {
            ReportPieChart.Width = 0;
            ReportPieChart.Height = 0;
            lblpiechart.Text = "Complaints Category data is Empty";

        }

    }
    
    

}