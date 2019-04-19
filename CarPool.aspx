<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CarPool.aspx.cs" Inherits="CarPool" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/MyFlat.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.11.1.min.js"></script>

    <link rel="stylesheet" href="CSS/ApttTheme.css" />
    <link rel="stylesheet" href="CSS/ApttLayout.css" />
     <link rel="stylesheet" href="CSS/NewAptt.css" />

    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- jQuery library -->
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css" />
   
    <script type="text/javascript" src="Scripts/datetime.js"></script>
   
    <script type="text/javascript" src="https://momentjs.com/downloads/moment.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.43/js/bootstrap-datetimepicker.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.43/css/bootstrap-datetimepicker.min.css"/>
 
    <script>

        var UserId, SocietyID, api_url, selectedPoolId, _ResID;


        $(document).ready(function () {

            UserId = <%=UserID %>;
            SocietyID = '<%=Session["SocietyID"] %>';
            api_url = '<%=Session["api_url"] %>';
            _ResID = <%=ResID%>;
            GetPoolOffers();
            GetMyPoolOffers();

        });


        function GetPoolOffers() {
            var abs_url = api_url + "/api/CarPool/All/" + SocietyID +"/"+  _ResID + "/0/20";
            $("#progressBarGetData").show();
            $.ajax({
                url: abs_url,
                dataType: "json",
                success: DisplayPoolData,
                failure: function (response) {
                    alert(response.d);
                    sessionStorage.clear();
                }
            });

        };

   

        function DisplayPoolData(response) {
            $("#progressBarGetData").hide();
           
            var strData = "";
            $("#CarPool").html(strData);
            var results = response.$values;// jQuery.parseJSON(response.$values);
            console.log(results);
            if (results.length > 0) {
                for (var i = 0; i < results.length; i++) {

                    var JourneyDTime = DisplayDateTime(results[i].JourneyDateTime);
                    var ReturnDTime = DisplayDateTime(results[i].ReturnDateTime);
                    var SeatRemaining = parseInt(results[i].AvailableSeats) - parseInt(results[i].InterestedSeatsCount);
                    var ImageSource = "GetImages.ashx?ResID=" + results[i].ResID + "&Name=" + results[i].FirstName + "&UserType= Owner";

                    strData = strData + "<div class=\"col-xs-4\" style=\"margin:0px;padding:10px;\">" +
                        "<div class=\"panel panel-success\">"
                        + "<div class='panel-heading'><div class='row'>"
                            + "<div class='col-xs-7'> <label class='small_label'>Destination :</label><div>" + results[i].Destination + "</div></div>"

                        + "<div class='col-xs-4'>" +"<img class='profile-image' src='" + ImageSource + "' />" + "</div></div>"

                        + "<label class='small_label'> StartTime :   </label><div>" + JourneyDTime +
                        " </div><label class='small_label'> ReturnTime :   </label><div>" + ReturnDTime + "</div></div>"
                        + "<div class='panel-body'>  <label class='data_label'> Vehicle :  </label>" + results[i].VehicleType
                        + "<div><label class='data_label'> Total Seats :  </label>" + results[i].AvailableSeats + "</div>"
                        + "<div>  <label class='data_label'> Cost :  </label>" + results[i].SharedCost + "</div>"
                        + "<div><label class='data_label'> Description :  </label> " + results[i].Description + "</div>"
                        + "<div> <label class='data_label'> Available Seats :  </label>  " + SeatRemaining + " of " + results[i].AvailableSeats + "</div>"
                        + "</div>"
                        + "<div class='panel-footer'><a onclick='ShowInterest(" + results[i].VehiclePoolID + ")'><span class='fa fa-thumbs-up'></span></a>" + results[i].InterestedCount
                        + "<i class='fa fa-users fa-1x pull-right' style='color:blue;' onclick='ShowUsers(" + results[i].VehiclePoolID + ")'></i>"
                        + "</div>"
                        +"</div>"
                        + "</div>";
                   
                }


            }
            else {
                       strData = "<div class=\"col-xs-12\" style=\"margin:0px;padding:10px;\"> No Car Pool Data to display</div>"

            }
            
              
                $("#CarPool").html(strData);
               
        }

        

      

        function ShowInterest(PoolId) {
            selectedPoolId = PoolId;
            $("#showInterestModal").show();
        }

        function ShowUsers() {

        }

        function AddInterest() {
            var CarPoolInterest = {};
            CarPoolInterest.VehiclePoolId = selectedPoolId;
            CarPoolInterest.InterestedResId = <%=ResID%>;
            CarPoolInterest.Seats = $("#in_seats").val();
            CarPoolInterest.DealStatus = 1;
            CarPoolInterest.Comments = $("#in_comments").val();
            var url = api_url + "/api/CarPool/Add/Interest";
            var carPoolInterestData = JSON.stringify(CarPoolInterest);

            $.ajax({
                dataType: "json",
                url: url,
                data: carPoolInterestData,
                type: 'post',
                async: false,
                contentType: 'application/json',
                success: function (data) {

                    $("#showInterestModal").hide();
                },
                error: function (data, errorThrown) {
                    alert('User Creation failed :' + errorThrown);
                    // sessionStorage.clear();
                }

            });


        }

        function CloseInterestModal() {
            $("#showInterestModal").hide();
        }


       
    </script>


    <style>
        .data_label {
            color:#000;
        }

      .model {
            display: none;  /*  Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 100; /* Sit on top */
            padding-top: 8%; /* Location of the box */
             padding-bottom: 2%;
            left: 0px;
            border-radius:5px;
            top: 0px;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto;  /*Enable scroll if needed  */
            background-color: #e6e2e2;
            background-color: rgba(0,0,0,0.4); 
        }
     </style>
</head>
<body>
    <form id="form1" runat="server">
    </form>
    <div class="container-fluid">

        <div class="container-fluid">


            <ul class="nav nav-pills" style="margin-top: 10px;">
                <li role="presentation" class="active"><a href="#AllPool" data-toggle="tab">Pool</a></li>
                <li role="presentation"><a href="#selfPool" data-toggle="tab">My Pool</a></li>
           </ul>
                <div class="tab-content">
                    <div class="tab-pane fade in active" id="AllPool">

                        <div id="CarPool"></div>
                    </div>

                    <%--<div class="tab-pane fade" id="selfPool" style="margin-top: 10px; margin-left: 10px;">
                        <button class="btn btn-primary" onclick="ShowPoolModal()">Add New Trip</button>
                        <div id="MyPool"></div>
                    </div>--%>
                </div>
        </div>

         <div id="progressBarGetData" class="container-fluid" style="text-align: center; height: 200px;display:none;">
                    <img src="Images/Icon/ajax-loader.gif" style="width: 40px; height: 40px; margin-top: 100px;" />
            </div>


       


        <div id="showInterestModal" class="model">
            <div class="modal-content" style="border-radius:5px; width: 350px; margin: auto; margin-top:150px;">
                <div class="modal-header" style="color: white; background-color: #337ab7; height: 50px;">
                    <i class="fa fa-close" style="float:right;cursor:pointer;" onclick="CloseInterestModal()"></i>
                    <h4 id="interestClose" class="modal-title" style="margin-top: 5px;font-family:Helvetica Neue,Helvetica,Arial,sans-serif; font-size:14px">show Interest for Pool:</h4>
                </div>

                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <label class="labelwidth col-sm-4 col-form-label">Seats: </label>
                         <div class="col-sm-8">
                            <input id="in_seats" type="number" onblur="" class="form-control form-control-sm" />
                        </div>
                      </div>
                    </div>
                    <div class="row" style="margin-top: 10px; margin-bottom: 10px">

                        <div class="col-sm-12">
                            <label class="labelwidth col-sm-4 col-form-label ">Comments:</label>
                         <div class="col-sm-8">
                            <input id="in_comments" class="form-control rows="2" form-control-sm" tabindex="2" />
                        </div>
                        </div>
                    </div>
                </div>

                <div class="panel-footer" style="text-align: right;">
                    <button type="button" id="btnInterestCancel" style="margin-top: 5px;" onclick="CloseInterestModal()" data-dismiss="modal" class="btn btn-danger">Cancel</button>
                    <button type="button" id="btnInterestSubmit" style="margin-top: 5px;" onclick="AddInterest();" class="btn btn-primary">Submit</button>

                </div>
            </div>

            <div id="intrestProgressBar" class="container-fluid" style="text-align: center; height: 200px; display:none">
                <img src="Images/Icon/ajax-loader.gif" style="width: 20px; height: 20px; margin-top: 50px;" />
            </div>
        </div>

     
    </div>
</body>
</html>
