<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Rent.aspx.cs" Inherits="Rent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
     <!-- jQuery library -->
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
   

    <link rel="stylesheet" type="text/css" href="CSS/ApttLayout.css" />
    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css"/>  
    
            <link rel="stylesheet" href="CSS/forum.css"/>
             <link rel="stylesheet" href="CSS/ApttTheme.css" />


          

    <script>
          var api_url = "http://www.Kevintech.in/GAService/";
        $(document).ready(function () {
              populateType();
            populateSelect();
               $("#progressBar").hide();
      
        });

      
        
        function populateType() {
            // THE JSON ARRAY.
            var InventoryType = [
                { "ID": 1, "Value": "Flat" },
                { "ID": 2, "Value": "PG" },
                { "ID": 3, "Value": "Studio" },
                { "ID": 4, "Value": "Independent" },

            ];

            var ele = document.getElementById('selType');
            for (var i = 0; i < InventoryType.length; i++) {
                // POPULATE SELECT ELEMENT WITH JSON.
                ele.innerHTML = ele.innerHTML +
                    '<option value="' + InventoryType[i]['ID'] + '">' + InventoryType[i]['Value'] + '</option>';
            }

        }



        function populateSelect() {
            // THE JSON ARRAY.
            var Inventory = [
                { "ID": 1, "Value": "2BHK" },
                { "ID": 2, "Value": "3BHK" },
                { "ID": 3, "Value": "4BHK" },
                { "ID": 4, "Value": "Bed" },
                { "ID": 5, "Value": "Bed & Food" },
                { "ID": 6, "Value": "Floor" }
            ];

            var ele = document.getElementById('selStyle');
            for (var i = 0; i < Inventory.length; i++) {
                // POPULATE SELECT ELEMENT WITH JSON.
                ele.innerHTML = ele.innerHTML +
                    '<option value="' + Inventory[i]['ID'] + '">' + Inventory[i]['Value'] + '</option>';
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

            console.log(RentInventory);

            var url = api_url + "api/RentInventory/Find"

                $.ajax({
                dataType: "json",
                url: url,
                data: JSON.stringify(RentInventory),
                type: 'post',
                async: false,
                contentType: 'application/json',
                    success: function (data) {
                     $("#progressBar").hide();
                    //var da = JSON.stringify(data);
                    //var js = jQuery.parseJSON(da);
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


               /* strData = strData + "<div class=\"row result_row\" style=\"margin-top:20px;\">" +
                    "<div class='row desc-row'><div class='col-xs-8'>" + results[i].Inventory + " " + results[i].RentType + " is available in " + results[i].sector + "</div><div class='col-xs-4'></div></div>"
                    + "<div class='col-xs-4'> Expected Rent " + results[i].RentValue + "</div> <div class='col-xs-8'>" + results[i].Description + "</div>"
                    + "<div class='row owner-row'><div class='col-xs-12'> Owner" + results[i].OwnerName + ", " + results[i].MobileNo + "</div><hr size='2'></div></div>";*/

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
        <div class="container-fluid">

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

                        <nav class="nav-main mega-menu">
                            <ul class="nav nav-pills nav-main scroll-menu" id="topMain">
                                <li class=" active"><a class="menu_text" href="Login.aspx">Home</a></li>
                                <li class=" "><a class="menu_text" href="Aboutus.aspx">About Us</a></li>

                                <li class=" "><a class="menu_text" href="contact.aspx">Contact </a></li>

                            </ul>
                        </nav>
                    </div>

                    <!-- /Top Nav -->

                </div>
            </header>

            <div class="row jumbotron" style="background-color:#6094c1; height:200px;border-radius:0px;margin-bottom:0px;">
                <div class="col-sm-3 hidden-xs"></div>
                <div class="col-sm-6 col-xs-12" >
                    
                    <form class="form-group">
                        <select id="selType" placeholder="Type" runat="server" class="search-dropdown"/>
                        <select id="selStyle" placeholder="Style" runat="server" class="search-text"/>
                         <input id="txtCity" placeholder="City" runat="server" class="search-text"/>
                         <input id="txtRent" placeholder="Rent" runat="server" class="search-text"/>
                        <i  onclick="searchHouse()" class="search-button"> <span class="fa fa-search fa-2x" ></span></i>

                    </form>
                          <div class="col-sm-3 hidden-xs"></div>
                </div>


                </div>
            
             
            <div class="row result-area">
                
                <div class="col-sm-2 hidden-xs"></div>
                <div class="col-sm-8 col-xs-12">
                    <label id="lblMessage"></label>
                    <div id="searchData">
                           <%--<div class="row result_row" style="margin-top: 10px;">

                             <div class="col-xs-6" >
                                <div style="color: blue;">Nestin-properties from Owners only</div> 
                                 <div class="row">
                                     <div class="col-xs-4">
                                         <img class="property-image" src="Images/Icon/darkredbg.png" />
                                     </div>
                                     <div class="col-xs-8">
                                         <div style="margin-top:5px;">
                                             <b>Expected Rent:
                                       
                                             INR 5000  </b>
                                         </div>
                                         <div class="dropup" style="margin-top:5px;">
                                             Contact: <button class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                 Amit Kumar</button>
                                             <ul class="dropdown-menu" style="padding:5px;">
                                               <li> Mob: 9591033223</li>
                                                <li> Email: amit.bansal@anvisys.net</li>
                                              </ul>
                                         </div>
                                     </div>
                                 </div>
                             </div>


                             <div class="col-xs-6">
                                 <div class="col-xs-12"><b>3 BHK Flat</b><span class="normal-text"> is available in Sector 27</span></div>
                                 <div class="col-xs-12">
                                     <div class="col-xs-3  well well-sm" style="text-align: center">
                                         <div class="summary-title">Area </div>
                                         <div class="summary-text">1200sqft</div>
                                     </div>
                                     <div class="col-xs-3  well well-sm">
                                         <div class="summary-title">Status </div>
                                         <div class="summary-text">from 1st March</div>
                                     </div>
                                     <div class="col-xs-3  well well-sm">
                                         <div class="summary-title">Floor </div>
                                         <div class="summary-text">G of 2 </div>
                                     </div>
                                     <div class="col-xs-3  well well-sm">
                                         <div class="summary-title">Furnished</div>
                                         <div class="summary-text">none </div>
                                     </div>
                                 </div>
                                 <div class="col-xs-12">
                                     Non-Vegetarians, Without Company Lease
                                 </div>
                             </div>
                         
                        </div>
                         <div class="row result_row" style="margin-top: 10px;">

                             <div class="col-xs-6" >
                                <div style="color: blue;">Nestin-properties from Owners only</div> 
                                 <div class="row">
                                     <div class="col-xs-4">
                                         <img class="property-image" src="Images/Icon/darkredbg.png" />
                                     </div>
                                     <div class="col-xs-8">
                                         <div style="margin-top:5px;">
                                             <b>Expected Rent:
                                       
                                             INR 5000  </b>
                                         </div>
                                         <div class="dropup" style="margin-top:5px;">
                                             Contact: <button class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                 Amit Kumar</button>
                                             <ul class="dropdown-menu" style="padding:5px;">
                                               <li> Mob: 9591033223</li>
                                                <li> Email: amit.bansal@anvisys.net</li>
                                              </ul>
                                         </div>
                                     </div>
                                 </div>
                             </div>


                             <div class="col-xs-6">
                                 <div class="col-xs-12"><b>3 BHK Flat</b><span class="normal-text"> is available in Sector 27</span></div>
                                 <div class="col-xs-12">
                                     <div class="col-xs-3  well well-sm" style="text-align: center">
                                         <div class="summary-title">Area </div>
                                         <div class="summary-text">1200sqft</div>
                                     </div>
                                     <div class="col-xs-3  well well-sm">
                                         <div class="summary-title">Status </div>
                                         <div class="summary-text">from 1st March</div>
                                     </div>
                                     <div class="col-xs-3  well well-sm">
                                         <div class="summary-title">Floor </div>
                                         <div class="summary-text">G of 2 </div>
                                     </div>
                                     <div class="col-xs-3  well well-sm">
                                         <div class="summary-title">Furnished</div>
                                         <div class="summary-text">none </div>
                                     </div>
                                 </div>
                                 <div class="col-xs-12">
                                     Non-Vegetarians, Without Company Lease
                                 </div>
                             </div>
                         
                        </div>--%>
                    </div>
                </div>
                <div class="col-sm-2 hidden-xs"></div>
                </div>
               <div id="progressBar" class="container-fluid" style="text-align:center; height:200px;margin-top:100px;">
                    <img src="Images/Icon/ajax-loader.gif" style="width:100px;height:100px; margin-top:50px;" />
                </div>
        </div>
    </form>
</body>
</html>
