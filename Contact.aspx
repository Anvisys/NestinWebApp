<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Contact us</title>
    <meta name="viewport" content="width=device-width, maximum-scale=1, initial-scale=1, user-scalable=0"/>
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
        #contact{
    background-color:#f1f1f1;
    font-family: 'Roboto', sans-serif;
}

#contact .well{
    margin-top:30px;
    border-radius:0;
}

#contact .form-control{
    border-radius: 0;
    border:1px solid #1e1e1e;
}

#contact button{
    border-radius:0;
    border:1px solid #1e1e1e;
}

#contact .row{
    margin-bottom:30px;
}

@media (max-width: 768px) { 
    #contact iframe {
        margin-bottom: 15px;
    }
    
}
      
        .Forgot_button{

        background-color:transparent;
        height:30px;      
        color:white;
        font-family:'Times New Roman', Times, serif;
        font-style:oblique;
        font-weight:bold;
         outline:0;
         display:none;
	}

        .forgot_pass{

            color:#6eab91;
            text-decoration:none;
            padding:1% 0 2% 0;
        }
        .forgottxt{
            padding:1% 2%
        }

        a{
            color:white;
        }

        .dvLoading_first
        {
            display:none;
           background: url(Images/Icon/ajax-loader.gif) no-repeat center center;
           opacity: 0.5;
           height: 50px;
           width: 50px;         
           z-index: 1000;                   
           border:0;
           outline:0;
           border-style:none;
           border-color:white;
           border-radius:5px;
           text-align:center;
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
                       <img  class="dvLoading_first" src="Images/Icon/ajax-loader.gif" alt="Loading..." style="border:0;"/>  
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
                    
             <a class="logo" href="#"> <img src="Images/Icon/Logo1.png" height="50" alt="logo"/> </a> 
         </div>
           <div class="col-sm-4 hidden-xs zero-margin">
                    <!-- Logo text or image --> 
                    
                      <div class="title" style="color:#00baed;padding-top:11px;text-align:center;font-size:x-large;"> Society Management System</div>
                    <!-- Top Nav -->

          </div>
           <div class="col-sm-4 col-xs-6 zero-margin">
               <button class="btn btn-mobile" data-toggle="collapse" data-target=".nav-main-collapse"> <i class="fa fa-bars"></i> </button>
                  <div class="navbar-collapse nav-main-collapse collapse pull-right" style="margin-top: 9px;color:white; text-align:center;">
                  <nav class="nav-main mega-menu">
                    <ul class="nav nav-pills nav-main scroll-menu" id="topMain">
                      <li class=" active"><a class="menu_text" href="Login.aspx">Home</a></li>
                      <li class=" "><a class="menu_text"  href="Aboutus.aspx">About Us</a></li>
       
                      <li class=" "><a  class="menu_text" href="Contact.aspx">Contact </a></li>
                      <li class=" "><a  class="menu_text" href="#" id="login">Login</a></li>
                        <li class=" "><a  class="menu_text" href="register.aspx" id="register">Register</a></li>
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
  


<section id="contact">
  
       <div class="jumbotron text-center">
  <h1 style="padding-top:70px;">Contact us</h1> 
 

</div>
	<div class="container">
	<div class="row">
	  <div class="col-md-7">
      <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3502.0336857316393!2d77.3739253145595!3d28.628752491003983!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390ce56d150cb4fb%3A0x3d26e6a0fb0fafa3!2sALPC+BUSINESS+PARK!5e0!3m2!1sen!2sin!4v1545212333342" style="width:100%;" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>
      </div>

      <div class="col-md-5">
          <h4><strong>Get in Touch</strong></h4>
        <form method="post" >
          <div class="form-group" action>
            <input type="text" class="form-control" name="fullName" value="" placeholder="Name"/>
          </div>
          <div class="form-group">
            <input type="email" class="form-control" name="emailId" value="" placeholder="E-mail"/>
          </div>
          <div class="form-group">
            <input type="tel" class="form-control" name="message" value="" placeholder="Phone"/>
          </div>
          <div class="form-group">
            <textarea class="form-control" name="" rows="3" placeholder="Message"></textarea>
          </div>
          <button class="btn btn-default" type="submit" name="submitbtn">
              <i class="fa fa-paper-plane-o" aria-hidden="true"></i> Submit
          </button>
        </form>
      </div>
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
                                    <img class="app_centre" src="Images/Icon/appdownload1.png" alt="Download" height="340"/>
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
                    <h2 class="logo1"><img src="Images/Icon/iconHome.png" alt="Logo" height="50" alt=""/></h2>
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
  
    	
  
</body>
</html>
