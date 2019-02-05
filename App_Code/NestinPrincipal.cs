using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Principal;

/// <summary>
/// Summary description for NestinPrincipal
/// </summary>
public class NestinPrincipal: System.Security.Principal.IPrincipal
{
    private NestinIdentity _identity;
    public NestinPrincipal(NestinIdentity identity)
    {
        _identity = identity;
    }

    public System.Security.Principal.IIdentity Identity
    {
        get { return _identity; }
    }

    public bool IsInRole(string role)
    {
        return false;
    }
}