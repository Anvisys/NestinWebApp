using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for IUserSocietyData
/// </summary>
public interface IUserSocietyData
{
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

    int AddSocietyUser();
    


}