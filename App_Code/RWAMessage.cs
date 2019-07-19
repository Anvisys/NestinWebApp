using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for RWAMessage
/// </summary>
public class RWAMessage
{
    public RWAMessage()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public int notice_id { get; set; }

    public String message { get; set; }

    public string notice_date { get; set; }

    public int isFile { get; set; }

    public String file_name { get; set; }

    public int sent_by { get; set; }
    public string valid_till { get; set; }

}