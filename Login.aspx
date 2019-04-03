﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Apartment Management - NestIn</title>


    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="keywords" content="Housing Society Management,Apartment Management,Society Management,Residential Society Management,Complaint Management,Society Expenses,Billing Software, Society  Security" />
    <meta name="description" content="Nestin provides solution to your daily Society and Apartment Management  operations like Service Requests, Visitor Entry, Vendor Directory, Notices, Internal discussions, Bills etc" />

    <meta name="developer" content="Anvisys Technologies Pvt. Ltd." />
    <meta name="google-site-verification" content="eaOkM-61kCTqQjVeBRR_YiPMSjlpY13WHQEz4I8T278" />

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <!-- CORE CSS -->

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


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
        var api_url;

        $(function () {
            if (top.location != self.location) {
                top.location = self.location.href
            }


            $("[id*=submitbutton]").bind("click", function () {

                //ValidateUser();

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

                        if (response.d == 1) {
                            window.location = "MainPage.aspx";
                        }
                        else if (response.d == 0) {
                            window.location = "Role.aspx";
                        }
                        else if (response.d == -1) {

                            $('#lblerror').text("Login Failed");
                            $('#lblerror').show();
                            $('#lblPasswordRes').hide();
                            $("#Forgotpass").show();
                        }
                        else if (response.d == -2) {
                            $('#lblerror').text("Failed to read database");
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

            $(".close").click(function () {
                $("#loginModal").hide();
                $("#Forgot_div").hide();
            });

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
            });

            $("#close").click(function () {
                $("input:text").val("");
                $("#txtPwd").val("");
                $("#lblerror").html("");
            });

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
        .featured-box h4 {
            color: #000 !important;
        }

        img.close {
            position: absolute;
            right: -14px;
            top: -14px;
            cursor: pointer;
        }

        .bosre {
            padding: 8px 0 0 0;
            border-radius: 50%;
            height: 78px;
            width: 78px;
            display: inline-block;
            margin: 0 0 12px 0;
        }

        .Forgot_button {
            background-color: transparent;
            height: 30px;
            color: white;
            font-family: 'Times New Roman', Times, serif;
            font-style: oblique;
            font-weight: bold;
            outline: 0;
            display: none;
        }

        .forgot_pass {
            color: #6eab91;
            text-decoration: none;
            padding: 1% 0 2% 0;
        }

        .forgottxt {
            padding: 1% 2%
        }

        a {
            color: white;
        }

        .dvLoading_first {
            display: none;
            background: url(Images/Icon/ajax-loader.gif) no-repeat center center;
            opacity: 0.5;
            height: 50px;
            width: 50px;
            z-index: 1000;
            border: 0;
            outline: 0;
            border-style: none;
            border-color: white;
            border-radius: 5px;
            text-align: center;
        }

        .download_overlay {
            background: url(../Images/Icon/downloadbg.png) repeat-y;
            width: 100%;
            height: 100%;
            position: absolute;
            left: 0;
            top: 0;
        }

        .download {
            position: relative;
            padding-top: 35px;
        }

        .download_item h5 {
            line-height: 1.5rem;
            width: 70%;
        }

        .download_item img.app_right {
            position: relative;
            bottom: -32px;
            padding-left: 195px;
        }

        img.app_centre {
            margin: auto;
            padding-top: 15px;
            margin-left: 115px
        }

        .download_app {
            margin-left: -10px;
        }

            .download_app a {
                margin-left: 10px;
            }

        .item-1 {
            position: absolute;
            display: block;
            top: 2em;
            width: 50%;
            font-family: cursive;
            font-size: 20px;
            animation-iteration-count: initial;
        }

        .item-1 {
            animation-name: anim-1;
        }

        @keyframes anim-1 {
            0%, 8.3% {
                left: -100%;
                opacity: 0;
            }

            8.3%,25% {
                left: 25%;
                opacity: 1;
            }

            33.33%, 100% {
                left: 110%;
                opacity: 0;
            }
        }

        @media only screen and (max-width:767px) {
            .item-1 {
                font-size: 10px;
                top: 1em;
                line-height: 18px !important;
                margin-top: 1px !important;
                color: #000;
                margin-left: 7px !important;
            }

                .item-1 h3 {
                    line-height: 22px;
                    padding-top: 17px;
                    color: #000;
                    padding-left: 8px;
                }
        }

        .nav-small li a{
                font-family: 'Open Sans'!important;
                font-style: normal!important;
                font-weight: 300!important;
                height: 100%!important;
                font-size: 15px!important;
        }
    </style>




    <!-- Facebook Pixel Code -->
    <script>
        !function (f, b, e, v, n, t, s) {
            if (f.fbq) return; n = f.fbq = function () {
                n.callMethod ?
                n.callMethod.apply(n, arguments) : n.queue.push(arguments)
            };
            if (!f._fbq) f._fbq = n; n.push = n; n.loaded = !0; n.version = '2.0';
            n.queue = []; t = b.createElement(e); t.async = !0;
            t.src = v; s = b.getElementsByTagName(e)[0];
            s.parentNode.insertBefore(t, s)
        }(window, document, 'script',
            'https://connect.facebook.net/en_US/fbevents.js');
        fbq('init', '277102566548362');
        fbq('track', 'PageView');
    </script>
    <noscript><img height="1" width="1" style="display:none"
          src="https://www.facebook.com/tr?id=277102566548362&ev=PageView&noscript=1"
        /></noscript>
    <!-- End Facebook Pixel Code -->
</head>
<body>

    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <%--Login Popup --%>

        <div class="login_div" id="loginModal" style="display: none; padding: 0% 0 3% 0;">
            <img id="close" class="close" src="Images/Icon/close_red.png" alt="close" width="25" height="25" style="background-size: contain;" />
            <br />

            <div style="padding: 0 1% 3% 1%; color: #6eab91; font-family: 'Baskerville Old Face'; font-size: x-large;">
                <%-- <img src="Images/Icon/login_icon.png"  width="25" height="25"/>--%>
                <i class="fa fa-user-circle-o" style="color: #000;" aria-hidden="true"></i>


                <asp:Label ID="lbltext" runat="server" Style="color: #000;" Text="Account Login "></asp:Label>

                <h4 style="margin-bottom: 0;">
                    <asp:Label ID="lblPasswordRes" runat="server" Text="" Font-Size="small" ForeColor="#000"></asp:Label></h4>

            </div>

            <asp:TextBox ID="TxtUserID" runat="server" CssClass="login_txtbox" placeholder="Email ID/MobileNumber" BorderStyle="None" TabIndex="1"></asp:TextBox><br />
            <br />
            <asp:TextBox ID="txtPwd" runat="server" CssClass="login_txtbox" placeholder="Password" TextMode="Password" BorderStyle="None" TabIndex="2"></asp:TextBox><br />
            <br />
            <div id="Login_background" style="padding: 0.5% 0% 0.5% 0%; background-color: #000;">
                <button type="button" id="submitbutton" style="width: 200px; height: 30px; color: white;" tabindex="3">Submit </button>
            </div>
            <div>
                <img class="dvLoading_first" src="Images/Icon/ajax-loader.gif" alt="loader" style="border: 0;" />
            </div>

            <asp:Label ID="lblerror" runat="server" Text="" CssClass="lblerror"></asp:Label><br />
            <a href="#" id="Forgotpass" class="forgot_pass" tabindex="4">Forgot Password</a><br />
        </div>
        <%--Login Popup --%>

        <%--Forgot Popup --%>

        <div class="login_div" id="Forgot_div" style="display: none;">
            <%--<img id="closed" class="close" src="Images/Icon/close.png" width="25" height="25"  style="background-size:contain;"/> <br />--%>
            <span id="closed" class="close fa fa-close" style="background-size: contain;"></span>
            <br />
            <div>
                <%--   <img src="Images/icon/login_icon.png"  width="25" height="25"/>--%>
                <asp:Label ID="Label1" runat="server" Font-Size="Medium" Text="Forgot Password "></asp:Label><br />

                <asp:Label ID="Label2" runat="server" ForeColor="#666666" Font-Size="Small" CssClass="forgottxt" Text="We will send  your New password to  your Email  which  is  associated with this UserId."></asp:Label>
            </div>

            <asp:TextBox ID="txtForgotText" runat="server" CssClass="login_txtbox" onfocus="if (this.value == 'Username or Email') this.value = '';" onblur="if (this.value == '') this.value = 'Username or Email';" value="Username or Email" BorderStyle="None"></asp:TextBox><br />
            <br />
            <div id="Login_backgroundd" style="padding: 2% 1% 2% 1%; background-color: #f19e64;">
                <asp:Button ID="btnForgotpass" runat="server" Text="Reset Password" CssClass="login_Submit" OnClick="btnForgotpass_Click" BorderStyle="None" /><br />
            </div>

            <asp:Label ID="lblEmailerror" runat="server" Text="" CssClass="lblerror"></asp:Label>
            <a href="#" id="GoLogin" class="forgot_pass">Go to Login</a><br />
            <asp:Label ID="lblres" runat="server"></asp:Label>


        </div>

        <%--Forgot  Popup Ends --%>


        <div class="login_div" id="select_flat" style="display: none;">

            <div>
                <input type="radio" name="gender" value="1" checked="checked" />
                A502, Owner, ATS<br />
                <input type="radio" name="gender" value="2" checked="checked" />A203, Owner, ATS<br />
                <input type="radio" name="gender" value="3" checked="checked" />
                Resident Admin, Gaur<br />
            </div>

            <asp:TextBox ID="TextBox1" runat="server" CssClass="login_txtbox" onfocus="if (this.value == 'Username or Email') this.value = '';" onblur="if (this.value == '') this.value = 'Username or Email';" value="Username or Email" BorderStyle="None"></asp:TextBox><br />
            <br />
            <asp:Label ID="Label5" runat="server" Text="" CssClass="lblerror"></asp:Label>
            <a href="#" id="GoMain" class="forgot_pass">Next</a><br />
            <asp:Label ID="Label6" runat="server"></asp:Label>


        </div>

    </form>


    <header id="topNav" class="layout_header" style="height: 75px; background-color: #fff; color: #fff;">

        <div class="container-fluid">
            <div class="col-sm-4 col-xs-6 zero-margin">
                <!-- Mobile Menu Button -->

                <a class="logo" href="#">
                    <img src="Images/Icon/Logo1.png" height="50" alt="Logo" />
                </a>
            </div>
            <div class="col-sm-4 hidden-xs zero-margin">
                <!-- Logo text or image -->

                <h1 class="title" style="color: #00baed; padding-top: 11px; text-align: center; font-size: x-large;">Society Management System</h1>
                <!-- Top Nav -->

            </div>
            <div class="col-sm-4 col-xs-6 zero-margin">
                <button class="btn btn-mobile" data-toggle="collapse" data-target=".nav-main-collapse"><i class="fa fa-bars"></i></button>
                <div class="navbar-collapse nav-main-collapse collapse pull-right" style="margin-top: 9px; color: white; text-align: center;">
                    <nav class="nav-main mega-menu">
                        <ul class="nav nav-pills nav-main scroll-menu nav-small" id="topMain">
                            <li class=" active"><a class="menu_text" href="#">Home</a></li>
                            <li class=" "><a class="menu_text" href="Aboutus.aspx">About Us</a></li>

                            <li class=" "><a class="menu_text" href="contact.aspx">Contact </a></li>
                            <li class=" "><a class="menu_text" href="#" id="login">Login</a></li>
                            <li class=" "><a class="menu_text" href="register.aspx" id="register">Register</a></li>
                            <!-- GLOBAL SEARCH -->
                            <li class=""><a class="menu_text" href="Rent.aspx" id="rent">Rent</a> </li>



                        </ul>
                    </nav>
                </div>
            </div>
            <!-- /Top Nav -->

        </div>
    </header>

    <!-- WRAPPER -->
    <span itemtype="http://schema.org/SoftwareApplication" />

    <!-- REVOLUTION SLIDER -->

    <div class="container-fluid" style="padding: 0px;">

        <div id="myCarousel" class="carousel slide" data-ride="carousel">
            <!-- Indicators -->


            <!-- Wrapper for slides -->
            <div class="carousel-inner" role="listbox" style="margin-top: 45px;">

                <div class="item active">
                    <img src="Images/Icon/ro1.jpg" alt="Banner" />

                    <h3 style="line-height: 32px; margin-top: 60px; color: #000; margin-left: 90px;" class="item-1"><span class="fa fa-check" style="color: #009688;"></span>Get instant Payment, activity alerts via Email/SMS.<br />
                        <span class="fa fa-check" style="color: #009688;"></span>A SMART Housing Society Management Solution<br />
                        <span class="fa fa-check" style="color: #009688;"></span>Fast Complaint resolution with effective Ticket System<br />
                        <span class="fa fa-check" style="color: #009688;"></span>Get Popular, Reliable Vendors At your doorstep<br />
                        <span class="fa fa-check" style="color: #009688;"></span>Manage all registers, documents and MOM effectively<br />
                        <span class="fa fa-check" style="color: #009688;"></span>Replace the Manual Visitor Register
                    </h3>


                    <%--<div class="carousel-caption hidden-xs" ><h1 style="color:#fff;margin-bottom:-34px;font-size:28px;" > Housing Society Management and connecting with your neighbour</h1></div>--%>
                </div>


                <!-- Controls -->

            </div>
        </div>
    </div>
    <!-- /REVOLUTION SLIDER -->

    <section class="goletfullwidth text-center" style="background-color: #f9f9f9; color: blue;">
        <div class="container">
            <div class="row">

                <h3 class="text-center" style="color: black; margin-bottom: 20px;"><span class="">Meets all your Society Management needs</span> </h3>
                <div class="col-xs-6 col-sm-3 ">
                    <div class="item-box box">
                        <span class="bosre"><span class="fa fa-user fontsize theme_third_main" aria-hidden="true"></span></span>
                        <h5>Owners/ Residents records</h5>
                    </div>
                </div>
                <div class="col-xs-6 col-sm-3">
                    <div class="item-box box">
                        <span class="bosre"><span class="fa fa-cubes fontsize theme_third_main" aria-hidden="true"></span></span>
                        <h5>Complaints Management</h5>
                    </div>
                </div>
                <div class="col-xs-6 col-sm-3">
                    <div class="item-box box">
                        <span class="bosre"><span class="fa fa-external-link-square fontsize theme_third_main" aria-hidden="true"></span></span>
                        <h5>Internal Forum Discussion</h5>
                    </div>
                </div>
                <div class="col-xs-6 col-sm-3 col-sm-4">
                    <div class="item-box box">
                        <span class="bosre"><span class="fa fa-bell-o fontsize theme_third_main" aria-hidden="true"></span></span>
                        <h5>Instant Notifications</h5>
                    </div>
                </div>

            </div>
        </div>
    </section>


    <!-- PARALLAX -->
    <section class="parallax delayed margin-footer parallax-init" data-stellar-background-ratio="0.7">
        <span class="overlay" style="background-color: #eee;"></span>
        <div class="container">
            <div class="row">
                <!-- left content -->
                <div class="col-md-7 animation_fade_in">
                    <h3>NestIn</h3>
                    <p class="lead" style="font-size: 18px;">NestIn is developed by Anvisys Technologies  for the Apartment Societies. </p>
                    <p style="text-align: justify;">
                        NestIn is developed by <a href="www.Anvisys.net" target="_blank">Anvisys Technologies Pvt. Ltd.</a> To cater the needs of RWA operations and society management needs. While the trend of residential complex is increasing due to varies advantage like security, facilities, gardens, club houses etc, there is a growing demand of a management system to manage these operations and communication mechanism to involve residents in operations.<br />
                        NestIn is our attempt to provide a state of the art, user friendly and secure Society Management System. We are good but not complacent, hence we are improving, enhancing the capabilities, taking the users feedback and working on them. Our dedicated team is working continuously to improve the system to better serve our customer.
                    </p>
                    <a class="btn btn-primary" style="color: #fff;" href="Aboutus.aspx">Read More</a><br />
                    <br />

                    <a class="btn btn-primary" style="color: #fff;" href="Register.aspx">RegisterNow</a>
                </div>

                <!-- right image -->
                <div class="col-md-5 animation_fade_in">
                    <img class="visible-md visible-lg img-responsive pull-right" src="Images/Icon/desktop2.png" alt="Society management System" />
                </div>
            </div>
        </div>
    </section>
    <!-- PARALLAX -->
    <div class="clearfix" style="margin-top: 80px;"></div>

    <h2 style="text-align: center; margin-top: 15px;">Features</h2>
    <!-- hr line -->
    <section class="container">
        <div class="row" style="color: #000;">
            <div class="col-md-3">
                <div class="featured-box nobg border-only" style="text-align: center;">
                    <span class="bosre"><span class="fa fa-address-book fa-3x" aria-hidden="true" style="color: #648cff;"></span></span>
                    <h4>Tenant Records</h4>
                    <p>The System has access for Residents, Employee, RWA and Administrator</p>
                </div>
            </div>

            <div class="col-md-3">
                <div class="featured-box nobg border-only left-separator" style="text-align: center;">
                    <span class="bosre" style="align-self: center;"><span class="fa fa-comments fa-3x" aria-hidden="true" style="color: #648cff;"></span></span>
                    <h4>Society Forum</h4>
                    <p>Keep the data well organized and well recorded</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="featured-box nobg border-only left-separator">
                    <span class="bosre"><span class="fa fa-shopping-bag fa-3x" aria-hidden="true" style="color: #648cff;"></span></span>
                    <h4>Vendor Directory</h4>
                    <p>Maintian interation among residents, Maintainence activities, Maintain Billing</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="featured-box nobg border-only left-separator">
                    <span class="bosre"><span class="fa fa-money fa-3x" aria-hidden="true" style="color: #648cff;"></span></span>
                    <h4>Society billing</h4>
                    <p>We belive in evalution and continuous improvement, hence open for customization</p>
                </div>
            </div>
        </div>
    </section>
    <section class="container">
        <div class="row" style="color: #000;">
            <div class="col-md-3">
                <div class="featured-box nobg border-only" style="text-align: center;">
                    <span class="bosre"><span class=" fa fa-bullhorn fa-3x" aria-hidden="true" style="color: #648cff;"></span></span>
                    <h4>Notice Board</h4>
                    <p>The System has access for Residents, Employee, RWA and Administrator</p>
                </div>
            </div>

            <div class="col-md-3">
                <div class="featured-box nobg border-only left-separator" style="text-align: center;">
                    <span class="bosre" style="align-self: center;"><span class="fa fa-pie-chart fa-3x" aria-hidden="true" style="color: #648cff;"></span></span>
                    <h4>Opinion Poll</h4>
                    <p>Keep the data well organized and well recorded</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="featured-box nobg border-only left-separator">
                    <span class="bosre"><span class="fa fa-check-square fa-3x" aria-hidden="true" style="color: #648cff;"></span></span>
                    <h4>InHouse Services</h4>
                    <p>Maintian interation among residents, Maintainence activities, Maintain Billing</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="featured-box nobg border-only left-separator">
                    <span class="bosre"><span class="fa fa-question-circle fa-3x" aria-hidden="true" style="color: #648cff;"></span></span>
                    <h4>Helpdesk</h4>
                    <p>We belive in evalution and continuous improvement, hence open for customization</p>
                </div>
            </div>
        </div>
    </section>
    <div class="clearfix"></div>
    <section class="parallax delayed margin-footer parallax-init" data-stellar-background-ratio="0.7">
        <span class="overlay" style="background-color: #eee;"></span>
        <div class="container">
            <div class="row">
                <!-- left content -->
                <div class="col-md-6 animation_fade_in" style="margin-bottom: 20px;">
                    <h2>Pricing</h2>
                    <h4 style="text-align: justify;">We don’t have complex pricing like many other software available as a service. Our is not based on complex features combination, not on number of users not for duration.
                           It’s Simple<span style="color: blue;"> Rs. 5.00 per flat per month </span>for all society Management Features.</h4>

                    <a class="btn btn-primary" style="color: #fff;" href="register.aspx?Role=demo">Start Free Trial</a>
                </div>

                <div class="col-md-6 animation_fade_in">
                    <img src="Images/Icon/test1.png" alt="Pricing" width="500" height="400" />
                </div>
                <!-- left image -->

            </div>
        </div>
    </section>

    <!-- /WRAPPER -->
    <section id="download" class="download">
        <div class="download_overlay"></div>
        <div class="container">
            <div class="row">
                <div class="main_download ">
                    <div class="col-md-6 col-xs-12">
                        <div class="download_item roomy-100">
                            <h2 class="text-white" style="padding-top: 65px;">How Download the app?</h2>
                            <h4>Just download the app from the store.
                                        Simple, nice and user-friendly application of theweather.
                                        Only relevant and useful information.</h4>

                            <div class="download_app m-top-30">

                                <a href="https://play.google.com/store/apps/details?id=net.anvisys.NestIn" target="_blank">
                                    <img src="Images/Icon/googleplay.png" style="height: 50px;" alt="Download" /></a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-xs-12">
                        <div class="download_item m-top-70">
                            <img class="app_centre" src="Images/Icon/appdownload1.png" alt="Download App" height="340" />
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
                    <h2 class="logo1">
                        <img src="Images/Icon/iconHome.png" height="50" alt="" /></h2>
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
                        <a href="https://www.facebook.com/NestIn.Online/" target="_blank" class="facebook"><i class="fa fa-facebook" style="color: dodgerblue; border: solid 1px; padding: 5px;"></i></a>
                        <a href="https://in.linkedin.com/company/anvisys" target="_blank" class="twitter"><i class="fa fa-linkedin" style="color: deepskyblue; border: solid 1px; padding: 5px;"></i></a>
                        <a href="#" class="google"><i class="fa fa-google-plus" style="color: red; border: solid 1px; padding: 5px;"></i></a>
                    </div>
                    <button type="button" class="btn btn-default"><a href="contact.aspx">Contact us</a> </button>
                </div>
            </div>
        </div>
        <div class="footer-copyright">
            <p>© 2018 <a href="www.Anvisys.net" target="_blank">ANVISYS TECHNOLOGIES</a>, ALL RIGHTS RESERVED. </p>
        </div>
    </footer>

</body>
</html>
