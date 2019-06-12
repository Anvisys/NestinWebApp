using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Threading.Tasks;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Data;

[Serializable]
public partial class Societies : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       // ReadSocieties();
       
    }

    public Society[] ReadSocieties()
    {
        Society[] societies = null;
        using (var client = new HttpClient())
        {
            client.BaseAddress = new Uri("http://localhost:5103/api/society/");
            var responseTask = client.GetAsync("All");
            responseTask.Wait();

            var result = responseTask.Result;
            if (result.IsSuccessStatusCode)
            {
                var readTask = result.Content.ReadAsAsync<Society[]>();
                readTask.Wait();

                societies = readTask.Result;

            }
        }
        return societies;
    }

}