using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Advertisement
/// </summary>
public class Ads
{
	public Ads()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public String Owner { get; set; }

    public String Title { get; set; }

    public String AdImage { get; set; }
    public String Description { get; set; }

    public String Offer { get; set; }

    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
}