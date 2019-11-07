using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;


/// <summary>
/// Summary description for VendorController
/// </summary>
public class VendorController
{
    public VendorController()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public int AddVendor(Vendor newVendor)
    {
        try
        {
            DataAccess dacess = new DataAccess();
            String InsetdataQuery = "Insert Into Vendors (ShopCategoryID,VendorName,ContactNumber,ContactNumber2,Address,Address2,InsertDate,SocietyID, CmdType) output INSERTED.ID Values ('"
                       + newVendor.ShopCategoryID + "','" + newVendor.VendorName + "','" + newVendor.ContactNumber + "','" + newVendor.ContactNumber2 + "','" + newVendor.Address + "','" + newVendor.Address2 + "','" + Utility.ChangeDateTimeLocalToSQLServerFormat(DateTime.UtcNow) + "'," + SessionVariables.SocietyID + ",'insert')";
            int ID = dacess.GetSingleValue(InsetdataQuery);
            return ID;
        }
        catch (Exception ex)
        {
            return 0;
        }
    }


    public bool UpdateVendor(Vendor newVendor)
    {
        try
        {
            DataAccess dacess = new DataAccess();
            String updateVendorQuery = "Update  dbo.Vendors set ShopCategoryID = '" + newVendor.ShopCategoryID + "',   VendorName= '" + newVendor.VendorName + "', ContactNumber ='" + newVendor.ContactNumber
                                    + "', ContactNumber2 ='" + newVendor.ContactNumber2 + "', Address = '"  + newVendor.Address + "', Address2 = '" + newVendor.Address2 + "' ,InsertDate = '" + Utility.ChangeDateTimeLocalToSQLServerFormat(DateTime.Now)
                                    + "' ,CmdType ='Update'   where ID = '" + newVendor.ID + "'";

            bool result = dacess.UpdateQuery(updateVendorQuery);
            return result;
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    public bool AddImage(byte[] bytesImages, int VendorID, String SavePath) {
        try {

            string imagename = VendorID.ToString();
            ImageFormat format = ImageFormat.Png;
            string filePath = string.Format(SavePath + "\\" + imagename + ".{0}", format.ToString());
            using (FileStream stream = new FileStream(filePath, FileMode.Create))
            {
                stream.Write(bytesImages, 0, bytesImages.Length);
                stream.Flush();
            }


            using (SqlConnection con1 = new SqlConnection(Utility.SocietyConnectionString))
            {
                con1.Open();
                String ImageQuery = "Update " + CONSTANTS.Table_Vendor + " Set VendorIcon = @VendorIcon";

            
                SqlCommand cmd = new SqlCommand(ImageQuery, con1);
                cmd.Parameters.Add("@VendorIcon", SqlDbType.Image).Value = bytesImages;
                int count = cmd.ExecuteNonQuery();
                con1.Close();

                DataAccess dacess = new DataAccess();
               bool result = dacess.Update(ImageQuery);
                return result;

            }
            }
        catch (Exception ex)
        {
            return false;
        }
    }


    public bool AddOffer( Offer newOffer)
    {
        try {
            DataAccess dacess = new DataAccess();
            String insertOffer = "Insert into " + CONSTANTS.Table_VendorOffer + "(VendorID, offerdescription,StartDate,EndDate,SocietyID) output INSERTED.ID Values("
                                  + newOffer.VendorID + ",'" + newOffer.offerdescription + "','" + newOffer.StartDate.ToString("yyyy-MM-dd HH:mm:ss") 
                                  + "','" + newOffer.EndDate.ToString("yyyy-MM-dd HH:mm:ss") + "'," + newOffer.SocietyID + ")";

            bool result = dacess.Update(insertOffer);
            return result;
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    public DataSet GetVendors(int SocietyID, String UserType, int VendorCategory)
    {
        try {

            DataAccess dacess = new DataAccess();
            String DatalistQuery;

            if (UserType.Equals("SuperAdmin"))
            {
                
                if (VendorCategory == 0)
                {
                    DatalistQuery = "Select * from " + CONSTANTS.View_Vendors + " order by ShopCategory asc  ";
                }
                else
                {
                    DatalistQuery = "Select * from " + CONSTANTS.View_Vendors +  " order by ShopCategoryID asc  ";
                }
            }
            else
            {
                if (VendorCategory == 0)
                {
                    DatalistQuery = "Select * from " + CONSTANTS.View_Vendors + " Where SocietyID =" + SocietyID +" order by ShopCategoryID asc  ";
                }
                else {
                    DatalistQuery = "Select * from " + CONSTANTS.View_Vendors + " Where SocietyID =" + SocietyID + " and ShopCategoryID = " + VendorCategory + "order by ShopCategoryID asc  ";
                }
                
            }

           

            DataSet DatasetVendors = dacess.ReadData(DatalistQuery);

            return DatasetVendors;

        }
        catch (Exception ex)
        {
            return null;
        }

    }


}

public class Offer
{
    public int VendorID { get; set; }
    public String offerdescription { get; set; }

    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    public int SocietyID { get; set; }
}

public class Vendor
{
    public int ID { get; set; }

    public int ShopCategoryID { get; set; }

    public String VendorName { get; set; }

    public String ContactNumber { get; set; }

    public String Address { get; set; }

    public DateTime InsertDate{ get; set; }
	public int SocietyID { get; set; }

    public string ContactNumber2 { get; set; }
	public string Address2 { get; set; }
    public string IconFormat { get; set; }
}