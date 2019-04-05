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

    <link href="Login/css/settings.css" rel="stylesheet" type="text/css" />
    <!-- THEME CSS -->

   <%-- <link href="Login/css/essentials.css" rel="stylesheet" type="text/css" />--%>
    <link href="Login/css/layout.css" rel="stylesheet" type="text/css" />
    <link href="Login/css/layout-responsive.css" rel="stylesheet" type="text/css" />

    <link href="Styles/layout.css" rel="stylesheet" />
    <link href="Styles/Responsive.css" rel="stylesheet" />

    <link rel="stylesheet" href="CSS/ApttTheme.css" />
    <link rel="stylesheet" href="CSS/ApttLayout.css" />
    <link rel="stylesheet" href="Login/CSS/footer.css" />


    <script type="text/javascript" src="Scripts/datetime.js"></script>


    <script>

        var UserId;
        var selectedSocietyId=0;
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
                        data: '{Society: '  + JSON.stringify(param)  + '}',
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
                                    socID:value.SocietyID
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
                                    flatId : value.ID
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
    
            console.log(House);
            $.ajax({
                type: 'POST',
                url: "Role.aspx/AddHouse",
                data: '{house: ' + JSON.stringify(House) + '}',
                contentType: "application/json; charset=utf-8",
                    async: false,
                 dataType: "json",
                success: function (response) {
                  // document.getElementById("post_loading").style.display = "none";
                    if (response.d >0) {
                            window.location = "main.aspx";
                    }
                   else if (response.d <0) {
                            alert('House number is in use');
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
             $("#ProgressBar").hide();

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
                    if (response.d >0) {
                            window.location = "main.aspx";
                    }
                    else if (response.d <0) {
                            alert('House number is in use');
                    }
                     else 
                    {
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

            $.ajax({
                url: abs_url,
                dataType: "json",
                success: DisplayFlats,
                failure: function (response) {
                    alert(response.d);
                    sessionStorage.clear();
                }
            });
        }

          function DisplayFlats(response) {

            var strData = "";
            $("#FlatRequests").html(strData);
            var results = response.$values;// jQuery.parseJSON(response.$values);
            console.log(results);
            if (results.length > 0) {
                for (var i = 0; i < results.length; i++) {

                    var reqDate = DisplayDateOnly(results[i].ActiveDate);
                     var modDate = DisplayDateOnly(results[i].DeActiveDate);
                                     
                    strData = strData + "<div class=\"row\" style=\"margin:20px;padding:0px;\">" +
                        "<div class='col-xs-1'>" + results[i].SocietyID + "</div>" +
                        "<div class='col-xs-5'> " + results[i].FlatNumber + "," + results[i].Status+ "<br/> Address:" +
                         results[i].SocietyName + ", " +  results[i].Address+
                        "</div>" +
                        "<div class='col-xs-2'> Requested On:" +  reqDate + "</div>" +
                        "<div class='col-xs-2'>Modified On :" + modDate + "</div>" +
                          "<div class='col-xs-2'> Status: <br/>" + results[i].Status + "</div>" 

                        //"<div class='panel-heading'>" + results[i].SocietyID + "<br/>: " + results[i].SocietyName + " <br/> Return " + results[i].Sector + "</div>"
                        //+ "<div class='panel-body'> City " + results[i].City
                        //+ "<div> State" + results[i].State + "</div>"
                        //   + "</div>"
                        + "</div>";
                    
                }
                
                $("#FlatRequests").html(strData);

            }
            else {

            }

        }


        function GetMySocietyRequests() {
            $("#ProgressBar").show();
            var abs_url = api_url + "/api/Society/" + <%=UserID%>;

            $.ajax({
                url: abs_url,
                dataType: "json",
                success: SocietyRequest,
                failure: function (response) {
                    alert(response.d);
                    sessionStorage.clear();
                }
            });
        }

        function SocietyRequest(response) {
            $("#ProgressBar").show();
            var strData = "";
            $("#SocietyRequests").html(strData);
            var results = response.$values;// jQuery.parseJSON(response.$values);
            console.log(results);
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

            }
            $("#ProgressBar").hide();
        }


        function GetMyHouses() {
            
            var abs_url = api_url + "/api/Society/House/" + <%=UserID%>;

            $.ajax({
                url: abs_url,
                dataType: "json",
                success: HouseRequests,
                failure: function (response) {
                    alert(response.d);
                    sessionStorage.clear();
                }
            });
        }


        function HouseRequests(response) {
            $("#ProgressBar").show();
            var strData = "";
            $("#HouseRequests").html(strData);
            var results = response.$values;// jQuery.parseJSON(response.$values);
            console.log(results);
            if (results.length > 0) {
                for (var i = 0; i < results.length; i++) {

                    var actDate = DisplayDateOnly(results[i].ActiveDate);
                    var inactDate = DisplayDateOnly(results[i].DeActiveDate);

                    strData = strData + "<div class=\"row\" style=\"margin:20px;padding:0px;\">"
                        + "<div class='col-xs-2'>ResId:" + results[i].ResID + "</div>"
                        + "<div class='col-xs-4'>" + results[i].HouseNUmber + "<br/>: " + results[i].Sector + ", " + results[i].City + ", " + results[i].State + "</div>"
                        + "<div class='col-xs-2'> Active " + actDate + "</div>"
                        + "<div class='col-xs-2'> Active Till" + inactDate + "</div>"
                        + "<div class='col-xs-2'></div>"
                        + "</div>";

                }

                $("#HouseRequests").html(strData);

            }
            else {

            }
            $("#ProgressBar").hide();
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

        function Click(ResId, status) {

            if (status = 0) {
                alert("Call Admin for Approval");
            }
            else {
                window.location = "MainPage.aspx?Res=" + ResId;
                alert("Go To Main Page");
            }
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


    </script>
      <style>

        .hiddencol{
            display:none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
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
                                            <li id="linkDashboard" ><a  href="MainPage.aspx">Dashboard</a></li>
                                            <li><asp:LinkButton  ID="btnlogout" runat="server" Text="Logout" OnClick="btnlogout_Click"></asp:LinkButton></li> 
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                            <!-- /Top Nav -->

                        </div>
                    </header>
      
        
        <div style="margin-top:100px;">

        <asp:GridView ID="gridViewRequests" runat="server"
               AutoGenerateColumns="false" OnRowDataBound="gridRequest_DataBound"
            
            >
              <Columns>
                                <%--<asp:BoundField DataField="FlatNumber" HeaderText="Flat" />--%>
                                <asp:TemplateField HeaderStyle-Width="50px">
                                <HeaderTemplate>
                                      <asp:Label ID="lblFlat" runat="server" Text="Flat"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <label  onclick='<%# "Click(" + Eval("ResID")+","+Eval("Status")+")" %>'  class="BillActiveGrid"> 
                                        <%# Eval("FlatNumber") %> 

                                    </label>
                                </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="SocietyName" HeaderStyle-Width="100px" HeaderText="Society"/>
                                <asp:BoundField DataField="FlatNumber" HeaderStyle-Width="40px" HeaderText="Flat"  ItemStyle-Width="40px"/>
                                <asp:BoundField DataField="ActiveDate" DataFormatString="{0:dd/MMM/yy}" HeaderStyle-Width="100px" HeaderText="Active From"/>
                                <asp:BoundField DataField="DeActiveDate" DataFormatString="{0:dd/MMM/yy}" HeaderStyle-Width="100px" HeaderText="Active Till"/>
                                <asp:BoundField DataField="Status" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hiddencol" />
                            <asp:BoundField DataField="Status" HeaderStyle-Width="100px" HeaderText="Status"/>
                            </Columns>
                            <EmptyDataRowStyle BackColor="#EEEEEE" />
                            <HeaderStyle BackColor="#0065A8" Font-Bold="false" Font-Names="Modern" Font-Size="Small" ForeColor="White" Height="30px" />
             
                </asp:GridView>

                </div>



                 <div class="container-fluid" id="flat_Request" style="margin:50px;">
                      <div class="row">
                    <div class="col-xs-10"><h4 style="margin-bottom:0px;"> My Flats </h4></div>
                     <div class="col-xs-2"><button class="btn btn-primary btn-sm" onclick="NewFlat()" type="button">New Flat</button></div>
                          </div>
                   <div class="row" id="FlatRequests" style="border-top: solid 1px black"></div>
                </div>

                 <div class="container-fluid" id="society_Request" style="margin:50px;">
                     <div class="row">
                     <div class="col-xs-10"><h4 style="margin-bottom:0px;" > My Societies </h4></div>
                     <div class="col-xs-2"><button class="btn btn-primary btn-sm" onclick="NewSociety()" type="button">New Society</button></div>
                         </div>
                   <div class="row" id="SocietyRequests" style="border-top: solid 1px black"></div>
                </div>

            <div class="container-fluid" id="House_Requests" style="margin:50px;">
                <div class="row">
                    <div class="col-xs-10"><h4 style="margin-bottom:0px;">  My Independent House</h4></div>
                <div class="col-xs-2"><button class="btn btn-primary btn-sm" onclick="NewHouse()" type="button">New House</button></div>
                    </div>
                   <div class="row" id="HouseRequests" style="border-top: solid 1px black"></div>
                </div>


      
          
                
        <div id="addHouse" class="modal">
            <div class="panel panel-primary" style="border: 0px; width: 670px; background-color: #fff; margin: auto;">
                <div class="panel-heading">
                    Add House<span class="fa fa-times" style="float: right; cursor: pointer;" onclick="HideAddHouse()" aria-hidden="true"></span>
                </div>
                <div class="panel-body">
                    <form class="AddNewHouse" autocomplete="off">
                        <div class="container-fluid">
                            <div class="form-group row">
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-4 col-form-label ">House No.</label>
                                    <div class="col-sm-8">
                                        <input type="number" name="house" class="form-control " id="houseno" placeholder="001" />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-4 col-form-label ">Sector</label>
                                    <div class="col-sm-8">
                                        <input type="text" name="Sector" class="form-control " id="sector" placeholder="Eg.sector-63" />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-4 col-form-label ">Locality</label>
                                    <div class="col-sm-8">
                                        <input type="text" name="Locality" class="form-control" id="locality" placeholder="Locality " />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-4 col-form-label ">City</label>
                                    <div class="col-sm-8">
                                        <input type="text" name="City" class="form-control " id="city" placeholder="Eg.Noida " />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-4 col-form-label ">State</label>
                                    <div class="col-sm-8">
                                        <input type="text" name="State" class="form-control " id="state" placeholder="State" />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-4 col-form-label ">Pin Code</label>
                                    <div class="col-sm-8">
                                        <input type="number" name="PinCode" class="form-control " id="pincode" placeholder="201301" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="panel-footer" style="text-align: right;">
                    <button type="button" class="btn btn-danger btn-sm" onclick="HideAddHouse()">Cancel</button>
                    <button type="button" class="btn btn-success btn-sm" onclick="AddInExistingSociety()">Submit</button>
                </div>

            </div>
        </div>
               
                   

               <%-- <div class="layout_modal_footer" style="margin-right:7px;">
                    <button type="button" class="btn btn-success" onclick="AddUser()" id="btnsubmit" disabled="individual.house.$disabled || individual.Sector.$disabled">
                    Submit</button>--%>

        <div id="addFlat" class="modal">
            <div class="panel panel-primary" style="border: 0px; width: 670px; background-color: #fff; margin: auto;">
                <div class="panel-heading">
                    Add Flat<span class="fa fa-times" style="float: right; cursor: pointer;" onclick="HideAddFlat()" aria-hidden="true"></span>
                </div>
                <div class="panel-body">
                    <form class="Addflat">
                        <div class="container-fluid">
                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label ">Select Your Society</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control " placeholder="Society" id="selectSociety" />

                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-4 col-form-label ">Flat No.</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control " id="flatno" placeholder="FlatNo. " />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-4 col-form-label ">Floor</label>
                                    <div class="col-sm-8">
                                        <label class="form-control " id="floor" />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-4 col-form-label ">Block</label>
                                    <div class="col-sm-8">
                                        <label class="form-control " id="block" />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-4 col-form-label ">Intercom </label>
                                    <div class="col-sm-8">
                                        <label class="form-control form-control-lg" id="intercom" />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-4 col-form-label ">Locality</label>
                                    <div class="col-sm-8">
                                        <label class="form-control" id="locality4" />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-4 col-form-label ">City</label>
                                    <div class="col-sm-8">
                                        <label class="form-control " id="city2" />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-4 col-form-label ">State</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control " id="state3" placeholder="State " />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-4 col-form-label ">PinCode</label>
                                    <div class="col-sm-8">
                                        <label class="form-control " id="pincode4" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="panel-footer" style="text-align: right;">
                    <button type="button" class="btn btn-danger btn-sm" onclick="HideAddFlat()">Cancel</button>
                    <button type="button" class="btn btn-success btn-sm" onclick="AddInExistingSociety()">Submit</button>
                </div>
            </div>
        </div>

        <div id="addSociety" class="modal">

            <div class="panel panel-primary" style="border: 0px; width: 600px; background-color: #fff; margin: auto;">
                <div class="panel-heading">
                    Add Society <span class="fa fa-times" style="float: right; cursor: pointer;" onclick="HideAddSociety()" aria-hidden="true"></span>
                </div>
                <div class="panel-body">
                    <form class="AddSociety">
                        <div class="container-fluid">
                            <div class="form-group row">
                                <label for="colFormLabelLg" class="col-sm-3 col-form-label ">Society Name</label>
                                <div class="col-sm-9">
                                    <input type="text" name="society" class="form-control " id="societyName" placeholder="Enter Society name" />
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-4 col-form-label ">Locality</label>
                                    <div class="col-sm-8">
                                        <input type="text" name="locality" class="form-control" id="socLocality" placeholder="Locality " />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-4 col-form-label ">City</label>
                                    <div class="col-sm-8">
                                        <input type="text" name="city" class="form-control" id="socCity" placeholder="City " />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-4 col-form-label ">State</label>
                                    <div class="col-sm-8">
                                        <input type="text" name="state" class="form-control " id="socState" placeholder="State " />

                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-4 col-form-label ">Pin Code</label>
                                    <div class="col-sm-8">
                                        <input name="pincode" class="form-control " id="socPin" placeholder="201301 " />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="panel-footer" style="text-align: right;">
                    <button type="button" class="btn btn-danger btn-sm" onclick="HideAddSociety()">Cancel</button>
                    <button type="button" class="btn btn-success btn-sm" onclick="AddNewSociety()">Submit</button>
                </div>

            </div>
        </div>

         <div id="ProgressBar" class="container-fluid" style="text-align: center; height: 200px;">
                <img src="Images/Icon/ajax-loader.gif" style="width: 40px; height: 40px;" />
            </div>


</form>


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
