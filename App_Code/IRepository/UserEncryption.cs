using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

/// <summary>
/// Summary description for UserEncryption
/// </summary>
public abstract class UserEncryption
{
    public UserEncryption()
    {
        //
        // TODO: Add constructor logic here
        //
    }



    public string EncryptPassword(string userID, string userPWD)
    {
        userID = userID.ToLower();
        MD5CryptoServiceProvider encoder = new MD5CryptoServiceProvider();
        byte[] bytDataToHash = Encoding.UTF8.GetBytes(userID + userPWD);
        byte[] bytHashValue = new System.Security.Cryptography.MD5CryptoServiceProvider().ComputeHash(bytDataToHash);
        return BitConverter.ToString(bytHashValue).Replace("-", "");
    }

    public string DecryptPassword(string userID, string Password)
    {
        UTF8Encoding UTF8 = new UTF8Encoding();
        MD5CryptoServiceProvider decoder = new MD5CryptoServiceProvider();
        byte[] bytedata = decoder.ComputeHash(UTF8.GetBytes(userID + Password));
        byte[] byvalue = new System.Security.Cryptography.MD5CryptoServiceProvider().ComputeHash(bytedata);
        return Password;
    }
}