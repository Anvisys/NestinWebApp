using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;

/// <summary>
/// Summary description for Notification
/// </summary>
public class Notification
{


    public Notification()
    {
      
    }

    public enum TO { All, Society, User, Flat }


    public void Notify(TO sendTo, int ID, Message message)
    {
        String textMessage = message.Topic + "&" + message.TextMessage;

        DataSet ds = GetReceipents(sendTo, ID, message.Topic);
        {
            if (ds != null)
                ds.Tables[0].AsEnumerable();

            var GCMList = (from g in ds.Tables[0].AsEnumerable()
                                   where g.Field<bool>("GCM") == true
                                   select g.Field<String>("RegID")).ToArray();


                    if (GCMList.Count() > 0)
                    {
                        string gcmArray = String.Concat(GCMList);

                        SendNotification(gcmArray, textMessage);
                    }

                    var mailList = (from g in ds.Tables[0].AsEnumerable()
                                    where g.Field<bool>("Mail") == true
                                    select g.Field<String>("RegID")).ToArray();

                    foreach (String mail in mailList)
                    {

                            SendMail(mail, message.Topic, message.TextMessage);
                        
                    }
                }

    }


    private DataSet GetReceipents(TO sendTo, int ID, String Topic)
    {
        DataSet ds;
        if (sendTo == TO.All)
        {
            DataAccess dacess = new DataAccess();
            //String VendorQuery = "Select * from dbo.aSocietybillplans";
            String VendorQuery = "Select * from ViewNewUserSetting where Topic ='" + Topic + "' ";
            ds = dacess.GetData(VendorQuery);
          
        }
        else if (sendTo == TO.Society)
        {
            DataAccess dacess = new DataAccess();
            //String VendorQuery = "Select * from dbo.aSocietybillplans";
            String VendorQuery = "Select * from ViewNewUserSetting where Topic ='" + Topic + "' and SocietyID = " + ID;
             ds = dacess.GetData(VendorQuery);
         
        }
        else
        {

            DataAccess dacess = new DataAccess();
            //String VendorQuery = "Select * from dbo.aSocietybillplans";
            String VendorQuery = "Select * from ViewNewUserSetting where Topic ='" + Topic + "' and ResID = " + ID;
            ds = dacess.GetData(VendorQuery);
        }

        return ds;
    }

    public void SendMail(string EmailID, string EmailSubject,string EmailBody)
    {
        try
        {
          
            string URI = "http://www.nestin.online/php/MyApttMail.php";
            WebRequest request = WebRequest.Create(URI);
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            string postData = "ToMail=" + EmailID + "&Subject=" + EmailSubject + "&html_Message=" + EmailBody;
            Stream dataStream = request.GetRequestStream();
            byte[] byteArray = Encoding.UTF8.GetBytes(postData);
            dataStream.Write(byteArray, 0, byteArray.Length);
            dataStream.Close();
            WebResponse response = request.GetResponse();

            StreamReader reader = new StreamReader(response.GetResponseStream());
            reader.Close();
            dataStream.Close();
            response.Close();
        }
        catch (Exception ex)
        { }

    }

    public void SendNotification(string receiverID, string NotificationText)
    {
      
        string url = "https://android.googleapis.com/gcm/send";
        String RegID = receiverID;
        String API_KEY = "AIzaSyBBny4kCJmN1Ep3NlUxImIF7iHz6OC6YWQ";
        String SENDER_ID = "288809313667";
        WebRequest tRequest;

        tRequest = WebRequest.Create(url);

        tRequest.Method = "post";

        // tRequest.ContentType = " application/x-www-form-urlencoded;charset=UTF-8";


        tRequest.ContentType = "application/json";

        tRequest.Headers.Add(string.Format("Authorization: key={0}", API_KEY));

        tRequest.Headers.Add(string.Format("Sender: id={0}", SENDER_ID));

        string postData = "{\"collapse_key\":\"score_update\",\"time_to_live\":108,\"delay_while_idle\":true,\"data\": { \"msg\" : " + "\"" + NotificationText + "\",\"time\": " + "\"" + System.DateTime.Now.ToString() + "\"},\"registration_ids\":[\"" + receiverID + "\"]}";

        Byte[] byteArray = System.Text.Encoding.UTF8.GetBytes(postData);

        tRequest.ContentLength = byteArray.Length;

        Stream dataStream = tRequest.GetRequestStream();

        dataStream.Write(byteArray, 0, byteArray.Length);

        dataStream.Close();

        WebResponse tResponse = tRequest.GetResponse();

        dataStream = tResponse.GetResponseStream();

        StreamReader tReader = new StreamReader(dataStream);

        String sResponseFromServer = tReader.ReadToEnd();   //Get response from GCM server.

        //lblnotifResp.Text = sResponseFromServer;      //Assigning GCM response to Label text 

        tReader.Close();
        dataStream.Close();
        tResponse.Close();
    }


}