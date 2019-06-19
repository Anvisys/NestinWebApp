<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Role.aspx.cs" Inherits="Role" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
    <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>
    <link rel="Stylesheet" href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.10/themes/redmond/jquery-ui.css" />
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />

    <link href="CSS_3rdParty/settings.css" rel="stylesheet" type="text/css" />
    <!-- THEME CSS -->

    <%-- <link href="Login/css/essentials.css" rel="stylesheet" type="text/css" />--%>
    <link href="CSS_3rdParty/layout.css" rel="stylesheet" type="text/css" />
    <link href="CSS_3rdParty/layout-responsive.css" rel="stylesheet" type="text/css" />

    <%--<link href="CSS/layout.css" rel="stylesheet" />--%>
    <%--<link href="Styles/Responsive.css" rel="stylesheet" />--%>
    <link href="CSS/mystylesheets.css" rel="stylesheet" />

    <%--<link rel="stylesheet" href="CSS/ApttTheme.css" />--%>
    <%--<link rel="stylesheet" href="CSS/ApttLayout.css" />--%>
    <link rel="stylesheet" href="CSS_3rdParty/footer.css" />

    <link rel="stylesheet" href="CSS/IP.css" />
    <link rel="stylesheet" href="CSS/Nestin.css" />
    <link rel="stylesheet" href="CSS/Nestin-3rdParty.css" />


    <script type="text/javascript" src="Scripts/datetime.js"></script>


    <script>

        var UserId;
        var selectedSocietyId = 0;
        var selectedFlatId = 0;
        var role = "";
        var ResId;

        $(document).ready(function () {
            let params = (new URL(document.location)).searchParams;

            if (params != null) {
                UserId = params.get("name");
            }

            ResCount = <%=ResCount%>;

            if (ResCount == 0) {
                $("#linkDashboard").hide();
            }
            else {
                $("#linkDashboard").show();
            }

            api_url = '<%=Session["api_url"] %>';
            GetMySocietyRequests();
            GetMyHouses();
            GetMyFlats();
            GetUserData();
        });


        $(function () {

            $("#selectSociety").autocomplete({
                select: onSociety_select,
                source: function (request, response) {
                    var param = {
                        SocietyName: $('#selectSociety').val()

                    };

                    $.ajax({
                        url: "Role.aspx/GetSocieties",
                        data: '{Society: ' + JSON.stringify(param) + '}',
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataFilter: function (data) { return data; },
                        success: function (data) {
                            var flats = jQuery.parseJSON(data.d);
                            response($.map(flats, function (value) {

                                return {
                                    //label: value.FlatNumber,
                                    value: value.SocietyName,
                                    sector: value.Sector,
                                    city: value.City,
                                    pinCode: value.PinCode,
                                    socID: value.SocietyID
                                }
                            }))
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            var err = eval("(" + XMLHttpRequest.responseText + ")");
                            alert(err.Message)
                            console.log("Ajax Error!");
                        }
                    });
                },

                minLength: 2, //This is the Char length of inputTextBox  
                serverPaging: true,
                pageSize: 10
            });


            $("#flatno").autocomplete({
                select: onFlat_select,
                source: function (request, response) {
                    var param = {
                        FlatNumber: $('#flatno').val(),
                        SocietyId: selectedSocietyId
                    };

                    $.ajax({
                        url: "Role.aspx/GetFlatNumber",
                        data: '{flat: ' + JSON.stringify(param) + '}',
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataFilter: function (data) { return data; },
                        success: function (data) {
                            var flats = jQuery.parseJSON(data.d);
                            response($.map(flats, function (value) {

                                return {
                                    //label: value.FlatNumber,
                                    value: value.FlatNumber,
                                    block: value.Block,
                                    flatArea: value.FlatArea,
                                    floor: value.Floor,
                                    intercom: value.IntercomNumber,
                                    bhk: value.BHK,
                                    flatId: value.ID
                                }
                            }))
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            var err = eval("(" + XMLHttpRequest.responseText + ")");
                            alert(err.Message)
                            console.log("Ajax Error!");
                        }
                    });
                },

                minLength: 2, //This is the Char length of inputTextBox  
                serverPaging: true,
                pageSize: 10
            });

        });

        function onSociety_select(e, ui) {

            $("#locality4").text(ui.item.sector);
            $("#city2").text(ui.item.city);
            $("#pincode4").text(ui.item.pinCode);
            selectedSocietyId = ui.item.socID;
        };

        function onFlat_select(e, ui) {

            console.log(ui.item.block);
            console.log(ui.item.floor);

            $("#floor").text(ui.item.floor);
            $("#block").text(ui.item.block);
            $("#intercom").text(ui.item.intercom);
            $("#city2").text(ui.item.block);
            selectedFlatId = ui.item.flatId;

        };


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
        };

        $(function () {
            $('#sel1').change(function () {
                $('.content').hide();
                $('#' + $(this).val()).show();
            });
        });

        function AddIndependentHouse() {
            $("#ProgressBar").show();
            var House = {};
            House.HouseNumber = document.getElementById("houseno").value;
            House.Sector = document.getElementById("sector").value;
            //House.City = document.getElementById("locality").value;
            House.City = document.getElementById("city").value;
            House.State = document.getElementById("state").value;
            House.PinCode = document.getElementById("pincode").value;


            $.ajax({
                type: 'POST',
                url: "Role.aspx/AddHouse",
                data: '{house: ' + JSON.stringify(House) + '}',
                contentType: "application/json; charset=utf-8",
                async: false,
                dataType: "json",
                success: function (response) {
                    // document.getElementById("post_loading").style.display = "none";
                    if (response.d > 0) {
                        window.location = "MainPage.aspx";
                    }
                    else if (response.d < 0) {
                        alert('House number is in use');
                    }
                    else {
                        alert('Server Error');
                    }

                },
                error: function (data, errorThrown) {
                    document.getElementById("post_loading").style.display = "none";
                    alert('Error Updating comment, try again');


                }
            });
            $("#ProgressBar").hide();
            location.reload();
        }

        function AddNewSociety() {
            $("#ProgressBar").show();
            var Society = {};
            Society.SocietyName = document.getElementById("societyName").value;
            Society.Sector = document.getElementById("socLocality").value;
            Society.City = document.getElementById("socCity").value;
            Society.State = document.getElementById("socState").value;
            Society.PinCode = document.getElementById("socPin").value;
            Society.ContactUserId = <%=UserID%>;
            Society.Status = 1;
            console.log(Society);

            $.ajax({
                type: 'POST',
                url: "Role.aspx/AddNewSociety",
                data: '{Society: ' + JSON.stringify(Society) + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //document.getElementById("post_loading").style.display = "none";
                    if (response.d > 0) {
                        window.location = "Role.aspx";
                    }
                    else if (response.d < 0) {
                        alert('House number is in use');
                    }
                    else {
                        alert('Server Error');
                    }

                },
                error: function (data, errorThrown) {
                    // document.getElementById("post_loading").style.display = "none";
                    alert('Error Updating comment, try again');


                }
            });
            $("#ProgressBar").hide();

        }

        function GetMyFlats() {
            var abs_url = api_url + "/api/Society/Flats/" + <%=UserID%>;
            console.log(abs_url);
            $("#flat_progressBar").show();
            $.ajax({
                url: abs_url,
                dataType: "json",
                success: DisplayFlats,
                failure: function (response) {
                    $("#flat_progressBar").hide();
                    alert(response.d);
                    sessionStorage.clear();
                }
            });
        }

        function DisplayFlats(response) {
            $("#flat_progressBar").hide();
            var strData = "";
            $("#FlatRequests").html(strData);
            var results = response.$values;// jQuery.parseJSON(response.$values);

            if (results.length > 0) {
                for (var i = 0; i < results.length; i++) {

                    var reqDate = DisplayDateOnly(results[i].ActiveDate);
                    var modDate = DisplayDateOnly(results[i].DeActiveDate);
                    var btnString = "";
                    if (results[i].Status == 2) {

                        btnString = "<button class='btn btn-primary btn-sm' onclick='Select(" + results[i].ResID + ",2)'>Select</button>";

                    }

                    strData =
                        strData + "<div class=\"row\" style=\"margin-top:10px; margin-right:40px;\">" +
                        "<div class='col-md-1 col-xs-1'>" + results[i].SocietyID + "</div>" +
                        "<div class='col-md-4 col-xs-3'>" + results[i].FlatNumber + "," + results[i].Status + "<br/> Address:" + results[i].SocietyName + ", " + results[i].Address + "</div>" +
                        "<div class='col-md-2 col-xs-2'>Requested On:" + reqDate + "</div>" +
                        "<div class='col-md-2 col-xs-2'>Modified On :" + modDate + "</div>" +
                        "<div class='col-md-1 col-xs-2'>Status: <br/>" + results[i].Status + "</div>" +
                        "<div class='col-md-2 col-xs-2'><button class='btn btn-primary btn-sm' id='btnSub' onclick='Select(" + results[i].ResID + ",2)'>Select</button></div>"
                        + "</div>";

                    //new data//

                    //strData = 
                    //    strData + "<div class=\"row\" style=\"margin-top:10px; margin-right:40px;\">" +
                    //                     "<div class='col-md-1'></div>" +
                    //                       "<div class='col-md-10 col-xs-12'>" +
                    //                        "<table>" +
                    //                            "<tr>" + 
                    //                               "<td>" + results[i].SocietyID + "&nbsp;" + "</td>" +
                    //                               "<td>" + results[i].FlatNumber + "," + results[i].Status + "<br/> Address:" + results[i].SocietyName + ", " + results[i].Address + "</td>" +
                    //                               "<td>" + "RequestedOn: " +  reqDate  + "</td>" +
                    //                               "<td>" + " ModifiedOn :" + modDate + "</td>" +
                    //                               "<td>" + "Status: " + results[i].Status + "</td>" +
                    //                               "<td>" + " <button class='btn btn-primary btn-sm' id='btnSub' onclick='Select("+results[i].ResID +",2)'>Select</button> " + "</td>" 
                    //                            + "</tr>"
                    //                      + "</table>"
                    //                     + "</div>"
                    //                   + "<div class='col-md-1'></div>"
                    //              + "</div>";




                }

                $("#FlatRequests").html(strData);
                var stat = results[i].Status;
                if (stat != 'Approved')
                    $("#btnSub").attr("disabled", "true");
                else {
                    $("#btnSub").attr("disabled", "false");
                }
            }
            else {
                var noData = "<h3> No data for Flats</h3>"
                $("#FlatRequests").html(noData);


            }

        }


        function GetMySocietyRequests() {
            $("#society_progressBar").show();
            var abs_url = api_url + "/api/Society/" + <%=UserID%>;

            $.ajax({
                url: abs_url,
                dataType: "json",
                success: SocietyRequest,
                failure: function (response) {
                    $("#society_progressBar").hide();
                    alert(response.d);
                    sessionStorage.clear();
                }
            });
        }

        function SocietyRequest(response) {
            $("#society_progressBar").hide();
            var strData = "";
            $("#SocietyRequests").html(strData);
            var results = response.$values;// jQuery.parseJSON(response.$values);

            if (results.length > 0) {
                for (var i = 0; i < results.length; i++) {

                    var reqDate = DisplayDateOnly(results[i].RequestDate);
                    var modDate = DisplayDateOnly(results[i].ModifiedDate);



                    strData = strData + "<div class=\"row\" style=\"margin:20px;padding:0px;\">" +
                        "<div class='col-xs-1'>" + results[i].SocietyID + "</div>" +
                        "<div class='col-xs-5'> " + results[i].SocietyName + "<br/> Address:" +
                        results[i].Sector + ", " + results[i].City + ", " + results[i].State +
                        "</div>" +
                        "<div class='col-xs-2'> Requested On:" + reqDate + "</div>" +
                        "<div class='col-xs-2'>Modified On :" + modDate + "</div>" +
                        "<div class='col-xs-2'> Status: <br/>" + results[i].Status + "</div>"

                        //"<div class='panel-heading'>" + results[i].SocietyID + "<br/>: " + results[i].SocietyName + " <br/> Return " + results[i].Sector + "</div>"
                        //+ "<div class='panel-body'> City " + results[i].City
                        //+ "<div> State" + results[i].State + "</div>"
                        //   + "</div>"


                        + "</div>";

                }

                $("#SocietyRequests").html(strData);

            }
            else {
                var noData = "<h3> No data for Society</h3>"

                $("#SocietyRequests").html(noData);
            }

        }


        function GetMyHouses() {
            $("#house_progressBar").show();
            var abs_url = api_url + "/api/Society/House/" + <%=UserID%>;

            $.ajax({
                url: abs_url,
                dataType: "json",
                success: ListHouseRequests,
                failure: function (response) {
                    $("#house_progressBar").hide();
                    alert(response.d);
                    sessionStorage.clear();
                }
            });
        }


        function ListHouseRequests(response) {
            $("#house_progressBar").hide();
            var strData = "";
            $("#HouseRequests").html(strData);
            var results = response.$values;// jQuery.parseJSON(response.$values);

            if (results.length > 0) {
                for (var i = 0; i < results.length; i++) {

                    var actDate = DisplayDateOnly(results[i].ActiveDate);
                    var inactDate = DisplayDateOnly(results[i].DeActiveDate);

                    strData = strData + "<div class=\"row\" style=\"margin:20px;padding:0px;\">"
                        + "<div class='col-xs-2'>ResId:" + results[i].ResID + "</div>"
                        + "<div class='col-xs-4'>" + results[i].HouseNUmber + "<br/>: " + results[i].Sector + ", " + results[i].City + ", " + results[i].State + "</div>"
                        + "<div class='col-xs-2'> Status : " + results[i].Status + "</div>"
                        + "<div class='col-xs-2'> Active Till" + inactDate + "</div>"
                        + "<div class='col-xs-2'><button id='btnSub' class='btn btn-primary btn-sm' onclick='Select(" + results[i].ResID + ",2)'>Select</button></div>"
                        + "</div>";

                }

                $("#HouseRequests").html(strData);
                var stat = results[i].Status;
                alert("481==>>" + stat);
                if (stat != 'Approved')
                    $("#btnSub").hide();
                else {
                    $("#btnSub").show();
                }

            }
            else {
                var noData = "<h3> No Independent House</h3>"

                $("#HouseRequests").html(noData);
            }

        }


        function AddInExistingSociety() {
            $("#ProgressBar").show();
            var user = {};
            user.SocietyId = selectedSocietyId;
            user.FlatId = selectedFlatId;

            $.ajax({
                type: 'POST',
                url: "Role.aspx/AddInSociety",
                data: '{sUser: ' + JSON.stringify(user) + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //document.getElementById("post_loading").style.display = "none";
                    if (response.d == true) {
                        alert('Your Request has been successfully Submitted');
                        $("#addFlat").hide();
                        GetMyFlats();
                    }
                    else {
                        alert('Request could not be submitted');
                    }

                },
                error: function (data, errorThrown) {
                    document.getElementById("post_loading").style.display = "none";
                    alert('Error Updating comment, try again');


                }
            });
            $("#ProgressBar").hide();
        }

        function Select(ResId, status) {
            window.location = "MainPage.aspx?Res=" + ResId;

            console.log(window.location);
            //if (status = 0) {
            //    alert("Call Admin for Approval");
            //}
            //else {
            //    window.location = "MainPage.aspx?Res=" + ResId;
            //    alert("Go To Main Page");
            //}
        }


        function NewFlat() {
            $("#addFlat").show();
        }

        function NewHouse() {
            $("#addHouse").show();
        }
        function NewSociety() {
            $("#addSociety").show();
        }


        function HideAddHouse() {
            $("#addHouse").hide();
        }

        function HideAddFlat() {
            $("#addFlat").hide();
        }

        function HideAddSociety() {
            $("#addSociety").hide();
        }



        function GetUserData(user_login) {

            $.ajax({
                type: "POST",
                url: "Userprofile.aspx/GetUserData",
                data: '{userLogin:"' + user_login + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: ShowUserData,
                failure: function (response) {
                    alert(response.d);
                    sessionStorage.clear();
                }
            });
        }


        function ShowUserData(response) {
            var js = jQuery.parseJSON(response.d);

            if (js.length > 0) {

                var length = js.length;

                for (var i = 0; i < length; i++) {

                    $('#txtUFName').val(<% =UserName %>);

                    $('#txtUMobile').val(js[i].MobileNo);


                    $('#txtULName').val(js[i].LastName);

                    $('#txtUEmail').val(js[i].EmailId);

                    $('#txtUAddress').val(js[i].Address);

                }

            }
            else {
                //alert("NoData")
            }

        }


    </script>
    <style>
        .hiddencol {
            display: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header id="topNav" class="layout_header" style="height: 75px; background-color: #727cf5; color: #fff;">

            <div class="container-fluid">
                <div class="col-sm-4 col-xs-6 zero-margin">
                    <!-- Mobile Menu Button -->

                    <a class="logo" href="MainPage.aspx">
                        <img src="Images/Icon/Logo1.png" height="50" alt="logo" />
                    </a>
                </div>
                <div class="col-sm-4 hidden-xs zero-margin">
                    <!-- Logo text or image -->

                    <h1 class="header-title" style="color: #fff; padding-top: 11px; text-align: center; font-size: x-large;">Society Management System</h1>
                    <!-- Top Nav -->

                </div>
                <div class="col-sm-4 col-xs-6 zero-margin">
                    <button class="btn btn-mobile" data-toggle="collapse" data-target=".nav-main-collapse"><i class="fa fa-bars"></i></button>
                    <div class="navbar-collapse nav-main-collapse collapse pull-right" style="margin-top: 9px; color: white; text-align: center;">
                        <nav class="nav-main mega-menu">
                            <ul class="nav nav-pills nav-main scroll-menu" id="topMain">
                                <li id="linkDashboard"><a href="MainPage.aspx">Dashboard</a></li>
                                <li>
                                    <asp:LinkButton ID="btnlogout" runat="server" Text="Logout" OnClick="btnlogout_Click"></asp:LinkButton></li>
                            </ul>
                        </nav>
                    </div>
                </div>
                <!-- /Top Nav -->

            </div>
        </header>


        <div style="margin-top: 100px;">

            <asp:GridView ID="gridViewRequests" runat="server"
                AutoGenerateColumns="false" OnRowDataBound="gridRequest_DataBound">
                <Columns>
                    <%--<asp:BoundField DataField="FlatNumber" HeaderText="Flat" />--%>
                    <asp:TemplateField HeaderStyle-Width="50px">
                        <HeaderTemplate>
                            <asp:Label ID="lblFlat" runat="server" Text="Flat"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <label onclick='<%# "Click(" + Eval("ResID")+","+Eval("Status")+")" %>' class="BillActiveGrid">
                                <%# Eval("FlatNumber") %>
                            </label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="SocietyName" HeaderStyle-Width="100px" HeaderText="Society" />
                    <asp:BoundField DataField="FlatNumber" HeaderStyle-Width="40px" HeaderText="Flat" ItemStyle-Width="40px" />
                    <asp:BoundField DataField="ActiveDate" DataFormatString="{0:dd/MMM/yy}" HeaderStyle-Width="100px" HeaderText="Active From" />
                    <asp:BoundField DataField="DeActiveDate" DataFormatString="{0:dd/MMM/yy}" HeaderStyle-Width="100px" HeaderText="Active Till" />
                    <asp:BoundField DataField="Status" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hiddencol" />
                    <asp:BoundField DataField="Status" HeaderStyle-Width="100px" HeaderText="Status" />
                </Columns>
                <EmptyDataRowStyle BackColor="#EEEEEE" />
                <HeaderStyle BackColor="#0065A8" Font-Bold="false" Font-Names="Modern" Font-Size="Small" ForeColor="White" Height="30px" />

            </asp:GridView>

        </div>

    </form>


    <div class="container-fluid" id="User_Profile" style="background-color: white;">
        <div class="row">
            <div class="col-md-2 hidden-xs hidden-sm" style="margin-left: 60px; margin-top: 30px;">
                <img id="uploadPreview" class="img image_large" src="GetImages.ashx?UserID=<% =UserID %>&Name=<% =UserName %>&UserType=Owner" />
            </div>
            <center>
                        <div class="col-xs-12  hidden-md hidden-lg">
                            <img id="uploadPreview" class="img image_small" src="GetImages.ashx?UserID=<% =UserID %>&Name=<% =UserName %>&UserType=Owner" />
                        </div>
                        </center>
            <div class="col-md-8 col-xs-12">
                <table class="w3-table w3-striped w3-bordered">
                    <tr>
                        <td>FirstName</td>
                        <td><% =UserName %></td>
                    </tr>
                    <tr>
                        <td>LastName</td>
                        <td><% =UserLastName %></td>
                    </tr>
                    <tr>
                        <td>Email</td>
                        <td><% =UserEmail %></td>
                    </tr>
                    <tr>
                        <td>Mobile</td>
                        <td><% =UserMobile %></td>
                    </tr>
                    <tr>
                        <td>Address</td>
                        <td>XXXXXXXXXXX</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <!-- My Flat NEW -->
    <div class="container" id="flat_Request" style="background-color: white; margin-top: 40px;">
        <div class="row">
            <div class="col-md-2 col-xs-2"></div>
            <div class="col-md-6 col-xs-6">
                <h4 style="margin-left: 10px;">My Flats</h4>
            </div>
            <div class="col-md-2 col-xs-2">
                <button class="btn btn-warning btn-sm" onclick="NewFlat()" type="button">New Flat</button>
            </div>
            <div class="col-md-2 col-xs-2"></div>
        </div>

        <hr style="border: 1px solid black" />

        <div class="row">
            <div class="col-md-1"></div>
            <div class="col-md-10 col-xs-12">
                <div id="FlatRequests"></div>
            </div>
            <div class="col-md-1"></div>
        </div>
    </div>
    <!-- My Flat new END -->

    <!-- My Society NEW -->
    <div class="container" id="society_Request" style="background-color: white; margin-top: 40px;">
        <div class="row">
            <div class="col-md-2 col-xs-2"></div>
            <div class="col-md-6 col-xs-6">
                <h4 style="margin-left: 10px;">My Societies</h4>
            </div>
            <div class="col-md-2 col-xs-2">
                <button class="btn btn-warning btn-sm" onclick="NewSociety()" type="button">New Society</button>
            </div>
            <div class="col-md-2 col-xs-2"></div>
        </div>

        <hr style="border: 1px solid black" />

        <div class="row">
            <div class="col-md-1"></div>
            <div class="col-md-10 col-xs-12">
                <div id="SocietyRequests"></div>
            </div>
            <div class="col-md-1"></div>
        </div>

    </div>
    <!-- My Society END -->

    <!-- My Independent House NEW -->
    <div class="container" id="House_Requests" style="background-color: white; margin-top: 40px;">
        <div class="row">
            <div class="col-md-2 col-xs-2"></div>
            <div class="col-md-6 col-xs-6">
                <h4 style="margin-left: 10px;">My Societies</h4>
            </div>
            <div class="col-md-2 col-xs-2">
                <button class="btn btn-warning btn-sm" onclick="NewHouse()" type="button">New House</button>
            </div>
            <div class="col-md-2 col-xs-2"></div>
        </div>

        <hr style="border: 1px solid black" />

        <div class="row">
            <div class="col-md-1"></div>
            <div class="col-md-10 col-xs-12">
                <div id="HouseRequests"></div>
            </div>
            <div class="col-md-1"></div>
        </div>

    </div>
    <!-- My Independent House END -->
    <br />
    <br />

    <!-- My Flats -->
    <%-- <div class="col-md-12">
        <div  class="container" id="flat_Request" style="min-height:700px; margin: 20px; background-color: white;">
            <div class="ProgressBar-Parent">
                <div class="row ProgressBar-Sibling" style="margin: 10px; width:100%;">
                <div class="row " >
                    <div class="col-md-9 col-xs-6">
                        <h4 style="margin-left: 10px;">My Flats</h4>
                    </div>
                    <div class="col-md-2 col-xs-3">
                        <button class="btn btn-primary btn-block" onclick="NewFlat()" type="button">New Flat</button>
                    </div>
                </div>
                <div id="FlatRequests" class="row " style="border-top: solid 2px black; margin-top: 10px; "></div>
                </div>
                <div id="flat_progressBar" class="ProgressBar" style="text-align: center; min-height: 200px; width:100%;">
                    <img src="images/icon/ajax-loader.gif" style="width: 40px; height: 40px; margin-top: 50px;" />
                </div>
            </div>
        </div>--%>

    <!-- My society -->
    <%--   <div class="col-md-12">
        <div class="container-fluid" id="society_Request" style="margin: 50px;min-height:200px; background-color: white;">
            <div class="ProgressBar-Parent">
                <div class="ProgressBar-Sibling" style="margin:10px; width:84%;">
                    <div class="row">
                        <div class="col-xs-10">
                            <h4 style="margin-bottom: 0px;">My Societies </h4>
                        </div>
                        <div class="col-xs-2">
                            <button class="btn btn-primary btn-sm" onclick="NewSociety()" type="button">New Society</button></div>
                    </div>
                    <div class="row" id="SocietyRequests" style="border-top: solid 2px black; margin-top: 10px; width:100%;"></div>
                </div>
                <div id="society_progressBar" class="ProgressBar" style="text-align: center; min-height: 200px;width:100%;">
                    <img src="images/icon/ajax-loader.gif" style="width: 40px; height: 40px; margin-top: 50px;" />
                </div>
            </div>
        </div>
        </div>--%>

    <!-- My Independent House -->
    <%-- <div class="col-md-12">
        <div class="container-fluid " id="House_Requests" style="margin: 50px;min-height:200px; background-color: white;">
            <div class="ProgressBar-Parent">
                <div class="ProgressBar-Sibling" style="width:84%; margin:10px;">
                    <div class="row" >
                        <div class="col-xs-10">
                            <h4 style="margin-bottom: 0px;">My Independent House</h4>
                        </div>
                        <div class="col-xs-2">
                            <button class="btn btn-primary btn-sm" onclick="NewHouse()" type="button">New House</button></div>

                    </div>
                    <div class="row" id="HouseRequests" style="border-top: solid 2px black; margin-top: 10px;"></div>
                </div>
                <div id="house_progressBar" class="ProgressBar" style="text-align: center; height: 200px;width:100%; ">
                    <img src="images/icon/ajax-loader.gif" style="width: 40px; height: 40px; margin-top: 50px;" />
                </div>
            </div>
        </div>
        </div>--%>



    <!-- Add House Button -->
    <div id="addHouse" class="modal">
        <div class="panel panel-primary" style="border: 0px; width: 670px; background-color: #fff; margin: auto;">
            <div class="panel-heading">
                Add House<span class="fa fa-times" style="float: right; cursor: pointer;" onclick="HideAddHouse()" aria-hidden="true"></span>
            </div>
            <form class="AddNewHouse" autocomplete="off">
                <div class="panel-body">

                    <div class="container-fluid">
                        <div class="form-group row">
                            <div class="col-md-6 col-xs-12">
                                <label for="colFormLabelLg" class="col-md-4 col-xs-2 col-form-label ">House No.</label>
                                <div class="col-md-8 col-xs-4">
                                    <input type="number" name="house" class="form-control " id="houseno" tabindex="1" placeholder="001" />
                                </div>
                            </div>
                            <div class="col-md-6 col-xs-12">
                                <label for="colFormLabelLg" class="col-md-4 col-xs-2 col col-form-label ">Sector</label>
                                <div class="col-md-8 col-xs-4">
                                    <input type="text" name="Sector" class="form-control " id="sector" tabindex="2" placeholder="Eg.sector-63" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-md-6 col-xs-12">
                                <label for="colFormLabelLg" class="col-md-4 col-xs-2 col col-form-label ">Locality</label>
                                <div class="col-md-8 col-xs-4">
                                    <input type="text" name="Locality" class="form-control" id="locality" tabindex="3" placeholder="Locality " />
                                </div>
                            </div>
                            <div class="col-md-6 col-xs-12">
                                <label for="colFormLabelLg" class="col-md-4 col-xs-2 col col-form-label ">City</label>
                                <div class="col-md-8 col-xs-4">
                                    <input type="text" name="City" class="form-control " id="city" tabindex="4" placeholder="Eg.Noida " />
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-md-6 col-xs-12">
                                <label for="colFormLabelLg" class="col-md-4 col-xs-2 col col-form-label ">State</label>
                                <div class="col-md-8 col-xs-4">
                                    <input type="text" name="State" class="form-control " id="state" tabindex="5" placeholder="State" />
                                </div>
                            </div>
                            <div class="col-md-6 col-xs-12">
                                <label for="colFormLabelLg" class="col-md-4 col-xs-2 col col-form-label ">Pin Code</label>
                                <div class="col-md-8 col-xs-4">
                                    <input type="number" name="PinCode" class="form-control " tabindex="6" id="pincode" placeholder="201301" />
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="panel-footer" style="text-align: right;">
                    <div class="row">
                        <div class="col-xs-6">
                            <button type="button" class="btn btn-danger btn-sm" onclick="HideAddHouse()">Cancel</button>
                            <button type="button" class="btn btn-success btn-sm" onclick="AddIndependentHouse()">Submit</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- Add Flat Button -->
    <div id="addFlat" class="modal">
        <div class="panel panel-primary" style="border: 0px; width: 670px; background-color: #fff; margin: auto;">
            <div class="panel-heading">
                Add Flat<span class="fa fa-times" style="float: right; cursor: pointer;" onclick="HideAddFlat()" aria-hidden="true"></span>
            </div>
            <div class="panel-body">
                <form class="Addflat">
                    <div class="container-fluid">
                        <div class="form-group row">
                            <label class="col-md-3 col-xs-12 col-form-label ">Select Your Society</label>
                            <div class="col-md-9 col-xs-8">
                                <input type="text" class="form-control " placeholder="Society" id="selectSociety" />

                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-md-6 col-xs-8">
                                <label for="colFormLabelLg" class="col-md-4 col-xs-4 col-form-label ">Flat No.</label>
                                <div class="col-md-8 col-xs-4">
                                    <input type="text" class="form-control " id="flatno" placeholder="FlatNo. " />
                                </div>
                            </div>
                            <div class="col-md-6 col-xs-8">
                                <label for="colFormLabelLg" class="col-md-4 col-xs-4 col-form-label ">Floor</label>
                                <div class="col-md-8 col-xs-4">
                                    <label class="form-control " id="floor" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-md-6 col-xs-8">
                                <label for="colFormLabelLg" class="col-md-4 col-xs-4 col-form-label ">Block</label>
                                <div class="col-md-8 col-xs-4">
                                    <label class="form-control " id="block" />
                                </div>
                            </div>
                            <div class="col-md-6 col-xs-8">
                                <label for="colFormLabelLg" class="col-md-4 col-xs-4 col-form-label ">Intercom </label>
                                <div class="col-md-8 col-xs-4">
                                    <label class="form-control form-control-lg" id="intercom" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-md-6 col-xs-8">
                                <label for="colFormLabelLg" class="col-md-4 col-xs-4 col-form-label ">Locality</label>
                                <div class="col-md-8 col-xs-4">
                                    <label class="form-control" id="locality4" />
                                </div>
                            </div>
                            <div class="col-md-6 col-xs-8">
                                <label for="colFormLabelLg" class="col-md-4 col-xs-4 col-form-label ">City</label>
                                <div class="col-md-8 col-xs-4">
                                    <label class="form-control " id="city2" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-md-6 col-xs-8">
                                <label for="colFormLabelLg" class="col-md-4 col-xs-4 col-form-label ">State</label>
                                <div class="col-md-8 col-xs-4">
                                    <input type="text" class="form-control " id="state3" placeholder="State " />
                                </div>
                            </div>
                            <div class="col-md-6 col-xs-8">
                                <label for="colFormLabelLg" class="col-md-4 col-xs-4 col-form-label ">PinCode</label>
                                <div class="col-md-8 col-xs-4">
                                    <label class="form-control " id="pincode4" />
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="panel-footer" style="text-align: right;">
                <div class="row">
                    <div class="col-xs-6">
                        <button type="button" class="btn btn-danger btn-sm" onclick="HideAddFlat()">Cancel</button>
                        <button type="button" class="btn btn-success btn-sm" onclick="AddIndependentHouse()">Submit</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Add Society Button -->
    <div id="addSociety" class="modal">
        <div class="panel panel-primary" style="border: 0px; width: 600px; background-color: #fff; margin: auto;">
            <div class="panel-heading">
                Add Society <span class="fa fa-times" style="float: right; cursor: pointer;" onclick="HideAddSociety()" aria-hidden="true"></span>
            </div>
            <div class="panel-body">
                <form class="AddSociety">
                    <div class="container-fluid">
                        <div class="form-group row">
                            <label for="colFormLabelLg" class="col-md-3 col-xs-4 col-form-label">Society Name</label>
                            <div class="col-md-8 col-xs-4">
                                <input type="text" name="society" class="form-control " id="societyName" tabindex="1" placeholder="Enter Society name" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-md-6 col-xs-12">
                                <label for="colFormLabelLg" class="col-md-4 col-xs-4 col-form-label">Locality</label>
                                <div class="col-md-8 col-xs-4">
                                    <input type="text" name="locality" class="form-control" id="socLocality" tabindex="2" placeholder="Locality " />
                                </div>
                            </div>
                            <div class="col-md-6 col-xs-12">
                                <label for="colFormLabelLg" class="col-md-4 col-xs-4 col-form-label ">City</label>
                                <div class="col-md-8 col-xs-4">
                                    <input type="text" name="city" class="form-control" id="socCity" tabindex="3" placeholder="City " />
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-md-6 col-xs-12">
                                <label for="colFormLabelLg" class="col-md-4 col-xs-4 col-form-label ">State</label>
                                <div class="col-md-8 col-xs-4">
                                    <input type="text" name="state" class="form-control " id="socState" tabindex="4" placeholder="State " />

                                </div>
                            </div>
                            <div class="col-md-6 col-xs-12">
                                <label for="colFormLabelLg" class="col-md-4 col-xs-4 col-form-label ">Pin Code</label>
                                <div class="col-md-8 col-xs-4">
                                    <input name="pincode" type="number" class="form-control " id="socPin" tabindex="5" placeholder="201301 " />
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="panel-footer" style="text-align: right;">
                <div class="row">
                    <div class="col-xs-6">
                        <button type="button" class="btn btn-danger btn-sm" onclick="HideAddSociety()">Cancel</button>
                        <button type="button" class="btn btn-success btn-sm" onclick="AddNewSociety()">Submit</button>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- WRAPPER -->

    <!-- /WRAPPER -->
    <%--    <section id="download" class="download">
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
    </section>--%>
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
