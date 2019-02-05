using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for Complaint
/// </summary>
public class Complaint
{
    
      public String Descrption;
      public int Assignedto;
      public int CurrentStatus;
      public int CompTypeID;
      public int SeverityID;
      public int ResidentID;
      public int SocietyID;
      public String FlatNumber;
      public DateTime ModifiedAt;
    public int ExistingComplaintID;

	public Complaint()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public bool AddNewComplaint()
    {
        try {
            DataAccess daAccess = new DataAccess();
            int CompID;
            ModifiedAt = Utility.GetCurrentDateTimeinUTC();
           
            string strMaxQuery = "select Max(CompID) from Complaints";
            CompID = daAccess.GetSingleValue(strMaxQuery);

            if (CompID == 0)
            {
                CompID = 1;
            }
            else
            {
                CompID = Convert.ToInt32(CompID) + 1;
            }
            String UpdateQuery = "insert into dbo.Complaints(CompID,Descrption,CompTypeID,SeverityID,Assignedto,ResidentID,FlatNumber,ModifiedAt,CurrentStatus, SocietyID) values('" +
                CompID + "','" + Descrption + "','" + CompTypeID + "','" + SeverityID + "','" + Assignedto + "','" + ResidentID + "','" + FlatNumber  + "',GETUTCDATE() ,'" + CurrentStatus +"' ,'" + SessionVariables.SocietyID+  "'   )";
            bool result = daAccess.Update(UpdateQuery);
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    public bool UpdateComplaint(int ComplaintID, String Remarks, int AssignedTo, int Status)
    {
        try
        {
            DataAccess daAccess = new DataAccess();
           
            ModifiedAt = Utility.GetCurrentDateTimeinUTC();

            String UpdateQuery = "INSERT INTO [dbo].[Complaints] ([CompID],[Descrption],[Assignedto],[CurrentStatus],[CompTypeID],[SeverityID],[ResidentID],[ModifiedAt],[FlatNumber],[SocietyID])"
                                  + " SELECT [CompID] ,'"+ Remarks + "',"+ AssignedTo + ",'"+ Status + "',[CompTypeID] ,[SeverityID],[ResidentID],GETUTCDATE(),[FlatNumber] ,[SocietyID]"
                                  + "FROM  [dbo].[Complaints] WHERE CompID = "+ ComplaintID.ToString();
            bool result = daAccess.Update(UpdateQuery);
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    public DataSet GetComplaints(int SocietyID, String FlatNumber, String CompType,String CompStatus,String ComplaintDateFilter)//Added by Aarshi on 11-Sept-2017 for bug fix
    {
        try
        {
            String ViewComplaintQuery = "";
            String FlatCond, CompTypeCond, CompStatusCond, DateCond = "";

            if (FlatNumber != "")
            {
                FlatCond = "FlatNumber = '" + FlatNumber + "'";
            }
            else
            {
                FlatCond = "FlatNumber is not null";
            }

            if (CompType != "")
            {
                CompTypeCond = "CompType = '" + CompType + "'";
            }
            else
            {
                CompTypeCond = "CompType is not null";
            }

            if (CompStatus != "" && CompStatus != "All")
            {
                if (CompStatus == "Open")
                {
                    CompStatusCond = "LastStatus != 'Closed'";
                }
                else if (CompStatus == "Closed")
                {
                    CompStatusCond = "LastStatus = 'Closed'";
                }
                else
                {
                    CompStatusCond = "LastStatus = '" + CompStatus + "'";
                }
            }
            else
            {
                CompStatusCond = "LastStatus is not null";
            }

            if (ComplaintDateFilter == "Current month")
            {
                DateCond = "month(LastAt) = month(getdate()) and year(LastAt) = year(getdate())";
            }
            else if (ComplaintDateFilter == "Last month")
            {
                DateCond = "month(LastAt) = month( DATEADD(month, -1, GETDATE())) and year(LastAt) = year( DATEADD(month, -1, GETDATE()))";
            }
            else if (ComplaintDateFilter == "This year" || ComplaintDateFilter == "Last year")
            {
                DateCond = "year(LastAt) = year(getdate())";
            }
            else
            {
                DateCond = "LastAt is not null";
            }

            //Added by Aarshi on 22-Sept-2017 for bug fix
            //if (ComplaintLoad == "ComplaintLoad")
            //    ViewComplaintQuery = "Select top 10 * from [dbo].[ViewComplaintSummary] where " + FlatCond + " and " + CompTypeCond + " and " + CompStatusCond + " and " + DateCond;
            //else
            ViewComplaintQuery = "Select * from [dbo].[ViewComplaintSummary] where SocietyID= " + SocietyID + " and " + FlatCond + " and " + CompTypeCond + " and " 
                + CompStatusCond + " and " + DateCond + " ORDER BY INITIATEDAT DESC";

            DataAccess dacess = new DataAccess();
            return dacess.GetData(ViewComplaintQuery);
        }
        catch (Exception ex)
        {
            return null;
        }
    }

    public DataSet GetComplaintsForEmployee(int EmpID, String FlatNumber, String CompType, String CompStatus, String ComplaintDateFilter)
    {
        try
        {
            String ViewComplaintQuery = "";
            String FlatCond, CompTypeCond, CompStatusCond, DateCond = "";

            if (FlatNumber != "")
            {
                FlatCond = "FlatNumber = '" + FlatNumber + "'";
            }
            else
            {
                FlatCond = "FlatNumber is not null";
            }

            if (CompType != "")
            {
                CompTypeCond = "CompType = '" + CompType + "'";
            }
            else
            {
                CompTypeCond = "CompType is not null";
            }

            if (CompStatus != "" && CompStatus != "All")
            {
                if (CompStatus == "Open")
                {
                    CompStatusCond = "LastStatus != 'Resolved'";
                }
                else if (CompStatus == "Closed")
                {
                    CompStatusCond = "LastStatus = 'Resolved'";
                }
                else
                {
                    CompStatusCond = "LastStatus = '" + CompStatus + "'";
                }
            }
            else
            {
                CompStatusCond = "LastStatus is not null";
            }

            if (ComplaintDateFilter == "Current month")
            {
                DateCond = "month(LastAt) = month(getdate()) and year(ModifiedAt) = year(getdate())";
            }
            else if (ComplaintDateFilter == "Last month")
            {
                DateCond = "month(LastAt) = month(getdate()) and year(ModifiedAt) = year(getdate())";
            }
            else if (ComplaintDateFilter == "This year" || ComplaintDateFilter == "Last year")
            {
                DateCond = "year(LastAt) = year(getdate())";
            }
            else
            {

                DateCond = "LastAt is not null";
            }


            ViewComplaintQuery = "Select * from [dbo].[ViewComplaintSummary] where Assignedto = " + EmpID +" and "+ FlatCond + " and " + CompTypeCond + " and " + CompStatusCond + " and " + DateCond;

            DataAccess dacess = new DataAccess();
            return dacess.GetData(ViewComplaintQuery);
        }
        catch (Exception ex)
        {
            return null;
        }
    }
}