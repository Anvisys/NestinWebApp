using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for IUserRepository
/// </summary>
public interface IUserRepository
{
    int AddUser(IUser user);

}