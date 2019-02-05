﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Aboutus.aspx.cs" Inherits="Aboutus" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>About us</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content="The MyAptt System is developed considering the day to day needs of society like complaints, Notification, social communication as well as managing the Residents, Vendors, and Employees Data of a society. Application caters the need of small to large societies and also provide the customization to meet your specific needs."/>
    <meta name="keywords" content="Society Management,Residential Society Management,Complaint Management,Society Expenses,Billing Software"/>
    <meta name="developer" content="Anvisys Technologies Pvt. Ltd."/>

            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
        <!-- CORE CSS -->

      <!-- Latest compiled and minified CSS -->
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
            <!-- jQuery library -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

            <!-- Latest compiled JavaScript -->
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


        <link href="Login/css/settings.css" rel="stylesheet" type="text/css"/>
        <!-- THEME CSS -->

        <link href="Login/css/essentials.css" rel="stylesheet" type="text/css"/>
        <link href="Login/css/layout.css" rel="stylesheet" type="text/css"/>
        <link href="Login/css/layout-responsive.css" rel="stylesheet" type="text/css"/>

        <link href="Styles/layout.css" rel="stylesheet" />
        <link href="Styles/Responsive.css" rel="stylesheet" />

    <link rel="stylesheet" href="CSS/ApttTheme.css" />
  <link rel="stylesheet" href="CSS/ApttLayout.css" />
     
    <link rel="stylesheet" href="CSS/NewAptt.css" />
   <link rel="stylesheet" href="Login/CSS/footer.css" />
    <script>


        $(function () {
            $("[id*=submitbutton]").bind("click", function () {
                var user = {};
                user.Username = $("[id*=TxtUserID]").val();
                user.Password = $("[id*=txtPwd]").val();
                $("#txtPwd").val("");
                $("#Forgotpass").hide();

                $.ajax({
                    type: "POST",
                    url: "Login.aspx/ValidateUser",
                    data: '{user: ' + JSON.stringify(user) + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                       
                        if (response.d == true) {
                            window.location = "MainPage.aspx";
                        }
                        else if (response.d == false) {

                            $('#lblerror').text("Login Failed");
                            $('#lblerror').show();
                            $('#lblPasswordRes').hide();
                            $("#Forgotpass").show();
                        }
                        //else {
                        //    alert(response.d);
                        //    var js = jQuery.parseJSON(response.d);
                        //    alert(JSON.stringify(js));
                        //    $("#topNav").hide();
                        //    $("#loginModal").hide();
                        //    $("#select_flat").show();
                        //}
                    }
                });
                return false;
            });
        });

        if (top.location != self.location) {
            top.location = self.location.href
        }

       <%-- function HideLabel() {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMessage.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };--%>

        $(document).ready(function () {
           
            $("#login").click(function () {           
                $("#loginModal").show();
                $("#Forgot_div").hide();
            });
        });

        $(document).ready(function () {
            $(".close").click(function () {
                $("#loginModal").hide();
                $("#Forgot_div").hide();
            });
        });


        $(document).ready(function () {
            $("#Forgotpass").click(function () {
                $("#loginModal").hide();
                $("#Forgot_div").show();
               
            });

            $("#GoLogin").click(function () {
                $("#loginModal").show();
                $("#Forgot_div").hide();

            });

            $("#btnForgotpass").click(function () {
                $("#Forgot_div").show();
                $("#loginModal").hide();
            })

        });

        $(document).ready(function () {
            $("#close").click(function () {
                $("input:text").val("");
                $("#txtPwd").val("");
                $("#lblerror").html("");

            });
        });


        $(document).ready(function () {

           $("#txtPwd").on('input', function () {
                $("#lblerror").html("");
            });
                
            
        });

        $(document).keypress(function (e) {
            if (e.which == 13) {
                e.preventDefault();
                $('#submitbutton').trigger('click');
            }
        });

        $(document).ajaxStart(function () {
            $('.dvLoading_first').show();
        }).ajaxStop(function () {
            $('.dvLoading_first').hide();
        });


        if (top.location != self.location) {
            top.location = self.location.href
        }

    </script>

    <style>
        body {
      font: 400 15px Lato, sans-serif;
      line-height: 1.8;
      color: #818181;
  }
  h2 {
      font-size: 24px;
      text-transform: uppercase;
      color: #303030;
      font-weight: 600;
      margin-bottom: 30px;
  }
  h4 {
      font-size: 19px;
      line-height: 1.375em;
      color: #303030;
      font-weight: 400;
      margin-bottom: 30px;
  }  
  .jumbotron {
      background-color: #00baed;
      color: #fff;
      
      font-family: Montserrat, sans-serif;
  }
 
  .bg-grey {
      background-color: #f6f6f6;
  }
  .bg-white {
      background-color: #fff;
  }
  .logo-small {
      color: #03A9F4;
      font-size: 50px;
  }
  .logo {
      color: #03A9F4;
      font-size: 200px;
  }
  .thumbnail {
      padding: 0 0 15px 0;
      border: none;
      border-radius: 0;
  }
  .thumbnail img {
      width: 100%;
      height: 100%;
      margin-bottom: 10px;
  }
  .carousel-control.right, .carousel-control.left {
      background-image: none;
      color: #f4511e;
  }
  .carousel-indicators li {
      border-color: #f4511e;
  }
  .carousel-indicators li.active {
      background-color: #f4511e;
  }
  .item h4 {
      font-size: 19px;
      line-height: 1.375em;
      font-weight: 400;
      font-style: italic;
      margin: 70px 0;
  }
  .item span {
      font-style: normal;
  }
  .panel {
      border: 1px solid #f4511e; 
      border-radius:0 !important;
      transition: box-shadow 0.5s;
  }
  .panel:hover {
      box-shadow: 5px 0px 40px rgba(0,0,0, .2);
  }
  .panel-footer .btn:hover {
      border: 1px solid #f4511e;
      background-color: #fff !important;
      color: #f4511e;
  }
  .panel-heading {
      color: #fff !important;
      background-color: #f4511e !important;
      padding: 25px;
      border-bottom: 1px solid transparent;
      border-top-left-radius: 0px;
      border-top-right-radius: 0px;
      border-bottom-left-radius: 0px;
      border-bottom-right-radius: 0px;
  }
  .panel-footer {
      background-color: white !important;
  }
  .panel-footer h3 {
      font-size: 32px;
  }
  .panel-footer h4 {
      color: #aaa;
      font-size: 14px;
  }
  .panel-footer .btn {
      margin: 15px 0;
      background-color: #f4511e;
      color: #fff;
  }
  .navbar {
      margin-bottom: 0;
      background-color: #f4511e;
      z-index: 9999;
      border: 0;
      font-size: 12px !important;
      line-height: 1.42857143 !important;
      letter-spacing: 4px;
      border-radius: 0;
      font-family: Montserrat, sans-serif;
  }
 
  .navbar-nav li a:hover, .navbar-nav li.active a {
      color: #f4511e !important;
      background-color: #fff !important;
  }
  .navbar-default .navbar-toggle {
      border-color: transparent;
      color: #fff !important;
  }
  footer .glyphicon {
      font-size: 20px;
      margin-bottom: 20px;
      color: #f4511e;
  }

  @keyframes slide {
    0% {
      opacity: 0;
      transform: translateY(70%);
    } 
    100% {
      opacity: 1;
      transform: translateY(0%);
    }
  }
  @-webkit-keyframes slide {
    0% {
      opacity: 0;
      -webkit-transform: translateY(70%);
    } 
    100% {
      opacity: 1;
      -webkit-transform: translateY(0%);
    }
  }
  @media screen and (max-width: 768px) {

    .btn-lg {
        width: 100%;
        margin-bottom: 35px;
    }
  }
  @media screen and (max-width: 480px) {
    .logo {
        font-size: 150px;
    }
  }
            .download_overlay {
            background: url(../Images/Icon/downloadbg.png) repeat-y;

            width: 100%;
            height: 100%;
            position: absolute;
            left: 0;
            top: 0;
        }
        .download{
    position: relative;
    padding-top:35px;
}
.download_item h5{
    line-height: 1.5rem;
    width:70%;
}
.download_item img.app_right{
        position: relative;
    bottom: -32px;
    padding-left: 195px;
}

img.app_centre{
       margin:auto;
       padding-top:15px;
       margin-left: 115px
}

.download_app{
    margin-left:-10px;
}
.download_app a{
    margin-left:10px;
}
.container-size {
     padding: 60px 50px;
}
    </style>

</head>
<body>
        
    <form id="form1" runat="server">
         <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>    
        <%--Login Popup --%>
      
        <div class="login_div" id="loginModal" style="display:none;padding:0% 0 3% 0;">
        <img id="close" class="close" src="Images/Icon/close_red.png" alt="close" width="25" height="25"  style="background-size:contain;"/> <br />    
           
            <div style="padding:0 1% 3% 1%;color:#6eab91; font-family:'Baskerville Old Face';font-size:x-large;">
               <%-- <img src="Images/Icon/login_icon.png"  width="25" height="25"/>--%>
               <i class="fa fa-user-circle-o" style="color:#000;" aria-hidden="true"></i>

                
                                <asp:Label ID="lbltext" runat="server" style="color:#000;" Text="Account Login "></asp:Label>    
                         
              <h4 style="margin-bottom:0;"> 
                  <asp:Label ID="lblPasswordRes" runat="server" Text="" Font-Size="small" ForeColor="#000"></asp:Label></h4> 

            </div>
           
                    <asp:TextBox ID="TxtUserID" runat="server" CssClass="login_txtbox" placeholder="Username/MobileNumber"   BorderStyle="None"  TabIndex="1" ></asp:TextBox><br /><br />
                   <asp:TextBox ID="txtPwd" runat="server" CssClass="login_txtbox"  placeholder="Password"  TextMode="Password" BorderStyle="None"  TabIndex="2"></asp:TextBox><br /><br />
                   <div id="Login_background" style="padding:0.5% 0% 0.5% 0%;background-color:#000;">
                        <button  type="button" id="submitbutton" style="width:200px;height:30px;color:white;" tabindex="3"> Submit </button>                
                   </div>
                   <div>
                       <img  class="dvLoading_first" src="Images/Icon/ajax-loader.gif" alt="loading..." style="border:0;"/>  
                   </div>

                  <asp:Label ID="lblerror" runat="server" Text="" CssClass="lblerror"></asp:Label><br />
                  <a href="#" id="Forgotpass" class="forgot_pass" tabindex="4">Forgot Password</a><br />
        </div>     
          <%--Login Popup --%>

          <%--Forgot Popup --%>

            <div class="login_div" id="Forgot_div" style="display:none;">
                        <%--<img id="closed" class="close" src="Images/Icon/close.png" width="25" height="25"  style="background-size:contain;"/> <br />--%>
                        <span id="closed" class="close fa fa-close"  style="background-size:contain; "></span> <br />
                            <div >
                             <%--   <img src="Images/icon/login_icon.png"  width="25" height="25"/>--%>
                                <asp:Label ID="Label1" runat="server" Text="Forgot Password "></asp:Label><br />

                                <asp:Label ID="Label2" runat="server" ForeColor="#666666" Font-Size="Small"  CssClass="forgottxt" Text="We will send  your New password to  your Email  which  is  associated with this UserId."></asp:Label>
                            </div>
           
                       <asp:TextBox ID="txtForgotText" runat="server" CssClass="login_txtbox" onfocus="if (this.value == 'Username or Email') this.value = '';" onblur="if (this.value == '') this.value = 'Username or Email';" value="Username or Email" BorderStyle="None"></asp:TextBox><br /><br />
                              <div id="Login_backgroundd" style="padding:2% 1% 2% 1%;background-color:#f19e64;">                 
                                   <asp:Button ID="btnForgotpass" runat="server" Text="Reset Password" CssClass="login_Submit"  OnClick="btnForgotpass_Click"   BorderStyle="None"/><br />                                            
                               </div>

                              <asp:Label ID="lblEmailerror" runat="server" Text="" CssClass="lblerror"></asp:Label>
                              <a href="#" id="GoLogin" class="forgot_pass" >Go to Login</a><br />
                    <asp:Label ID="lblres" runat="server"></asp:Label>


            </div>

          <%--Forgot  Popup Ends --%>


         <div class="login_div" id="select_flat" style="display:none;">
                        
                          <div>
                               <input type="radio" name="gender" value="1" checked="checked" /> A502, Owner, ATS<br/>
                               <input type="radio" name="gender" value="2" checked="checked" />A203, Owner, ATS<br/>
                              <input type="radio" name="gender" value="3" checked="checked" /> Resident Admin, Gaur<br/>
                            </div>
           
                       <asp:TextBox ID="TextBox1" runat="server" CssClass="login_txtbox" onfocus="if (this.value == 'Username or Email') this.value = '';" onblur="if (this.value == '') this.value = 'Username or Email';" value="Username or Email" BorderStyle="None"></asp:TextBox><br /><br />
                             <asp:Label ID="Label5" runat="server" Text="" CssClass="lblerror"></asp:Label>
                              <a href="#" id="GoMain" class="forgot_pass" >Next</a><br />
                    <asp:Label ID="Label6" runat="server"></asp:Label>


            </div>

        </form>


   <header id="topNav" class="layout_header" style="height: 75px; background-color:#fff; color:#fff;">

              <div class="container-fluid" > 
         <div class="col-sm-4 col-xs-6 zero-margin">
                    <!-- Mobile Menu Button -->
                    
             <a class="logo" href="login.aspx"> <img src="Images/Icon/Logo1.png" height="50" alt="Logo"/> </a> 
         </div>
           <div class="col-sm-4 hidden-xs zero-margin">
                    <!-- Logo text or image --> 
                    
                      <div class="title" style="color:#00baed;padding-top:12px;text-align:center;font-size:x-large;"> Society Management System</div>
                    <!-- Top Nav -->

          </div>
           <div class="col-sm-4 col-xs-6 zero-margin">
               <button class="btn btn-mobile" data-toggle="collapse" data-target=".nav-main-collapse"> <i class="fa fa-bars"></i> </button>
                  <div class="navbar-collapse nav-main-collapse collapse pull-right" style="margin-top: 9px;color:white; text-align:center;">
                  <nav class="nav-main mega-menu">
                    <ul class="nav nav-pills nav-main scroll-menu" id="topMain">
                      <li class=" active"><a class="menu_text" href="Login.aspx">Home</a></li>
                      <li class=" "><a class="menu_text"  href="Aboutus.aspx">About Us</a></li>
       
                      <li class=" "><a  class="menu_text" href="contact.aspx">Contact </a></li>
                      <li class=" "><a  class="menu_text" href="#" id="login">Login</a></li>
                      <!-- GLOBAL SEARCH -->
                      <li class="search dropdown" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true"  style="display:none;"> </li>
            
                        <!-- search form -->
                        <ul class="dropdown-menu">
                          <li>
                            <form method="get" action="#" class="input-group pull-right" style="">
                              <input type="text" class="form-control" name="k" id="k" value="" placeholder="Search"/>
                              <span class="input-group-btn">
                              <button class="btn btn-primary notransition" style="margin-top: 8px;"><i class="fa fa-search"></i></button>
                              </span>
                            </form>
                          </li>
                        </ul>
            
                        <!-- /search form -->
            
                    </ul>
                  </nav>
                 </div>
           </div>
    <!-- /Top Nav --> 
    
  </div>
</header>

<!-- WRAPPER -->
    <span  itemtype="http://schema.org/SoftwareApplication"/>
    <div class="jumbotron text-center">
  <h1 style="padding-top:70px;">About us</h1> 
 

</div>


<div id="about" class="container-fluid container-size">
  <div class="row">
    <div class="col-sm-8">
      <h2>About Nestin</h2><br/>
        <h4 style="text-align:justify;"><strong>NESTIN</strong> is developed by Anvisys Technologies Pvt. Ltd. To cater the needs of RWA operations and society management needs. While the trend of residential complex is increasing due to varies advantage like security, facilities, gardens, club houses etc, there is a growing demand of a management system to manage these operations and communication mechanism to involve residents in operations. Nested is our attempt to provide a state of the art, user friendly and secure Society Management System.<br /> We are good but not complacent, hence we are improving, enhancing the capabilities, taking the users feedback and working on them. Our dedicated team is working continuously to improve the system to better serve our customer. The system in available as Web and Mobile Interface. The web interface can be used for Administrative tasks like Data Management, Vendor Registration, Billing Management etc. by Administration apart from standard features by Owners and Residents. The Android Mobile interface can be used for all resident’s operation like Complaints, Forum, Billing, Vendor etc.</h4>
      <br/>
      <br/><button class="btn btn-default btn-lg"><a href="contact.aspx">Get In Touch</a></button>
    </div>
    <div class="col-sm-4">
      <span class="glyphicon glyphicon-signal logo" style="padding-top:150px;"></span>
    </div>
  </div>
</div>

<div class="container-fluid bg-white container-size">
  <div class="row">
    <div class="col-sm-4">
      <span class="glyphicon glyphicon-globe logo slideanim"></span>
    </div>
    <div class="col-sm-8">
      <h2>Our Values</h2><br>
      <h4><strong>MISSION:</strong> Our mission lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</h4><br>
      <p><strong>VISION:</strong> Our vision Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
    </div>
  </div>
</div>

<!-- Container (Services Section) -->
<div id="services" class="container-fluid text-center container-size">
  <h2>Features</h2>
  <section class="container">
    <div class="row" style="color:#000;">
      <div class="col-md-3">
        <div class="featured-box nobg border-only" style="text-align:center;"> <span class="bosre"> <span class="fa fa-address-book fa-3x" aria-hidden="true" style="color:#648cff;"></span></span>
        <h4>Tenant Records</h4>
          <p>The System has access for Residents, Employee, RWA and Administrator</p>
      </div>
        </div>
     
      <div class="col-md-3">
        <div class="featured-box nobg border-only left-separator" style="text-align:center;"><span class="bosre" style="align-self:center;"> <span class="fa fa-comments fa-3x" aria-hidden="true" style="color:#648cff;"></span></span> 
          <h4>Society Forum</h4>
          <p>Keep the data well organized and well recorded</p>
        </div>
      </div>
      <div class="col-md-3">
        <div class="featured-box nobg border-only left-separator"><span class="bosre"><span class="fa fa-shopping-bag fa-3x" aria-hidden="true" style="color:#648cff;"></span></span>
          <h4>Vendor Directory</h4>
          <p>Maintian interation among residents, Maintainence activities, Maintain Billing</p>
        </div>
      </div>
      <div class="col-md-3">
        <div class="featured-box nobg border-only left-separator"><span class="bosre"><span class="fa fa-money fa-3x" aria-hidden="true" style="color:#648cff;"></span></span>
          <h4>Society billing</h4>
          <p>We belive in evalution and continuous improvement, hence open for customization</p>
        </div>
      </div>
   </div>
  </section>
       <section class="container">
    <div class="row" style="color:#000;">
      <div class="col-md-3">
        <div class="featured-box nobg border-only" style="text-align:center;"> <span class="bosre"> <span class=" fa fa-bullhorn fa-3x" aria-hidden="true" style="color:#648cff;"></span></span>
        <h4>Notice Board</h4>
          <p>The System has access for Residents, Employee, RWA and Administrator</p>
      </div>
        </div>
     
      <div class="col-md-3">
        <div class="featured-box nobg border-only left-separator" style="text-align:center;"><span class="bosre" style="align-self:center;"> <span class="fa fa-pie-chart fa-3x" aria-hidden="true" style="color:#648cff;"></span></span> 
          <h4>Opinion Poll</h4>
          <p>Keep the data well organized and well recorded</p>
        </div>
      </div>
      <div class="col-md-3">
        <div class="featured-box nobg border-only left-separator"><span class="bosre"><span class="fa fa-check-square fa-3x" aria-hidden="true" style="color:#648cff;"></span></span>
          <h4>InHouse Services</h4>
          <p>Maintian interation among residents, Maintainence activities, Maintain Billing</p>
        </div>
      </div>
      <div class="col-md-3">
        <div class="featured-box nobg border-only left-separator"><span class="bosre"><span class="fa fa-question-circle fa-3x" aria-hidden="true" style="color:#648cff;"></span></span>
          <h4>Helpdesk</h4>
          <p>We belive in evalution and continuous improvement, hence open for customization</p>
        </div>
      </div>
   </div>
  </section>

 
</div>
 
            


<!-- /WRAPPER --> 
     <section id="download" class="download">
                <div class="download_overlay"></div>
                <div class="container">
                    <div class="row">
                        <div class="main_download ">
                            <div class="col-md-6 col-xs-12">
                                <div class="download_item roomy-100">
                                    <h2 class="text-white" style="padding-top:65px;">How Download the app?</h2>
                                    <h4>Just download the app from the store.
                                        Simple, nice and user-friendly application of theweather.
                                        Only relevant and useful information.</h4>

                                    <div class="download_app m-top-30">
                                        
                                        <a href="https://play.google.com/store/apps/details?id=net.anvisys.NestIn" target="_blank"><img src="Images/Icon/googleplay.png" style="height:50px;" alt="Download" /></a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 col-xs-12">
                                <div class="download_item m-top-70">
                                    <img class="app_centre" src="Images/Icon/appdownload1.png" alt="Dowmload" height="340"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
<!-- FOOTER -->
   
    <footer id="myFooter">
        <div class="container">
            <div class="row">
                <div class="col-sm-3">
                    <h2 class="logo1"><img src="Images/Icon/iconHome.png" height="50" alt="Logo"/></h2>
                </div>
                <div class="col-sm-2">
                    <h5>Get started</h5>
                    <ul>
                        <li><a href="Login.aspx">Home</a></li>
                        <li><a href="#">Sign up</a></li>
                        <li><a href="contact.aspx">Contact us</a></li>
                    </ul>
                </div>
                <div class="col-sm-2">
                    <h5>Quick Link</h5>
                    <ul>
                        <li><a href="Aboutus.aspx">About us</a></li>
                        <li><a href="contact.aspx">Contact us</a></li>
                        <li><a href="PrivacyPolicy.aspx">Privacy policy</a></li>
                    </ul>
                </div>
                <div class="col-sm-2">
                    <h5>Support</h5>
                    <ul>
                        <li><a href="#">FAQ</a></li>
                        <li><a href="contact.aspx">Help desk</a></li>
                        <li><a href="#">Terms Of Use</a></li>
                    </ul>
                </div>
                <div class="col-sm-3">
                      <div class="social-networks">
                        <a href="https://www.facebook.com/NestIn.Online/" target="_blank" class="facebook"><i class="fa fa-facebook" style="color:dodgerblue;border:solid 1px;padding:5px;"></i></a>
                        <a href="https://in.linkedin.com/company/anvisys" target="_blank" class="twitter"><i class="fa fa-linkedin" style="color:deepskyblue;border:solid 1px;padding:5px;"></i></a>
                        <a href="#" class="google"><i class="fa fa-google-plus" style="color:red;border:solid 1px;padding:5px;"></i></a>
                    </div>
                    <button type="button"  class="btn btn-default"><a href="contact.aspx">Contact us</a> </button>
                </div>
            </div>
        </div>
        <div class="footer-copyright">
            <p>© 2018 ANVISYS TECHNOLOGIES, ALL RIGHTS RESERVED. </p>
        </div>
    </footer>
<%--<footer> 
  
  <!-- copyright , scrollTo Top -->
  <div class="footer-bar">
    <div class="container-fluid"> 
        <div class="col-sm-6">
             <span class="copyright">Copyright © <span itemprop="publisher" itemtype="http://schema.org/Organization">
        <span itemprop="name">Anvisys Technologies</span></span>,  All Rights Reserved.</span> 
        </div>
        <div class="col-sm-3">
           <span class="copyright"><a href="PrivacyPolicy.aspx">Privacy policy</a></span>
        </div>
          <div class="col-sm-3">
         <span class="copyright">Follwo us <a href="https://www.facebook.com/anvisys/" target="_blank" class="fa fa-facebook" style="color:#fff;border:solid 1px;padding:5px;background-color:darkblue;"></a><a href="https://in.linkedin.com/company/anvisys" target="_blank" class="fa fa-linkedin" style="color:#fff;border:solid 1px;padding:5px;background-color:dodgerblue;"></a></span>&nbsp;&nbsp;<a class="toTop copyright" href="#"><i class="fa fa-arrow-circle-up fa-2x"></i></a>

        </div>
        </div>
     
  </div>
  <!-- copyright , scrollTo Top --> 
  
  <!-- footer content -->
  
  <!-- footer content --> 
  
</footer>--%>
  
</body>
</html>
