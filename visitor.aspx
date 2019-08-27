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
     <script src="Scripts/datetime.js"></script>
     <!-- jQuery library -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
         <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css"/>  
    
        <link rel='stylesheet' type='text/css'href="CSS_3rdParty/timepicki.css"/>
       <%-- <link rel="stylesheet" href="CSS/ApttLayout.css"/>
        <link rel="stylesheet" href="CSS/ApttTheme.css" />
        <link rel="stylesheet" href="CSS/NewAptt.css" />--%>
        <link rel="stylesheet" href="CSS/mystylesheets.css" />
    
    
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
 

        var UserType, ResId, SocietyId, FlatNumber, RequestID, VisitorEntryHour,api_url; 
        var page = 1;
        var pagecount=0;
        var size = 5;

        function CloseAddVisitor() {

           $("#AddVisitorModal,").hide();
        }


        function CloseVerify()
        {
            $("#VerifyVisitorModal").hide();
        }


        $(document).ready(function () {
            window.parent.FrameSourceChanged();
             api_url = '<%=Session["api_url"] %>';
            UserType = '<%=Session["UserType"]%>';
            ResId = '<%=Session["ResiID"]%>';
            SocietyId = '<%=Session["SocietyID"]%>';
            FlatNumber = '<%=Session["FlatNumber"]%>';

      

            console.log(SocietyId);
            if (UserType != "Admin") {
                $("#btnVerifyVisitor").hide();
            }
            //GetVisitorData();

            $("#btnAddVisitor").click(function () {

                var currentDate = new Date();
                
               // var strDate= currentDate.getDate() + "-" + currentDate.getMonth() + "-" + currentDate.getFullYear(); 

              //  $("#btnEntryDate").val(strDate);

                $('#btnEntryDate').datepicker("setDate", new Date(2008,9,3) );

              var currentHrs = currentDate.getHours();
                VisitorEntryHour = currentHrs; 
             
                var hrs;
                var num = (currentHrs+1) + ":00 Hrs";
                for (hrs = currentHrs; hrs < 25; hrs++) {
                   
                   // console.log(hrs);
                    var str = "<option onclick='Select("+hrs +")'>" + hrs + ":00 Hrs</option>";
                    // console.log(str);
                    $("#timeList").append(str);
                }
                //alert(num);
                $("#btnEndTime").append(num);

          
           
                $("#AddVisitorModal").show();
                 

            });

            function Select(hr) {
                $("#btnEndTime").append(num);
               // console.log("at Select  ==> num=" + num);
            }

            $('#timeList').on('change', function () {


                var endTime = $("#timeList").val().toString();

                VisitorEntryHour = +endTime.split(":")[0];

                var time = (VisitorEntryHour+1).toString() + ":00 Hrs";
              //  alert(VisitorEntryHour);
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
       
            function clearModalFields() {
                $("#txtmobile").val("");
                $("#idName").val("");
                $("#Address").val("");
                $("#Purpose").val("");
                $("#btnEndTime").html("");
            }

            $("#btnSubmit").click(function () {

            //    alert("atsubmit 213");
                AddVisitor();
            });
            $(document).ready(function () {
                $("#btnCancel,#icon_close").click(function () {
                    $("#AddVisitorModal").hide();
                    clearModalFields();
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
            $("#txtmobile").blur(function () {
              //  alert("1");
                getByDataMobile();

            });


            GetVisitorData();

            $('#timepicker').timepicki();

        });
        
    
        function GetDataForCode()
        {
            var code = $("#SecurityCode").val();
            document.getElementById("verify_loading").style.display = "block";
            var url = api_url+"/api/Visitor/Code"; 

            var jasondata = "{\"VisitorCode\""+":"+code+" ,\"SocietyID\""+":"+SocietyId+"}";

            $.ajax({
                data: jasondata,
                async: false,
                type: "Post",
                url: url,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    document.getElementById("verify_loading").style.display = "none";
                    if (data == null) {
                        alert("no data");
                    }
                    else
                    {
                    
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
                }
                    
                },
                failure: function (response) {
                    document.getElementById("verify_loading").style.display = "none";
                    alert("Error Occured");
                   // alert(response.d);
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


          function ShowPrevious() {
            page = page - 1;
            GetVisitorData(); 
        }

        function ShowNext() {
            page = page + 1;
            GetVisitorData(); 
        }

        function GetVisitorData() {
            
            var loadingWindow = document.getElementById("data_loading");
            loadingWindow.style.display = "block";
            loadingWindow.style.height = "100%";
            loadingWindow.style.top = "4em";
            var oneprev = document.getElementById("oneprev");
            var onenext = document.getElementById("onenext");
            var current = document.getElementById("current");
            oneprev.innerText = page - 1;
            onenext.innerText = page + 1;
            current.innerText = page;


           // alert("at 345==>> societyid= " + SocietyId);
          
           var  url = api_url + "/api/Visitor/Soc/" + SocietyId +"/" + page + "/" + size;
           // alert(url);
            if (UserType == 'Admin') {
                url = api_url+  "/api/Visitor/Soc/" + SocietyId  +"/" + page + "/" + size;
            }
            else if ((UserType == "Owner")||(UserType == "Tenant")) {
                url = api_url + "/api/Visitor/"+ SocietyId+"/Res/" + ResId +"/" + page + "/" + size;
            }
           // console.log(url);
            $.ajax({
                type: "Get",
                url: url,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                  
                    document.getElementById("data_loading").style.display = "none";
                    if (data != null) {
                       //  alert(data.values +" at 365 ==>> is not null");

                        if (page > 1) {
                            $("#btnPrevious").show();
                            $('#btnNext').show();
                            oneprev.addEventListener("click", ShowPrevious);
                        }
                        else {
                            $("#btnPrevious").hide();
                            $("#oneprev").hide();
                            oneprev.removeEventListener("click", ShowPrevious);
                        }
                      //  if (data.length < size) {
                        if (data.length < size) {
                            $("#btnNext").hide();
                            onenext.removeEventListener("click", ShowNext);
                        }
                        else {
                            onenext.addEventListener("click", ShowNext);
                        }

                        /*  if (page = 1) {
                              $("#btnPrevious").hide();
                           
                          }*/
                       
                        //pagecount = data.values.count;
                        //alert("at 391===>> "+pagecount);
                        SetData(data);
                    }

                    else {
                     
                        $("#pagination>nav").hide();
                        $("#pagination").html("<h4 style='color: red;'>NO Visitor Data!!</h4>");
                       // alert("NO Data!!");                        
                    }
                },
                failure: function (response) {
                    
                    document.getElementById("data_loading").style.display = "none";

                  //  alert(response.d);
                    sessionStorage.clear();
                }
            });

        }


        function SetData(jarray) {
           //alert("at set data");
           // var jarray = data.$values;
            var length = jarray.length;

            if (length == 0) {
                  $("#pagination>nav").hide();
                $("#pagination").html("<h4>NO Visitor Data!!</h4>");

                return;
            }

            var viewString = "";
           
            var con = document.getElementById("dataContainer");
                con.innerHTML = "";
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
                var endDate = jarray[i].endDate;

                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
                var yyyy = today.getFullYear();
                today = mm + '/' + dd + '/' + yyyy;
                var todaydate = new Date(today);

                var inTime = new Date(InTime);
                var stTime = new Date(startTime);
                var status = "";
                var time = "";
                var bgClass;
               
                if (todaydate > endDate) {
                    status = "Expired...";
                    time = ChangeDateformat(InTime);
                    bgClass = "Expired...";
                }
                else if (todaydate == endDate) {
                    if (inTime > stTime) {
                        status = "Checked In...";
                        time = ChangeDateformat(InTime);
                        bgClass = "Checked In...";
                    }
                    else {
                         status = "Expired...";
                         time = ChangeDateformat(InTime);
                         bgClass = "Expired...";
                    }
                }
                else
                {
                    status = "Waiting...";
                    time = "Start After :" + ChangeDateformat(startTime);
                    bgClass = "Waiting...";
                }



                viewString += '<div class=\"row layout_shadow_table\">' +
                         '<div class=\"col-lg-2 col-md-2 col-sm-2 col-xs-6\"><b>Visitor: <span class="fa fa-circle" style="color:green;"></span></b> <img id="TenantImage" src="Images/Icon/profile.jpg" height="60" width="60" style="border-radius:50%;"/> </div>' +
                         '<div class=\"col-lg-4 col-md-4 col-sm-4 col-xs-6\"> <br/> <span class="fa fa-user" style="color:#2b7a2d;"></span>  ' + VisitorName + '<br /><span class="fa fa-phone" style="color:#2b7a2d;"></span> ' + VisitorMobile + '<br /><span class="fa fa-home" style="color:#2b7a2d;"></span> ' + VisitorAddress + '</div>' +
                         '<hr class=\"hidden-lg hidden-md hidden-sm\" style="margin-top:90px;" /> ' +
                         '<div class=\"col-lg-3 col-md-3 col-sm-3 col-xs-6 ' + bgClass + '\"><br/><span class="fa fa-question-circle" style="color:#2b7a2d;"></span> ' + VisitPurpose + '<br/>' + time + '<br /><span class="fa fa-info-circle" style="color:#2b7a2d;"></span><p1> ' + status + '</p1></div>' +
                         '<div class=\"col-lg-3 col-md-3 col-sm-3 col-xs-6 Host\"><b> Host: <br/><span class="fa fa-user" style="color:#2b7a2d;"></span> </b>' + HostName + ',' + HostType + '<br/><span class="fa fa-phone" style="color:#2b7a2d;"></span> </b>' + VisitorMobile + '<br/><span class="fa fa-home" style="color:#2b7a2d;"></span> </b>' + FlatNumber + '</div>' +
                         '</div>';

            }


            con.innerHTML += viewString;

            parent.iframeLoaded();
        }



        function AddVisitor() {
           // alert("at 485 add visitor");
            var name, mobile, address, purpose,visitDate;

            name = document.getElementById("idName").value;
           // alert("at 450==> name=" + name);
            mobile = document.getElementById("txtmobile").value;
            address = document.getElementById("Address").value;
            purpose = document.getElementById("Purpose").value;
            visitDate = document.getElementById("btnEntryDate").value;
            startTime = $("#timeList").val();
            var start = new Date(visitDate);
            var strStartDate = GetDateTimeinISO(start);
            // alert("at 498==> " + strStartDate);
            var strEndDate = GetDateTimeinISO(new Date("2020-05-10T00:00:00.000"));
            
         //   alert(strStartDate);

        //   // var strStartDate = GetDateTimeinISO(start);

        //    var strStartDate = new Date(visitDate).toISOString();
        ////    splitstring1 = strStartDate.split(".")[0];
        //  //  splitstring2 = splitstring1.split("T");
        //    var start = new Date(visitDate);
        //   //var startdate = new Date(start.getFullYear() + "/" + start.getMonth() + "/" +start.getDate()+" 00:00:00.000");
        //    //alert(startdate);
        //   // alert(strStartDate.getMonth());
        //    //alert(strStartDate.getDate());
        //     //alert(strStartDate.getTime());

        //    var endDate = start.setHours(start.getHours + 1);

        //    var strEndDate = "2012/02/10";
        //    // var strEndDate = GetDateTimeinISO(endDate);
        //   // var strEndDate = new Date(endDate).toISOString();


        //   // alert(start);

        //    var month = start.getMonth() + 1;

        //    var strMonth="";
        //    if (month < 10) {
        //        strMonth = 0 + month.toString();
        //    }
        //    else {
        //        strMonth = month.toString();
        //    }

        //    var day = start.getDate();

        //    var strDay="";
        //    if (day < 10) {
        //        strDay = 0 + day.toString();
        //    }
        //    else {
        //        strDay = day.toString();
        //    }

        //    var startHrs = "";
        //    var endHrs = "";

        //    if (VisitorEntryHour < 9) {
        //         startHrs = 0 + VisitorEntryHour.toString();
        //       endHrs = 0 + (VisitorEntryHour+1).toString();

        //    }
        //    else if (VisitorEntryHour = 9) {
        //         startHrs = 0+ VisitorEntryHour.toString();
        //       endHrs = (VisitorEntryHour+1).toString();
        //    }
        //    else {
        //       startHrs = VisitorEntryHour.toString();
        //       endHrs = (VisitorEntryHour+1).toString();

        //    }


        //    var strStartDate = start.getFullYear() + "-" + strMonth + "-" + strDay + "T" + startHrs + ":00:00";
            

        //    var strEndDate = start.getFullYear() + "-" + strMonth + "-" + strDay +  "T" + endHrs + ":00:00" ;
           
        //   // alert(strStartDate);
           
     
        ////   endTime = document.getElementById("btnStartTime").value;
       
            document.getElementById("post_loading").style.display = "block";


            
             var strURL = api_url +  "/api/Visitor/New";
             //var strURL = "visitor.aspx/AddVisitor";

            var reqBody = "{\"VisitorName\":\"" + name + "\",\"VisitorMobile\":\"" + mobile + "\",\"VisitorAddress\":\"" + address + " \",\"VisitPurpose\":\"" + purpose + "\",\"StartTime\":\"" + strStartDate + "\",\"EndTime\":\"" + strEndDate +
                           "\",\"ResID\":\"" + ResId + "\",\"FlatNumber\":\"" + FlatNumber + "\",\"SocietyId\":\"" + SocietyId + "\"}"
            console.log(reqBody);
          //  alert(reqBody);

            $.ajax({
                dataType: "json",
                url: strURL,
                async: false,
                data: reqBody,
                type: 'post',
                contentType: "application/json; charset=utf-8",
                success: function (data) {
               //     alert(JSON.stringify(data));
                    document.getElementById("post_loading").style.display = "none";

                    if (data.Response == "Fail") {
                        alert('Could not update');
                    }
                    else if (data.Response == "Ok") {
                         $("#AddVisitorModal").hide();
                        alert('Updated Successfully');
                        GetVisitorData();
                    }
                    else {
                         alert('Undefined');
                    }
                    
                },
                error: function (data, errorThrown) {
                    document.getElementById("post_loading").style.display = "none";

                    alert('Error Updating comment, try again');
                }
            });
            closefn();
        }

        function closefn() {
            document.getElementById('btnEndTime').innerText = null;
            document.forms["form1"].reset();
           document.getElementById('AddVisitorModal').style.display="none";
      
        }

        function UpdateCheckIn() {
            document.getElementById("verify_loading").style.display = "block";



            var strURL = api_url +  "/api/Visitor/CheckIn";

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
                //  alert("Name must be filled out");
                return false;
            }
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }

        function getByDataMobile() {
            var MobileNo = document.getElementById("txtmobile").value;
            console.log(MobileNo);
            url = api_url + "/api/Visitor/" + SocietyId + "/Mob/" + MobileNo;


            $.ajax({
                type: "Get",
                url: url,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    //console.log(data);
                    $("#idName").val(data.VisitorName);
                    $("#Address").val(data.VisitorAddress);
                    console.log(data.VisitorAddress);
                },
                failure: function (response) {
                    // document.getElementById("verify_loading").style.display = "none";
                    alert("None");
                    // alert(response.d);
                    //sessionStorage.clear();
                }
            });

        }
      

    </script>
    <style>

        .padd {
            padding-right:5px !important;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
     <div class="container-fluid" style="background-color:#f7f7f7;position:relative;">
                         <div class="row" style="margin-top:15px;">
                               
                             <div class="col-md-3 col-sm-3  hidden-xs">
                                     <div>
                                         <h4 class="pull-left ">Visitor :</h4>

                                     </div>
                                 </div>

                                 <div class="col-md-6 col-sm-6 col-xs-6" style="margin-top:-20px" id="pagination">                           
                                     <nav aria-label="Page navigation example">
                                         <ul class="pagination">
                                             <li class="page-item"><a class="page-link" href="#"  onclick="ShowPrevious()" id="btnPrevious" >Previous</a></li>
                                             <li class="page-item"><a class="page-link" id="oneprev" href="#">1</a></li>
                                             <li class="page-item"><a class="page-link" id="current" href="#">2</a></li>
                                             <li class="page-item"><a class="page-link" id="onenext" href="#">3</a></li>
                                             <li class="page-item"><a class="page-link" href="#"  id="btnNext" onclick="ShowNext()" >Next</a></li>
                                         </ul>
                                     </nav>
                                </div>

                                 <div class="col-md-3 col-sm-3 col-xs-6">
                                         <button id="btnAddVisitor" class="btn btn-primary btn-sm" type="button"><i class="fa fa-plus"></i> Add Visitor</button>
                                         <button id="btnVerifyVisitor"  class="btn btn-primary btn-sm" type="button"><i class="fa fa-check"></i> Verify</button>
                                 </div>
                             </div>
   
       
          
         <div id="dataContainer" class="container-fluid padd" >
             </div>
              <div id="data_loading" class="container-fluid padd" style="text-align:center;width:100%; height:200px;background-color:#090909;opacity:0.2;position:fixed; top:100px; z-index:99;">
                    <img src="Images/Icon/ajax-loader.gif" style="width:20px;height:20px; margin-top:50px;" />
                  <%--<i class="fa fa-spinner"  style="width:50px; height:50px;margin-top:100px;"></i>--%>
                   </div>

        <div id="AddVisitorModal" class="modal">
             
                  
                  <div class="panel panel-primary" style="width:400px;background-color:#fff;margin: auto;">
                              <div class="panel-heading">
                                  Add Visitor <span class="fa fa-times" id="icon_close" style="cursor:pointer;float:right;"></span>
                              </div>
                              <div class="panel-body" >
                                  <form name="visitor" autocomplete="off">
                                      <div class="container-fluid">
                                           <div class="row"style="margin-top:5px">
                                            <label class="col-xs-4" for="MobileNo">Mobile No:</label>
                                            <div class="col-xs-8">
                                                 <input id="txtmobile" type="text" onkeypress="return isNumberKey(event)" class="form-control col-xs-8"  placeholder="Enter Mobile No." name="MobileNo" onblur="blur()" />
  
                                            </div>
                                          </div>

                                          <div class="row" style="margin-top:0px">
                                            <label for="colFormLabel" class="col-xs-4 col-form-label">Name: </label>
                                            <div class="col-xs-8">
                                                <input type="text" class="form-control col-xs-8" id="idName"   placeholder="Enter Name" name="Name" />
                                            </div>
                                          </div>
                                         
                                          <div class="row"style="margin-top:5px">
                                            <label for="colFormLabel" class="col-xs-4 col-form-label">Address: </label>
                                            <div class="col-xs-8">
                                                 <textarea class="form-control col-xs-8" rows="2" id="Address" style="resize:none;" name="Address" placeholder="Enter Address"></textarea>
                                            </div>
                                          </div>
                                          <div class="row"style="margin-top:5px">
                                            <label for="colFormLabel" class="col-xs-4 col-form-label">Purpose: </label>
                                            <div class="col-xs-8">
                                             <input type="text" name="Purpose" class="form-control col-xs-8"id="Purpose" placeholder="Enter Purpose"/>
                                            </div>
                                          </div>
                                          <div class="row"style="margin-top:5px">
                                            <label for="colFormLabel" class="col-xs-4 col-form-label">Time / Date </label>
                                            <div class="col-xs-8">
                                             <input type="text" class="form-control col-xs-4"   id="btnEntryDate"  name="StartDate"/>
                                             <select class="form-control col-xs-4" id="timeList"></select>
                                            </div>
                                          </div>
                                          <div class="row"style="margin-top:5px">
                                            <label for="colFormLabel" class="col-xs-4 col-form-label">Valid Till: </label>
                                            <div class="col-xs-8">
                                           <label  class="form-control col-xs-8" id="btnEndTime" ></label>
                                            </div>
                                          </div>
                                      </div>
                                 
                                  </form>


                              </div>

                              <div class="panel-footer" style="text-align:right; background-color:#f7f7f7;">
                                   <button type="button" id="btnSubmit"  style="margin-top:5px;"  class="btn-sm btn btn-primary">Submit</button>
                                  <button type="button" id="btnCancel"  style="margin-top:5px;" class="btn-sm btn btn-danger">Cancel</button>
                                   
                              </div>
                      <div id="post_loading" class="container-fluid" style="text-align:center;width:100%; height:200px;background-color:#090909;display:none;opacity:0.2;position:fixed; top:100px; z-index:99;">
                    <img src="Images/Icon/ajax-loader.gif" style="width:20px;height:20px; margin-top:50px;" />
                    <%-- <i class="fa fa-spinner" aria-hidden="true" style="width:30px; height:30px;margin-top:100px;"></i>--%>
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
                          <button type="button" class="btn btn-sm btn-danger" onclick="CloseVerify()">Cancel</button>
                              <button type="button" id="btnCheckIn"  class="btn btn-sm btn-primary" >Check In</button>
                                     
                      </div>
                        <div id="verify_loading" class="layout-overlay" style="width:500px; text-align:center;vertical-align:middle;">

                            <%--<i class="fa fa-spinner" aria-hidden="true" style="width:30px; height:30px;margin-top:100px;"></i>--%>
                               <img src="Images/Icon/ajax-loader.gif" style="width:30px; height:30px;margin-top:100px;" />
                              
                     </div>
                 </div>
                 
                </div>
            </div>
         </div>
    </form>

</body>
</html>
