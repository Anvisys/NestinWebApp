using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Net;
using System.IO;
using System.Data;
using System.Text;
using Newtonsoft.Json;

public partial class Aboutus : System.Web.UI.Page
{

    User muser;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    

    public class Users
    {
        public string Username { get; set; }
        public string Password { get; set; }
    }
}