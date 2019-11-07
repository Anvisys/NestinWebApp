<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Societies.aspx.cs" Inherits="Societies" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
         <script src="Scripts/jquery-1.11.1.min.js"></script>

     <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

      <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>



    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }

        table{
            width:40%;
            padding:5px;
            background:#8ddbed;
            border:1px solid double blue;
        }
    </style>

    <script>

        $(document).ready(function () {
            window.parent.FrameSourceChanged();
            GetSocietyData();

        });


        function GetSocietyData() {

            var api_url = '<%=Session["api_url"] %>';
            //var api_url = 'http://localhost:5103/api/';
            var societyURL = api_url + "/api/society/all";

            $.ajax({
                url: societyURL,
                dataType: "Json",
                success: function (data) {
                    DisplayData(data);
                    
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    var err = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(err.Message)
                    console.log("Ajax Error!");
                }
            });

        }

        function DisplayData(data) {
                 console.log(data);
                  /* console.log(data.$values);
                var stringHTMl = JSON.stringify(data);
                 var js = jQuery.parseJSON(stringHTMl);
                console.log("Data!!!= " + js.FirstName);*/

                var jSonArray = data

                var x = jSonArray.length;
                if (x > 0)
                {
                    var html = "";
                    for (var i = 0; i < x; i++)
                    {
                       

                            html = html+ '<div class="row" style="margin-top:10px;" id="index">' +
                                 ' <div class="col-xs-4"> Society Name :' + jSonArray[i].SocietyName + '</div>'+
                                '<div class="col-xs-4"> Admin: ' + jSonArray[i].FirstName + "  " + jSonArray[i].LastName + '</div>' +
                               
                                '<div class="col-xs-4"> Sector: ' +jSonArray[i].Sector + '</div>' +
                                '<div class="col-xs-4"> City: ' + jSonArray[i].City + '</div>' +
                                '<div class="col-xs-4"> Pin Code: ' + jSonArray[i].PinCode + '</div>' +
                                '<div class="col-xs-4"> E mail: ' + jSonArray[i].EmailId + '</div>' +
                                '<div class="col-xs-4"> Mobile Number : ' + jSonArray[i].MobileNo + '</div>' +
                            '</div> <hr/>';
                    }

                      document.getElementById("societyData").innerHTML = html;
                 

                                            
                }


            }



    </script>
</head>
<body>

    <div class="container-fluid">
  

        <div id="societyData">


        </div>
        
        </div>


    <form id="form1" runat="server">
        
<br />
            
    </form>
</body>
</html>
