using System;
using System.Activities.DurableInstancing;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for UserFactory
/// </summary>
public class UserFactory
{
    enum Type
    {
        Owner,    // 0
        Admin,           // 1
        Tenant, // 6
        Employee,           // 7
        Empty,
        Demo
    }

    public UserFactory()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public IUser GetUser(string UserType, User user)
    {
        if (UserType.Equals("Owner"))
            return new OwnerUser();
        else if (UserType.Equals("Employee"))
            return new EmployeeUser();
        else if (UserType.Equals("Demo"))
            return new DemoUser(user);
        else if (UserType.Equals("Empty"))
            return new EmptyUser(user);
        else
            return null;
    }
}