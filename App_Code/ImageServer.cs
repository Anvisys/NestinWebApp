using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;


using System.Drawing.Drawing2D;
using System.Drawing.Imaging;

/// <summary>
/// Summary description for ImageServer
/// </summary>
public class ImageServer
{
	public ImageServer()
	{
		//
		// TODO: Add constructor logic here
		//

       
	}

    public static bool SaveImage(byte[] imageByte,String ResID)
    {
       // String Savepath = Request.PhysicalApplicationPath + "~\\ImageTest\\";
          var path = System.Web.Hosting.HostingEnvironment.MapPath("~/ImageServer/User");

        try
        {
             Image result = null;
             MemoryStream stream = new MemoryStream(imageByte);
             result = new Bitmap(stream);

             ImageFormat format = ImageFormat.Png;

              using (Image imageToExport = result)
             {
              // string filePath = string.Format(@"D:\SoftwareProjects\Notes\.{0}", format.ToString());

                 string filePath = string.Format(path + "\\" + ResID + ".{0}", format.ToString());

                imageToExport.Save(filePath, format);
               

               }
      stream.Close();
            return true;       
        }

        catch (Exception ex)
        {

            return false;
        }
    
    
    
    }

    public static System.Drawing.Image resizeImage(System.Drawing.Image imgToResize, Size size)
    {
        try
        {
            //Get the image current width
            int sourceWidth = imgToResize.Width;
            //Get the image current height
            int sourceHeight = imgToResize.Height;
            float sourceHWRatio = (float)sourceHeight / (float)sourceWidth;
            float targetHWRation = (float)size.Height / (float)size.Width;
            int newHeight, newWidth = 0;

            if (sourceHWRatio > targetHWRation)
            {
                newHeight = size.Height;
                newWidth = (int)(((float)sourceWidth / (float)sourceHeight) * newHeight);
            }
            else {
                newWidth = size.Width;
                newHeight = (int)(((float)sourceHeight / (float)sourceWidth) * newWidth);
            }

            Bitmap b = null;

            b = new Bitmap(newWidth, newHeight);
            Graphics g = Graphics.FromImage((System.Drawing.Image)b);
            
            g.InterpolationMode = InterpolationMode.HighQualityBicubic;
            // Draw image with new width and height
            g.DrawImage(imgToResize, 0, 0, newWidth, newHeight);
            g.Dispose();

            return (System.Drawing.Image)b;

        }


        catch (Exception ex)
        {
            return null;
        }

        finally
        {

        }
    }

    public static byte[] ImageToByte(Image img)
    {
        ImageConverter converter = new ImageConverter();
        return (byte[])converter.ConvertTo(img, typeof(byte[]));
    }


}

public class UserDefaultIcon
{
    string backgroundImageName = "bluebg.png";
    Brush textBrush = Brushes.Red;
    string nameFirstLetter = "";                
    public UserDefaultIcon(string name)
    {
        nameFirstLetter = name.Substring(0, 1);
        InitializeParams();
    }
    public string BackgroundImageName
    {
        get { return backgroundImageName; }
    }
    public Brush TextBrush
    {
        get { return textBrush; }
    }

    private void InitializeParams()
    {
        switch (nameFirstLetter)
        {
            case "A":
                backgroundImageName = "bluebg.png";
                textBrush = Brushes.Red;
                break;
            case "B":
                backgroundImageName = "bluebg.png";
                textBrush = Brushes.Orange;
                break;
            case "C":
                backgroundImageName = "bluebg.png";
                textBrush = Brushes.Purple;
                break;
            case "D":
                backgroundImageName = "darkredbg.png";
                textBrush = Brushes.Blue;
                break;
            case "E":
                backgroundImageName = "darkredbg.png";
                textBrush = Brushes.Green;
                break;
            case "F":
                backgroundImageName = "darkredbg.png";
                textBrush = Brushes.Yellow;
                break;
            case "G":
                backgroundImageName = "greenbg.png";
                textBrush = Brushes.DarkRed;
                break;
            case "H":
                backgroundImageName = "greenbg.png";
                textBrush = Brushes.DarkBlue;
                break;
            case "I":
                backgroundImageName = "greenbg.png";
                textBrush = Brushes.Purple;
                break;
            case "J":
                backgroundImageName = "greenbg.png";
                textBrush = Brushes.Black;
                break;
            case "K":
                backgroundImageName = "orangebg.png";
                textBrush = Brushes.Green;
                break;
            case "L":
                backgroundImageName = "orangebg.png";
                textBrush = Brushes.Blue;
                break;
            case "M":
                backgroundImageName = "orangebg.png";
                textBrush = Brushes.Yellow;
                break;
            case "N":
                backgroundImageName = "orangebg.png";
                textBrush = Brushes.Green;
                break;
            case "O":
                backgroundImageName = "orangebg.png";
                textBrush = Brushes.DarkRed;
                break;
            case "P":
                backgroundImageName = "purplebg.png";
                textBrush = Brushes.WhiteSmoke;
                break;
            case "Q":
                backgroundImageName = "purplebg.png";
                textBrush = Brushes.DarkBlue;
                break;
            case "R":
                backgroundImageName = "purplebg.png";
                textBrush = Brushes.DarkGreen;
                break;
            case "S":
                backgroundImageName = "purplebg.png";
                textBrush = Brushes.DarkGoldenrod;
                break;
            case "T":
                backgroundImageName = "purplebg.png";
                textBrush = Brushes.AntiqueWhite;
                break;
            case "U":
                backgroundImageName = "yellowbg.png";
                textBrush = Brushes.Blue;
                break;
            case "V":
                backgroundImageName = "yellowbg.png";
                textBrush = Brushes.Green;
                break;
            case "W":
                backgroundImageName = "yellowbg.png";
                textBrush = Brushes.Red;
                break;
            case "X":
                backgroundImageName = "rosebg.png";
                textBrush = Brushes.CadetBlue;
                break;
            case "Y":
                backgroundImageName = "rosebg.png";
                textBrush = Brushes.DarkSeaGreen;
                break;
            case "Z":
                backgroundImageName = "rosebg.png";
                textBrush = Brushes.Black;
                break;
               

        }
    }
}