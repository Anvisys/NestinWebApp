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

        var UserId;
        var selectedSocietyId=0;
        var selectedFlatId = 0;

        $(document).ready(function () {
          let params = (new URL(document.location)).searchParams;
            UserId = params.get("name");

            
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

          function onSociety_select(e,ui) {   
         
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

                            if (document.getElementById('Div1').style.display == 'none')
                            {
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

        function AddIndependentHouse() {
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
                 dataType: "json",
                success: function (response) {
                   document.getElementById("post_loading").style.display = "none";
                    if (response.d >0) {
                            window.location = "main.aspx";
                    }
                    if (response.d <0) {
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

        }


      function  AddInExistingSociety(){
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
                    else 
                    {
                        alert('Request could not be submitted');
                    }

                },
                error: function (data, errorThrown) {
                    document.getElementById("post_loading").style.display = "none";
                        alert('Error Updating comment, try again');
                
                  
                }
            });
        }


    </script>

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
                                            <li class=" active"><a class="menu_text" href="Login.aspx">Home</a></li>
                                            <asp:LinkButton ID="btnlogout" runat="server" Text="Logout" OnClick="btnlogout_Click"></asp:LinkButton>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                            <!-- /Top Nav -->

                        </div>
                    </header>
        <div style="margin-top:100px;">

        <asp:GridView ID="gridViewRequests" runat="server"
            
            
            >
              <Columns>
                                <%--<asp:BoundField DataField="FlatNumber" HeaderText="Flat" />--%>
                                <asp:TemplateField HeaderStyle-Width="50px">
                                <HeaderTemplate>
                                    <asp:Label ID="lblFlat" runat="server" Text="Request"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkFlatNumber" runat="server" CssClass="BillActiveGrid"  Font-Bold="true" Font-Underline="true" ForeColor="#0066cc" 
                                        Text='<%# Bind("FlatNumber") %>'></asp:LinkButton>
                                </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="SocietyName" HeaderStyle-Width="100px" HeaderText="Society"/>
                                <asp:BoundField DataField="FlatNumber" HeaderStyle-Width="40px" HeaderText="Flat"  ItemStyle-Width="40px"/>
                                <asp:BoundField DataField="ActiveDate" HeaderStyle-Width="100px" HeaderText="Date"/>
                              <%--  <asp:BoundField DataField="Status" HeaderStyle-Width="40px" HeaderText="Status"  ItemStyle-Width="40px"/>--%>
                                
                              
                            </Columns>
                            <EmptyDataRowStyle BackColor="#EEEEEE" />
                            <HeaderStyle BackColor="#0065A8" Font-Bold="false" Font-Names="Modern" Font-Size="Small" ForeColor="White" Height="30px" />
             
        </asp:GridView>

        </div>
        <div class="container-fluid">
            <div class="col-xs-3"></div>
            <div class="col-xs-6">
                        <div class="form-group row" style="margin-top:100px;">
                            <label class="col-sm-3 col-form-label col-form-label-lg">Select Your Purpose</label>
                            <div class="col-sm-9">
                                <select class="form-control" id="sel1">
                                    <option>Select</option>
                                    <option value="individualHouse">Independent House</option>
                                    <option value="existingSociety">Enroll in Exisiting Society</option>
                                    <option value="RequesttoAdd">Request for New Society Registration</option>

                                </select>

                            </div>
                        </div>


                        <div id="individualHouse" class="content" style="display: none">
                            <div class="form-group row">
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-6 col-form-label col-form-label-lg">House No.</label>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control form-control-lg" id="houseno" placeholder="Eg.82 " />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-5 col-form-label col-form-label-lg">Sector</label>
                                    <div class="col-sm-7">
                                        <input type="text" class="form-control form-control-lg" id="sector" placeholder="Eg.sector-63 " />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-6 col-form-label col-form-label-lg">Locality</label>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control form-control-lg" id="locality" placeholder="Locality " />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-5 col-form-label col-form-label-lg">City</label>
                                    <div class="col-sm-7">
                                        <input type="text" class="form-control form-control-lg" id="city" placeholder="Eg.Noida " />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-6 col-form-label col-form-label-lg">State</label>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control form-control-lg" id="state" placeholder="State " />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <label for="colFormLabelLg" class="col-sm-5 col-form-label col-form-label-lg">Pin Code</label>
                                    <div class="col-sm-7">
                                        <input type="text" class="form-control form-control-lg" id="pincode" placeholder="Eg.201301 " />
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-9">
                                <button type="button" onclick="AddIndependentHouse()" id="btnfinalsubmit" class="btn btn-default">Submit</button>

                            </div>
                        </div>

                        <div id="existingSociety" class="content" style="display: none">
                            <div class="form-group row">
                                <label class="col-sm-3 col-form-label col-form-label-lg">Select Your Society</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control form-control-lg" placeholder="Society" id="selectSociety"/>
                                     
                                </div>
                            </div>
                                <div class="form-group row">
                                <div class="col-sm-6">
                               <label for="colFormLabelLg" class="col-sm-6 col-form-label col-form-label-lg">Flat No.</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control form-control-lg" id="flatno" placeholder="State " />
                                </div>
                                </div>
                                 <div class="col-sm-6">
                               <label for="colFormLabelLg" class="col-sm-5 col-form-label col-form-label-lg">floor</label>
                                <div class="col-sm-7">
                                    <label class="form-control form-control-lg" id="floor" />
                                </div>
                                </div>
                            </div>
                                <div class="form-group row">
                                <div class="col-sm-6">
                               <label for="colFormLabelLg" class="col-sm-6 col-form-label col-form-label-lg">Block</label>
                                <div class="col-sm-6">
                                    <label class="form-control form-control-lg" id="block" />
                                </div>
                                </div>
                                 <div class="col-sm-6">
                               <label for="colFormLabelLg" class="col-sm-5 col-form-label col-form-label-lg">Intercom No.</label>
                                <div class="col-sm-7">
                                    <label class="form-control form-control-lg" id="intercom" />
                                </div>
                                </div>
                            </div>
                               <div class="form-group row">
                                <div class="col-sm-6">
                               <label for="colFormLabelLg" class="col-sm-6 col-form-label col-form-label-lg">Locality</label>
                                <div class="col-sm-6">
                                    <label class="form-control form-control-lg" id="locality4"  />
                                </div>
                                </div>
                                 <div class="col-sm-6">
                               <label for="colFormLabelLg" class="col-sm-5 col-form-label col-form-label-lg">City</label>
                                <div class="col-sm-7">
                                    <label  class="form-control form-control-lg" id="city2"  />
                                </div>
                                </div>
                            </div>
                                <div class="form-group row">
                                <div class="col-sm-6">
                               <label for="colFormLabelLg" class="col-sm-6 col-form-label col-form-label-lg">State</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control form-control-lg" id="state3" placeholder="State " />
                                </div>
                                </div>
                                 <div class="col-sm-6">
                               <label for="colFormLabelLg" class="col-sm-5 col-form-label col-form-label-lg">Pin Code</label>
                                <div class="col-sm-7">
                                    <label class="form-control form-control-lg" id="pincode4" />
                                </div>
                                </div>
                                    <div class="col-xs-12">
                                        <button type="button" class="btn btn-success btn-sm" onclick="AddInExistingSociety()">Submit</button>
                                    </div>
                            </div>



                        </div>

                        <div id="RequesttoAdd" class="content" style="display: none">
                            <div class="form-group row">
                                <label for="colFormLabelLg" class="col-sm-3 col-form-label col-form-label-lg">Society Name</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control form-control-lg" id="societyname" placeholder="Enter Society name" />
                                </div>
                            </div>
                           <div class="form-group row">
                                <div class="col-sm-6">
                               <label for="colFormLabelLg" class="col-sm-6 col-form-label col-form-label-lg">Locality</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control form-control-lg" id="locality1" placeholder="Locality " />
                                </div>
                                </div>
                                 <div class="col-sm-6">
                               <label for="colFormLabelLg" class="col-sm-5 col-form-label col-form-label-lg">City</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control form-control-lg" id="city1" placeholder="City " />
                                </div>
                                </div>
                            </div>
                                <div class="form-group row">
                                <div class="col-sm-6">
                               <label for="colFormLabelLg" class="col-sm-6 col-form-label col-form-label-lg">State</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control form-control-lg" id="state1" placeholder="State " />
                                </div>
                                </div>
                                 <div class="col-sm-6">
                               <label for="colFormLabelLg" class="col-sm-5 col-form-label col-form-label-lg">Pin Code</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control form-control-lg" id="pincode2" placeholder="Eg.201301 " />
                                </div>
                                </div>
                            </div>
                              <label class="col-sm-3 col-form-label col-form-label-lg"></label>
                           
                        </div>


                        <div class="form-group row">
                          

                        </div>
                 </div>
                 <div class="col-xs-3"></div>
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
