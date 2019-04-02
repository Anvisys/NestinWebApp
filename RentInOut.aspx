<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RentInOut.aspx.cs" Inherits="RentInOut" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <meta charset="utf-8"/>
   <meta name="viewport" content="width=device-width, initial-scale=1"/>
      
    <link href="Styles/MyFlat.css" rel="stylesheet" type="text/css" />
      <script src="Scripts/jquery-1.11.1.min.js"></script>
     
    <link rel="stylesheet" href="CSS/ApttTheme.css" />
    <link rel="stylesheet" href="CSS/ApttLayout.css" />

             <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
            <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
            <!-- jQuery library -->
            <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
   
            <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css"/>  
    
    <script>

          var UserId,SocietyID,api_url;
       

        $(document).ready(function () {
        
            UserId = <%=UserID %>;
            SocietyID = '<%=Session["SocietyID"] %>';
             api_url = '<%=Session["api_url"] %>';
            GetSocietyRequest();

        });


        function GetSocietyRequest() {
            var abs_url =  api_url + "/api/RentInventory/" + SocietyID;
       
             $.ajax({
                url: abs_url,
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert(response.d);
                    sessionStorage.clear();
                }
            });

        };


         function OnSuccess(response) {
              // alert(JSON.stringify(response));
              var strData = "";

            var results = response.$values;
           
            if (results.length > 0) {
                for (var i = 0; i < results.length; i++) {
                    strData = strData + "<div class=\"col-xs-3 panel panel-primary\" style=\"margin:20px;padding:0px;\">" +
                        "<div class='panel-heading'>" + results[i].Inventory + " " + results[i].RentType + " ,<br/> Rent " + results[i].RentValue + "</div>"
                        + "<div class='panel-body'> Sector " + results[i].Description + "<div> Contact" + results[i].ContactName + "</div>"
                        + "<div>" + results[i].ContactNumber + ", " + results[i].FlatNumber + "</div></div>"
                        + "<div class='panel-footer'><a href=''  onclick='ShowInterest(" + results[i].RentInventoryID + ")'><span class='fa fa-thumbs-up'></span></a></div>"
                        + "</div>";
                }


            $("#RentInView").html(strData);



              
            }
            else {
                
            }

        }

        function ShowInterest(RentInventoryID) {
            alert(RentInventoryID);
        }

    </script>

    <style>
             .card {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
  max-width: 300px;
  margin: auto;
  text-align: center;
  font-family: arial;
  background-color:#fff;
}
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
     <div class="container-fluid"> 
         <div class="row" id="RentInView"></div>

     </div>
</body>
</html>
