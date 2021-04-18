using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Owner
/// </summary>
public class OwnerUser : IUser
{
    public OwnerUser() 
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public string Gender
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

    public int FlatId { get ; set; }
    public string FirstName { get; set; }
    public string MiddleName { get; set; }
    public string LastName { get; set; }
    public string MobileNo { get; set; }
    public string EmailId { get; set; }
    public string Parentname { get; set; }
    public string UserLogin { get; set; }
    public string Password { get; set; }
    public int UserId { get; set; }
    public int HouseID { get; set; }
    public string Actdate { get; set; }
    public string Deactdate { get; set; }

    public string Address { get; set; }

    public int SocietyID { get; set; }
    public int Status { get; set; }
    public string Type { get; set; }
    public int ServiceType { get; set; }
    public string CompanyName { get; set; }
    public string DeActiveDate { get; set; }
    public string ActiveDate { get; set; }
    public string ModifiedDate { get; set; }



    public int AddUser()
    {
        throw new NotImplementedException();
    }

 
}