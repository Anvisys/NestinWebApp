using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;

using System.Data;
using System.Data.SqlClient;
using System.Web.UI.DataVisualization.Charting;


public partial class Poll : System.Web.UI.Page
{
    User muser;
    PollData p;
    static int pollCount;
    static int currPageNumber;
    static String DisplayStatus="Open";
   
    List<PollData> pollList;
    protected void Page_Load(object sender, EventArgs e)
    {
        //Added by Aarshi on 18 auh 2017 for session storage
        //muser = (User)Session["User"];
        muser = SessionVariables.User;
        SessionVariables.CurrentPage = "Poll.aspx";
        if (muser == null)
        {
            Response.Redirect("Login.aspx");
        }

        else
        {
            //Session.Add("UserType", muser.UserType);
            SessionVariables.UserType = muser.currentResident.UserType;
            if (!IsPostBack)
            {
                SetFields();
            }
        }
        
      
    }


    private void SetFields()
    {
        currPageNumber = 1;
        p = new PollData();
        pollCount = p.GetTotalPollCount(muser.currentResident.SocietyID, DisplayStatus);

        if (pollCount == 0)
        {
            ShowEmptyPage();
        }
        else {
            DisplayPage(currPageNumber, DisplayStatus);
        }

    }

    private void DisplayPage(int PageNumber, String Status)
    {
        int Poll1Count = (PageNumber - 1) * 2 + 1;
        int Poll2Count = (PageNumber - 1) * 2 + 2;

        p = new PollData();
        pollCount = p.GetTotalPollCount(muser.currentResident.SocietyID, DisplayStatus);

        lblPollP1.Text = "Poll " + Poll1Count + " of " + pollCount;

        lblPollP2.Text = "Poll " + Poll2Count + " of " + pollCount;

        String orderby = "";
        p = new PollData();
        pollList = p.GetData(currPageNumber, orderby, muser.currentResident.SocietyID, Status);

        if (pollList.Count != 0)
        {
            lblEmptyPie1.Visible = false;
            if (PageNumber == 1)
            {
                btnPreBottom.Visible = false;
            }
            else
            {
                btnPreBottom.Visible = true;
            }
            if (pollCount <= currPageNumber * 2)
            {
                btnNextBottom.Visible = false;
            }
            else
            {
                btnNextBottom.Visible = true;
                
                pnlchart2.Visible = true;
            }

            CreatePieChart1(pollList[0]);

            if (pollCount >= currPageNumber * 2)
            {
                CreatePieChart2(pollList[1]);
            }
            else
            {
                HidePieChart2();
            }

        }
        else
        { 
            ShowEmptyPage(); 
        }
    }

    public void RefreshControls()
    {
        RadioChart1Opt1.Checked = false;
        RadioChart1Opt2.Checked = false;
        RadioChart1Opt3.Checked = false;
        RadioChart1Opt4.Checked = false;

        RadioChart2Opt1.Checked = false;
        RadioChart2Opt2.Checked = false;
        RadioChart2Opt3.Checked = false;
        RadioChart2Opt4.Checked = false;

    }
    protected void btnPreBottom_Click(object sender, EventArgs e)
    {
        try
        {
            RefreshControls();
            currPageNumber = currPageNumber - 1;
            DisplayPage(currPageNumber, DisplayStatus);
           
        }
        catch(Exception ex)
        {

        }
        
    }
    protected void btnNextBottom_Click(object sender, EventArgs e)
    {
        try
        {
            RefreshControls();
            currPageNumber = currPageNumber + 1;
            DisplayPage(currPageNumber, DisplayStatus);
        }

        catch(Exception ex)
        {

        }
        
    }


    protected void btnPieChart1_Click(object sender, EventArgs e)
    {

        int newSelection = 0;
        int previousSelection = 0;
        int PollID = Convert.ToInt32(HiddenField1.Value);

        //Added by Aarshi on 18 auh 2017 for session storage
        if (SessionVariables.SelectedAnswerChart1 != 0)
        {
            previousSelection = SessionVariables.SelectedAnswerChart1;
        }

        if (RadioChart1Opt1.Checked)
        {
            newSelection = 1;
        }
        else if (RadioChart1Opt2.Checked)
        {
            newSelection = 2;
        }
        else if (RadioChart1Opt3.Checked)
        {
            newSelection = 3;
        }
        else if (RadioChart1Opt4.Checked)
        {
            newSelection = 4;
        }

        PollData pData = new PollData();

        bool result = pData.UpdatePollAnswer(muser.currentResident.ResID, PollID, newSelection, previousSelection);

        if (result == true)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert()", "alert('Updated Sucessfully')", true);
        }

        DisplayPage(currPageNumber, DisplayStatus);
                            
    }

    protected void btnPieChart2_Click(object sender, EventArgs e)
    {
        
        int newSelection = 0;
        int previousSelection = 0;
        int PollID = Convert.ToInt32(HiddenField2.Value);

        
        //Added by Aarshi on 18 auh 2017 for session storage
        if (SessionVariables.SelectedAnswerChart2 != 0)
        {
            previousSelection = SessionVariables.SelectedAnswerChart2;
        }

        if (RadioChart2Opt1.Checked)
        {
            newSelection = 1;
        }
        else if(RadioChart2Opt2.Checked)
        {
            newSelection = 2;
        }
        else if(RadioChart2Opt3.Checked)
        {
            newSelection = 3;
        }
        else if (RadioChart2Opt4.Checked)
        {
            newSelection = 4;
        }

        PollData pData = new PollData();

        bool result = pData.UpdatePollAnswer(muser.currentResident.ResID, PollID, newSelection, previousSelection);

        if(result == true)
        {
            ClientScript.RegisterStartupScript(this.GetType(),"alert()","alert('Updated Sucessfully')",true);
        }

        DisplayPage(currPageNumber, DisplayStatus);
    }


    private void CreatePieChart1(PollData p1)
    {
        try
        {
            String[] Answer1 = p1.Answer;
            String q1 = p1.Question;

            int[] AnswerCount1 = p1.AnsCount;
            lblQ1.Text = q1;
           
            lblPie1date.Text = "Started On: " + p1.StartDate + " Closing On: " + p1.EndDate;

            PieChart1.Series[0].Points.DataBindXY(Answer1, AnswerCount1);

            foreach (DataPoint dp in PieChart1.Series["Series1"].Points)
                dp.IsEmpty = (dp.YValues[0] == 0) ? true : false;

            RadioChart1Opt1.Text = Answer1[0] + "( "+ AnswerCount1[0].ToString() + " Votes)";
            RadioChart1Opt2.Text = Answer1[1] + "( " + AnswerCount1[1].ToString() + " Votes)";
            RadioChart1Opt3.Text = Answer1[2] + "( " + AnswerCount1[2].ToString() + " Votes)";
            RadioChart1Opt4.Text = Answer1[3] + "( " + AnswerCount1[3].ToString() + " Votes)";
            lblTotalVote1.Text = (AnswerCount1[0] + AnswerCount1[1] + AnswerCount1[2] + AnswerCount1[3]).ToString() + " Resident Voted";
            if (RadioChart1Opt1.Text == "")
            {
                RadioChart1Opt1.Visible = false;
            }
            else
            {
                RadioChart1Opt1.Visible = true;
            }
            if (RadioChart1Opt2.Text == "")
            {
                RadioChart1Opt2.Visible = false;
            }
            else
            {
                RadioChart1Opt2.Visible = true;
            }
            if (RadioChart1Opt3.Text == "")
            {
                RadioChart1Opt3.Visible = false;
            }
            else
            {
                RadioChart1Opt3.Visible = true;
            }
            if (RadioChart1Opt4.Text == "")
            {
                RadioChart1Opt4.Visible = false;
            }
            else
            {
                RadioChart1Opt4.Visible = true;
            }

            if (muser.currentResident.UserType == "Admin")
            {
                RadioChart1Opt1.Enabled = false;
                RadioChart1Opt2.Enabled = false;
                RadioChart1Opt3.Enabled = false;
                RadioChart1Opt4.Enabled = false;
            }
            else if (muser.currentResident.UserType == "Tenant" || muser.currentResident.UserType == "Owner" || muser.currentResident.UserType == "ResidentAdmin")
            {
                int ResID = muser.currentResident.ResID;
                int Answer = p1.getSelectedValue(p1.PollID, ResID);
                //Session["SelectedAnswerChart1"] = Answer;
                //Added by Aarshi on 18 auh 2017 for session storage
                SessionVariables.SelectedAnswerChart1 = Answer;
                HiddenField1.Value = p1.PollID.ToString();

                switch (Answer)
                {
                    case 1:
                        RadioChart1Opt1.Checked = true;
                        break;
                    case 2:
                        RadioChart1Opt2.Checked = true;
                        break;
                    case 3:
                        RadioChart1Opt3.Checked = true;
                        break;
                    case 4:
                        RadioChart1Opt4.Checked = true;
                        break;
                }

            }
        }
        catch (Exception ex)
        {
            int a = 1;
        }
    }
    private void CreatePieChart2(PollData p2)
    {

        try
        {
            String[] Answer2 = p2.Answer;
            String q2 = p2.Question;
            int[] AnswerCount2 = p2.AnsCount;
            lblQ2.Text = q2;
            
            lblPie2Date.Text = "Started On: " + p2.StartDate + " Closing On: " + p2.EndDate;
           
            Piechart2.Series[0].Points.DataBindXY(Answer2, AnswerCount2);

            foreach (DataPoint dp in Piechart2.Series["Series1"].Points)
                dp.IsEmpty = (dp.YValues[0] == 0) ? true : false;

            RadioChart2Opt1.Text = Answer2[0] + "( " + AnswerCount2[0].ToString() + " Votes)";
            RadioChart2Opt2.Text = Answer2[1] + "( " + AnswerCount2[1].ToString() + " Votes)";
            RadioChart2Opt3.Text = Answer2[2] + "( " + AnswerCount2[2].ToString() + " Votes)";
            RadioChart2Opt4.Text = Answer2[3] + "( " + AnswerCount2[3].ToString() + " Votes)";
            lblTotalVote2.Text = (AnswerCount2[0] + AnswerCount2[1] + AnswerCount2[2] + AnswerCount2[3]).ToString() + " Resident Voted";

            if (RadioChart2Opt1.Text == "")
            {
                RadioChart2Opt1.Visible = false;
            }
            else
            {
                RadioChart2Opt1.Visible = true;
            }
            if (RadioChart2Opt2.Text == "")
            {
                RadioChart2Opt2.Visible = false;
            }
            else
            {
                RadioChart2Opt2.Visible = true;
            }
            if (RadioChart2Opt3.Text == "")
            {
                RadioChart2Opt3.Visible = false;
            }
            else
            {
                RadioChart2Opt3.Visible = true;
            }
            if (RadioChart2Opt4.Text == "")
            {
                RadioChart2Opt4.Visible = false;
            }
            else
            {
                RadioChart2Opt4.Visible = true;
            }

            if (muser.currentResident.UserType == "Admin")
            {
                RadioChart2Opt1.Enabled = false;
                RadioChart2Opt2.Enabled = false;
                RadioChart2Opt3.Enabled = false;
                RadioChart2Opt4.Enabled = false;
            }
            else if (muser.currentResident.UserType == "Tenant" || muser.currentResident.UserType == "Owner" || muser.currentResident.UserType == "ResidentAdmin")
            {
                int ResID = muser.currentResident.ResID;
                if (p2.SelectedAnswer == null || p2.SelectedAnswer ==0)
                {
                    p2.SelectedAnswer = p2.getSelectedValue(p2.PollID, ResID);
                }

                //Session["SelectedAnswerChart2"] = p2.SelectedAnswer;
                //Added by Aarshi on 18 auh 2017 for session storage
                SessionVariables.SelectedAnswerChart2 = p2.SelectedAnswer;

                HiddenField2.Value = p2.PollID.ToString();

                switch (p2.SelectedAnswer)
                {
                    case 1:
                        RadioChart2Opt1.Checked = true;
                        break;
                    case 2:
                        RadioChart2Opt2.Checked = true;
                        break;
                    case 3:
                        RadioChart2Opt3.Checked = true;
                        break;
                    case 4:
                        RadioChart2Opt4.Checked = true;
                        break;
                }

            }
        }
        catch (Exception ex)
        {
            int b = 1;
        }
    }

    public void HidePieChart2()
    {
        // lblQ2.Text = "";
        // lblPie2Date.Visible = false;


        // lblPollP2.Visible = false;
        //// lblPie2Yourvote.Visible = false;

        // RadioChart2Opt4.Visible = false;
        // RadioChart2Opt2.Visible = false;
        // RadioChart2Opt3.Visible = false;
        // RadioChart2Opt1.Visible = false;

        pnlchart2.Visible = false;
        

    }

    public void Showcontrol()
    {
        //lblPie2Yourvote.Visible = true;
        
        lblPie2Date.Visible = true;
       //btnNextChart.Visible = true;
        btnNextBottom.Visible = true;
        lblPollP2.Visible = true;
       
        lblPollP2.Visible = true;
        
       
    }

    protected void btnAddPoll_Click(object sender, EventArgs e)
    
    {
       // MultiView1.ActiveViewIndex = 1;

    }
   
    protected void btnPollSubmit_Click(object sender, EventArgs e)
    {
        //DateTime date = System.DateTime.Now;
        DateTime date = Utility.GetCurrentDateTimeinUTC(); 
        try
        {
            DataAccess dacess = new DataAccess();

           // DateTime Presentdate = System.DateTime.Now;
            DateTime Presentdate = Utility.GetCurrentDateTimeinUTC();

            DateTime Deactivedate = DateTime.ParseExact(txtEndDate.Text, "dd-MM-yyyy", System.Globalization.CultureInfo.CurrentUICulture); 

            if(Deactivedate > Presentdate)
            {
                String PollQuery = "Insert into dbo.PollingData (Question,Answer1,Answer2,Answer3,Answer4,StartDate,EndDate, SocietyID) values('" 
                    + txtPollQ.Text + "','" + txtPollAns1.Text + "','" + txtPollAns2.Text + "','" + txtPollAns3.Text + "','" 
                    + txtPollAns4.Text + "','" + DateString(date) + "','" + DateString(Deactivedate) + "','" + muser.currentResident.SocietyID + "')";
                bool result = dacess.Update(PollQuery);

                if (result == true)
                {
                    
                    lblPollstatus.Text = "Poll Submitted Sucessfully";
                   
                    pollCount = pollCount + 1;

                    if (pollCount == 0)
                    {
                        ShowEmptyPage();
                    }
                    else
                    {
                        DisplayPage(1, DisplayStatus);
                    }
                    // DisplayPage(currPageNumber);

                    Message msg = new Message();
                    msg.Topic = "Poll";
                    msg.SocietyID = muser.currentResident.SocietyID;
                    msg.TextMessage = "A new Poll is initiated in your Society ";

                    Notification notification = new Notification();
                    notification.Notify(Notification.TO.Society, muser.currentResident.SocietyID, msg);


                    ClientScript.RegisterStartupScript(this.GetType(), "alert()", "alert('Poll Added Sucessfully')", true);
                }
                else
                {
                    lblPollstatus.ForeColor = System.Drawing.Color.Red;
                    lblPollstatus.Text = "Poll Submitted failed,Check again";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "ViewPopup()", true);
                }
            }

            else
            {
                lblPollstatus.Text = "End Date  Should not  be  lessthan  Current date";
                ClientScript.RegisterStartupScript(this.GetType(), "alert('')", "ViewPopup()", true);
            }

        }
        catch (Exception ex)
        {
            lblPollstatus.Text = "Poll Submitted failed";
        }

       
    }



    private String DateString(DateTime dateTime)
    {

        return dateTime.ToString("MM-dd-yyyy HH:MM:ss");
    }

    protected void drpPollFilter_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataAccess dacess = new DataAccess();
       // String FilterDate = drpPollFilter.SelectedItem.Text;
        String FilterQuery = "";

        DisplayPage(currPageNumber, DisplayStatus);
    
    }

    private void ShowEmptyPage()
    {
      //  WebControl myControlControl = (WebControl)Page.FindControl("chartdata");
       // myControlControl.Visible = false;
        chartData.Visible = false;
        chart2data.Visible = false;
        //chart1 - data
        PieChart1.Visible = false;
        PieChart1.Width = 0;
        PieChart1.Height = 0;
        lblQ1.Visible = false;
        Piechart2.Visible = false;
        Piechart2.Width = 0;
        Piechart2.Height = 0;
        lblPie1date.Visible = false;
       
        RadioChart1Opt1.Visible = false;
        RadioChart1Opt2.Visible = false;
        RadioChart1Opt3.Visible = false;
        RadioChart1Opt4.Visible = false;

        RadioChart2Opt1.Visible = false;
        RadioChart2Opt2.Visible = false;
        RadioChart2Opt3.Visible = false;
        RadioChart2Opt4.Visible = false;

        lblPie2Date.Visible = false;
        lblPie1date.Visible = false;
        
        lblPollP1.Visible = false;
        lblTotalVote1.Visible = false;
        lblTotalVote2.Visible = false;

        lblPollP2.Visible = false;
        
        btnPreBottom.Visible = false;
        btnNextBottom.Visible = false;
        
        lblQ2.Visible = false;
        lblEmptyPie1.Visible = true;
        lblEmptyPie1.Text = "Currently there are  no  polls to Answer.";
         
    
    }


    protected void showOpen_Click(object sender, EventArgs e)
    {
        try
        {
            DisplayStatus = "Open";
            DisplayPage(1, DisplayStatus);
            ClientScript.RegisterStartupScript(this.GetType(), "alert('')", " SetActiveClass('Open')", true);
        }

        catch (Exception ex)
        {

        }
    }
    protected void showClose_Click(object sender, EventArgs e)
    {
        try
        {
            DisplayStatus = "Close";
            DisplayPage(1, DisplayStatus);
            ClientScript.RegisterStartupScript(this.GetType(), "alert('')", " SetActiveClass('Close')", true);
        }

        catch (Exception ex)
        {

        }
    }

    protected void showAll_Click(object sender, EventArgs e)
    {
        try
        {
            DisplayStatus = "All";
            DisplayPage(1, DisplayStatus);
            ClientScript.RegisterStartupScript(this.GetType(), "alert('')", " SetActiveClass('All')", true);
        }

        catch (Exception ex)
        {

        }
    }
}