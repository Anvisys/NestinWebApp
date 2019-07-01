using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;

/// <summary>
/// Summary description for PollData
/// </summary>
public class PollData
{
	public PollData()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public int PollID;
    public String Question;
    public String StartDate;
    public String EndDate;

    public String[] Answer = new String[4];
    public int[] AnsCount = new int[4];

    //public String Answer1;
    //public String Answer2;
    //public String Answer3;
    //public String Answer4;

    public String[] AnswerString = new String[4];

    public int Ans1Count;
    public int Ans2Count;
    public int Ans3Count;
    public int Ans4Count;
    public int SelectedAnswer;

    public List<PollData> getPollWithCount(int SocietyID)
    {
        List<PollData> newList = new List<PollData>();
        try
        {
            String getQuery = "Select * from ViewPollDataWithCount where SocietyID = " + SocietyID;
            DataAccess dacess = new DataAccess();
            DataTable Polldatatable = new DataTable();
            DataSet Polldata = dacess.ReadData(getQuery);
            if (Polldata != null)
            {
                Polldatatable = Polldata.Tables[0];
                for (int i = 0; i < Polldatatable.Rows.Count; i++)
            {
                PollData temp = new PollData();
                temp.PollID = Convert.ToInt32(Polldatatable.Rows[i]["PollID"]);
                try
                {
                    temp.Question = Polldatatable.Rows[i]["Question"].ToString();
                    temp.Answer[0] = Polldatatable.Rows[i]["Answer1"].ToString();
                    temp.Answer[1] = Polldatatable.Rows[i]["Answer2"].ToString();
                    temp.Answer[2] = Polldatatable.Rows[i]["Answer3"].ToString();
                    temp.Answer[3] = Polldatatable.Rows[i]["Answer4"].ToString();
                    String Ans1Count =  Polldatatable.Rows[i]["Answer1Count"].ToString();
                    if (Ans1Count != "" && Ans1Count!= null)
                    {
                    temp.AnsCount[0] = Convert.ToInt32(Polldatatable.Rows[i]["Answer1Count"].ToString());
                    temp.AnsCount[1] = Convert.ToInt32(Polldatatable.Rows[i]["Answer2Count"].ToString());
                    temp.AnsCount[2] = Convert.ToInt32(Polldatatable.Rows[i]["Answer3Count"].ToString());
                    temp.AnsCount[3] = Convert.ToInt32(Polldatatable.Rows[i]["Answer4Count"].ToString());
                    }
                    else
                    {
                        temp.AnsCount[0] = temp.AnsCount[1] = temp.AnsCount[2] = temp.AnsCount[3] = 0;
                    }
                    DateTime dstart = Convert.ToDateTime(Polldatatable.Rows[i]["StartDate"]);
                    temp.StartDate = dstart.ToString("dd/MM/yyyy");
                    DateTime dEnd = Convert.ToDateTime(Polldatatable.Rows[i]["EndDate"]);
                    temp.EndDate = dEnd.ToString("dd/MM/yyyy");
                }
                    catch(Exception ex)
                {
                    int a = 1;
                    }
                newList.Add(temp);
            }
        }

        }
        catch (Exception ex)
        { 
        
        }

        return newList;
    }


    public int getSelectedValue(int PollID, int ResID)
    {
        int selectedAnswer = 0;
        try {
            String query = "Select SelectedAnswer from dbo.PollingAnswer where PollID =" + PollID + " and ResID = " + ResID;
            DataAccess dAccess = new DataAccess();
            selectedAnswer =  dAccess.GetSingleValue(query);
            
        }
        catch (Exception ex)
        { }
        return selectedAnswer;
    }
    public List<PollData> getPollDataFromDB(String FilterQuery)
    {

        List<PollData> newList = new List<PollData>();

        DataAccess dacess = new DataAccess();
        String PickDataQuery = "";
        if(  FilterQuery == "")
        {
            PickDataQuery = "SELECT * FROM [dbo].[PollingData]";
        }

        else
        {
            PickDataQuery = FilterQuery;
        }
       
      //  String PickDataQuery = "SELECT TOP 10 * FROM [dbo].[PollingData]";

        DataTable Polldatatable = new DataTable();
        DataSet Polldata = dacess.ReadData(PickDataQuery);

        if (Polldata != null)
        {
            Polldatatable = Polldata.Tables[0];

            for (int i = 0; i < Polldatatable.Rows.Count; i++)
            {
                PollData temp = new PollData();
                DataRow dr = Polldatatable.Rows[i];

                String question = dr["Question"].ToString();
                String answer1 = dr["Answer1"].ToString();
                DateTime startD =Convert.ToDateTime( dr["StartDate"]);

                string startDate = startD.ToString("dd/MM/yyyy");

                String EndD = dr["EndDate"].ToString();

                String Endate = Convert.ToDateTime(EndD).ToString("dd/MM/yyyy");

                String Answer1String = dr["Answer1String"].ToString();

                int answerCount1 = Convert.ToInt32(dr["Answer1Count"]);

                if (answer1 != null || answer1 == "")
                {
                    temp.StartDate = startDate;
                    temp.EndDate = Endate;
                    temp.Question = question;
                    temp.AnswerString[0] = Answer1String;
                    temp.Answer[0] = answer1;
                    temp.AnsCount[0] = answerCount1;
                }

                String answer2String = dr["Answer2String"].ToString();
                String answer2 = dr["Answer2"].ToString();
                int answerCount2 = Convert.ToInt32(dr["Answer2Count"]);

                if (answer2 != null || answer2 == "")
                {
                    temp.StartDate = startDate;
                    temp.EndDate = Endate;
                    temp.Question = question;
                    temp.AnswerString[1] = answer2String;
                    temp.Answer[1] = answer2;
                    temp.AnsCount[1] = answerCount2;
                }

                String answer3String = dr["Answer3String"].ToString();
                String answer3 = dr["Answer3"].ToString();
                int answerCount3 = Convert.ToInt32(dr["Answer3Count"]);
                if (answer3 != null || answer3 == "")
                {
                    temp.StartDate = startDate;
                    temp.EndDate = Endate;
                    temp.Question = question;
                    temp.AnswerString[2] = answer3String;
                    temp.Answer[2] = answer3;
                    temp.AnsCount[2] = answerCount3;
                }

                String answer4String = dr["Answer4String"].ToString();
                String answer4 = dr["Answer4"].ToString();
                int answerCount4 = Convert.ToInt32(dr["Answer4Count"]);

                if (answer4 != null || answer4 == "")
                {
                    temp.StartDate = startDate;
                    temp.EndDate = Endate;
                    temp.Question = question;
                    temp.AnswerString[3] = answer4String;
                    temp.Answer[3] = answer4;
                    temp.AnsCount[3] = answerCount4;
                }
                newList.Add(temp);                         
            }
        }
        else{
             
           }

            return newList;
        }

    public bool UpdatePollAnswer(int ResID, int PollID, int PollAnswer, int PreviousAnswer)
    {
        bool result;
        String stringQuery;
        try {
            if (PreviousAnswer == 0 || PreviousAnswer == null)
            {
                stringQuery = "Insert into dbo.PollingAnswer(PollID,ResID,SelectedAnswer,LastUpdated) Values('" 
                    + PollID + "','" + ResID + "','" + PollAnswer + "','" + DateTime.UtcNow.ToString("MM-dd-yyyy HH:MM:ss") + "')";

            }
            else
            {
                stringQuery = "Update dbo.PollingAnswer set SelectedAnswer =  '" + PollAnswer + "'  where PollID = '" + PollID + "' and ResID = '" + ResID + "'";
            }
            
                DataAccess dAccess = new DataAccess();
                result = dAccess.Update(stringQuery);
                return result;
        }
        catch (Exception ex)
        {
            return false;
        }
    
    }

    public List<PollData> GetData(int PageNumber, String order, int SocietyID, String Status)
    {
        order = "";
        String orderby = "";
        String StatusCond = "";
        if (order == "EndDate Descending")
        {
            orderby = "EndDate DESC";
        }
        else if (order == "EndDate Ascending")
        {
            orderby = "EndDate ASC";
        }
        else if (order == "Creation Date")
        {
            orderby = "StartDate ASC";
        }
        else {
            orderby = "StartDate DESC";
        }

        if (Status == "All")
        {
            StatusCond = "";
        }
        else if (Status == "Open")
        {
            StatusCond = " and EndDate >= Convert(date, GetUTCDate())";
        }
        else if (Status == "Close")
        {
            StatusCond = " and EndDate < Convert(date, GetUTCDate())";
        }



        List<PollData> newList = new List<PollData>();

        DataAccess dacess = new DataAccess();
         String GetQuery = "SELECT * FROM "
                        + " (SELECT ROW_NUMBER() OVER (ORDER BY " + orderby + ") AS rownumber,* FROM ViewPollDataWithCount where SocietyID = " + SocietyID.ToString() + StatusCond + ")  as Poll"
                        + " WHERE rownumber IN (" + (2 * PageNumber-1) + "," + 2 * PageNumber + ")";

         DataTable Polldatatable = new DataTable();
         DataSet Polldata = dacess.ReadData(GetQuery);

         if (Polldata != null)
            {
                Polldatatable = Polldata.Tables[0];
                for (int i = 0; i < Polldatatable.Rows.Count; i++)
                {
                    PollData temp = new PollData();
                    temp.PollID = Convert.ToInt32(Polldatatable.Rows[i]["PollID"]);
                    try
                    {
                        temp.Question = Polldatatable.Rows[i]["Question"].ToString();
                        temp.Answer[0] = Polldatatable.Rows[i]["Answer1"].ToString();
                        temp.Answer[1] = Polldatatable.Rows[i]["Answer2"].ToString();
                        temp.Answer[2] = Polldatatable.Rows[i]["Answer3"].ToString();
                        temp.Answer[3] = Polldatatable.Rows[i]["Answer4"].ToString();
                        String Ans1Count = Polldatatable.Rows[i]["Answer1Count"].ToString();
                        if (Ans1Count != "" && Ans1Count != null)
                        {
                            temp.AnsCount[0] = Convert.ToInt32(Polldatatable.Rows[i]["Answer1Count"].ToString());
                            temp.AnsCount[1] = Convert.ToInt32(Polldatatable.Rows[i]["Answer2Count"].ToString());
                            temp.AnsCount[2] = Convert.ToInt32(Polldatatable.Rows[i]["Answer3Count"].ToString());
                            temp.AnsCount[3] = Convert.ToInt32(Polldatatable.Rows[i]["Answer4Count"].ToString());
                        }
                        else
                        {
                            temp.AnsCount[0] = temp.AnsCount[1] = temp.AnsCount[2] = temp.AnsCount[3] = 0;
                        }
                        DateTime dstart = Convert.ToDateTime(Polldatatable.Rows[i]["StartDate"]);
                        temp.StartDate = dstart.ToString("dd/MM/yyyy");
                        DateTime dEnd = Convert.ToDateTime(Polldatatable.Rows[i]["EndDate"]);
                        temp.EndDate = dEnd.ToString("dd/MM/yyyy");
                    }
                    catch (Exception ex)
                    {
                        int a = 1;
                    }
                    newList.Add(temp);
                }
           }
               return newList;
        }

    public int GetTotalPollCount(int SocietyID, String Status)
    {
        try {
            String StatusCond = "";
            if (Status == "All")
            {
                StatusCond = "";
            }
            else if (Status == "Open")
            {
                StatusCond = " and EndDate >= Convert(date, GetUTCDate())";
            }
            else if (Status == "Close")
            {
                StatusCond = " and EndDate < Convert(date, GetUTCDate())";
            }

            DataAccess dacess = new DataAccess();
            String GetQuery = "SELECT Count(PollID) FROM ViewPollDataWithCount where SocietyID = " + SocietyID.ToString() + StatusCond;
           return dacess.GetSingleValue(GetQuery);
        }
        catch(Exception ex)
        {
            return 0;
        }
    }





}

    
    
    


         
