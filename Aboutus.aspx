<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Aboutus.aspx.cs" Inherits="Aboutus" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>About us</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
    <link href="CSS_3rdParty/settings.css" rel="stylesheet" type="text/css" />
    <!-- THEME CSS -->
    <link href="CSS_3rdParty/essentials.css" rel="stylesheet" type="text/css" />
    <link href="CSS_3rdParty/layout.css" rel="stylesheet" type="text/css" />
    <link href="CSS_3rdParty/layout-responsive.css" rel="stylesheet" type="text/css" />
    <link href="CSS_3rdParty/footer.css" rel="stylesheet" type="text/css" />

    <link href="CSS_3rdParty/mythirdpartystylesheets.css" rel="stylesheet" type="text/css" />

    <link rel="stylesheet" href="CSS/Nestin.css" />
    <link rel="stylesheet" href="CSS/Nestin-3rdParty.css" />

    <%--<link href="Login/css/settings.css" rel="stylesheet" type="text/css" />--%>
    <!-- THEME CSS -->

   <%-- <link href="Login/css/essentials.css" rel="stylesheet" type="text/css" />
    <link href="Login/css/layout.css" rel="stylesheet" type="text/css" />
    <link href="Login/css/layout-responsive.css" rel="stylesheet" type="text/css" />--%>

    <%--<link href="Styles/layout.css" rel="stylesheet" />
    <link href="Styles/Responsive.css" rel="stylesheet" />

    <link rel="stylesheet" href="CSS/ApttTheme.css" />

    <link rel="stylesheet" href="CSS/ApttLayout.css" />

    <link rel="stylesheet" href="CSS/NewAptt.css" />
    <link rel="stylesheet" href="Login/CSS/footer.css" />--%>

    

    
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
            border-radius: 0 !important;
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



        footer .glyphicon {
            font-size: 20px;
            margin-bottom: 20px;
            color: #f4511e;
        }




        .download_overlay {
            background: url(../Images/Icon/downloadbg.jpg);
            width: 100%;
            height: 100%;
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

        .container-size {
            padding: 60px 50px;
        }
    </style>
    <style>
        .nav-color {
            background: #727CF5;
        }
    </style>


</head>
<body>

    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


    </form>


    <header id="topNav" class="layout_header top-NavigationBar">

        <!-- scroll bar progress -->
        <div class="progress-container">
            <div class="progress-bar" id="myBar"></div>
        </div>
        <!-- End progress -->


        <div class="container-fluid">
            <div class="row">
                <div class="col-md-5 col-xs-12">
                    <div class="navbar-header">
                        <a class="logo col-xs-2" href="Login.aspx">
                            <img src="Images/Icon/Logo1.png" height="50" alt="Logo" />
                        </a>
                        <div class="navbar-inverse">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                        </div>
                    </div>
                    <%-- <h1 class="title hidden-xs" style="color: #fff; padding-top: 11px; font-size:30px;">Society Management System</h1>--%>
                </div>
                <div class="col-md-7">
                    <div class="collapse navbar-collapse pull-right" id="myNavbar" style="margin-top: 9px; text-align: center;">
                        <nav class="nav navbar-nav nav-color">
                            <ul class="nav nav-pills nav-main scroll-menu nav-small" id="topMain">
                                <li class=" active"><a class="menu_text" href="Login.aspx">Home</a></li>
                                <li class=" "><a class="menu_text" href="Aboutus.aspx">About Us</a></li>
                                <li class=" "><a class="menu_text" href="contact.aspx">Contact </a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>


    </header>

    

    <div class="jumbotron-local text-center" style="height: 120px;">
        <h3 style="padding-top: 85px; color: #ffffff;">About us</h3>
    </div>


    <div id="about" class="container-fluid container-size">
        <div class="row">
            <div class="col-sm-8">
                <h2>About Nestin</h2>
                <br />
                <h4 style="text-align: justify;"><strong>NESTIN</strong> is developed by Anvisys Technologies Pvt. Ltd. To cater the needs of RWA operations and society management needs. While the trend of residential complex is increasing due to varies advantage like security, facilities, gardens, club houses etc, there is a growing demand of a management system to manage these operations and communication mechanism to involve residents in operations. Nested is our attempt to provide a state of the art, user friendly and secure Society Management System.<br />
                    We are good but not complacent, hence we are improving, enhancing the capabilities, taking the users feedback and working on them. Our dedicated team is working continuously to improve the system to better serve our customer. The system in available as Web and Mobile Interface. The web interface can be used for Administrative tasks like Data Management, Vendor Registration, Billing Management etc. by Administration apart from standard features by Owners and Residents. The Android Mobile interface can be used for all resident’s operation like Complaints, Forum, Billing, Vendor etc.</h4>
                <br />
                <br />
                <button class="btn btn-default btn-lg"><a href="contact.aspx">Get In Touch</a></button>
            </div>
            <div class="col-sm-4">
                <span class="glyphicon glyphicon-signal logo hidden-xs" style="padding-top: 150px;"></span>
            </div>
        </div>
    </div>

    <div class="container-fluid bg-white container-size">
        <div class="row">
            <div class="col-sm-6">
                <span class="glyphicon glyphicon-globe logo slideanim hidden-xs" style="margin-left: 120px; margin-top:100px;"></span>
            </div>
            <div class="col-sm-6">
                <h2>Our Values</h2>
                <br />
                <h4><strong>MISSION:</strong> Our mission lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</h4>
                <br />
                <p>
                   <h4> <strong>VISION:</strong> Our vision Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</h4>
                </p>
            </div>
        </div>
    </div>

    <!-- Container (Services Section) -->
    <div id="services" class="container-fluid text-center container-size">
        <h2>Features</h2>
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


    </div>




    <!-- /WRAPPER -->
    <%--<section id="download" class="download">
        <div class="download_overlay"></div>
        <div class="container">
            <div class="row">
                <div class="hidden-xs hidden-sm col-md-8">
                    <h2 style="padding-top: 65px; color: white;">How Download the app?</h2>
                    <h4 style="color: white; text-align:justify;">
                         Just download the app from the store.
                         Simple, nice and user-friendly application of the weather.
                         Only relevant and useful information.
                    </h4>
                    <a href="https://play.google.com/store/apps/details?id=net.anvisys.NestIn" target="_blank">
                        <img src="Images/Icon/googleplay.png" style="height: 50px;" alt="Download" />
                    </a>
                </div>
                <div class="hidden-xs hidden-sm col-md-4">
                    <img src="Images/Icon/appdownload1.png" style="height: 50vh; width:100%;" />
                </div>
            </div>

             <div class="row">
                <div class="col-xs-12 hidden-md hidden-lg">
                    <h2 style="padding-top: 65px; color: Black;">How Download the app?</h2>
                    <h4 style="color: black; text-align:justify;">
                         Just download the app from the store.
                         Simple, nice and user-friendly application of the weather.
                         Only relevant and useful information.
                    </h4>
                    <a href="https://play.google.com/store/apps/details?id=net.anvisys.NestIn" target="_blank">
                        <img src="Images/Icon/googleplay.png" style="height: 50px; width:50%;" alt="Download" />
                    </a>
                </div>
                <div class="col-xs-12 hidden-md hidden-lg">
                    <img src="Images/Icon/appdownload1.png" style="height: 40vh; width:100%;" />
                </div>
            </div>
        </div>
    </section>--%>
    <!-- FOOTER -->

    <footer id="myFooter">
        <div class="container">
            <div class="row">
                <div class="col-md-3 hidden-xs">
                    <h2 class="logo1">
                        <img src="Images/Icon/iconHome.png" height="50" alt="" /></h2>
                </div>
                <div class="col-md-2 col-xs-4">
                    <h5>Get started</h5>
                    <ul>
                        <li><a href="Login.aspx">Home</a></li>
                        <li><a href="#">Sign up</a></li>
                        <li><a href="contact.aspx">Contact us</a></li>
                    </ul>
                </div>
                <div class="col-md-2 col-xs-4">
                    <h5>Quick Link</h5>
                    <ul>
                        <li><a href="Aboutus.aspx">About us</a></li>
                        <li><a href="contact.aspx">Contact us</a></li>
                        <li><a href="PrivacyPolicy.aspx">Privacy policy</a></li>
                    </ul>
                </div>
                <div class="col-md-2 col-xs-4">
                    <h5>Support</h5>
                    <ul>
                        <li><a href="#">FAQ</a></li>
                        <li><a href="contact.aspx">Help desk</a></li>
                        <li><a href="#">Terms Of Use</a></li>
                    </ul>
                </div>
                <div class="col-md-3 col-xs-12">
                    <div class="social-networks">
                        <a href="https://www.facebook.com/NestIn.Online/" target="_blank" class="facebook"><i class="fa fa-facebook" style="color: dodgerblue; border: solid 1px; padding: 5px;"></i></a>
                        <a href="https://in.linkedin.com/company/anvisys" target="_blank" class="twitter"><i class="fa fa-linkedin" style="color: deepskyblue; border: solid 1px; padding: 5px;"></i></a>
                        <a href="#" class="google"><i class="fa fa-google-plus" style="color: red; border: solid 1px; padding: 5px;"></i></a>
                    </div>
                    <button type="button" class="btn btn-default">
                        <a href="contact.aspx">Contact us</a>
                    </button>
                </div>
            </div>
        </div>
        <div class="footer-copyright">

            <p>© 2019 <a href="www.Anvisys.net" target="_blank">ANVISYS TECHNOLOGIES</a>| ALL RIGHTS RESERVED. </p>

        </div>
    </footer>

  
</body>
</html>
