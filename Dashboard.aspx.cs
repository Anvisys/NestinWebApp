using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
public partial class Dashboard : System.Web.UI.Page
{

    User mUser;
    protected void Page_Load(object sender, EventArgs e)
    {
        mUser = SessionVariables.User;
        SessionVariables.CurrentPage = "Dashboard.aspx";
        if (mUser == null)
        {
            Response.Redirect("Login.aspx");
        }

       // SetSummary();
        FlatData();
        //BillChart();
        SetComplaintData();
        SetForumData();
        //ComplaintChart();
        NoticeData();
        PollData();
      
        VendorData();

        

    }


    private void FlatData()
    {
        int TotalFlat = 0, Owner = 0, Tenant = 0;
        try
        {
            String flatQuery = "Select Count(ResID) as value, [Type] from dbo.ViewSocietyUsers where SocietyID = " + SessionVariables.SocietyID + " group by [Type] ";
            DataAccess da = new DataAccess();
            DataSet ds = da.GetData(flatQuery);
            if (ds != null)
            {
                int length = ds.Tables[0].Rows.Count;
                for (int i = 0; i < length; i++)
                {
                    string type = (ds.Tables[0].Rows[i]["Type"]).ToString();

                    if (type == "Owner")
                    {
                        TotalFlat = Convert.ToInt32(ds.Tables[0].Rows[i]["value"]);
                    }
                    else if (type == "Tenant")
                    {
                        Tenant = Convert.ToInt32(ds.Tables[0].Rows[i]["value"]);
                    }
                    
                }

                Owner = TotalFlat - Tenant;
                lblFlatInfo.Text = "Number of Flats: " + TotalFlat + "</br>" + "Number of Owners: " + Owner + "</br>" + "Number of Tenants: " + Tenant;
            }
            else
            {
                lblFlatInfo.Text = "Could not read data";
            }
        }
        catch (Exception ex)
        {

        }
    }




    private void SetBillData()
    {
        int TotalBills = 0, BillsPaid = 0, BillsDue = 0, CurrentBill = 0 ;
        try
        {
           String billQuery = "Select BillType, Sum(AmountTobePaid) as amount, Count(PayID) as value , Sum (case when CurrentMonthBalance >0 and PaymentDueDate>GetDate() then 1 else 0 end) as status  from[dbo].[ViewLatestGeneratedBill] where SocietyID = " + SessionVariables.SocietyID + "  group by BillType";
        
            // String billQuery = "  Select Count(PayID) from [dbo].[ViewLatestGeneratedBill] where FlatNumber = '" + mUser.FlatNumber + "' and CurrentMonthBalance >0";
            DataAccess da = new DataAccess();
           // int pendingBillCount = da.GetSingleValue(billQuery);

          
            DataSet ds = da.GetData(billQuery);
            if (ds != null)
            {
                int length = ds.Tables[0].Rows.Count;
                for (int i = 0; i < length; i++)
                {
                    int status = Convert.ToInt32(ds.Tables[0].Rows[i]["status"]);

                    if (status == 0)
                    {
                        BillsPaid = Convert.ToInt32(ds.Tables[0].Rows[i]["value"]);
                    }
                    else if (status == 1)
                    {
                        BillsDue = Convert.ToInt32(ds.Tables[0].Rows[i]["value"]);
                    }

                }

                TotalBills = BillsPaid + BillsDue;
                lblpending.Text = "Total Bills: " + TotalBills + "</br>" + "Bills Paid: " + BillsPaid + "</br>" + "Pending Bills: " + BillsDue;


                string[] x =  new string[] { "Payable","Paid","Balance"};
                int[] y = new int[] { TotalBills, BillsPaid, BillsDue };

                billChart.Series["Series1"].Points.DataBindXY(x, y);
                billChart.Series["Series1"].Label = "#VAL";
                this.billChart.Series[0]["PieLabelStyle"] = "Inside";
                //Title Title = new Title("No Of Complaints", Docking.Top, new Font("Verdana", 12), Color.Black);
                billChart.Titles.Add(Title);
                billChart.DataBind();

            }
            else
            {
                lblpending.Text = "Could not read data";
            }

        }
        catch (Exception ex)
        {
            int a = 1;
        }

    }

    //private void BillChart()
    //{

    //    try
    //    {
    //        int PreviousBalance = 0, BillsPaid = 0, BillsDue = 0, CurrentBill = 0;
    //        DataAccess dacess = new DataAccess();
    //        String query = " Select Sum(CurrentBillAmount) as BillAmount, Sum(PreviousMonthBalance) as PreviousBalance," +
    //                       "  sum(AmountPaid) as Paid, Sum(CurrentMonthBalance) as Balance from ViewLatestGeneratedBill ";

    //        DataSet ds = dacess.ReadData(query);


    //        if (ds == null)
    //        {
    //            lblpending.Text = "Percentage of Complaint Category Data is Empty";
    //        }
    //        else
    //        {
    //            int length = ds.Tables[0].Rows.Count;
    //            for (int i = 0; i < length; i++)
    //            {
    //                CurrentBill = Convert.ToInt32(ds.Tables[0].Rows[i]["BillAmount"]);
    //                BillsPaid = Convert.ToInt32(ds.Tables[0].Rows[i]["Paid"]);
    //                PreviousBalance = Convert.ToInt32(ds.Tables[0].Rows[i]["PreviousBalance"]);
    //                BillsDue = Convert.ToInt32(ds.Tables[0].Rows[i]["Balance"]);
                 

    //            }

               
    //            lblpending.Text = "Current Bills: " + CurrentBill + "</br>" + "Bills Paid: " + BillsPaid + "</br>" + "Pending Bills: " + BillsDue + "</br>" + "Previous Balance: " + PreviousBalance;


    //            string[] x = new string[] { "Current", "Paid", "Balance", "Previous" };
    //            int[] y = new int[] { CurrentBill, BillsPaid, BillsDue, PreviousBalance };

    //            billChart.Series["Series1"].Points.DataBindXY(x, y);
    //            billChart.Series["Series1"].Label = "#VAL";
    //            this.billChart.Series[0]["PieLabelStyle"] = "Inside";
    //            //Title Title = new Title("No Of Complaints", Docking.Top, new Font("Verdana", 12), Color.Black);
    //            billChart.Titles.Add(Title);
    //            billChart.DataBind();
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        Piechart.Visible = false;
    //    }

    //}

    private void SetComplaintData()
    {
        try
        {
            String query = " ";
            if (mUser.currentResident.UserType == "Admin" || mUser.currentResident.UserType == "Admin")
            {
                query = "  Select Count(LastStatus) as number, LastStatus   from [dbo].[ViewComplaintSummary] where month(LastAt) = month(CURRENT_TIMESTAMP) Group by LastStatus";
            }
            else {
               query = "  Select Count(LastStatus) as number, LastStatus   from [dbo].[ViewComplaintSummary] where month(LastAt) = month(CURRENT_TIMESTAMP) and ResidentID = "
                + mUser.currentResident.ResID + " Group by LastStatus";
            }


                

            DataAccess da = new DataAccess();
            DataSet ds = da.GetData(query);
            if (ds != null)
            {
                DataTable dt = ds.Tables[0];
                if (dt.Rows.Count == 0)
                {
                   // String yrQuery = "  Select Count(LastStatus) as number, LastStatus   from [dbo].[ViewComplaintSummary] where year(LastAt) = year(CURRENT_TIMESTAMP) and ResidentID = " 
                      //  + mUser.currentResident.ResID + " Group by LastStatus";
                    DataSet dsy = da.GetData(query);
                    if (dsy == null)
                    {
                        lblComplaintInfo.Text = "1) Issue:need eletrician \n 2) Issue:with my parking";
                        return;
                    }
                    dt = dsy.Tables[0];
                }
                int[] x = new int[3];
                int initiated = 0, resolved = 0, assigned = 0;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    x[i] = Convert.ToInt32(dt.Rows[i][0]);
                    if ((dt.Rows[i][1]).ToString() == "New")
                    {
                        initiated = x[i];
                    }
                    else if ((dt.Rows[i][1]).ToString() == "Resolved")
                    {
                        resolved = x[i];
                    }
                    else if ((dt.Rows[i][1]).ToString() == "Assigned")
                    {
                        assigned = x[i];
                    }
                }
                //lblComplaintInfo.Text = "New = " + initiated + "<br/>" + "Assigned = " + assigned + "<br/>" + "Resolved = " + resolved;
            }
        }
        catch (Exception ex)
        {
            lblComplaintInfo.Text = "1) Issue: need eletrician \n 2) Issue: with my parking";
        }

    }

    private void SetForumData()
    {
        String forumQuery = "Select Top 3 * from dbo.ViewThreadSummaryNoImageCount where SocietyID="+SessionVariables.SocietyID+" order by UpdatedAt desc";
       // String forumQuery = "Select Top 3 * from dbo.ViewThreadSummaryNoImageCount  order by UpdatedAt desc";

        DataAccess da = new DataAccess();
        DataSet ds = da.GetData(forumQuery);

        if (ds != null)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                String forumString = "";// "<div class=\"long_text\">";
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    var forText = ds.Tables[0].Rows[i]["FirstThread"].ToString();
                    if (forText.Length > 50)
                    {
                        forText = forText.Substring(0, 50);
                    }
                    int ResID =  Convert.ToInt32(ds.Tables[0].Rows[i]["FirstResID"].ToString());
                    string Name = ds.Tables[0].Rows[i]["Initiater"].ToString();
                    forumString += "<div style=\"margin:3px;\"> <img class=\"profile-image\" style=\"height:20px;width:20px;\" src='GetImages.ashx?ResID="+ ResID + "&Name="+ Name + "&UserType=Resident' /> &nbsp; "
                        + forText + "...  <br/></div>";

                }
                //forumString += "</div>";
                // lblTopForum.Text = forumString; //forumString.Substring(0,forumString.Length-5) ;
                lblTopForum.Text = "1) Hey i am new owner of Flat I-1850." +
                    "2) Hi, There did anyone els having problem with leaking in tower I";
            }
            else
            {

                lblTopForum.Text = "No Data Available";
            }

        }
    }

    //private void ComplaintChart()
    //{
    //    try
    //    {
    //        DataAccess dacess = new DataAccess();

    //        //String BarChartQuery = "Select Count(*) as 'Number_Of_Complaints' , Age from dbo.ViewComplaintSummary where LastStatusID=4 Group By Age";

    //        String query = " select t.range as [Age_range], count(*) as [Number_Of_Complaints]"
    //                      + "from (  select case  "
    //                           + " when Age between 0 and 1 then ' 0- 1'"
    //                           + " when Age between 2 and 5 then '2-5'"
    //                           + " else '6-10' end as range"
    //                            + " from dbo.ViewComplaintSummary where SocietyID="+SessionVariables.SocietyID+") t group by t.range";

    //        DataSet databarchart = dacess.ReadData(query);
    //        if (databarchart == null)
    //        {
    //            lblEmptyDataText.Text = "Age of Complaints Data is Empty";
    //            BarChart.Width = 0;
    //        }

    //        else
    //        {
    //            DataTable dtable = databarchart.Tables[0];
    //            BarChart.DataSource = dtable;
    //            BarChart.Series["Series1"].XValueMember = "Age_range";
    //            BarChart.Series["Series1"].YValueMembers = "Number_Of_Complaints";
    //            BarChart.ChartAreas[0].AxisX.Title = "Duration in Days";
    //            BarChart.ChartAreas[0].AxisY.Title = "number of complaints";
    //            BarChart.DataBind();
    //        }

    //        String PieChartQuery = "Select Count(*) as Number_Of_Complaints , CompType from dbo.ViewComplaintSummary Group By CompType";

    //        //  ReportPieChart.DataSource = dacess.ReadData(PieChartQuery).Tables[0];

    //        DataSet ds = dacess.ReadData(PieChartQuery);


    //        if (ds == null)
    //        {
    //            lblpiechart.Text = "Percentage of Complaint Category Data is Empty";
    //        }
    //        else
    //        {
    //            DataTable dt = ds.Tables[0];
    //            string[] x = new string[dt.Rows.Count];
    //            int[] y = new int[dt.Rows.Count];

    //            for (int i = 0; i < dt.Rows.Count; i++)
    //            {

    //                x[i] = dt.Rows[i][1].ToString();
    //                y[i] = Convert.ToInt32(dt.Rows[i][0]);

    //            }

    //            Piechart.Series["Series1"].Points.DataBindXY(x, y);
    //            Piechart.Series["Series1"].Label = "#PERCENT{P2}";
    //            this.Piechart.Series[0]["PieLabelStyle"] = "Inside";
    //            //Title Title = new Title("No Of Complaints", Docking.Top, new Font("Verdana", 12), Color.Black);
    //            Piechart.Titles.Add(Title);
    //            Piechart.DataBind();
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        Piechart.Visible = false;
    //        //Barchart.Visible = false;
    //        //lblbarchart.Text = "Complaints data is empty";
    //        lblpiechart.Text = "Complaint Category data is empty";
    //    }
    //}

    private void NoticeData()
    {
        String notice = "";
        try
        {
            String noticeQuery = "Select top 2 *  from dbo.Notifications where SocietyID = " + SessionVariables.SocietyID +" order by [Date] desc";
            DataAccess da = new DataAccess();
            DataSet ds = da.GetData(noticeQuery);
            if (ds != null)
            {
                int length = ds.Tables[0].Rows.Count;
                if (length > 0)
                    for (int i = 0; i < length; i++)
                {
                        String notText = (ds.Tables[0].Rows[i]["Notification"]).ToString();

                        if (notText.Length > 50)
                        { notice = notice + notText.Substring(0, 50) + "...<br/>" + "<br/>"; }
                        else
                        { notice = notice + notText + "...<br/>" + "<br/>"; }
                  


                }
                else
                {
                    notice = "Notice Box Empty";
                }

                lblTopNotice.Text = notice;

            }
           
        }
        catch (Exception ex)
        {

        }
    }
    
    private void PollData()
    {
        String Poll = "";
        try
        {
            String pollQuery = "Select top 2 *  from dbo.PollingData where SocietyID = " + SessionVariables.SocietyID + " order by [StartDate] desc";
            DataAccess da = new DataAccess();
            DataSet ds = da.GetData(pollQuery);
            if (ds != null)
            {
                int length = ds.Tables[0].Rows.Count;
                if (length>0)
                for (int i = 0; i < length; i++)
                {

                    Poll = Poll + (ds.Tables[0].Rows[i]["Question"]).ToString() + "<br/>" + "<br/>";


                }
                else
                {
                    Poll = "Polling Data are Empty";
                }

                lblTopPoll.Text = Poll;
            }
        }
        
        catch (Exception ex)
        {

        }
    }
  
private void VendorData()
    {
        String Offer = "";
        try
        {
            String pollQuery = "NO vendors are available";
            //String pollQuery = "Select top 2 *  from dbo.ViewOffers where SocietyID = " + SessionVariables.SocietyID + " order by [StartDate] desc";
            DataAccess da = new DataAccess();
            DataSet ds = da.GetData(pollQuery);
            if (ds != null)
            {
                int length = ds.Tables[0].Rows.Count;
                if (length > 0)
                {
                    for (int i = 0; i < length; i++)
                    {

                        Offer = Offer + (ds.Tables[0].Rows[i]["Offer"]).ToString() + "<br/>" + "<br/>";

                    }
                }
                else {

                    Offer = "Currently,no any vendor added in your society";
                }


                lblOffer.Text = "No offers are available now";
           
            }
            else
            {
                //lblOffer.Text = "Error in retrieving data";
                lblOffer.Text = "Grocery:- No offers are available now. Medical:- 10% off on your first purchase";
            }
        }
        catch (Exception ex)
        {

        }
    }
}