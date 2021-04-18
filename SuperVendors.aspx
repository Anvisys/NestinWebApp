<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SuperVendors.aspx.cs" Inherits="SuperVendors" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <!-- CORE CSS -->

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />


    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js"></script>  
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>  
    <link rel="Stylesheet" href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.10/themes/redmond/jquery-ui.css" /> 

    <script>
          var SocID;

        $(document).ready(function () {
                api_url = '<%=Session["api_url"] %>';
          SocID = getUrlVars()["SocID"];
          
            GetVendorData();
        });



          function GetVendorData() {
               var url = api_url + "/api/Vendor/Get/" + SocID + "/All/1/20";
               
               console.log(url);
                $.ajax({
                    dataType: "json",
                    url: url,
                    success: OnSuccess,
                    error: function (data, errorThrown) {

                        alert('request failed :' + errorThrown);
                    }

                });
        }


        function OnSuccess(response) {
             console.log(response);
            var strVendor = "";
            var countVendor = 0;
            

            var results = response; //jQuery.parseJSON(response);
            console.log(results);
            countVendor = results.length;
            if (results.length > 0) {
                for (var i = 0; i < results.length; i++) {
                    console.log(JSON.stringify(results[0]));

                    var strButton =""
                  /*  if (results[i].Status == 'Approved') {

                        strButton = "<button class='btn btn-primary btn-sm' disabled>Done</button>";

                    }
                    else if(results[i].Status == 'Applied'){
                        strButton = "<button class='btn btn-primary btn-sm' onClick='ApproveRequest(" + results[i].SocietyID + ")' >Approve</button>"
                            + " &nbsp&nbsp<button class='btn btn-primary btn-sm' onClick='RejectRequest(" + results[i].SocietyID + ")'>Reject</button> ";
                    }*/

                    var row = "<div class=\"row \" style=\"margin-top:5px;margin-left:100px;border-top:solid 1px black;\">"
                        + "<div class='row'><div class='col-xs-4'>" + results[i].ShopCategory + "</div>"
                        + "<div class='col-xs-4'>Name:" + results[i].VendorName + "</div><div class='col-xs-4'>Contact:" + results[i].ContactNumber + "<b style='color:blue;'>VendorID: " + results[i].VendorID + "</b></div>"
                        + "</div>"
                        + "<div class='row'>"
                        + "<div class='col-xs-4'>Address:" + results[i].Address + " " + results[i].Address2 + "</div> <div class='col-xs-4'> " + + "</div> <div class='col-xs-4'> City : " + results[i].MobileNo + "</div>"
                        + "</div>"
                        + "<div class='row'><div class='col-xs-8'>Contact" + results[i].ContactNumber2 + "&nbsp&nbsp" + strButton + "</div> " +
                        "<div class='col-xs-4'>" 
                        + "</div></div>"
                        
                        + "</div>";

                    strVendor = strVendor + row;
                
                }
                strVendor = "&nbsp;&nbsp;&nbsp;Total Vendors    " + countVendor + "<br/>" + strVendor;
                $("#VendorList").html(strVendor);

            }
            else {
                 strVendor = "&nbsp;&nbsp;&nbsp;Total Vendors    " + countVendor + "<br/>";
                $("#VendorList").html(strVendor);
            }

        }

        function getUrlVars()
        {
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for(var i = 0; i < hashes.length; i++)
            {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
        }


    </script>

</head>
<body>
    <form id="form1" runat="server">
 
            <div class="row" id="VendorList" style="background:#a1a1a1; margin-top:50px;">

        </div>
    </form>
</body>
</html>
