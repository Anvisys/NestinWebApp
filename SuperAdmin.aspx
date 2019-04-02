<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SuperAdmin.aspx.cs" Inherits="SuperAdmin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

       <meta name="viewport" content="width=device-width, maximum-scale=1, initial-scale=1, user-scalable=0" />
    <meta name="description" content="The MyAptt System is developed considering the day to day needs of society like complaints, Notification, social communication as well as managing the Residents, Vendors, and Employees Data of a society. Application caters the need of small to large societies and also provide the customization to meet your specific needs." />
    <meta name="keywords" content="Society Management,Residential Society Management,Complaint Management,Society Expenses,Billing Software" />
    <meta name="developer" content="Anvisys Technologies Pvt. Ltd." />

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

    <link href="Login/css/settings.css" rel="stylesheet" type="text/css" />
    <!-- THEME CSS -->

    <link href="Login/css/essentials.css" rel="stylesheet" type="text/css" />
    <link href="Login/css/layout.css" rel="stylesheet" type="text/css" />
    <link href="Login/css/layout-responsive.css" rel="stylesheet" type="text/css" />

    <link href="Styles/layout.css" rel="stylesheet" />
    <link href="Styles/Responsive.css" rel="stylesheet" />

    <link rel="stylesheet" href="CSS/ApttTheme.css" />
    <link rel="stylesheet" href="CSS/ApttLayout.css" />
    <link rel="stylesheet" href="Login/CSS/footer.css" />
    <link rel="stylesheet" href="CSS/NewAptt.css" />



    <script>

          var UserId;
       

        $(document).ready(function () {
        
            UserId = <%=UserID %>;

            GetSocietyRequest();

        });


           function GetSocietyRequest() {
         
             $.ajax({
                url: "SuperAdmin.aspx/GetSocietyRequest",
                type: 'Post',
                async: false,
                contentType: 'application/json',
                success: OnSuccess,
                failure: function (response) {
                    alert(response.d);
                    sessionStorage.clear();
                }
            });

        };


         function OnSuccess(response) {

              var strData = "";

            var results = jQuery.parseJSON(response.d);
           
            if (results.length > 0) {
                for (var i = 0; i < results.length; i++) {
                    console.log(JSON.stringify(results[0]));

                     strData = strData + "<div class=\"row \" style=\"margin-top:20px;margin-left:100px;\">" +
                    "<div class='row'><div class='col-xs-8'>" + results[i].SocietyID + " " + results[i].SocietyName + " , Total Flats " + results[i].TotalFlats + "</div><div class='col-xs-4'></div></div>"
                    + "<div class='col-xs-4'> Sector " + results[i].Sector + "</div> <div class='col-xs-8'> City" + results[i].City + "</div>"
                    + "<div class='row'><div class='col-xs-12'> Pin" + results[i].PinCode + ", " + results[i].State + "</div><hr size='2'></div>" +
                    "<button type='button' class='btn btn-primary btn-sm' onclick='Close("+ results[i].ContactUserId +",\"" + results[i].Status +"\")' >Close</button>"
                    +"</div>"
                }


            $("#SocitiesView").html(strData);



              
            }
            else {
                
            }

        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
           
        </div>
    </form>
     <div class="container-fluid"> 
         <div class="row" id="SocitiesView"></div>

     </div>
</body>
</html>
