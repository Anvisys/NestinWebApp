using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Flat
/// </summary>
public interface IFlat
{
    string FlatNumber { get; set; }
    int Floor { get; set; }
    string Block { get; set; }
    int IntercomNumber { get; set; }
    int BHK { get; set; }
    int UserID { get; set; }
    string FlatArea { get; set; }
    int SocietyID { get; set; }
    DateTime FlatAddDate { get; set; }

    int AddFlat();
}