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

    <link href="css_3rdParty/settings.css" rel="stylesheet" type="text/css" />
    <!-- THEME CSS -->

    <link href="css_3rdParty/essentials.css" rel="stylesheet" type="text/css" />
    <link href="css_3rdParty/layout.css" rel="stylesheet" type="text/css" />
    <link href="css_3rdParty/layout-responsive.css" rel="stylesheet" type="text/css" />
      <link href="css_3rdParty/layout.css" rel="stylesheet" type="text/css" />

  <!--  <link href="Styles/layout.css" rel="stylesheet" />
    <link href="Styles/Responsive.css" rel="stylesheet" />-->

    <link href="CSS/mystylesheets.css" rel="stylesheet" />
     <link rel="stylesheet" href="css_3rdParty/footer.css" />
 
    <%--<link rel="stylesheet" href="CSS/ApttTheme.css" />
    <link rel="stylesheet" href="CSS/ApttLayout.css" />
    <link rel="stylesheet" href="CSS/NewAptt.css" />--%>



    <script>

          var UserId;
        var selectedSocietyId = 0;

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
             console.log(response);
              var strData = "";

            var results = jQuery.parseJSON(response.d);
           
            if (results.length > 0) {
                for (var i = 0; i < results.length; i++) {
                    console.log(JSON.stringify(results[0]));

                    var strButton =""
                    if (results[i].Status == 'Approved') {

                        strButton = "<button class='btn btn-primary btn-sm' disabled>Done</button>";

                    }
                    else if(results[i].Status == 'Applied'){
                        strButton = "<button class='btn btn-primary btn-sm' onClick='ApproveRequest(" + results[i].SocietyID + ")' >Approve</button>"
                            + " &nbsp&nbsp<button class='btn btn-primary btn-sm' onClick='RejectRequest(" + results[i].SocietyID + ")'>Reject</button> ";
                    }

                     strData = strData + "<div class=\"row \" style=\"margin-top:5px;margin-left:100px;border-top:solid 1px black;\">" 
                         + "<div class='row'><div class='col-xs-4'>" + results[i].SocietyID + "<b style='color:blue;'> " + results[i].SocietyName + "</b></div>"
                         + "<div class='col-xs-4'> Total Flats: 1000" + "</div><div class='col-xs-4'></div>"
                         + "</div>"
                         +"<div class='row'>"
                         + "<div class='col-xs-4'> Sector " + results[i].Sector + "</div> <div class='col-xs-4'> " + results[i].PinCode + ", " + results[i].State + "</div> <div class='col-xs-4'> City : " + results[i].City + "</div>"
                         +"</div>"
                         + "<div class='row'><div class='col-xs-12'>" + results[i].Status + "&nbsp&nbsp" + strButton + "</div></div>" 

                 
                        + "</div>"
                
                }


            $("#SocitiesView").html(strData);



              
            }
            else {
                
            }

        }


        function ApproveRequest(SocId) {

            selectedSocietyId = SocId;

            $("#showApproveModal").show();

        }

        function CloseApproveModal() {
              $("#showApproveModal").hide();
        }

        function Approve() {

          
            var socData = {};
            socData.SocietyID = selectedSocietyId;
            console.log("147===>" +JSON.stringify(socData));
            $.ajax({
                dataType: "json",
                url: "SuperAdmin.aspx/ApproveSocietyRequest",
                data: '{"society":'+ JSON.stringify(socData) +'}',
                type: 'post',
                async: false,
                contentType: 'application/json',
                success: function (data) {

                    console.log("157===>> data=" + JSON.stringify(data));
                    if (data.d == true) {
                        $("#showApproveModal").hide();
                        GetSocietyRequest();
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

        function RejectRequest(SocId) {
              selectedSocietyId = SocId;

            $("#showRejectModal").show();
        }

        function CloseRejectModal() {
              $("#showRejectModal").hide();
        }


        function Reject() {
               var socData = {};
            socData.SocietyID = selectedSocietyId;

            $.ajax({
                dataType: "json",
                url: "SuperAdmin.aspx/RejectSocietyRequest",
                data: '{"society":'+ JSON.stringify(socData) +'}',
                type: 'post',
                async: false,
                contentType: 'application/json',
                success: function (data) {
                    if (data.d == true) {
                        $("#showRejectModal").hide();
                        GetSocietyRequest();
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
        <div>
           
        </div>
    </form>
     <div class="container-fluid"> 
         <div class="row" id="SocitiesView" ></div> 

     </div>

    <div id="showApproveModal" class="model">
            <div class="modal-content"style="border-radius:5px; width: 350px; margin: auto; margin-top:150px;position:relative;">

                <div class="modal-header" style="color: white; background-color: #337ab7; height: 50px;">
                      <i class="fa fa-close" style="float:right;cursor:pointer;" onclick="CloseApproveModal()"></i>
                    <h4 id="close_Close" class="modal-title" style="margin-top: 5px;font-family:Helvetica Neue,Helvetica,Arial,sans-serif; font-size:14px">Close Selected Pool</h4>
                   
                </div>

                <div class="modal-body">
           
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
                    <button type="button" id="btnCloseCancel" style="margin-top: 5px;" onclick="CloseApproveModal()" data-dismiss="modal" class="btn btn-danger">Cancel</button>
                    <button type="button" id="btnCloseSubmit" style="margin-top: 5px;" onclick="Approve();" class="btn btn-primary">Submit</button>

                </div>

                  <div id="closeProgressBar" class="container-fluid" style="text-align: center; height: 200px; position:absolute;">
                        <img src="Images/Icon/ajax-loader.gif" style="width: 20px; height: 20px; margin-top: 50px;" />
                    </div>

            </div>

        </div>


     <div id="showRejectModal" class="model">
            <div class="modal-content"style="border-radius:5px; width: 350px; margin: auto; margin-top:150px;position:relative;">

                <div class="modal-header" style="color: white; background-color: #337ab7; height: 50px;">
                      <i class="fa fa-close" style="float:right;cursor:pointer;" onclick="CloseRejectModal()"></i>
                    <h4  class="modal-title" style="margin-top: 5px;font-family:Helvetica Neue,Helvetica,Arial,sans-serif; font-size:14px">Reject Society </h4>
                   
                </div>

                <div class="modal-body">
           
                    <div class="row" style="margin-top: 10px; margin-bottom: 10px">
                        <div class="col-sm-12">
                            <label class="labelwidth col-sm-4 col-form-label">Comments:</label>
                         <div class="col-sm-8">
                            <input id="reject_comments"  class="form-control rows="2" form-control-sm" tabindex="2" />
                        </div>
                      </div>
                    </div>
                </div>

                <div class="panel-footer" style="text-align: right;">
                    <button type="button" id="btnCloseReject" style="margin-top: 5px;" onclick="CloseRejectModal()" data-dismiss="modal" class="btn btn-danger">Cancel</button>
                    <button type="button" id="btnSubmitReject" style="margin-top: 5px;" onclick="Reject();" class="btn btn-primary">Submit</button>

                </div>

                  <div id="rejectProgressBar" class="container-fluid" style="text-align: center; height: 200px; position:absolute;">
                        <img src="Images/Icon/ajax-loader.gif" style="width: 20px; height: 20px; margin-top: 50px;" />
                    </div>

            </div>

        </div>

</body>
</html>
