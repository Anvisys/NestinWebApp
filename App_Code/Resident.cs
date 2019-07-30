using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Transactions;
/// <summary>
/// Summary description for Resident
/// </summary>
public class Resident
{

    public int ResID { get; set; }
    public int UserID { get; set; }
    public int FlatID { get; set; }

    public String UserType { get; set; }
    public int ServiceType { get; set; }
    public String CompanyName { get; set; }
    public String ActiveDate { get; set; }
    public String DeActiveDate { get; set; }
    public String ModifiedDate { get; set; }
    public int SocietyID { get; set; }
    public int Status { get; set; }
    public int HouseID { get; set; }

    public String SocietyName { get; set; }
    public String IntercomNumber { get; set; }
    public String FlatNumber { get; set; }

    public string HouseNo { get; set; }
    public string Sector { get; set; }
    public string City { get; set; }
    public string State { get; set; }
    public string Pin { get; set; }

    
    public Resident()
    {
        ResID = 0;
        UserID = 0;
        FlatID = 0;
        UserType = "Owner";
        ServiceType = 0;
        CompanyName = "NA";
        ActiveDate = DateTime.UtcNow.ToString("MM-dd-yyyy HH:MM:ss");
        DeActiveDate = DateTime.UtcNow.AddYears(5).ToString("MM-dd-yyyy HH:MM:ss");
        ModifiedDate = DateTime.UtcNow.ToString("MM-dd-yyyy HH:MM:ss");
        SocietyID = 1;
        Status = 1;
        HouseID = 0;
    }

    public DataSet GetResidentForUser(int UserId)
    {
        DataSet dsResidentUserFlat = null;
        try
        {
            
            DataAccess dacess = new DataAccess();
            String UserSearchQuery = "select * from " + CONSTANTS.View_SocietyUser + " Where (Type = 'Owner' or Type = 'Tenant') and UserID =" + UserId  ;
            dsResidentUserFlat = dacess.GetData(UserSearchQuery);
        }
        catch (Exception ex)
        {
        }
        return dsResidentUserFlat;
    }


    public DataSet GetActiveResident(int UserId)
    {
        DataSet dsResidentUserFlat = null;
        try
        {

            DataAccess dacess = new DataAccess();
            String UserSearchQuery = "select * from " + CONSTANTS.View_SocietyUser + " Where UserID =" + UserId +" and StatusID = 2 and DeActiveDate > GetDate()";
                                     
            //
            dsResidentUserFlat = dacess.GetData(UserSearchQuery);
        }
        catch (Exception ex)
        {
        }
        return dsResidentUserFlat;

    }

    public DataSet GetResidentAll()
    {
        DataSet dsResident = null;
        try
        {
            DataAccess dacess = new DataAccess();
            String UserSearchQuery = "select * from " + CONSTANTS.View_SocietyUser;
            dsResident = dacess.GetData(UserSearchQuery);

        }
        catch (Exception ex)
        {
        }
        return dsResident;
    }

    public bool AddSocietyUser(int UserId, int FlatID, int _SocietyID)
    {
        try {


            String societyUserQuery = "Insert Into dbo.SocietyUser  (UserID,FlatID,Type,ServiceType,CompanyName,ActiveDate, SocietyID,Status) output INSERTED.ResID Values('" +
                                                                 UserId + "','"+ FlatID + "','Owner','0','NA','" + DateTime.UtcNow.ToString("MM-dd-yyyy HH:MM:ss") + "','" + _SocietyID + "',"+Status+")";


    DataAccess da = new DataAccess();
            bool result =   da.UpdateQuery(societyUserQuery);

            return result;
        }
        catch (Exception ex)
        {
            return false;
        }

    }

    public bool AddSocietyUser()
    {
        try
        {


            String societyUserQuery = "Insert Into dbo.SocietyUser (UserID,FlatID,Type,ServiceType,CompanyName,ActiveDate,DeActiveDate,ModifiedDate, SocietyID,Status, HouseID) output INSERTED.ResID Values('" +
                                      UserID + "','" + FlatID + "','"+UserType+"','" + ServiceType + "','" + CompanyName+"','"+ActiveDate+"','" + DeActiveDate + "','" + ModifiedDate + "','" + SocietyID + "','" + Status + "','" + HouseID+"')";

            DataAccess da = new DataAccess();
            bool result = da.UpdateQuery(societyUserQuery);

            return result;
        }
        catch (Exception ex)
        {
            return false;
        }

    }

    public DataSet GetActiveOwner(int FlatId, int SocietyId)
    {
        try
        {

            DataAccess dacess = new DataAccess();
            String UserSearchQuery = "select UserID, FirstName, LastName from " + CONSTANTS.View_SocietyUser 
                + " Where Status = 2 and ActiveDate < GetDate() and DeActiveDate > GetDate() and FlatID = " + FlatId + " and SocietyID = " + SocietyId;

           DataSet dsResidentUserFlat = dacess.GetData(UserSearchQuery);
         

            return dsResidentUserFlat;
        }
        catch (Exception ex)
        {
            return null;
        }

    }



    public DataSet GetResidentUserFlat(string UserName, String FlatNumber)
    {
        DataSet dsResidentUserFlat = null;
        try
        {
            String flatCond = "", userNameCond = "";
            if (FlatNumber == "")
            {
                flatCond = "FlatNumber is not null";
            }
            else
            {
                flatCond = "FlatNumber = '" + FlatNumber + "'";
            }

            if (UserName == "Select")
            {
                userNameCond = "FirstName is not null";
            }
            else
            {
                userNameCond = "FirstName like '" + UserName + "%'";
            }


            DataAccess dacess = new DataAccess();
            String UserSearchQuery = "select * from " + CONSTANTS.View_SocietyUser + " Where " + userNameCond + " and " + flatCond;
            dsResidentUserFlat = dacess.GetData(UserSearchQuery);
        }
        catch (Exception ex)
        {
        }
        return dsResidentUserFlat;
    }

    public DataSet GetResident(String FlatNumber, String ResType, int SocietyID)
    {        
        try
        {           
            String ResidentGenQuery = "";

            if (FlatNumber != "" && ResType != "All")
            {
                ResidentGenQuery = "select * from " + CONSTANTS.View_SocietyUser + " where FlatNumber ='" + FlatNumber + "' and Type = '" + ResType + "' and societyID = " + SocietyID;
            }


            else if (FlatNumber != "" && ResType == "All")
            {
                ResidentGenQuery = "  select * from " + CONSTANTS.View_SocietyUser + " where (Type = 'Owner' or Type = 'Tenant') and FlatNumber ='" + FlatNumber + "' and societyID = " + SocietyID;
            }

            else if (FlatNumber == "" && ResType != "All")
            {
                ResidentGenQuery = "select * from " + CONSTANTS.View_SocietyUser + " where Type ='" + ResType + "' and societyID = " + SocietyID ;
            }

            else if (FlatNumber == "" && ResType == "All")
            {
                ResidentGenQuery = "select * from " + CONSTANTS.View_SocietyUser + " where (Type = 'Owner' or Type = 'Tenant') and societyID = '" + SocietyID + "'";
            }

            DataAccess dacess = new DataAccess();
            return dacess.GetData(ResidentGenQuery);
        }
        catch (Exception ex)
        {
            return null;
        }
       
    }

    public DataSet GetInReviewResident(int _SocietyID)
    {
        try
        { 
        String ResidentGenQuery = "select * from " + CONSTANTS.View_SocietyUser + " where Type = 'Owner' and StatusID = 1 and societyID = '" + _SocietyID + "'";
        DataAccess dacess = new DataAccess();
        return dacess.GetData(ResidentGenQuery);
         }
        catch (Exception ex)
        {
            return null;
        }
    }

    public DataSet GetEmployee( int SocietyID, int ServiceTypeID)
    {
        try
        {
            String EmployeeQuery = "";

            EmployeeQuery = "select * from " + CONSTANTS.View_SocietyUser + " where Type = 'Employee' and societyID = '" + SocietyID + "'";

            if (ServiceTypeID > 0)
            {
                EmployeeQuery = "select * from " + CONSTANTS.View_SocietyUser + " where Type = 'Employee' and societyID = '" + SocietyID + "' and ServiceType = " + ServiceTypeID;
            }

            DataAccess dacess = new DataAccess();
            return dacess.GetData(EmployeeQuery);
        }
        catch (Exception ex)
        {
            return null;
        }

    }


    public bool DeactivateResident(DateTime _Date, int _ResID)
    {
        DataAccess dacess = new DataAccess();
        String DeactiveUserQuery = "Update " + CONSTANTS.Table_SocietyUser + "  set Status = 4 , DeActiveDate = '" + _Date.ToString("MM-dd-yyyy HH:MM:ss") + "'  where ResID = " + _ResID ;
        bool result = dacess.Update(DeactiveUserQuery);
        return result;
    }

    public bool ApproveResident(DateTime _Date, int _ResID)
    {
        DataAccess dacess = new DataAccess();
        String DeactiveUserQuery = "Update " + CONSTANTS.Table_SocietyUser + "  set Status = 2 , ActiveDate = '" + _Date.ToString("MM-dd-yyyy HH:MM:ss")
                                   +"', DeActiveDate = '" + _Date.AddYears(5).ToString("MM-dd-yyyy HH:MM:ss") + "'  where ResID = " + _ResID;
        bool result = dacess.Update(DeactiveUserQuery);
        return result;
    }


    public bool InsertUserResident(string FirstName, string LastName, string MobileNo, string EmailId,String Password, string Gender, string Parentname, string UserLogin, string Address)
    {
        DataAccess dacess = new DataAccess();
        User newUser = new User();
        string strNewPassword = newUser.EncryptPassword(EmailId, Password);
        
        String UpdateQuery = "Insert into " + CONSTANTS.Table_Users + 
            " (FirstName, MiddleName,LastName,MobileNo,EmailId,Gender,Parentname,UserLogin, Password,Address) Values('" 
            + FirstName + "','','" + LastName + "','" + MobileNo + "','" + EmailId + "','" + Gender + "','" + Parentname + "','" + UserLogin +"','" + strNewPassword + "','" + Address +  "')";



        bool result = dacess.Update(UpdateQuery);
        return result;
    }

    public int GetUserAvailable(string UserName)
    {
        DataAccess dacess = new DataAccess();
        String UserAvailbleQuery = "Select  * from " + CONSTANTS.Table_Users + " where UserLogin = '" + UserName + "'";
        int UserID = dacess.GetSingleUserValue(UserAvailbleQuery);
        return UserID;
    }

    public DataSet GetEmailAvailable(String EmailID)
    {
        DataAccess dacess = new DataAccess();
        String EmailAvailableQuery = "Select * from " + CONSTANTS.Table_Users + " where EmailId = '" + EmailID + "' ";
        DataSet dUser = dacess.GetUserData(EmailAvailableQuery);
        return dUser;
    }

    public DataSet GetDeactiveCheck(String UserID)
    {
        DataAccess dacess = new DataAccess();
        String CheckDeactiveQuery = "Select DeActiveDate from " + CONSTANTS.Table_SocietyUser + " where UserID = '" + UserID + "' ";
        DataSet ds = dacess.GetData(CheckDeactiveQuery);
        return ds;
    }

    public bool UpdateUserResident(string FirstName, string MiddleName, string LastName, string EmailId, string ParentName, string MobileNo, string UserID)
    {
        DataAccess dacess = new DataAccess();
        String UpdateQuery = "Update " + CONSTANTS.Table_Users + "  SET Firstname='" + FirstName + "', MiddleName='" + MiddleName + "', LastName='" + FirstName + "',Emailid='" + EmailId + "',Parentname= '" + ParentName + "' ,MobileNo='" + MobileNo + "' WHERE UserID ='" + UserID + "'";
        bool result = dacess.Update(UpdateQuery);
        return result;
    }

    public bool UpdateResident(string FirstName, string LastName, string EmailId, string MobileNo, string UserID)
    {
        DataAccess dacess = new DataAccess();
        String UpdatReseQuery = "Update " + CONSTANTS.Table_Users + " SET Firstname='" + FirstName + "', LastName='" + LastName + "',Emailid='" + EmailId + "',MobileNo='" + MobileNo + "' WHERE UserID ='" + UserID + "'";
        bool result = dacess.Update(UpdatReseQuery);
        return result;
    }

    public int GetEditMobileNoAvailable(String UserEditMobileNo)
    {
        DataAccess dacess = new DataAccess();
        String UserAvailbleQuery = "Select  UserID from " + CONSTANTS.Table_Users + " where MobileNo = '" + UserEditMobileNo + "'";
        int UserID = dacess.GetSingleUserValue(UserAvailbleQuery);
        return UserID;
    }
    public int GetEditEmailIDAvailable(String UserEditEmailID)
    {
        DataAccess dacess = new DataAccess();
        String EmailAvailableQuery = "Select UserID from " + CONSTANTS.Table_Users + " where EmailId = '" + UserEditEmailID + "'";
        int UserID = dacess.GetSingleUserValue(EmailAvailableQuery);
        return UserID;
    }

    public User GetEditResidentData(String UserId, String FlatNumber)
    {
        User editUSer = new User();
        DataAccess dacess = new DataAccess();
        SqlConnection con = dacess.ConnectUserDB();
        {
            DataTable dt = new DataTable();

            String EditUserQuery = "select * from " + CONSTANTS.Table_Users + " where UserID ='" + UserId + "'";
            SqlCommand myCommand = new SqlCommand(EditUserQuery, con);
            SqlDataReader myReader = myCommand.ExecuteReader();

            while (myReader.Read())
            {
               
                //editUSer.FlatNumber = FlatNumber;
                editUSer.FirstName = (myReader["FirstName"].ToString());
                editUSer.MiddleName = (myReader["MiddleName"].ToString());
                editUSer.LastName = (myReader["LastName"].ToString());
                editUSer.EmailID = (myReader["Emailid"].ToString());
                editUSer.ParentName = (myReader["Parentname"].ToString().Trim());
                editUSer.MobileNumber = (myReader["MobileNo"].ToString());
                editUSer.UserLogin = (myReader["UserLogin"].ToString());
                editUSer.UserID = Convert.ToInt32(UserId);
                HttpContext.Current.Session.Add("EditUser", editUSer);
                HttpContext.Current.Session["UserID"] = UserId;           
            }
            con.Close();
        }
        return editUSer;
    }

    public List<string> GetFlatNumber(string FlatNumber, int SocietyID)
    {
        List<string> Emp = new List<string>();
        //Changed View name by aarshi on 4 aug 2017, it was throwing exception for ViewOwnerResidents not exist
        //string query = string.Format("Select distinct FlatNumber from dbo.ViewOwnerResidents where FlatNumber like '" + FlatNumber + "%'");

        string query = string.Format("Select distinct FlatNumber from " + CONSTANTS.Table_Flats + " where SocietyID = "+ SocietyID + " and FlatNumber like '" + FlatNumber + "%'");
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

   

    public bool AddEmployeeWithUser(User newUser, int ServiceType, String CompanyName)
    {
        try
        {
            int resultID = 0;
            String EncryptPassword = newUser.EncryptPassword(newUser.UserLogin.ToLower(), newUser.Password);

            String newUserQuery =
                "Insert Into dbo.TotalUsers  (FirstName, MiddleName,LastName,MobileNo,EmailId,Gender,Parentname,UserLogin, Password,Address) output INSERTED.UserID values('" +
                newUser.FirstName + "','','" + newUser.LastName + "','" + newUser.MobileNumber + "','" + newUser.EmailID + "','" + newUser.Gender + "','" + newUser.ParentName + "','" + newUser.UserLogin + "','" + EncryptPassword + "','" + newUser.Address + "')";

            using (TransactionScope tran = new TransactionScope())
            {
                string connString = Utility.SocietyConnectionString;
                using (SqlConnection dbConnection = new SqlConnection(connString))
                {
                    dbConnection.Open();

                    SqlCommand sqlComm = new SqlCommand();
                    sqlComm = dbConnection.CreateCommand();
                    sqlComm.CommandText = newUserQuery;
                    int userId = (int)sqlComm.ExecuteScalar();


                    String societyUserQuery = "Insert Into dbo.SocietyUser  (UserID,FlatID,Type,ServiceType,CompanyName,ActiveDate, SocietyID) output INSERTED.ResID Values('" +
                                                                         userId + "','0','Employee','" + ServiceType + "','" + CompanyName + "','" + newUser.ActiveDate + "','" + SessionVariables.SocietyID + "')";
                    sqlComm.CommandText = societyUserQuery;

                    resultID = (int)sqlComm.ExecuteScalar();


                }
                tran.Complete();
                if (resultID > 0)
                    return true;
                else
                    return false;
            }

        }
        catch (Exception ex)
        {
            return false;
        }

    }

    public bool ActivateUser( int _ResId, DateTime _activeDate, DateTime _deactiveDate)
    {
        try
        {
            DataAccess dacess = new DataAccess();
            String UpdateQuery = "update " + CONSTANTS.Table_SocietyUser
                               + " set ActiveDate = '" + Utility.ChangeDateTimeLocalToSQLServerFormat(_activeDate) + "', DeActiveDate = '" + Utility.ChangeDateTimeLocalToSQLServerFormat(_deactiveDate)
                               + "', Status = 2 Where ResID = " + _ResId;
            
            bool result = dacess.Update(UpdateQuery);
            return result;
        }
        catch (Exception ex)
        {

            return false;
        }
    }

}