<%@ Page Language="C#" AutoEventWireup="true" CodeFile="visitor.aspx.cs" Inherits="visitor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <meta name="viewport" content="width=device-width, initial-scale=1"/>

       <script src="Scripts/jquery-1.11.1.min.js"></script>


             <!-- Latest compiled and minified CSS -->
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>

           

            <!-- Latest compiled JavaScript -->
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
   
     <!-- jQuery library -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
         <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css"/>  
    
    <link rel='stylesheet' type='text/css'href="Styles/timepicki.css"/>
              <link rel="stylesheet" href="CSS/ApttLayout.css"/>
              <link rel="stylesheet" href="CSS/ApttTheme.css" />
              <link rel="stylesheet" href="CSS/NewAptt.css" />
    
    
    <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js"></script>  
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>  
    <link rel="Stylesheet" href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.10/themes/redmond/jquery-ui.css" /> 
   
    <script type='text/javascript'src="Scripts/timepicki.js"></script>
    
    <style>
          .layout-overlay 
                {
                background:#f7f6f6;
                top: 0px;
                display:none;
                height:100px;
                position: absolute;
                transition: height 500ms ease 0s;
                width: 80%;
                opacity:0.5;
            }


            .modal {
             display: none;  /*  Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
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
            .form-control {
                margin-bottom:2px;
                margin-top:2px;
            }
        .fa-2x {
            font-size: 2em;
            color: #000;
            padding-left: 423px;
        }

        .Done p1 {
            color:green;
            /*border: 1px solid #2fcc66;*/
            padding:3px;
            
        }

        .Pending p1 {
            color:red;
            /*border: 1px solid red;*/
            padding:3px;
        }
        .layout-list {
            padding:8px;
            text-align: justify;
            background-color:#fff;
                
            
        }
        b {
            padding-bottom:2px;
        }

        .Host {
            border-left:solid 2px red;
        }
        .scrollable-menu {
    height: auto;
    max-height: 200px;
    overflow-x: hidden;
}

        @media only screen and (max-width: 600px) {
            .col-xs-4 {
                width: 140px;
            }
        }
    </style>
    <script>
     

        var UserType, ResId, SocietyId, FlatNumber, RequestID, VisitorEntryHour;

        function CloseAddVisitor() {

           $("#AddVisitorModal,").hide();
        }


        function CloseVerify()
        {
            $("#VerifyVisitorModal").hide();
        }


        $(document).ready(function () {

            UserType = '<%=Session["UserType"]%>';
            ResId = '<%=Session["ResiID"]%>';
            SocietyId = '<%=Session["SocietyID"]%>';
            FlatNumber = '<%=Session["FlatNumber"]%>';

            $("#btnAddVisitor").click(function () {

                var currentDate = new Date();
                
               // var strDate= currentDate.getDate() + "-" + currentDate.getMonth() + "-" + currentDate.getFullYear(); 

              //  $("#btnEntryDate").val(strDate);

                $('#btnEntryDate').datepicker("setDate", new Date(2008,9,3) );

              var currentHrs = currentDate.getHours();
                VisitorEntryHour = currentHrs; 
             
                var hrs;

                for (hrs = currentHrs; hrs < 25; hrs++) {
                   
                   // console.log(hrs);
                    var str = "<option onclick='Select("+hrs +")'>" + hrs + ":00 Hrs</option>";
                    // console.log(str);
                    $("#timeList").append(str);
                }

                //var num = Number($("#timeList").val()) + 1; 
                //alert(num);
                //$("#btnEndTime").append(num);

          
           
                $("#AddVisitorModal").show();
                 

            });

            function Select(hr) {
                $("#btnEndTime").append(num);
            }

            $('#timeList').on('change', function () {


                var endTime = $("#timeList").val().toString();

                VisitorEntryHour = +endTime.split(":")[0];

                var time = (VisitorEntryHour+1).toString() + ":00 Hrs";
                alert(VisitorEntryHour);
                $("#btnEndTime").text(time);
            });



            $('#btnEntryDate').on('change', function () {
              $('#timeList').empty()
              for (hrs = 1; hrs < 25; hrs++) {
                   
                   // console.log(hrs);
                    var str = "<option onclick='Select("+hrs +")'>" + hrs + ":00 Hrs</option>";
                  //console.log(str);
                  $("#timeList").append(str);
                }

            });
       


            $("#btnSubmit").click(function () {
               
                AddVisitor();
            });
            $(document).ready(function () {
                $("#btnCancel,#icon_close").click(function () {
                    $("#AddVisitorModal").hide();
                });


                $("#btnEntryDate").datepicker({ dateFormat: 'dd-MM-yy', currentText: "Now", minDate:new Date() });
                
                
               // $('#btnEntryTime').timepicker('getTime');

                //$("#btnEntryDate").datetimepicker({
                //    format: 'LT'
                //});

            });
            $("#btnVerifyVisitor").click(function () {
               
                $("#VerifyVisitorModal").show();

            });

            $("#btnVerify").click(function () {

                GetDataForCode();
            });


            $("#btnCheckIn").click(function () {
         
                UpdateCheckIn();

            });

            GetVisitorData();

            $('#timepicker').timepicki();

        });
        
    
        function GetDataForCode()
        {
            var code = $("#SecurityCode").val();
            document.getElementById("verify_loading").style.display = "block";
            var url = "http://www.kevintech.in/GaurMahagun/api/Visitor/Code/" + code;

           

            $.ajax({
                type: "Get",
                url: url,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    document.getElementById("verify_loading").style.display = "none";
                    RequestID = data.RequestId;
                    $("#lblMobile").text(data.VisitorMobile);
                    $("#lblName").text(data.VisitorName);
                    $("#lblAddress").text(data.VisitorAddress);
                    $("#lblPurpose").text(data.VisitPurpose);
                    $("#lblStartTime").text(ChangeDateformat(data.StartTime));
                    $("#lblEndTime").text(ChangeDateformat(data.EndTime));
                    $("#lblHostName").text(data.FirstName + " " + data.LastName);
                    $("#lblHostFlat").text(data.Flat);
                     $("#lblHostMobile").text(data.ResidentMobile);
                    $("#lblHostType").text(data.Type);
                
                    
                },
                failure: function (response) {
                    document.getElementById("verify_loading").style.display = "none";
                    alert(response.d);
                    sessionStorage.clear();
                }
            });

        }

         function ChangeDateformat(inputdate) {
            var NewFormatDate;
            var date = new Date(inputdate);

            //alert(date);
            var Currentdate = new Date();

            var DateFormat = date.toLocaleDateString("ddMMM,YY");

            var TimeFormat = date.toLocaleTimeString();

            var CurrentDateFormat = Currentdate.toLocaleDateString();
              NewFormatDate = DateFormat + "  " + TimeFormat;
             
            return NewFormatDate;
        }

        function GetVisitorData() {
            document.getElementById("data_loading").style.display = "block";
          
           var  url = "http://www.kevintech.in/GaurMahagun/api/Visitor/Soc/" + SocietyId;

            if (UserType == 'Admin') {
                url = "http://www.kevintech.in/GaurMahagun/api/Visitor/Soc/" + SocietyId;
            }
            else if ((UserType == "Owner")||(UserType == "Tenant")) {
                url = "http://www.kevintech.in/GaurMahagun/api/Visitor/"+ SocietyId+"/Res/" + ResId;
            }
          

            $.ajax({
                type: "Get",
                url: url,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                   
                    document.getElementById("data_loading").style.display = "none";
                    SetData(data);
                },
                failure: function (response) {
                    document.getElementById("data_loading").style.display = "none";
                    alert(response.d);
                    sessionStorage.clear();
                }
            });

        }


        function SetData(data) {

            var jarray = data.$values;
            var length = jarray.length;
            var viewString = "";
            var con = document.getElementById("dataContainer");
            for (var i = 0; i < length; i++) {

                var VisitorName = jarray[i].VisitorName;
                var VisitorMobile = jarray[i].VisitorMobile;
                var VisitorAddress = jarray[i].VisitorAddress;
                var VisitPurpose = jarray[i].VisitPurpose;
                var startTime = jarray[i].StartTime;
                var InTime = jarray[i].ActualInTime;
                var OutTime = jarray[i].ActualOutTime;
                var HostName = jarray[i].FirstName + jarray[i].LastName;
                var HostType = jarray[i].Type;
                var FlatNumber = jarray[i].Flat;

                var inTime = new Date(InTime);
                var stTime = new Date(startTime);
                var status = "";
                var time = "";
                var bgClass;
                if (inTime > stTime) {
                    status = "Done";
                    time =  ChangeDateformat(InTime);
                    bgClass = "Done";
                }
                else {
                    status = "Pending";
                    time = "Start After :" + ChangeDateformat(startTime);
                    bgClass = "Pending";
                }



                viewString += '<div class=\"row layout_shadow_table\">' +
                    '<div class=\"col-xs-4\"><b>Visitor: <span class="fa fa-circle" style="color:red;"></span></b> <br/> <span class="fa fa-user" style="color:#2b7a2d;"></span>  ' + VisitorName + '<br /><span class="fa fa-phone" style="color:#2b7a2d;"></span> ' + VisitorMobile + '<br /><span class="fa fa-home" style="color:#2b7a2d;"></span> ' + VisitorAddress + '</div>' +
                         '<div class=\"col-xs-4 ' + bgClass + '\"><br/><span class="fa fa-question-circle" style="color:#2b7a2d;"></span> ' + VisitPurpose + '<br/>' + time + '<br /><span class="fa fa-info-circle" style="color:#2b7a2d;"></span><p1> ' + status + '</p1></div>' +
                        
                         '<div class=\"col-xs-4 Host\"><b> Host: <br/><span class="fa fa-user" style="color:#2b7a2d;"></span> </b>' + HostName + ',' + HostType+ '<br/><span class="fa fa-phone" style="color:#2b7a2d;"></span>' + VisitorMobile + '<br/><span class="fa fa-home" style="color:#2b7a2d;"></span>' + FlatNumber + '</div>' +
                      '</div>';

            }


            con.innerHTML += viewString;

            parent.iframeLoaded();
        }



        function AddVisitor() {
            
            var name, mobile, address, purpose,visitDate;

            name = document.getElementById("Name").value;
            mobile = document.getElementById("MobileNo").value;
            address = document.getElementById("Address").value;
            purpose = document.getElementById("Purpose").value;
            visitDate = document.getElementById("btnEntryDate").value;
          

            alert(visitDate);
            var start = new Date(visitDate);
            alert(start);

            var month = +start.getMonth() + 1;
            var strMonth="";
            if (month < 10) {
                strMonth = 0 + month.toString();
            }
            else {
                strMonth = month.toString();
            }

             var day = +start.getDate();
            var strDay="";
            if (day < 10) {
                strDay = 0 + day.toString();
            }
            else {
                strDay = day.toString();
            }

            var startHrs = "";
            var endHrs = "";

            if (VisitorEntryHour < 9) {
                 startHrs = 0 + VisitorEntryHour.toString();
               endHrs = 0 + (VisitorEntryHour+1).toString();

            }
            else if (VisitorEntryHour = 9) {
                 startHrs = 0+ VisitorEntryHour.toString();
               endHrs = (VisitorEntryHour+1).toString();
            }
            else {
               startHrs = VisitorEntryHour.toString();
               endHrs = (VisitorEntryHour+1).toString();

            }


            var strStartDate = start.getFullYear() + "-" + strMonth + "-" + strDay + "T" + startHrs + ":00:00";
            

            var strEndDate = start.getFullYear() + "-" + strMonth + "-" + strDay +  "T" + endHrs + ":00:00" ;
           
            alert(strStartDate);
           
     
        //   endTime = document.getElementById("btnStartTime").value;
       
            document.getElementById("post_loading").style.display = "block";


            
             var strURL = "http://www.kevintech.in/GaurMahagun/api/Visitor/New";
             //var strURL = "visitor.aspx/AddVisitor";
             
            var reqBody = "{\"VisitorName\":\"" + name + "\",\"VisitorMobile\":\"" + mobile + "\",\"VisitorAddress\":\"" + address + " \",\"VisitPurpose\":\"" + purpose + "\",\"StartTime\":\"" + strStartDate + "\",\"EndTime\":\"" + strEndDate +
                           "\",\"ResID\":\"" + ResId + "\",\"FlatNumber\":\"" + FlatNumber + "\",\"SocietyId\":\"" + SocietyId + "\"}"

            alert(reqBody);

            $.ajax({
                dataType: "json",
                url: strURL,
                async: false,
                data: reqBody,
                type: 'post',
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    alert(JSON.stringify(data));
                    document.getElementById("post_loading").style.display = "none";

                    if (data.Response == "Fail") {
                        alert('Could not update');
                    }
                    else {
                        alert('Updated Successfully');
                    }

                    

                },
                error: function (data, errorThrown) {
                    document.getElementById("post_loading").style.display = "none";

                    alert('Error Updating comment, try again');
                }
            });

        }


        function UpdateCheckIn()
        {
            document.getElementById("verify_loading").style.display = "block";



            var strURL = "http://www.kevintech.in/GaurMahagun/api/Visitor/CheckIn";

            var reqBody = "{\"RequestId\":\"" + RequestID + "\"}"



            $.ajax({
                dataType: "json",
                url: strURL,
                async: false,
                data: reqBody,
                type: 'post',
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    document.getElementById("verify_loading").style.display = "none";
                    alert('Updated Successfully');

                },
                error: function (data, errorThrown) {
                    document.getElementById("verify_loading").style.display = "none";

                    alert('Error Updating comment, try again');
                }
            });


        }

        // ************************************  Date  Change format function 
        function ChangeDateformat(inputdate) {
            var NewFormatDate;
            var date = new Date(inputdate);

            //alert(date);
            var Currentdate = new Date();

            var DateFormat = date.toLocaleDateString();

            var TimeFormat = date.toLocaleTimeString();

            var CurrentDateFormat = Currentdate.toLocaleDateString();


            var Hoursdiff = Math.ceil(Currentdate.getTime() - date.getTime()) / 3600000;

            var diff = (Currentdate.getTime() - date.getTime()) / 1000;
            diff /= 60;

            //   alert(Currentdate.getTime() - date.getTime());

            var Minsdiffnew = Math.abs(Math.round(diff));

            //  alert(diff);
            //   alert(Minsdiffnew);

            var TimeHoursdiff = Math.floor(Hoursdiff);

            if (TimeHoursdiff < 12) {
                if (TimeHoursdiff < 1) {
                    if (Minsdiffnew == 0) {
                        NewFormatDate = "just now";
                    }
                    else {

                        NewFormatDate = Minsdiffnew + "min";
                    }
                }
                else {
                    NewFormatDate = TimeHoursdiff + "hrs";
                }
            }

            else {
                NewFormatDate = DateFormat + "  " + TimeFormat;
            }



            return NewFormatDate;
        }
        function validateForm() {
  var x = document.forms["myForm"]["fname"].value;
  if (x == "") {
    alert("Name must be filled out");
    return false;
  }
}

</script>
</head>
<body>
    <form id="form1" runat="server">
     <div class="container-fluid" style="background-color:#f7f7f7;">
                         <div class="row">
                                 <div class="col-sm-5">
                                     <div><h4 class="pull-left ">Visitor </h4></div>
                                 </div>
                             <div class="col-sm-5 pull-right">
                                     <button id="btnAddVisitor" class="btn_my btn" type="button"><i class="fa fa-plus"></i> Add Visitor</button>

                                    <button id="btnVerifyVisitor" style="background-color:#2ECC71!important;border-color:#2ECC71!important;" class="btn_my btn" type="button"><i class="fa fa-check"></i> Verify</button>
                                 </div>
                             </div>
   
       

         <div id="dataContainer" class="container-fluid">

                     
                         <div id="data_loading" class="container-fluid" style="text-align:center; height:200px;">
                    <img src="Images/Icon/ajax-loader.gif" style="width:20px;height:20px; margin-top:50px;" />

                   </div>
             </div>

        <div id="AddVisitorModal" class="modal">
             
                  
                  <div class="panel panel-primary" style="width:350px;background-color:#f2f2f2;margin: auto;">
                              <div class="panel-heading">
                                  Add Visitor <span class="fa fa-times" id="icon_close" style="cursor:pointer;float:right;"></span>
                              </div>
                              <div class="panel-body" >

                                <form class="form-inline" method="post" >
                                           <div class="form-group" >
                                               
                                                  <label class="col-xs-4"  for="Name">Name:</label>
                                                
                                               
                                                <input type="text" class="form-control col-xs-8" id="Name" style="width:210px;"  placeholder="Enter Name" name="Name" required/>
                                              
                                            </div>
                                           <div class="form-group" >
                                              <label class="col-xs-4" for="MobileNo">Mobile No:</label>
     
                                                <input type="text" class="form-control col-xs-8" id="MobileNo" style="width:210px;" placeholder="Enter Mobile No." name="MobileNo"/>
    
                                            </div>
                                           <div class="form-group">
   
                                      <label class="col-xs-4" >Address:</label>
 
                                      <textarea class="form-control col-xs-8" rows="2" id="Address" style="width:210px;resize:none;" name="Address" placeholder="Enter Address"></textarea>

                                       </div>
                                           <div class="form-group">
                                          <label class="col-xs-4" for="Offer">Purpose:</label>
  
                                          <input type="text" name="Purpose" class="form-control col-xs-8"id="Purpose" style="width:210px;" placeholder="Enter Purpose"/>
                                       </div>
                                    <div class="form-group">
     
                                          <label class="col-xs-4" for="Owner">Time / Date</label>
                                        <input type="text" class="form-control col-xs-4" style="width:102px;"  id="btnEntryDate"  name="StartDate"/>
                                        <select class="form-control col-xs-4" style="width:108px;" id="timeList">
                                           
                                         
                                        </select>
                                
                                            
                                              
                                            </div>
                                     <div class="form-group" >
     
                                         </div>
                                    

                                           <div class="form-group">
                                          <label class="col-xs-4" for="Owner">Valid Till:</label>
      
                                            <label style="width:210px;" class="form-control col-xs-8" id="btnEndTime" ></label>
      
                                            </div>
                                    
                                 
                                      <div id="post_loading" class="layout-overlay" style="margin-top:50px; left:100px; width:100%; text-align:center;vertical-align:middle;">
                                       <img src="Images/Icon/ajax-loader.gif" style="width:30px; height:30px;margin-top:35px;" />
                                      </div>
                                    </form>
                              </div>

                              <div class="panel-footer" style="text-align:right;">
                                  <button type="button" id="btnCancel"  style="margin-top:5px;" class="btn btn-danger">Cancel</button>
                                  <button type="button" id="btnSubmit"  style="margin-top:5px;" class="btn btn-primary">Submit</button>
                                          
                              </div>
                          </div>

                  
                 
        </div>
         
          <div id="VerifyVisitorModal" class="modal">
            
              <div class="container-fluid" style="width:100%;">
                 
                  <div class="panel panel-primary popup_box_size" style="position:relative;background-color:#f2f2f2;">
                      <div class="panel-heading">Visitor Verification

                          <span class="fa fa-times" onclick="CloseVerify()" style="cursor:pointer; float:right;"></span>
                      </div>
                      <div class="panel-body">
                                            <div class="row" style="margin-top:10px;">
                                                        <div class="col-xs-12" >
                                                            <label  >Security Code:</label>
    
                                                            <input type="text"   id="SecurityCode" name="code_a" style=""placeholder="Enter Code here"/>
                                                                <button id="btnVerify" type="button" class="btn btn-sm btn-danger">Verify</button>

                                                            </div>
                                             </div>
                                            <div class="row" style="margin-top:10px;">
                                                    <div class="col-xs-6">
                                                        <label >Name: </label> <label id="lblName"></label>
     
                                                    </div>
                                                         
                                                    <div class="col-xs-6">
                                                        <label >Mobile No: </label> <label id="lblMobile"></label>
     
                                                    </div>
                                             </div>
                                              <div class="row" style="margin-top:10px;">
                                                    <div class="col-xs-6">
                                                                <label >Address: </label> <label id="lblAddress"></label>
                                                        </div>

                                                        <div class="col-xs-6">
                                                                <label  >Purpose: </label> <label id="lblPurpose" ></label>
                                                        </div>
                                               </div>
                                       <div class="row" style="margin-top:10px;">
                                            <div class="col-xs-6">
                                                    <label >Start Time: </label><label id="lblStartTime"></label>
                                            </div>
                                           

                                            <div class="col-xs-6">
                                                <label >End Time: </label><label id="lblEndTime"></label>
      
                                            </div>
                                         </div>
                               <div class="row" style="margin-top:10px;">
                                            <div class="col-xs-6" >
                                                <label >Host Name: </label> <label id="lblHostName"></label>
     
                                            </div>
                                             <div class="col-xs-6" >
                                                <label >Host Flat: </label> <label id="lblHostFlat"></label>
     
                                            </div>
                                  </div>   
                                 <div class="row" style="margin-top:10px;">
                                            <div class="col-xs-6" >
                                                <label >Host Mobile: </label> <label id="lblHostMobile"></label>
     
                                            </div>
                                             <div class="col-xs-6" >
                                                <label >Host Type: </label> <label id="lblHostType"></label>
     
                                            </div>
                                  </div>  
                                    </div>
                         
                     
                      <div class="panel-footer" style="text-align:right;">
                          <button type="button" class="btn btn-danger" onclick="CloseVerify()">Cancel</button>
                              <button type="button" id="btnCheckIn"  class="btn btn-primary" >Check In</button>
                                     
                      </div>
                        <div id="verify_loading" class="layout-overlay" style="width:500px; text-align:center;vertical-align:middle;">
                               <img src="Images/Icon/ajax-loader.gif" style="width:30px; height:30px;margin-top:100px;" />
                              
                     </div>
                 </div>
                 
                </div>
            </div>
         </div>
    </form>

</body>
</html>
