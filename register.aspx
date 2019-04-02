﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
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


        $(document).ready(function () {
            let params = (new URL(document.location)).searchParams;
            role = params.get("Role");
             alert(role);
            if (role == "demo") {
                alert("demo");
                $("#lblRegisterUser").text('Register for 15 days free trail');

            }
            else {
                 $("#lblRegisterUser").text('Register as new  User');
            }

        });

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
        $("#btnSubmit").click(function () {

            AddUser();
        });

        if (top.location != self.location) {
            top.location = self.location.href
        }

        /*------*/
        function AddDemoUser() {

            var email, mobile, firstname, lastname,parentname, address;
            email = document.getElementById("email").value;
            
            mobile = document.getElementById("mobile").value;
            firstname = document.getElementById("firstname").value;
            lastname = document.getElementById("lastname").value;
            parentname = document.getElementById("parentname").value;
            address = document.getElementById("address").value;
    
            //alert(visitDate);
            var start = new Date();
            // alert(start);

            var month = start.getMonth() + 1;

            var strMonth = "";
            if (month < 10) {
                strMonth = 0 + month.toString();
            }
            else {
                strMonth = month.toString();
            }

            var day = start.getDate();
            var strDay = "";
            if (day < 10) {
                strDay = 0 + day.toString();
            }
            else {
                strDay = day.toString();
            }

            var endDate = new Date(new Date().getTime() + (15 * 24 * 60 * 60 * 1000));


             var endMonth = endDate.getMonth() + 1;

            var strEndMonth = "";
            if (endMonth < 10) {
                strEndMonth = 0 + endMonth.toString();
            }
            else {
                strEndMonth = endMonth.toString();
            }


            var endDay = start.getDate() + 10;
            var strEndDay = "";
            if (endDay < 10) {
               strEndDay = 0 + endDay.toString();
            }
            else {
                strEndDay = endDay.toString();
            }
           


            var strStartDate = start.getFullYear() + "-" + strMonth + "-" + strDay + "T00:00:00";


            var strEndDate = endDate.getFullYear() + "-" + strEndMonth + "-" + strEndDay + "T00:00:00";

      document.getElementById("post_loading").style.display = "block";

            var strURL = "http://www.kevintech.in/GAService/api/User/Add/Demo";
            //var strURL = "visitor.aspx/AddVisitor";

            var reqBody = "{\"UserLogin\":\"" + email + "\",\"Password\":\"Password@123\",\"MiddleName\":\"K\",\"FirstName\":\"" + firstname + "\",\"LastName\":\"" + lastname + " \",\"MobileNo\":\""
                + mobile + "\",\"StartTime\":\"" + strStartDate + "\",\"EndTime\":\"" + strEndDate +
                "\",\"EmailId\":\"" + email + "\",\"Gender\":\"male\",\"Parentname\":\"" + parentname + "\",\"Address\":\"" + address
                + "\",\"SocietyID\":\"" + 1 + "\",\"UserType\":\"Demo\"}";

          

            $.ajax({
                dataType: "json",
                url: strURL,
                async: false,
                data: reqBody,
                type: 'post',
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                   console.log(JSON.stringify(data));
                    document.getElementById("post_loading").style.display = "none";

                    window.location = "Role.aspx?UserID=10111";


                },
                error: function (data, errorThrown) {
                       document.getElementById("post_loading").style.display = "none";
                    if (data.status == 500) {
                        alert("Internal Server Error");
                    }
                    else {
                          console.log(data);
                    console.log(errorThrown);
                 

                     alert('Error Updating comment, try again');
                    }
                  
                }
            });

        }

        function AddUser() {
              var email, mobile, firstname, lastname,parentname, address;
            email = document.getElementById("email").value;
            
            mobile = document.getElementById("mobile").value;
            firstname = document.getElementById("firstname").value;
            lastname = document.getElementById("lastname").value;
            parentname = document.getElementById("parentname").value;
            address = document.getElementById("address").value;
    
            //alert(visitDate);
            var start = new Date();
            // alert(start);

            var month = start.getMonth() + 1;

            var strMonth = "";
            if (month < 10) {
                strMonth = 0 + month.toString();
            }
            else {
                strMonth = month.toString();
            }

            var day = start.getDate();
            var strDay = "";
            if (day < 10) {
                strDay = 0 + day.toString();
            }
            else {
                strDay = day.toString();
            }

            var endDate = new Date(new Date().getTime() + (15 * 24 * 60 * 60 * 1000));


             var endMonth = endDate.getMonth() + 1;

            var strEndMonth = "";
            if (endMonth < 10) {
                strEndMonth = 0 + endMonth.toString();
            }
            else {
                strEndMonth = endMonth.toString();
            }


            var endDay = start.getDate() + 10;
            var strEndDay = "";
            if (endDay < 10) {
               strEndDay = 0 + endDay.toString();
            }
            else {
                strEndDay = endDay.toString();
            }
           


            var strStartDate = start.getFullYear() + "-" + strMonth + "-" + strDay + "T00:00:00";


            var strEndDate = endDate.getFullYear() + "-" + strEndMonth + "-" + strEndDay + "T00:00:00";

      document.getElementById("post_loading").style.display = "block";

            var strURL = "http://www.kevintech.in/GAService/api/User/Add/Demo";
            //var strURL = "visitor.aspx/AddVisitor";

            var user = "{\"UserLogin\":\"" + email + "\",\"Password\":\"Password@123\",\"MiddleName\":\"K\",\"FirstName\":\"" + firstname + "\",\"LastName\":\"" + lastname
                        + " \",\"MobileNumber\":\""  + mobile + "\",\"StartTime\":\"" + strStartDate + "\",\"EndTime\":\"" + strEndDate +
                        "\",\"EmailID\":\"" + email + "\",\"Gender\":\"male\",\"ParentName\":\"" + parentname + "\",\"Address\":\"" + address
                        + "\",\"SocietyID\":\"" + 1 + "\",\"UserType\":\"Demo\"}";

            var user1 = "{\"UserLogin\":\"" + email + "\"}";

           
            var url
            if (role == "Demo") {
              url= "register.aspx/AddDemoUser";

            }
            else {
              url=    "register.aspx/AddUser";
            }

         var jData =  JSON.parse(user)

            $.ajax({
                type: 'POST',
                url: url,
                data: '{user: ' + JSON.stringify(jData) + '}',
                contentType: "application/json; charset=utf-8",
                 dataType: "json",
                success: function (response) {
                   document.getElementById("post_loading").style.display = "none";
                    if (response.d > 0) {
                       
                        if (role == "Demo") {

                            window.location = "Role.aspx";
                        }
                        else {
                            window.location = "MainPage.aspx";
                        }
                    }
                    else if(response.d < 0)
                        {
                        alert('Mobile Number or Email is in use, Please go to login');
                    }
                    else 
                    {
                        alert('Server Error');
                    }

                },
                error: function (data, errorThrown) {
                    document.getElementById("post_loading").style.display = "none";
                        alert('Error Updating comment, try again');
                
                  
                }
            });

             
        }

            function switchVisible() {
                        if (document.getElementById('Div1')) {

                            if (document.getElementById('Div1').style.display == 'none') {
                                document.getElementById('Div1').style.display = 'block';
                                document.getElementById('Div2').style.display = 'none';
                            }
                            else {
                                document.getElementById('Div1').style.display = 'none';
                                document.getElementById('Div2').style.display = 'block';
                            }
                        }
                    }

                       $(function() {
                    $('#sel1').change(function(){
                        $('.content').hide();
                        $('#' + $(this).val()).show();
                    });
                });
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

            /*#contact .form-control{
    border-radius: 0;
    border:1px solid #1e1e1e;
}*/

            #contact button {
                border-radius: 0;
                border: 1px solid #1e1e1e;
            }

            #contact .row {
                margin-bottom: 15px;
            }

        @media (max-width: 768px) {
            #contact iframe {
                margin-bottom: 15px;
            }
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
            /*background-color:#9e9e9ebf;*/
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

        .p-3 {
            padding: 3rem !important;
        }

        .mb-5, .my-5 {
            margin-bottom: 3rem !important;
        }

        .shadow {
            box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;
        }

        .rounded {
            border-radius: 1rem !important;
        }

        .bg-white {
            background-color: #fff !important;
         /*background-image: linear-gradient(120deg, #89f7fe 0%, #66a6ff 100%);*/
        }
    </style>

</head>
<body>

    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    



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

            <section id="contact">

        <div class="jumbotron text-center" style="height: 150px;">
            <h3 style="padding-top: 50px; color: #000;"><lable id="lblRegisterUser"></lable></h3>


        </div>
        <div class="container">
            <div class="row">

                <div class="col-sm-3">
                </div>
                <div  class="col-sm-6 shadow p-3 mb-5 bg-white rounded">

                    <div id="formRegister">
                    <div class="layout_modal_body container-fluid">
                    <form name="newActivity" style="display:none;">
                   
                        <div class="form-group row">
                            <label for="colFormLabelLg" class="col-sm-3 col-form-label col-form-label-lg">Email</label>
                            <div class="col-sm-9">
                                <input type="email" name="Email" class="form-control form-control-lg" id="email" placeholder="Enter Email" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label col-form-label-lg">Mobile No.</label>
                            <div class="col-sm-9">
                                <input type="number" name="Mobile"  class="form-control form-control-lg" id="mobile" placeholder="Enter Mobile No." required />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label col-form-label-lg">First Name</label>
                            <div class="col-sm-9">
                                <input type="text" name="firstName" class="form-control form-control-lg" id="firstname" placeholder="Enter first name" required />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label col-form-label-lg">Last Name</label>
                            <div class="col-sm-9">
                                <input type="text" name="LastName" class="form-control form-control-lg" id="lastname" placeholder="Enter last name" required />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label col-form-label-lg">Parent Name</label>
                            <div class="col-sm-9">
                                <input type="text" name="ParentName" class="form-control form-control-lg" id="parentname" placeholder="Enter parent name" required />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label col-form-label-lg">Address</label>
                            <div class="col-sm-9">
                                <input type="text" name="Address" class="form-control form-control-lg" id="address" placeholder="Enter address" required />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label col-form-label-lg"></label>
                            <div class="col-sm-9" style="text-align:end">
                                <button type="button" onclick="AddUser()"  id="btnsubmit" class="btn btn-primary">Submit</button>
                            </div>    
                        </div>
        
                     <div id="post_loading" class="container-fluid" style="text-align:center;width:100%; height:200px;background-color:#090909;opacity:0.2;display:none;position:fixed; top:100px; z-index:99;">
                    <img src="Images/Icon/ajax-loader.gif" style="width:20px;height:20px; margin-top:50px;" />
                  </div>
                    </form>
                </div>
               </div>
                   <%-- <div class="layout_modal_footer" style="margin-right:7px;">
                    <button type="button" class="btn btn-success" onclick="AddUser()" id="btnsubmit" disabled="register.Email.$invalid || register.Mobile.$invalid || register.firstName.$invalid|| register.LastName.$invalid|| register.ParentName.$invalid|| register.Address.$invalid">
                    Submit</button>
                    &nbsp;&nbsp;
                    <button type="button" class="btn btn-warning" onclick="Cancel()">Cancel</button>
                </div>--%>
                </div>
                <div class="col-sm-3">
                </div>
            </div>
        </div>
    </section>

    </form>


    <header id="topNav" class="layout_header" style="height: 75px; background-color: #fff; color: #fff;">

        <div class="container-fluid">
            <div class="col-sm-4 col-xs-6 zero-margin">
                <!-- Mobile Menu Button -->

                <a class="logo" href="#">
                    <img src="Images/Icon/Logo1.png" height="50" alt="logo" />
                </a>
            </div>
            <div class="col-sm-4 hidden-xs zero-margin">
                <!-- Logo text or image -->

                <div class="title" style="color: #00baed; padding-top: 11px; text-align: center; font-size: x-large;">Society Management System</div>
                <!-- Top Nav -->

            </div>
            <div class="col-sm-4 col-xs-6 zero-margin">
                <button class="btn btn-mobile" data-toggle="collapse" data-target=".nav-main-collapse"><i class="fa fa-bars"></i></button>
                <div class="navbar-collapse nav-main-collapse collapse pull-right" style="margin-top: 9px; color: white; text-align: center;">
                    <nav class="nav-main mega-menu">
                        <ul class="nav nav-pills nav-main scroll-menu" id="topMain">
                            <li class=" active"><a class="menu_text" href="Login.aspx">Home</a></li>
                         

                        </ul>
                    </nav>
                </div>
            </div>
            <!-- /Top Nav -->

        </div>
    </header>

    <!-- WRAPPER -->
    <span itemtype="http://schema.org/SoftwareApplication" />







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
                            <img class="app_centre" src="Images/Icon/appdownload1.png" alt="Download" height="340" />
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
                        <img src="Images/Icon/iconHome.png" alt="Logo" height="50" alt="" /></h2>
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
            <p>© 2018 ANVISYS TECHNOLOGIES, ALL RIGHTS RESERVED. </p>
        </div>
    </footer>



</body>
</html>