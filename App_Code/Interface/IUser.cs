using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for IUser
/// </summary>
public interface IUser
{
 
    string FirstName { get; set; }
    String MiddleName { get; set; }
    String LastName { get; set; }
    string Gender { get; set; }
    String MobileNo { get; set; }
    String EmailId { get; set; }
    String Parentname { get; set; }
    String Address { get; set; }
    String UserLogin { get; set; }
    String Password { get; set; }

    int UserId { get; set; }
    int FlatId { get; set; }
    int HouseID { get; set; }
    int SocietyID { get; set; }
    int Status { get; set; }
    string Type { get; set; }
    int ServiceType { get; set; }
    string CompanyName { get; set; }
    string DeActiveDate { get; set; }
    string ActiveDate { get; set; }
    string ModifiedDate { get; set; }

    int AddUser();
}