<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Contact us</title>
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

    <link href="CSS_3rdParty/settings.css" rel="stylesheet" type="text/css" />
    <!-- THEME CSS -->
    <link href="CSS_3rdParty/essentials.css" rel="stylesheet" type="text/css" />
    <link href="CSS_3rdParty/layout.css" rel="stylesheet" type="text/css" />
    <link href="CSS_3rdParty/layout-responsive.css" rel="stylesheet" type="text/css" />
    <link href="CSS_3rdParty/footer.css" rel="stylesheet" type="text/css" />

    <link href="CSS_3rdParty/mythirdpartystylesheets.css" rel="stylesheet" type="text/css" />

    <link rel="stylesheet" href="CSS/Nestin.css" />
    <link rel="stylesheet" href="CSS/Nestin-3rdParty.css" />


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
        #contact {
            background-color: #f1f1f1;
            font-family: 'Roboto', sans-serif;
        }

            #contact .well {
                margin-top: 30px;
                border-radius: 0;
            }

            #contact .form-control {
                border-radius: 0;
                border: 1px solid #1e1e1e;
            }

            #contact button {
                border-radius: 0;
                border: 1px solid #1e1e1e;
            }

            #contact .row {
                margin-bottom: 30px;
            }

        @media (max-width: 768px) {
            #contact iframe {
                margin-bottom: 15px;
            }
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
        <%--Login Popup --%>

        <%--Login Popup --%>

        <%--Forgot Popup --%>


        <%--Forgot  Popup Ends --%>
    </form>


    <header>
        <nav class="navbar navbar-default nav-color navbar-fixed-top">
            <div class="container-fluid">

                <!-- Brand/logo -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#example-1" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="logo" href="Login.aspx">
                        <img src="Images/Icon/Logo1.png" height="50" alt="Logo" />
                    </a>
                </div>

                <!-- Collapsible Navbar -->
                <div class="collapse navbar-collapse" id="example-1">
                    <ul class="nav navbar-nav pull-right">
                        <li class=""><a class="menu_text" href="Login.aspx">Home</a></li>
                        <li class=""><a class="menu_text" href="Aboutus.aspx">About Us</a></li>
                        <li class=""><a class="menu_text" href="contact.aspx">Contact </a></li>

                        <li class=""><a class="menu_text" href="register.aspx" id="register">Register</a></li>

                    </ul>
                </div>

            </div>
        </nav>
    </header>

    <!-- WRAPPER -->
    <span itemtype="http://schema.org/SoftwareApplication" />
    <section id="contact">
        <%--    <div class="jumbotron text-center">
  <h1 style="padding-top:70px;">Contact us</h1> --%>
        <div class="jumbotron-local text-center" style="height: 120px;">
            <h3 style="padding-top: 85px; color: #ffffff;">Contact us</h3>
        </div>

        <br />

        <div class="container">
            <div class="row">
                <div class="col-md-7">
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3502.0336857316393!2d77.3739253145595!3d28.628752491003983!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390ce56d150cb4fb%3A0x3d26e6a0fb0fafa3!2sALPC+BUSINESS+PARK!5e0!3m2!1sen!2sin!4v1545212333342" style="width: 100%;" height="450" frameborder="0" style="border: 0" allowfullscreen></iframe>
                </div>

                <div class="col-md-5">
                    <h4><strong>Get in Touch</strong></h4>
                    <form method="post">
                        <div class="form-group" action>
                            <input type="text" class="form-control" name="fullName" value="" placeholder="Name" />
                        </div>
                        <div class="form-group">
                            <input type="email" class="form-control" name="emailId" value="" placeholder="E-mail" />
                        </div>
                        <div class="form-group">
                            <input type="tel" class="form-control" name="message" value="" placeholder="Phone" />
                        </div>
                        <div class="form-group">
                            <textarea class="form-control" name="" rows="3" placeholder="Message"></textarea>
                        </div>
                        <button class="btn btn-default" type="submit" name="submitbtn">
                            <i class="fa fa-paper-plane-o" aria-hidden="true"></i>Submit
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </section>





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
                    <h2 style="padding-top: 65px; color: black;">How Download the app?</h2>
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
