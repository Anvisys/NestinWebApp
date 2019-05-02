rrrr<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Rent.aspx.cs" Inherits="Rent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
     <!-- jQuery library -->
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

            <link rel="stylesheet" href="CSS/Nestin.css" />
            <link rel="stylesheet" href="CSS/Nestin-3rdParty.css" />


            <link rel="stylesheet" type="text/css" href="CSS/ApttLayout.css" />
            <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css" />

            <link rel="stylesheet" href="CSS/forum.css" />
            <link rel="stylesheet" href="CSS/ApttTheme.css" />
            <link rel="stylesheet" href="CSS/ApttLayout.css" />
            <link rel="stylesheet" href="Login/CSS/footer.css" />
    <script>
        var api_url = "";


        $(document).ready(function () {
             api_url = '<%=Session["api_url"] %>';

            GetInventoryTypeData();
             GetAccomodationType(1);

            $('#selType').on('change', function () {
                  GetAccomodationType( this.value );
            });

            // populateSelect();
            $("#progressBar").hide();

        });

        function GetInventoryTypeData() {

              var abs_url = api_url + "/api/InventoryType";

            $.ajax({
                url: abs_url,
                dataType: "json",
                success: populateInventoryType,
                failure: function (response) {
                    alert(response.d);
                    sessionStorage.clear();
                }
            });


        }

        function populateInventoryType(data) {
          
            var InventoryType = data.$values;

            var ele = document.getElementById('selType');
              ele.innerHTML = "";
            for (var i = 0; i < InventoryType.length; i++) {
                // POPULATE SELECT ELEMENT WITH JSON.
                ele.innerHTML = ele.innerHTML +
                    '<option value="' + InventoryType[i].InventoryTypeID + '">' + InventoryType[i].InventoryType + '</option>';
            }

        }


        function GetAccomodationType(id) {

               var abs_url = api_url + "/api/Accomodation/" + id;

            $.ajax({
                url: abs_url,
                dataType: "json",
                success: populateAccomodationType,
                failure: function (response) {
                    alert(response.d);
                    sessionStorage.clear();
                }
            });
        }


        function populateAccomodationType( data) {
            // THE JSON ARRAY.
            var Inventory =  data.$values;

            var ele = document.getElementById('selStyle');
            ele.innerHTML = "";
            for (var i = 0; i < Inventory.length; i++) {
                // POPULATE SELECT ELEMENT WITH JSON.
                ele.innerHTML = ele.innerHTML +
                    '<option value="' + Inventory[i].AccomodationTypeID + '">' + Inventory[i].AccomodationType + '</option>';
            }
        }


        function searchHouse() {
            $("#searchData").html("");
            $("#progressBar").show();
            var RentInventory = {};
            RentInventory.InventoryID = $("#selStyle").val();
            RentInventory.RentTypeID = $("#selType").val();
            RentInventory.RentValue = $("#txtRent").val();
            RentInventory.FlatCity = $("#txtCity").val();
            RentInventory.Available = 1;

            var url = api_url + "/api/RentInventory/Find"

                console.log(url);
                console.log(RentInventory);

                $.ajax({
                dataType: "json",
                url: url,
                data: JSON.stringify(RentInventory),
                type: 'post',
                async: false,
                contentType: 'application/json',
                    success: function (data) {
                     $("#progressBar").hide();
              
                     var count = data.$values.length;
                    if(count>0)
                       {
                        document.getElementById("lblMessage").innerHTML = count + " Result Found";

                        DisplayResults(data.$values);
                                          }
                    else {
                        document.getElementById("lblMessage").innerHTML = count + " Result Found";
                    }

                },
                    error: function (data, errorThrown) {
                     $("#progressBar").hide();
                    alert('Error in Searh :' + errorThrown);
                   
                }

            });
        }


        function DisplayResults(results) {
            var strData = "";

            for (var i = 0; i < results.length; i++) {

                var FlatNo = results[i].FlatNumber;
                var HouseNo = results[i].HouseNumber;
                strData = strData +     '<div class="row result_row" style="margin-top: 10px;">'+

                             '<div class="col-xs-6" >'+
                                '<div style="color: blue;">Nestin-properties from Owners only</div>'+ 
                                 '<div class="row">'+
                                     '<div class="col-xs-4">'+
                                         '<img class="property-image" src="Images/Icon/darkredbg.png" />'+
                                     '</div>'+
                                     '<div class="col-xs-8">'+
                                         '<div style="margin-top:5px;font-weight:bold;"> Expected Rent:'+
                                           results[i].RentValue+
                                         '</div>'+
                                         '<div class="dropup" style="margin-top:5px;">'+
                                             'Contact: <button class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">'+
                                               results[i].OwnerName+
                                             '</button >'+
                                             '<ul class="dropdown-menu" style="padding:5px;"><li> Mob:'+
                                               results[i].MobileNo+
                                                '</li><li> Email:'+ results[i].HouseNumber + results[i].FlatNumber  +'</li>'+
                                              '</ul> </div> </div> </div>  </div>'+


                             '<div class="col-xs-6">'+
                                 '<div class="col-xs-12"><b>'+ results[i].Inventory + results[i].RentType+'</b><span class="normal-text"> is available in'+ results[i].sector +'</span></div>'+
                                 '<div class="col-xs-12">'+
                                     '<div class="col-xs-3  well well-sm" style="text-align: center">'+
                                         '<div class="summary-title">Area </div>'+
                                         '<div class="summary-text">'+ results[i].FlatArea +'sqft</div>'+
                                     '</div>'+
                                     '<div class="col-xs-3  well well-sm">'+
                                         '<div class="summary-title">Status </div>'+
                                         '<div class="summary-text">from 1st March</div>'+
                                     '</div>'+
                                     '<div class="col-xs-3  well well-sm">'+
                                         '<div class="summary-title">Floor </div>'+
                                         '<div class="summary-text">G of 2 </div>'+
                                     '</div>'+
                '<div class="col-xs-3  well well-sm">' +
                    '<div class="summary-title">Furnished</div>' +
                    '<div class="summary-text">none </div>' +
                    '</div>' +
                    '</div>' +
                    '<div class="col-xs-12">' +
                    results[i].Description +
                    '</div>  </div> </div>';

            }

            $("#searchData").html(strData);

        }
  

    </script>

        <style>
             .result-area {
              background-color: #D1D1D1;
              padding-bottom: 100px;
            }
            .result_row {
                /* border-bottom: 1px solid #bfbfbf; */
                background-color: #fff;
                border-radius: 5px;
                font-family: 'open_sansregular', Helvetica, Arial, sans-serif;
                font-size: 1.5rem;
                padding:10px;
            }
        .desc-row {
            height:30px;
            padding-left:25px;
            text-size-adjust:auto;
            font-size:medium;
            font-weight:100;
           
        }
        .owner-row {
             height:40px;
            padding-left:25px;
            text-size-adjust:auto;
            font-size:medium;
            font-weight:200;
            color:blue;
        }
            .summary-title {
                font-size: 1rem;
                color: #909090;
                letter-spacing: .2px;
                font-family: Open Sans,Helvetica,Arial,sans-serif;
                text-transform: uppercase;
            }

            .summary-text {
                font-size: 1.2rem;
                font-weight: 600;
                font-family: Open Sans,Helvetica,Arial,sans-serif;
                line-height: 1.5;
                background-color: #fff;
                color: #303030;
            }
            .normal-text {
                 font-size: 1.5rem;
                font-weight: 200;
                font-family: Open Sans,Helvetica,Arial,sans-serif;
                line-height: 1.5;
                color: #909090;

            }
            .property-image{
                height:80px;
                width:80px;
            }
           
           
    </style>
</head>
<body>
        <form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


        </form>


        <header id="topNav" class="layout_header top-NavigationBar">

            <div class="container-fluid">
                <div class="col-sm-4 col-xs-6 zero-margin">
                    <!-- Mobile Menu Button -->

                    <a class="logo" href="Login.aspx">
                        <img src="Images/Icon/Logo1.png" height="50px" alt="Logo" />
                    </a>
                </div>

                <div class="col-sm-4 hidden-xs zero-margin">
                    <h1 class="header-title main-headertop" style="color:#fff;">Society Management System</h1>
                </div>


                    <div class="col-sm-4 col-xs-6 zero-margin">
                        <div class="navbar-collapse nav-main-collapse collapse pull-right" style="margin-top: 9px; color: white; text-align: center;">
                            <nav class="nav-main mega-menu nav-small">
                                <ul class="nav nav-pills nav-main scroll-menu" id="topMain">
                                    <li><a class="menu_text" href="Login.aspx">Home</a></li>
                                    <li><a class="menu_text" href="Aboutus.aspx">About Us</a></li>
                                    <li><a class="menu_text" href="contact.aspx">Contact</a></li>
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

    <span itemtype="http://schema.org/SoftwareApplication" />

    <div class="jumbotron-local text-center" style="height: 100px;">
        <h3 style="padding-top: 65px; color: #ffffff;">Rent</h3>
    </div>

            <div class="row jumbotron" style="background-color:#6094c1; height:130px;border-radius:0px;margin-top:0px;">
                <div class="col-sm-3 hidden-xs"></div>
                <div class="col-sm-8 col-xs-12" >
                    
                    <form class="form-group" style="align-content:center;padding:0px;">
                        <select id="selType" placeholder="Type" runat="server" class="search-dropdown"/>
                        
                        <select id="selStyle" placeholder="Style" runat="server" class="search-text"/>
                         <input id="txtCity" placeholder="City" runat="server" class="search-text"/>
                         <input id="txtRent" placeholder="Rent" runat="server" class="search-text"/>
                        <i  onclick="searchHouse()" class="search-button"> <span class="fa fa-search fa-2x" ></span></i>

                    </form>
                          <div class="col-sm-2 hidden-xs"></div>
                </div>


                </div>


                        <div class="row result-area">

                            <div class="col-sm-2 hidden-xs"></div>
                            <div class="col-sm-8 col-xs-12">
                                <label id="lblMessage" style="color: blue; font-size: medium;"></label>
                                <div id="searchData">
                                </div>
                            </div>
                            <div class="col-sm-2 hidden-xs"></div>
                        </div>

               <div id="progressBar" class="container-fluid" style="text-align:center; height:200px;margin-top:50px;">
                    <img src="Images/Icon/ajax-loader.gif" style="width:100px;height:100px; margin-top:50px;" />
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
    </div>
    </form>
</body>
</html>
