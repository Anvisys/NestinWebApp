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
    public static string Table_User_Image = "dbo.UserImage";
    public static string Table_Flats = "dbo.Flats";
    public static string Table_IndependentHouse = "dbo.House";
    public static string Table_SocietyUser = " dbo.SocietyUser";
    public static string Table_Society = " dbo.Societies";

    public static string View_SocietyUser = "dbo.ViewSocietyUsers";
    public static string View_Society = "dbo.ViewSocieties";
    public static string View_Employee = "dbo.ViewEmployeeAssignment";

    public static string Table_Resident = "dbo.Resident";

    public static string Table_GeneratedBill = "dbo.GeneratedBill";
    public static string View_LatestFlatBill = "dbo.ViewLatestFlatBill";

    public static string Table_VendorOffer = "dbo.Offers";

    public static string Table_Vendor = "dbo.Vendors";
    public static string Table_Offer = "dbo.Offers";
    public static string View_Vendors = "dbo.ViewVendor";
    public static string View_LatestOffer = "dbo.ViewLatestOffer";

    public static string View_Notices = "dbo.ViewNotifications";

    public static string View_Forum_Summary = "dbo.ViewThreadSummaryNoImageCount";

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