using System;
using System.Activities.Validation;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for EmptyUser
/// </summary>
public class EmptyUser: IUser
{
    IUserRepository userRepository;
    public EmptyUser(User user)
    {
        this.FirstName = user.FirstName;
        this.MiddleName = user.MiddleName;
        this.LastName = user.LastName;
        this.Gender = user.Gender;
        this.MobileNo = user.MobileNumber;
        this.EmailId = user.EmailID;
        this.Parentname = user.ParentName;
        this.UserLogin = user.EmailID;
        this.Password = user.Password;
        this.Address = user.Address;
    }

    public string FirstName { get; set; }

    public string MiddleName { get; set; }
    public string LastName { get; set; }
    public string Gender { get; set; }
    public string MobileNo { get; set; }
    public string EmailId { get; set; }
    public string Parentname { get; set; }
    public string Address { get; set; }
    public string UserLogin { get; set; }
    public string Password { get; set; }
    public int UserId { get; set; }
    public int FlatId { get; set; }
    public int HouseID { get; set; }
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
        userRepository = new UserRepository();
        int ResID = userRepository.AddUser(this);

        return ResID;
    }
}