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
            var abs_url = api_url + "/api/CarPool/" + SocietyID + "/0/20";
            $("#progressBarGetData").show();
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

        function GetMyPoolOffers() {
            var abs_url = api_url + "/api/CarPool/self/" + SocietyID + "/" + _ResID + "/0/20";

            $.ajax({
                url: abs_url,
                dataType: "json",
                success: MyPoolData,
                failure: function (response) {
                    alert(response.d);
                    sessionStorage.clear();
                }
            });

        };

        function OnSuccess(response) {
            $("#ProgressBar").show();
            var strPoolData = "";
            $("#CarPool").html("");

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
                     alert ('1');
                }
              
                $("#CarPool").html(strData);
                 $("#progressBarGetData").hide();

            }
        }

        


        function MyPoolData(response) {
            var strMyData = "";
            $("#MyPool").html("");
            var results = response.$values;// jQuery.parseJSON(response.$values);

            if (results.length > 0) {
                for (var i = 0; i < results.length; i++) {

                    var JourneyDTime = DisplayDateTime(results[i].JourneyDateTime);
                    var ReturnDTime = DisplayDateTime(results[i].ReturnDateTime);
                    var SeatRemaining = parseInt(results[i].AvailableSeats) - parseInt(results[i].InterestedSeatsCount);

                    strMyData = strMyData + "<div class=\"col-xs-4\" style=\"margin:0px;padding:10px;\">" 
                        +"<div class=\"panel panel-success\" >"
                        + "<div class='panel-heading'><label class='small_label'> Destination :</label><div> " + results[i].Destination
                        + "</div><label class='small_label'> Start Time : </label><div> " + JourneyDTime + "</div><label class='small_label'> Return Time : </label><div> " + ReturnDTime + "</div></div>"
                        + "<div class='panel-body'> <label class='small_label'> Vehicle:  </label>" + results[i].VehicleType
                        + "<div> <label class='data_label'> Total Seats:  </label>" + results[i].AvailableSeats + "</div>"
                        + "<div><label class='data_label'> Cost :  </label>  " + results[i].SharedCost + "</div>"
                        + "<div> <label class='data_label'> Description :  </label>  " + results[i].Description + "</div>"
                        + "<div> <label class='data_label'> Available :  </label>  " + SeatRemaining + " of " + results[i].AvailableSeats + "</div>"
                        + "</div>"
                        + "<div class='panel-footer'><a onclick='Close(" + results[i].VehiclePoolID + ")'><span class='fa fa-trash'></span></a>" + results[i].InterestedCount
                        + "</div>"
                        + "</div>"
                        + "</div>";
                    
                }
                
                $("#MyPool").html(strMyData);

            }
           
        }

        function ShowPoolModal() {
            $("#addCarPoolModal").show();
        }


        function ClosePoolModal() {
            $("#addCarPoolModal").hide();
        }

        function AddPoolOffer() {

            $("#ProgressBar").show();
            var CarPool = {};
            CarPool.OneWay = 0;  // pool_type
            CarPool.PoolTypeID = 1; //pool_cycle   // 1, onetime, 2 for regular
            CarPool.Active = 1;
            CarPool.Destination = $("#destination").val();
            CarPool.InitiatedDateTime = GetDateTimeinISO(new Date());


            var date = $("#date_when").val();
            var time = $("#time_when").val();
            var datetime = date + "T" + time + ":00";

            CarPool.JourneyDateTime = datetime;

            var date_return = $("#date_return").val();
            var time_return = $("#time_return").val();
            var datetime_return = date_return + "T" + time_return + ":00";

            CarPool.ReturnDateTime = datetime_return;

            CarPool.VehicleType = $("#vehicle_type").val();
            CarPool.AvailableSeats = $("#seats").val();
            CarPool.SharedCost = $("#Shared_cost").val();
            CarPool.Description = $("#pool_description").val();
            CarPool.ResID = <%=ResID%>;
            CarPool.SocietyID = <%=SocietyID%>;
            var url = api_url + "/api/CarPool/Add";
            var CarPoolString = JSON.stringify(CarPool);



            $.ajax({
                dataType: "json",
                url: url,
                data: CarPoolString,
                type: 'post',
                async: false,
                contentType: 'application/json',
                success: function (data) {
                    if (data.Response == "Ok") {
                        $("#addCarPoolModal").hide();
                        GetPoolOffers();
                    }
                    else {
                        alert('Could not add : try later');
                    }

                },
                error: function (data, errorThrown) {
                    alert('CarPool Creation failed :' + errorThrown);
                    // sessionStorage.clear();
                }

            });
            $("#ProgressBar").hide();
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


        function Close(VehiclePoolID) {
            selectedPoolId = VehiclePoolID;
            $("#showCloseModal").show();
        }

        function CloseCloseModal() {
            $("#showCloseModal").hide();
        }

        function ClosePoolOffer() {
            var CarPool = {};
            CarPool.VehiclePoolID = selectedPoolId;
            CarPool.ResID = <%=ResID%>;
            CarPool.Active = 0;

            var url = api_url + "/api/CarPool/Status";
            var CarPoolString = JSON.stringify(CarPool);

            $.ajax({
                dataType: "json",
                url: url,
                data: CarPoolString,
                type: 'post',
                async: false,
                contentType: 'application/json',
                success: function (data) {
                    if (data.Response == "Ok") {
                        $("#showCloseModal").hide();
                        GetPoolOffers();
                    }
                    else {
                        alert('Could not close : try later');
                    }

                },
                error: function (data, errorThrown) {
                    alert('Could not close :' + errorThrown);
                    // sessionStorage.clear();
                }

            });
        }
    </script>
    <script type="text/javascript">
        $(function () {
            $('#time_return').datetimepicker({
                format: 'LT'
            });
        });
         $(function () {
            $('#time_when').datetimepicker({
                format: 'LT'
            });
        });
         $(function () {
            $('#date_when').datetimepicker({
            format: 'DD/MM/YYYY' 
            });
        });
        $(function () {
            $('#date_return').datetimepicker({format: 'DD/MM/YYYY' });
        });
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

                    <div class="tab-pane fade" id="selfPool" style="margin-top: 10px; margin-left: 10px;">
                        <button class="btn btn-primary" onclick="ShowPoolModal()">Add New Trip</button>
                        <div id="MyPool"></div>
                    </div>
                </div>
        </div>

         <div id="progressBarGetData" class="container-fluid" style="text-align: center; height: 200px;display:none;">
                    <img src="Images/Icon/ajax-loader.gif" style="width: 40px; height: 40px; margin-top: 100px;" />
            </div>


        <div id="addCarPoolModal" class="model">
            <div class="modal-content" style="border-radius:5px; width: 580px; margin: auto;margin-top:0px">

                <div class="modal-header" style="color: white; background-color: #337ab7; height: 50px;">
                    <i class="fa fa-close" style="float:right;cursor:pointer;" onclick="ClosePoolModal()"></i>
                    
                    <h4 id="" class="modal-title" style="margin-top: 5px;font-family:Helvetica Neue,Helvetica,Arial,sans-serif; font-size:14px">Offer for Pool:</h4>
                </div>
                <div class="layout_modal_body container-fluid">
                    <form name="CarPool">
                      
                        <div class="row" style="margin-top: 20px;">

                            <div class="col-sm-6">
                                <label class="labelwidth col-sm-4 col-form-label">Type :</label>
                                <div class="col-sm-8">
                                <select id="pool_type" class="form-control form-control-sm" onblur="" tabindex="1" >
                                    <option "1">One Way</option>
                                    <option "2">Two Way</option>
                                </select>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <label class="labelwidth col-sm-4 col-form-label">Duration</label>
                                <div class="col-sm-8">
                                <select id="pool_cycle" class="form-control form-control-sm" onblur="" tabindex="2" >
                                    <option>One Time</option>
                                    <option>Daily</option>
                                </select>
                            </div>
                            </div>
                        </div>
                        <div class="row"style="margin-top: 10px;" >
                            <div class="col-sm-6">
                                <label class="labelwidth col-sm-4 col-form-label">Where: </label>
                                <div class="col-sm-8">
                                <input type="text" id="destination" class="form-control form-control-sm" onblur="" tabindex="3" />
                               </div>
                            </div>
                            <div class="col-sm-6">
                                <label class="labelwidth col-sm-4 col-form-label">Available Seat</label>
                                <div class="col-sm-8">
                                <input type="number" id="seats"  class="form-control form-control-sm" tabindex="4" />
                            </div>
                          </div>
                        </div>
                        <div class="row" style="margin-top: 0px;">
                            <div class="col-sm-6">
                                <label class="labelwidth col-sm-4 col-form-label">When: </label>
                                <div class="col-sm-8">
                                <%--<div class="form-group">
                                <div class='input-group date'>--%>
                                    <input type='text'  id='date_when' class="form-control" placeholder="DD/MM/YYYY" tabindex="5"  />
                              <%--      <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                             </div>--%>
                                </div>
                                </div>
                            <div class="col-sm-6">
                                <label class="labelwidth col-sm-4 col-form-label">Time:</label>
                                <div class="col-sm-8">
                                
                                         <input type='text'  id='time_when' class="form-control" placeholder="00 : 00 AM" tabindex="6" />
                                        
                               </div>
                            </div>
                        </div>
                         <div class="row" style="margin-top: 10px;">
                            <div class="col-sm-6">
                                <label class="labelwidth col-sm-4 col-form-label">Return:</label>
                             <div class="col-sm-8">  
                               
                                    <input type='text'  id='date_return' class="form-control"  placeholder="DD/MM/YYYY"/ tabindex="7" />
                                 
                              </div>
                            </div>
                             <div class="col-sm-6">
                                 <label class="labelwidth col-sm-4 col-form-label">Time:</label>
                                 <div class="col-sm-8">
                                         <input id='time_return' type='text' placeholder="00 : 00 AM" class="form-control" tabindex="8" />
                                 </div>
                             </div>
                        </div>
                        <div class="row" style="margin-top:10px;">
                            <div class="col-sm-6">
                                <label class="labelwidth col-sm-4 col-form-label">Vehicle Type:</label>
                                 <div class="col-sm-8">
                                <input id="vehicle_type" class="form-control form-control-sm" tabindex="9" />
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <label class="labelwidth col-sm-4 col-form-label">Cost / Seat</label>
                                <div class="col-sm-8">
                                <input id="Shared_cost" type="number" class="form-control form-control-sm" tabindex="10" />
                            </div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 5px; margin-bottom: 15px">
                            <div class="col-sm-12">
                                <label class="labelwidth col-sm-2 col-form-label">Description:</label>
                                <div class="col-sm-10">
                                <input type="text" id="pool_description" class="form-control form-control-lg" style="max-height:inherit" tabindex="11"  />
                                </div>
                            </div>
                        </div>
                        </form>
                    </div>

                    <div class="panel-footer" style="text-align: right;">
                        <button type="button" id="btnInvCancel" style="margin-top: 5px;" onclick="ClosePoolModal()" data-dismiss="modal" class="btn btn-danger">Cancel</button>
                        <button type="button" id="btnInvSubmit" style="margin-top: 5px;" onclick="AddPoolOffer();" class="btn btn-primary">Submit</button>
                    </div>
                </div>

            <div id="invProgressBar" class="container-fluid" style="text-align: center; height: 200px; display: none;">
                <img src="Images/Icon/ajax-loader.gif" style="width: 20px; height: 20px; margin-top: 50px;" />
            </div>
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

        <div id="showCloseModal" class="model">
            <div class="modal-content"style="border-radius:5px; width: 350px; margin: auto; margin-top:150px;position:relative;">

                <div class="modal-header" style="color: white; background-color: #337ab7; height: 50px;">
                      <i class="fa fa-close" style="float:right;cursor:pointer;" onclick="CloseCloseModal()"></i>
                    <h4 id="close_Close" class="modal-title" style="margin-top: 5px;font-family:Helvetica Neue,Helvetica,Arial,sans-serif; font-size:14px">Close Selected Pool</h4>
                   
                </div>

                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <label class="labelwidth col-sm-4 col-form-label">Seats: </label>
                            <div class="col-sm-8">
                            <input id="close_seats" type="number" onblur="" class="form-control form-control-sm" tabindex="1"/>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px; margin-bottom: 10px">
                        <div class="col-sm-12">
                            <label class="labelwidth col-sm-4 col-form-label">Comments:</label>
                         <div class="col-sm-8">
                            <input id="close_comments"  class="form-control rows="2" form-control-sm" tabindex="2" />
                        </div>
                      </div>
                    </div>
                </div>

                <div class="panel-footer" style="text-align: right;">
                    <button type="button" id="btnCloseCancel" style="margin-top: 5px;" onclick="CloseCloseModal()" data-dismiss="modal" class="btn btn-danger">Cancel</button>
                    <button type="button" id="btnCloseSubmit" style="margin-top: 5px;" onclick="ClosePoolOffer();" class="btn btn-primary">Submit</button>

                </div>

                  <div id="closeProgressBar" class="container-fluid" style="text-align: center; height: 200px; position:absolute;">
                        <img src="Images/Icon/ajax-loader.gif" style="width: 20px; height: 20px; margin-top: 50px;" />
                    </div>

            </div>

          
        </div>
    </div>
</body>
</html>
