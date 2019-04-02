using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CONSTANTS
/// </summary>
public class CONSTANTS
{

    public static string Table_Users = "dbo.TotalUsers";
    public static string Table_Flats = "dbo.Flats";
    public static string Table_IndependentHouse = "dbo.House";
    public static string Table_SocietyUser = " dbo.SocietyUser";
    public static string Table_Society = " dbo.Societies";

    public static string View_SocietyUser = "dbo.ViewSocietyUsers";
    public static string View_Society = "dbo.ViewSocieties";
    public static string Table_Resident = "dbo.Resident";
 


    public CONSTANTS()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    
}

public enum Resident_Status {
    Approved=0,
    Applied =1,
    Demo =2,

}