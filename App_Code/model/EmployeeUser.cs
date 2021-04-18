using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Employee
/// </summary>
public class EmployeeUser : IUser
{
    public EmployeeUser()
    {
        FlatId = 0;
    }

    public string Gender { get; set; }

    public int FlatId { get; set; }
    public string FirstName { get; set; }
    public string MiddleName { get; set; }
    public string LastName { get; set; }
    public string MobileNo { get; set; }
    public string EmailId { get; set; }
    public string Parentname { get; set; }
    public string UserLogin { get; set; }
    public string Password { get; set; }


    public string Address { get; set; }

    public int UserId { get; set; }
    public int SocietyID { get; set; }
    public int Status { get; set; }
    public string Type { get; set; }
    public int ServiceType { get; set; }
    public string CompanyName { get; set; }
    public string DeActiveDate { get; set; }
    public string ActiveDate { get; set; }
    public string ModifiedDate { get; set; }

    public int HouseID
    {
        get
        {
            throw new NotImplementedException();
        }

        set
        {
            throw new NotImplementedException();
        }
    }

    public int AddSocietyUser()
    {
        throw new NotImplementedException();
    }

    public int AddUser()
    {
        throw new NotImplementedException();
    }

  
}