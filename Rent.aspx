<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Rent.aspx.cs" Inherits="Rent" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title></title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- 3rd party CSS -->
    <link href="CSS_3rdParty/mythirdpartystylesheets.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css" />
    <link rel="stylesheet" href="CSS/Nestin.css" />
    <script>
        var api_url = "";

        $(document).ready(function () {
            api_url = '<%=Session["api_url"] %>';

            GetInventoryTypeData();
            GetAccomodationType(1);

            $('#selType').on('change', function () {
                GetAccomodationType(this.value);
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


        function populateAccomodationType(data) {
            // THE JSON ARRAY.
            var Inventory = data.$values;

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
                    if (count > 0) {
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
                strData = strData + '<div class="row result_row" style="margin-top: 10px;">' +

                    '<div class="col-md-6" >' +
                    '<div style="color: Black;">Nestin-properties from Owners only</div>' +
                    '<div class="row">' +
                    '<div class="col-md-4 col-xs-3">' +
                    '<img class="property-image" src="Images/Icon/darkredbg.png" />' +
                    '</div>' +
                    '<div class="col-md-8 col-xs-9">' +
                    '<div style="margin-top:5px;font-weight:bold;"> Expected Rent: ' +
                    results[i].RentValue +
                    '</div>' +
                    '<div class="dropup" style="margin-top:5px;font-weight:bold;">' +
                    'Contact: <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">' +
                    results[i].OwnerName +
                    '</button >' +
                    '<ul class="dropdown-menu" style="padding:5px;"><li> Mob:' +
                    results[i].MobileNo +
                    '</li><li> Email:' + results[i].HouseNumber + results[i].FlatNumber + '</li>' +
                    '</ul> </div> </div> </div>  </div>' +


                    '<div class="col-md-6">' +
                    '<div class="col-md-10"><b>' + results[i].Inventory + ' ' + results[i].RentType + '</b><span class="normal-text"> is available in ' + results[i].sector + '</span></div>' +
                    '<div class="col-md-12">' +
                    '<div class="col-md-3 col-xs-6  well well-sm">' +
                    '<div class="summary-title">Area </div>' +
                    '<div class="summary-text">' + results[i].FlatArea + 'sqft</div>' +
                    '</div>' +
                    '<div class="col-md-3 col-xs-6 well well-sm">' +
                    '<div class="summary-title">Status </div>' +
                    '<div class="summary-text">from 1st March</div>' +
                    '</div>' +
                    '<div class="col-md-3 col-xs-6 well well-sm">' +
                    '<div class="summary-title">Floor </div>' +
                    '<div class="summary-text">G of 2 </div>' +
                    '</div>' +
                    '<div class="col-md-3 col-xs-6 well well-sm">' +
                    '<div class="summary-title">Furnished</div>' +
                    '<div class="summary-text"> Non </div>' +
                    '</div>' +
                    '</div>' +
                    '<div class="col-md-12 col-xs-12">' +
                    results[i].Description +
                    '</div>  </div> </div>';

            }

            $("#searchData").html(strData);

        }


    </script>

    <style>
        .result-area {
            background-color: transparent !important;
        }

        .result_row {
            /* border-bottom: 1px solid #bfbfbf; */
            background-color: #fff;
            border-radius: 5px;
            font-family: 'open_sansregular', Helvetica, Arial, sans-serif;
            font-size: 1.5rem;
            padding: 10px;
        }

        .desc-row {
            height: 30px;
            padding-left: 25px;
            text-size-adjust: auto;
            font-size: medium;
            font-weight: 100;
        }

        .owner-row {
            height: 40px;
            padding-left: 25px;
            text-size-adjust: auto;
            font-size: medium;
            font-weight: 200;
            color: blue;
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

        .property-image {
            height: 60px;
            width: 60px;
        }
    </style>
    <style>
        .nav-color {
            background: #727CF5;
        }

        .search-dropdown {
            width: 200px;
            height: 50px;
            padding: 0px;
            margin: 0px;
            padding-left: 10px;
            float: left;
            border-radius: 0px;
            border: 0px;
            font-size:18px;
        }

        .search-text {
            width: 200px;
            height: 50px;
            padding: 0px;
            padding-left: 10px;
            margin: 0px;
            display: inline;
            float: left;
            border: 0px;
            font-size:18px;
        }

        .search-button {
            width: 53px;
            height: 40px;
            padding-left: 5px;
            padding-top: 5px;
            margin: 0px;
            display: inline;
            float: none;
            background-color: chocolate;
        }

        .search-symbol {
            height: 40px;
            width: 40px;
            margin: 0px;
            padding: 0px;
            margin: auto;
        }
    </style>

    <!-- GOOGLE ADSENS-->

    <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
    <script>
        (adsbygoogle = window.adsbygoogle || []).push({
            google_ad_client: "ca-pub-5831709708295912",
            enable_page_level_ads: true
        });
    </script>

    <!-- GOOGLE ADSENS END -->

</head>
<body style="background-image: url(Images/Icon/rent.jpg); background-repeat: no-repeat; background-size: cover;">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
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
                    </ul>
                </div>

            </div>
        </nav>
    </header>

    <div class="jumbotron-local text-center" style="height: 120px;">
        <h2 style="padding-top: 70px; color: #ffffff; font-weight: bold; letter-spacing: 3px;">RENT</h2>
    </div>


    <div class="row" style="margin-top: 60px;">
        <div class="col-md-2 col-xs-1"></div>
        <div class="col-md-8 col-xs-11">
            <form>
                <select id="selType" placeholder="Type" runat="server" class="search-dropdown" />
                <select id="selStyle" placeholder="Style" runat="server" class="search-dropdown" />
                <input id="txtCity" placeholder="City" runat="server" class="search-text" />
                <input id="txtRent" placeholder="Rent" runat="server" class="search-text" />
            </form>
        </div>
        <div class=""></div>
    </div>

    <div class="row" style="margin-top: 20px;">
        <div class="col-md-4 col-xs-3"></div>
        <div class="col-md-4 col-xs-6" style="text-align: center;">
            <button onclick="searchHouse()" type="button" class="btn btn-warning  fa fa-search">&nbsp SEARCH</button>
        </div>
        <div class="col-md-4 col-xs-3"></div>
    </div>



    <div class="row result-area">
        <div class="col-md-1 col-lg-1 col-xs-1"></div>
        <div class="col-md-10 col-lg-10 col-xs-10">
            <label id="lblMessage" style="color: white; font-size: medium;"></label>
            <div id="searchData"></div>
        </div>
        <div class="col-md-1 col-lg-1 col-xs-1"></div>
    </div>

    <!-- FOOTER -->
    <footer id="myFooter" style="margin-top: 200px;">
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
