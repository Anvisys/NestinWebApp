<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MainPage.aspx.cs" Inherits="MainPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- jQuery library -->


    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css" />

    <link rel="stylesheet" href="CSS/NewAptt.css" />



    <style>
        @media only screen and (max-width: 600px) {
            #lblsocietyname {
                font-size:14px;
            }
        }
        @media only screen and (max-width: 600px) {
            #profile_image {
                margin-left: 17px;
            }
        }
        e
        .Left-Nav {
            
            padding-left: 15px;
           
        }

            .Left-Nav ul {
                list-style-type: none;
            }
            .Left-Nav li {
                margin-top: 20px;
            }
            .Left-Nav a {
                color: white;
                font-size: 15px;
               
            }

        .margin-zero {
            margin: 0px !important;
            padding: 0px;
            background-color: #727cf5;
        }

        .margin-five {
            margin: 5px !important;
            padding: 0px;
            background-color: #727cf5;
        }
        .dropdown-menu {
            left: 20px;
            float: none;
            background-color: #f7f7f7;
        }
        .dropdown-menu li a {
            color:#000;
        }
        .button-style {
            background: none;
            border: none;
            padding-left: 1px;
            color: #fff;
        }
          .textlign {
                position: absolute;
    padding-left: 30px;
        }
        @media only screen and (max-width: 600px) {
            .button-style {
                padding-left: 18px;
            }
.dropdown-menu {
           
            left: -40px!important;
           
        }
        }
        .ro {
            margin-top: 10px;
        }

      
        .thumbnail {
            border-color: #f7f7f7;
            background-color: #4fc3f7;
            text-align:center;
            
        }

        @media only screen and (max-width: 600px) {
            .thumbnail {
                border-color: #f7f7f7;
                background-color: #4fc3f7;
                height: 120px;
                color:#fff;
                margin-bottom:0px;   
            }
            .textlign {
                position: static;
            }
            .button-style {
                color:#000;
            }
            .thumbnail img {
                height: 100px;
                width: 100px;
                float: right;
            }
                .thumbnail h3, p, h4 {
                    float: left;
                    margin-right: 45px;
                    margin-top: 2px;
                    margin-bottom: 8px;
                    padding-left: 10px;
                }
                #displayData {
                    padding:0px;
                    margin:0px;
                }
            .ro {
                margin-top: 0px;
            }
        }
         .dropdown-menu {
      left:20px;
  }
    
      
    </style>


    <script>
        var userType;
         $(document).ready(function () {
            userType = '<%=Session["UserType"] %>';
              api_url = '<%=Session["api_url"] %>';

            if (screen.width >= 768) {
              //  document.getElementById("content_frame").height = (screen.height - 100) + "px";

                // document.getElementById("slider").height = (screen.height - 220) / 4 + "px";
            }

            else {
              // document.getElementById("content_frame").height = (screen.height - 60) + "px";
            }

            SetMenu();

            var url = '<%=Session["CurrentPage"] %>';

            $('#content_frame').attr('src', url);
             GetAdvertisementData();
             $("#changeLoggedinSociety").hide();
        });

        function SetMenu() {
           
            if (userType == "Admin") {

                document.getElementById("Admin_Navigation").style.display = "inline";
                document.getElementById("Resident_Navigation").style.display = "none";
                document.getElementById("Employee_Navigation").style.display = "none";
                document.getElementById("Individual_Navigation").style.display = "none";

            }

            else if (userType == "Owner" || userType == "Tenant") {
                document.getElementById("Resident_Navigation").style.display = "inline";
                document.getElementById("Admin_Navigation").style.display = "none";
                document.getElementById("Employee_Navigation").style.display = "none";
                document.getElementById("Individual_Navigation").style.display = "none";
            }

            else if (userType == "Employee") {
                document.getElementById("Employee_Navigation").style.visibility = "visible";
                document.getElementById("Admin_Navigation").style.display = "none";
                document.getElementById("Resident_Navigation").style.display = "none";
                document.getElementById("Individual_Navigation").style.display = "none";

            }
            else if (userType == "Individual") {
                Individual_Navigation
                document.getElementById("Employee_Navigation").style.visibility = "none";
                document.getElementById("Admin_Navigation").style.display = "none";
                document.getElementById("Resident_Navigation").style.display = "none";
                document.getElementById("Individual_Navigation").style.display = "visible";
            }
        }



        function ShowMenu() {
            var content = "";
          

            var content_profile = document.getElementById("bs-example-navbar-collapse-2").innerHTML;
            var profile_dropdown = document.getElementById("profile_dropdown").innerHTML;
            var profile_image = document.getElementById("image").innerHTML;
            $("#Menu_x").empty();
            $("#Menu_x").append(content_profile);
            $("#Menu_x").append("<hr class=\"margin-five\" />");
            $("#Menu_x").append(profile_image);
            $("#Menu_x").append("<hr class=\"margin-five\"  />");
            $("#Menu_x").append(profile_dropdown);

            $("#Menu_x").toggle();
            //$("#menu1").toggle();

            
        }

        function FrameSourceChanged() {
            
            if (userType == "Owner" || userType == "Tenant") {
               
                $('#Menu_x').slideUp('hide');
            }
            else {
                 $('#Menu_x').slideUp('hide');
            }

            //if (userType == "Admin") {
            //    $('#bs-example-navbar-collapse-1').slideUp('hide');
            //}
            //else if (userType == "Owner" || userType == "Tenant") {
            //    $('#bs-example-navbar-collapse-2').slideUp('hide');
            //}
            //else if (userType == "Employee") {
            //    $('#bs-example-navbar-collapse-3').slideUp('hide');
            //}

        }

          function iframeLoaded() {
            var iFrameID = document.getElementById('content_frame');
            if (iFrameID) {
                // here you can make the height, I delete it first, then I make it again
                iFrameID.height = "";
                var scrollHeight = iFrameID.contentWindow.document.body.scrollHeight;
                var MinHeight = screen.height - 178;
                iFrameID.style.minHeight = MinHeight + "px";

                iFrameID.height = scrollHeight + "px";
            }
        }

        function ShowDDD() {
            $("#ddmenu").toggle();
        }

 


        function GetAdvertisementData() {
           
          var url = api_url + "/api/Ads";
            $.ajax({
                type: "Get",
                url: url,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    //document.getElementById("data_loading").style.display = "none";
                 
                    SetAds(data);
                },
                failure: function (response) {
                    // document.getElementById("data_loading").style.display = "none";
                    alert(response.d);
                    sessionStorage.clear();
                }
            });

        }


        function SetAds(data) {

            var jarray = data.$values;
            var length = jarray.length;
            var AdString = [];
            var con = document.getElementById("displayData");
            for (var i = 0; i < length; i++) {

                var Owner = jarray[i].Owner;
                var Title = jarray[i].Title;
                var Description = jarray[i].Description;
                var Offer = jarray[i].Offer;
                var StartDate = jarray[i].StartDate;
                var EndDate = jarray[i].EndDate;
                var base64Image = jarray[i].AdImage;


                AdString[i] = '<div class=\"ro \">' +
                    '<div class=\"thumbnail\">' +
                    '<h3 class=\"textlign\">' + Owner + '</h3>' +
                    '<img class=\"img_ad\" src="data:image/png;base64,' + base64Image + '">' +

                    '<h4 class=\"txtcolorwhite\">' + Description + '</h4>' +
                    '<h4 class=\"txtcolor\">Offer- ' + Offer + '</h4>' +

                    '</div>' +
                    '</div>';

            }


            con.innerHTML += AdString;




        }

         function ChangeLoggedinFlat() {

            $("#changeLoggedinSociety").show();
        }
        function changeLoggedinUserClick(val) {
            if (val == true) {
                $("#changeLoggedinSociety").hide();
                return true;
            }
            else {
                $("#changeLoggedinSociety").hide();
                return false;
            }
           
        }
    </script>

</head>
<body style="background-color:#f7f7f7;">
    <form id="form1" runat="server">
         <div class="container-fluid">

        <div class="row" id="top_header" style="position: fixed;width:100%; z-index: 10;">
            <div class="col-xs-4">
                <img src="Images/Icon/iconHome.png" style="margin-top: 5px;margin-left:20px;" height="47" width="75" />
            </div>
            <div class="col-xs-4">
                   <h4 style="color:#fff;text-align:center;"><asp:Label ID="lblsocietyname" runat="server"></asp:Label></h4>
            </div>
            <div class="col-md-4 hidden-xs">

                <ul class="list-inline pull-right" style="margin-top:7px;">

                    <li  class="dropdown">
                        <span id="image">
                             <asp:Image runat="server" ID="ImgProfileIcon" Style="height: 40px; width: 40px; border-radius: 50%;" />
                        </span>
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                           <asp:Label ID="lblUserName" runat="server" ForeColor="white"></asp:Label>
                            <span class="caret"></span>
                        </a>
                        <ul id="profile_dropdown" class="dropdown-menu">
                            <li><a href="Userprofile.aspx" id="User_profile" target="targetframe">Profile</a></li>
                            <li>
                                 <asp:LinkButton ID="btnlogout" runat="server" Text="Logout" OnClick="btnlogout_Click"></asp:LinkButton>
                            </li>
                             <li><a href="Role.aspx" id="User_Role" >Role</a></li>
                              <li id="ChangeFlat" runat="server" onclick="ChangeLoggedinFlat()"><a href="#">Change Flat/Role</a></li>
                        </ul>
                    </li>

                </ul>

            </div>
            <div class="hidden-lg hidden-md hidden-sm col-xs-4">
                <span class="fa fa-align-justify fa-2x" onclick="ShowMenu()" style="float:right;color:white;padding-top:10px;"></span>

                <ul class="dropdown-menu" id="Menu_x" style="display:none;"></ul>
            </div>


        </div>

        <div class="row" style="margin-top:67px;">

            <div class="col-md-2 hidden-sm hidden-xs margin-zero">

                <div id="Admin_Navigation" style="position:fixed;height:100%;background-color:#727cf5;width:inherit;" >
                    <div class="Left-Nav">
                        <ul >

                            <li> <a href="Dashboard.aspx" target="targetframe">Dashboard</a></li> <li> <a href="Reports.aspx" target="targetframe">Reports</a></li>
                            <li> <a href="Notifications.aspx" target="targetframe">Notifications</a></li>
                            <li>   <a href="Poll.aspx" target="targetframe">Polls</a></li>
                            <li>  <a href="Vendors.aspx" target="targetframe">Vendors</a></li>
                            <li> <a href="Viewcomplaints.aspx" target="targetframe">Complaints</a></li>
                            <li>  <a href="visitor.aspx" target="targetframe">Visitor</a></li>
                                                             
                                        <li class="dropdown">
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Users <b class="caret"></b></a>
                                            <ul class="dropdown-menu">
                                                <li style="margin-top:2px;"><a href="Totalusers.aspx" target="targetframe">Residents</a></li>

                                                <li style="margin-top:2px;"><a href="Employees.aspx" target="targetframe">Employees</a></li>
                                                <li style="margin-top:2px;"><a href="Flats.aspx" target="targetframe">Flats/Resident</a></li>
                                          </ul>
                                        </li>
                                   <li class="dropdown">
                                  <a href="#" class="dropdown-toggle" data-toggle="dropdown">Bills <b class="caret"></b></a>
                                            <ul class="dropdown-menu">
                                                <li style="margin-top:2px;"><a href="LatestBill.aspx" target="targetframe">Latest</a></li>

                                                <li style="margin-top:2px;"><a href="ActiveBillPlan.aspx" target="targetframe">Active</a></li>
                                                <li style="margin-top:2px;"><a href="SocietyBillPlan.aspx" target="targetframe">Plans</a></li>
                                                </ul>
                                       </li>
                        </ul>
                        </div>
                    </div>
                    <div id="Resident_Navigation" style="position:fixed;height:100%;background-color:#727cf5;width:inherit;" >
                    <div class="Left-Nav">
                        <ul id="bs-example-navbar-collapse-2">

                            <li> <a href="Dashboard.aspx" target="targetframe">Dashboard</a></li>

                            <li><a href="Discussions.aspx" target="targetframe">Discussions</a></li>
                            <li> <a href="Reports.aspx" target="targetframe">Reports</a></li>
                            <li> <a href="Notifications.aspx" target="targetframe">Notifications</a></li>
                            <li>   <a href="Poll.aspx" target="targetframe">Polls</a></li>
                            <li>  <a href="Vendors.aspx" target="targetframe">Vendors</a></li>
                            <li> <a href="Viewcomplaints.aspx" target="targetframe">Complaints</a></li>
                            <li> <a href="BillPayments.aspx" target="targetframe">Payments</a></li>
                            <li>  <a href="MyFlat.aspx" target="targetframe">MyFlat</a></li>
                            <li>  <a href="visitor.aspx" target="targetframe">Visitor</a></li>
                            <li>  <a href="RentInOut.aspx" target="targetframe">Rent</a></li>
                             <li>  <a href="CarPool.aspx" target="targetframe">CarPool</a></li>

                        </ul>
                        </div>
                    </div>
                  <div id="Employee_Navigation" style="position:fixed;height:100%;background-color:#727cf5;width:inherit;" >
                    <div class="Left-Nav">
                        <ul id="bs-example-navbar-collapse-4">

                            <li> <a href="Dashboard.aspx" target="targetframe">Dashboard</a></li>

                            <li><a href="Discussions.aspx" target="targetframe">Discussions</a></li>
                            <li> <a href="Reports.aspx" target="targetframe">Reports</a></li>
                      



                        </ul>
                        </div>
                    </div>
                <div id="Individual_Navigation" style="position:fixed;height:100%;background-color:#727cf5;width:inherit;" >
                    <div class="Left-Nav">
                        <ul id="navbar-individual">

                            <li> <a href="MyHouse.aspx" target="targetframe">My House</a></li>
                            <li><a href="Vendors.aspx" target="targetframe">Vendors</a></li>
                            <li> <a href="Services.aspx" target="targetframe">Services</a></li>
                      



                        </ul>
                        </div>
                    </div>
            </div>


      
            <div class="col-md-8 col-sm-12 col-xs-12" style="height:600px; margin:0px; padding:0px;">
  <iframe   style="margin:0px;padding:0px;background-color: #f7f7f7;" id="content_frame" onload="iframeLoaded()" name="targetframe" src="Dashboard.aspx" class="iframe-layout"></iframe>
            </div>

        <div class="col-md-2 col-sm-12 hidden-xs" id="displayData">
        </div>
        </div>
                    <div class="changeLoggedinSociety" id="changeLoggedinSociety">
                    <div class="changeLoggedinSociety-inner">
                    <div style="text-align: center">
                        <h3 style="padding-top: 10px;">Please change Role/Flat</h3>
                    </div>
                    <div class="changeLoggedinSociety-items ">
                        <asp:DataList ID="dlRoles" runat="server">
                            <SelectedItemStyle />

                            <ItemTemplate>
                                <div class="rolesList">
                                    <asp:LinkButton ID="lnkRole" runat="server" CommandArgument='<%#Eval("Value.ResID") %>' OnClick="lnkRole_Click">
                                                    <span> <%# Eval("Key")%></span>
                                    </asp:LinkButton>

                                </div>
                            </ItemTemplate>
                        </asp:DataList>
                    </div>
                    <div style="text-align: right; margin-right: 20px;">
                        <button type="button" id="btnCancel" class="btn btn-danger" onclick="changeLoggedinUserClick(false)">Cancel</button>
                    </div>
                </div>
 
    </div>
    </div>
    </form>

</body>

</html>
