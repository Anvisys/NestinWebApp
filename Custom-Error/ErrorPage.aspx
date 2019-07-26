<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ErrorPage.aspx.cs" Inherits="Custom_Error_ErrorPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <style>

        html
        {
            height:100%;
            box-sizing:border-box;
        }

        body
        {
            background-color:#47476b;
            height:100%;
            
        }

        .pagemain_styling
        {
            display:flex;
            color:aliceblue;
            font-family:Arial;
            font-size:25px;
            align-items:center;
            justify-content:center;
            height:100%;
            font-weight:100;
            
           
        }

        .content_styling
        {
            width:40%; 
           // border:1px solid aliceblue;
            height:30%;
            padding:5px;
            
        }

        button
        {
            margin-right:3px;
            border:2px solid aliceblue;
            width:90px;
            height:40px;
            color:inherit;
            border-radius:5px;
            background:inherit;
        }

        #btnhelp
        {
            background-color:white;
            color:#47476b;
        }

        .imagediv
        {
            height:50%;
            width:30%;
            border:none;
            margin-left:10%;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server" style="height:100%;" >
        <div  class="pagemain_styling">
            
                
                    <div class="content_styling" >
                        <p>Something's Wrong Here.....</p>
                        <p style="font-size: 16px;">We can't find the page you are looking for. Check out our HelpCenter or head back to Home</p>
                        <button id="btnhelp">Help</button>
                        <button id="btnhome">Home</button>
                    </div>

                    <div class="imagediv content_styling">
                        <img src="../Images/Icon/question3.png"></img>
                    </div>
               
           

        </div>
    </form>
</body>
</html>
