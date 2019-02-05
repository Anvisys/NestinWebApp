using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;

/// <summary>
/// Summary description for NestinIdentity
/// </summary>
public class NestinIdentity: System.Security.Principal.IIdentity
{
    private FormsAuthenticationTicket _ticket;
    private string[] userData;
    public NestinIdentity(FormsAuthenticationTicket ticket)
    {
        _ticket = ticket;
        userData = _ticket.UserData.Split("|".ToCharArray());
    }

    public string AuthenticationType
    {
        get { return "Nestin"; }
    }

    public bool IsAuthenticated
    {
        get { return true; }
    }

    public string Name
    {
        get { return _ticket.Name; }
    }

    public FormsAuthenticationTicket Ticket
    {
        get { return _ticket; }
    }
  //  string userDataString = string.Concat(user.ID, "|", user.ResiID, "|", user.strFirstName, "|", user.strLastName,
   //         "|", user.SocietyName, "|", user.FlatNumber);
    public string UserID
    {
        get { return userData[0]; }
    }
    public string UserType
    {
        get { return userData[1]; }
    }
    public string ResID
    {
        get { return userData[2]; }
    }
    public string UserFirstName
    {
        get { return userData[3]; }
    }
    public string UserLastName
    {
        get { return userData[4]; }
    }
    public string SocietyName
    {
        get { return userData[5]; }
    }
    public string FlatNumber
    {
        get { return userData[6]; }
    }

}