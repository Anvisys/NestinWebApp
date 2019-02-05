<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MainPage_1.aspx.cs" Inherits="MainPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Aptt</title>

     
      <meta name="viewport" content="width=device-width, initial-scale=1"/>
     <script src="Scripts/jquery-1.11.1.min.js"></script>
   
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- jQuery library -->
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
   
    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css"/>  

   <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />

     <link rel="Stylesheet" href="CSS/ApttLayout.css"/>
    <link rel="stylesheet" href="CSS/ApttTheme.css" />

     <link rel="stylesheet" href="CSS/NewAptt.css" />

    <script>

        var userType;

        $(document).ready(function () {
            userType = '<%=Session["UserType"] %>';

                    if (screen.width >= 768)
                    {
                      document.getElementById("content_frame").height = (screen.height - 154) + "px";
                    }

                    else
                    {
                      document.getElementById("content_frame").height = (screen.height - 50) + "px";
                    }


                    SetMenu();

             $('html').click(function () {
                 $(".layout-dropdown-content").hide();
             });

             $("a").click(function () {
                 $("a").removeClass("selected_link");
                 $(this).addClass("selected_link");
             });


             $("#profile_button").click(function (event) {
               
                 if ($('#UserType_Div').is(':visible')) {
                     $("#UserType_Div").hide();
                 } else {

                     $("#UserType_Div").slideDown();
                 }
                 event.stopPropagation();
             });


             var url = '<%=Session["CurrentPage"] %>';
     
            $('#content_frame').attr('src', url);
        });

        function ProfileChange() {
            
            var ResiID = '<%=Session["ResiID"] %>';
         
            document.getElementById("ImgProfileIcon").src = "/Images/User/" + ResiID + ".png";

        }


        function SetMenu() {
                   
            if (userType == "Admin") {

                document.getElementById("Admin_Navigation").style.display = "inline";
                document.getElementById("Resident_Navigation").style.display = "none";
                document.getElementById("Employee_Navigation").style.display = "none";

            }

            if (userType == "Owner" || userType == "Tenant") {
                document.getElementById("Resident_Navigation").style.display = "inline";
                document.getElementById("Admin_Navigation").style.display = "none";
                document.getElementById("Employee_Navigation").style.display = "none";

            }

            if (userType == "Employee") {
                document.getElementById("Employee_Navigation").style.visibility = "visible";
                document.getElementById("Admin_Navigation").style.display = "none";
                document.getElementById("Resident_Navigation").style.display = "none";

            }
        }

        function ShowMenu() {

            if (userType == "Admin") {
                $('#bs-example-navbar-collapse-1').toggle();
            }
            else if (userType == "Owner" || userType == "Tenant") {
                $('#bs-example-navbar-collapse-2').toggle();
            }
            else if (userType == "Employee") {
                $('#bs-example-navbar-collapse-3').toggle();
            }

        }

        function FrameSourceChanged() {
           
            if (userType == "Admin") {
                $('#bs-example-navbar-collapse-1').slideUp('hide');
            }
            else if (userType == "Owner" || userType == "Tenant") {
                $('#bs-example-navbar-collapse-2').slideUp('hide');
            }
            else if (userType == "Employee") {
                $('#bs-example-navbar-collapse-3').slideUp('hide');
            }

        }


    </script>

    <style>
  .header1 {
       float: left;
    height: 40px;
    padding: 8px 13px;
    
}
  .header1 a {
      color:#fff;
  }
  .dropdown-menu {
      left:50px;
  }
    </style>
</head>
<body class="theme_body_background font_primary" style="margin-bottom:0px;padding:0px; overflow:hidden;">

    


    <form id="form1" runat="server">

        <div class="row" style="width:100%; height:60px; background-color:#D14545;">
        <div class="col-xs-4">
            <img src="http://icons.iconarchive.com/icons/graphicloads/100-flat/256/home-icon.png" height="40" width="40"/>
        </div>
        <div class="col-xs-4">
            <h4 style="color:#fff">

                <asp:Label ID="lblSocietyName2" runat="server"></asp:Label>
            </h4>
        </div>
        <div class="col-md-4 hidden-xs">
              
                     <ul class="list-inline pull-left">
               
                            <li class="dropdown">
                                <img src="../Images/Default/profile.jpg" style="height:40px;width:40px; border-radius:50%; "/>
                                  <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                  <asp:Label ID="lblUserName" runat="server"></asp:Label>
                                      <span class="caret"></span></a>
                                  <ul class="dropdown-menu">
                                    <li><a href="Userprofile.aspx" id="User_profile" target="targetframe">Profile</a></li>
                                      <li><a href="#"><asp:LinkButton ID="LinkButton3" runat="server" Text="Logout" OnClick="btnlogout_Click"></asp:LinkButton> </a></li>
                                    <li><a href="#">About</a></li>
                                  </ul>
                                </li>

                    </ul>
           
        </div>
                        <div class="hidden-md hidden-lg hidden-sm col-xs-4">
                            <button class="pull-right dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <span class="glyphicon glyphicon-th-list"></span>
                                         
                                      </button>

                            <ul class="dropdown-menu">
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="#">Separated link</a></li>
                              </ul>

                        </div>
    </div>



     <div class="container-fluid" id="MyHeader" style="margin-bottom:0px;padding-bottom:0px;margin-right:0px; ">
      <%--rohit menu--%>
            <div class="row" style="display:none;">
             <nav class="navbar navbar-inverse zero-margin">
                  <div class="container-fluid">
                    <div class="navbar-header">
                      <button type="button" class="" data-toggle="collapse" data-target="#myNavbar">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>                        
                      </button>
                      <ul class="list-inline">
                     <li> <img src="http://icons.iconarchive.com/icons/graphicloads/100-flat/256/home-icon.png" height="40" width="40"></li>
                      <li><a class="navbar-brand" href="#"><asp:Label ID="lblsocietyname" runat="server" Font-Size="Medium"></asp:Label></a></li> 
                        </ul>
                    </div>
                    <div class="collapse navbar-collapse" id="myNavbar">
      
                      <ul class="nav navbar-nav navbar-right">
                        <li><asp:ImageButton ID="ImgProfileIcon" ImageUrl="~/Images/Default/profile.jpg" runat="server" Height="50" Width="50" CssClass="profile_log" /></li>
        
                      <li class="dropdown">
                          <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                              <asp:Label ID="lblAdmin" runat="server" Text="Nagaraju"></asp:Label> as 
                                                <asp:Label ID="lblUType" runat="server" Text="Admin"></asp:Label>
                              <span class="caret"></span></a>
                          <ul class="dropdown-menu">
                            <%--<li><a href="Userprofile.aspx" id="User_profile" target="targetframe">Profile</a></li>--%>
                            <li><asp:Button ID="btnlogout" runat="server" Text="Logout" CssClass="layout_list_type" OnClick="btnlogout_Click" /></li>
                            <li><a href="#">Help</a></li>
                          </ul>
                        </li>
                      </ul>
                    </div>
                  </div>
                </nav>
         </div>
      
     
            <%--   <header id="header">
            <div class="row hidden-xs hidden-sm theme_text_only" >
                <div class="col-xs-4 font_size_3">
                    <img src="Images/Icon/iconHome.png" alt="My Aptt" width:45px; height="45px" style="border-radius:50%;" /><br />
                        <label id="lblAnvisys">Anvisys</label>
                </div>
                <div class="col-xs-4 font_size_1">
                     <label id="lbltitle">SOCIETY MANAGEMENT SYSTEM</label>
                            <asp:Label ID="lblsocietyname" runat="server" Font-Size="Medium"></asp:Label>
                                         
                </div>
               <div class="col-sm-4">
                    <div id="profile_button" class="font_size_3" style="float:right; margin-right:10px;">
                            <asp:ImageButton ID="ImgProfileIcon" ImageUrl="~/Images/Default/profile.jpg" runat="server" Height="50" Width="50" CssClass="profile_log" />
                            <b class="caret"></b>
                               <asp:Label ID="lblAdmin" runat="server" Text="Nagaraju"></asp:Label> as 
                                <asp:Label ID="lblUType" runat="server" Text="Admin"></asp:Label>

                        </div>
                        <%-- User Profile Div--%>
<%--                        <div id="Usertype" style="color:#10023c; float:right; margin-right:40px; margin-top:30px;">--%>
<%--                            <div class="layout-dropdown-content theme-dropdown-content" id="UserType_Div">--%>
<%--                                <a href="Userprofile.aspx" id="User_profile" target="targetframe">Profile</a>--%>
                                <%--<asp:Button ID="btnlogout" runat="server" Text="Logout" CssClass="layout_list_type" OnClick="btnlogout_Click" />--%>
<%--                                <a href="#" id="help">Help</a>--%>
                   <%--         </div>
                        </div>
                </div>
            </div>
       </header>--%> 
        <div class="container-fluid" style="margin-bottom:0px;padding-bottom:0px;margin-right:0px;">
        <div class="row" >
            <div class="col-12">
                       <%-- Admin Navigation Bar  --%>
                 <div id="Admin_Navigation" style="text-align: center;display: none;">
                           
                        <nav  class="navbarfont_heading_1" role="navigation" >
                            <!-- Brand and toggle get grouped for better mobile display -->
                            
                            <div class="hidden-lg hidden-md hidden-sm" style="border-style:none; vertical-align:central;">
                                <label class="font_size_1" >Society Management System</label>
                                    <button type="button" class="hidden-lg hidden-md hidden-sm" style="border:none; background-color:transparent;" data-toggle="" onclick="ShowMenu()">
                                       <span class="glyphicon glyphicon-menu-hamburger" style="color:black;font-size:large"></span>
									</button>
                                </div>

                            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" style="color:black;">
                             <ul id="menu" class="nav navbar-nav font_size_2">
                                    <li ><a href="Dashboard.aspx" target="targetframe">Dashboard</a></li>
                                      <%-- <li class="active"><a href="home.aspx" target="targetframe">Home</a></li>--%>
                                       <li><a href="Discussions.aspx" target="targetframe">Discussions</a></li>
                                    <li><a href="Reports.aspx" target="targetframe">Reports</a></li>
                                    <li><a href="Notifications.aspx" target="targetframe">Notifications</a></li>

                                 <%--   <li><a href="BillPayments.aspx" target="targetframe">Bill Payments</a></li>--%> 
                                    <li><a href="Poll.aspx" target="targetframe">Polls</a></li>
                                    <li><a href="Vendors.aspx" target="targetframe">Vendors</a></li>
                                    <li><a href="Viewcomplaints.aspx" target="targetframe">Complaints</a></li>

                                    <ul class="nav navbar-nav ">
                                        <li class="dropdown">
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Users <b class="caret"></b></a>
                                            <ul class="dropdown-menu">
                                                <li><a href="Totalusers.aspx" target="targetframe">Residents</a></li>

                                                <li><a href="Employees.aspx" target="targetframe">Employees</a></li>
                                                <li><a href="Flats.aspx" target="targetframe">Flats</a></li>
                                          </ul>
                                        </li>
                                    </ul>

                                   <ul class="nav navbar-nav ">
                                        <li class="dropdown">
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Bills <b class="caret"></b></a>
                                            <ul class="dropdown-menu">
                                                <li><a href="LatestBill.aspx" target="targetframe">Latest</a></li>

                                                <li><a href="ActiveBillPlan.aspx" target="targetframe">Active</a></li>
                                                <li><a href="SocietyBillPlan.aspx" target="targetframe">Plans</a></li>
                                          </ul>
                                        </li>
                                    </ul>
                                                                    
                                 <li class="hidden-sm hidden-md hidden-lg"><asp:LinkButton ID="LogOut" runat="server" Text="LogOff" OnClick="btnlogout_Click"></asp:LinkButton>  </li>
                                </ul>
                            </div>
                        </nav>

                 </div>


                    <%-- Resident Navigation Bar  --%>
                 <div id="Resident_Navigation" style="text-align: center;display: none;">
                           
                        <nav  class="navbar theme_primary_bg font_heading_1" role="navigation" >
                            <!-- Brand and toggle get grouped for better mobile display -->
                            
                            <div class="hidden-lg hidden-md hidden-sm" style="border-style:none; vertical-align:central;">
                                <label class="font_size_1" >Society Management System</label>
                                    <button type="button" class="hidden-lg hidden-md hidden-sm" style="border:none; background-color:transparent;" data-toggle="" onclick="ShowMenu()">
                                       <span class="glyphicon glyphicon-menu-hamburger" style="color:black;font-size:large"></span>
									</button>
                                </div>

                            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2" style="color:black;">
                             <ul id="menu" class="nav navbar-nav theme_primary_bg font_size_2">
                                    <li ><a href="Dashboard.aspx" target="targetframe">Dashboard</a></li>
                                      <%-- <li class="active"><a href="home.aspx" target="targetframe">Home</a></li>--%>
                                       <li><a href="Discussions.aspx" target="targetframe">Discussions</a></li>
                                    <li><a href="Reports.aspx" target="targetframe">Reports</a></li>
                                    <li><a href="Notifications.aspx" target="targetframe">Notifications</a></li>

                                 <%--   <li><a href="BillPayments.aspx" target="targetframe">Bill Payments</a></li>--%> 
                                    <li><a href="Poll.aspx" target="targetframe">Polls</a></li>
                                    <li><a href="Vendors.aspx" target="targetframe">Vendors</a></li>
                                    <li><a href="Viewcomplaints.aspx" target="targetframe">Complaints</a></li>
                                 <li><a href="BillPayments.aspx" target="targetframe">Payments</a></li>
                                  <li><a href="MyFlat.aspx" target="targetframe">MyFlat</a></li>
                                   
                                 <li class="hidden-sm hidden-md hidden-lg"><asp:LinkButton ID="LinkButton1" runat="server" Text="LogOff" OnClick="btnlogout_Click"></asp:LinkButton>  </li>
                                </ul>
                            </div>
                        </nav>

                 </div>

                  <%-- Employee Navigation Bar  --%>
                 <div id="Employee_Navigation" style="text-align: center;display: none;">
                           
                        <nav  class="navbar theme_primary_bg font_heading_1" role="navigation" >
                            <!-- Brand and toggle get grouped for better mobile display -->
                            
                            <div class="hidden-lg hidden-md hidden-sm" style="border-style:none; vertical-align:central;">
                                <label class="font_size_1" >Society Management System</label>
                                    <button type="button" class="hidden-lg hidden-md hidden-sm" style="border:none; background-color:transparent;" data-toggle="" onclick="ShowMenu()">
                                       <span class="glyphicon glyphicon-menu-hamburger" style="color:black;font-size:large"></span>
									</button>
                                </div>

                            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-3" style="color:black;">
                             <ul id="employee_menu" class="nav navbar-nav theme_primary_bg font_size_2">
                                    <li ><a href="Dashboard.aspx" target="targetframe">Dashboard</a></li>
                                      <%-- <li class="active"><a href="home.aspx" target="targetframe">Home</a></li>--%>
                                       <li><a href="Discussions.aspx" target="targetframe">Discussions</a></li>
                                    <li><a href="Reports.aspx" target="targetframe">Reports</a></li>
                                    <li><a href="Notifications.aspx" target="targetframe">Notifications</a></li>

                                 <%--   <li><a href="BillPayments.aspx" target="targetframe">Bill Payments</a></li>--%> 
                                    <li><a href="Poll.aspx" target="targetframe">Polls</a></li>
                                    <li><a href="Vendors.aspx" target="targetframe">Vendors</a></li>
                                    <li><a href="Viewcomplaints.aspx" target="targetframe">Complaints</a></li>
                                 <li><a href="BillPayments.aspx" target="targetframe">Payments</a></li>
                                  <li><a href="MyFlat.aspx" target="targetframe">MyFlat</a></li>
                                   
                                 <li class="hidden-sm hidden-md hidden-lg"><asp:LinkButton ID="LinkButton2" runat="server" Text="LogOff" OnClick="btnlogout_Click"></asp:LinkButton>  </li>
                                </ul>
                            </div>
                        </nav>

                 </div>


                  </div>    
       </div>
          </div>


          
        
    </div>

            <div class="container-fluid" style="margin-bottom:0px;padding-bottom:0px;margin-right:0px;">
                <div class="row">
                    <div class="col-md-2 hidden-xs hidden-sm">
                        <a href="https://www.zomato.com/ncr/desi-kalika-hut-indirapuram-ghaziabad" target="_blank" style="text-decoration:none;text-decoration-color:black; display:none;">
                            <div class="layout_ad_banner" style="margin-left:10px;margin-top:0px; background-color:#d7eef2; height:220px;  ">
                                <img src="Images/Static/DesiKalikaHut.jpg" style="width:80px; height:80px;padding:5px; align-self:center" />
                                <h5 style="margin-top:5px;margin-bottom:5px;font:200;font-family:'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif">Desi Kalika</h5>
                                Now in IndiraPuram, Gaziabad <br />
                                Veg and Non_Veg Muglai <br />
                            </div>
                        </a>

                        <a href="https://www.anvisys.net" target="_blank" style="text-decoration:none;text-decoration-color:black; position:fixed; bottom:25px; display:none;">
                            <div class="layout_ad_banner" style="margin-left:10px; background-color:#c1ac88; height:220px;  ">
                                <img src="Images/Static/IT_Anvisys.jpg" style="width:80px; height:80px;padding:5px; align-self:center" />
                                <h5 style="margin-top:5px;margin-bottom:5px;font:200;font-family:'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif">Anvisys Technologies</h5>
                                IT Consulting and Services <br />
                                HO: Noida <br />
                            </div>
                        </a>
                    </div>
                    <div class="col-12  col-md-8">
                         <iframe  id="content_frame" name="targetframe" src="Dashboard.aspx" class="layout_iframe"></iframe>
                    </div>
                <div class="col-md-2"></div>
                </div>
             
            </div>
    </form>
</body>
</html>
