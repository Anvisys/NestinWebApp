<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyHouse.aspx.cs" Inherits="MyHouse" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link href="Styles/MyFlat.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.11.1.min.js"></script>

    <link rel="stylesheet" href="CSS/ApttTheme.css" />
    <link rel="stylesheet" href="CSS/ApttLayout.css" />

    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- jQuery library -->
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css" />

    <script>
        var api_url;
        var selectedInventory;
        $(document).ready(function () {

            api_url = '<%=Session["api_url"] %>';
            GetRentInventory();
        });

        function InitiateRent() {
            populateType();
            populateSelect();
            $("#addTenantModal").show();
        }

        function CloseRentalBox() {
            $("#addTenantModal").hide();

        }


        function populateType() {
            // THE JSON ARRAY.
            var InventoryType = [
                { "ID": 1, "Value": "Flat" },
                { "ID": 2, "Value": "PG" },
                { "ID": 3, "Value": "Studio" },
                { "ID": 4, "Value": "Independent" },

            ];

            var ele = document.getElementById('type');
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

            var ele = document.getElementById('inventory');
            for (var i = 0; i < Inventory.length; i++) {
                // POPULATE SELECT ELEMENT WITH JSON.
                ele.innerHTML = ele.innerHTML +
                    '<option value="' + Inventory[i]['ID'] + '">' + Inventory[i]['Value'] + '</option>';
            }
        }

        function GetRentInventory() {
            var UserID = <%=UserID%>;
                var HouseID =<%=HouseID%>;

            var url = api_url + "/api/RentInventory/Find/0/" + HouseID

            $.ajax({
                url: url,
                type: 'get',
                async: false,
                contentType: 'application/json',
                success: function (data) {


                    var obj = data.$values;
                    if (obj.length > 0) {

                        DisplayResults(obj)
                    }
                    else {

                    }

                },
                error: function (data, errorThrown) {
                    alert('User Creation failed :' + errorThrown);
                    // sessionStorage.clear();
                }

            });
        }

        function DisplayResults(results) {
            var strData = "";

            for (var i = 0; i < results.length; i++) {

                var FlatNo = results[i].FlatNumber;
                var HouseNo = results[i].HouseNumber;


                strData = strData + "<div class=\"row result_row\" style=\"margin-top:20px;\">" +
                    "<div class='row desc-row'><div class='col-xs-8'>" + results[i].Inventory + " " + results[i].RentType + " is available in " + results[i].sector + "</div><div class='col-xs-4'></div></div>"
                    + "<div class='col-xs-4'> Expected Rent " + results[i].RentValue + "</div> <div class='col-xs-8'>" + results[i].Description + "</div>"
                    + "<div class='row owner-row'><div class='col-xs-12'> Owner" + results[i].OwnerName + ", " + results[i].MobileNo + "</div><hr size='2'></div>" +
                    "<button type='button' class='btn btn-primary btn-sm' onclick='Close("+ results[i].RentInventoryID +",\"" + results[i].Inventory +"\")' >Close</button>"
                    +"</div>"

            }

            $("#inventoryData").html(strData);

        }


        function Close(RentInventoryID, Inventory) {
            selectedInventory = RentInventoryID;
            $("#lblInventory").val(Inventory);
            $("#updateDialog").show();
        };

        function CloseUpdateBox() {
             $("#updateDialog").hide();
        }

        function AddRentInventory() {

            var RentInventory = {};
            RentInventory.InventoryID = $("#inventory").val();
            RentInventory.RentTypeID = $("#type").val();
            RentInventory.RentValue = $("#inRent").val();
            RentInventory.Available = 1;
            RentInventory.Description = $("#description").val();
            RentInventory.ContactName = $("#contactName").val();
            RentInventory.ContactNumber = $("#contactNumber").val();
            RentInventory.UserID = <%=UserID%>;
                RentInventory.HouseID =<%=HouseID%>;
            RentInventory.FlatID = 0;

            console.log(RentInventory);
            var url = api_url + "/api/RentInventory/New"

            $.ajax({
                dataType: "json",
                url: url,
                data: JSON.stringify(RentInventory),
                type: 'post',
                async: false,
                contentType: 'application/json',
                success: function (data) {
                   
                      $("#updateDialog").hide();
                
                    var Response = data.Response;
                    if (Response == "OK") {
                        document.getElementById("lblMessage").innerHTML = "Your inventory is submitted for Rent";
                    }
                    else {
                        document.getElementById("lblMessage").innerHTML = "Could not submitt, Please contact admin";
                    }

                },
                error: function (data, errorThrown) {
                    alert('User Creation failed :' + errorThrown);
                    // sessionStorage.clear();
                }

            });
        }

        function UpdateInventory() {

              var InventoryUpdate = {};
            InventoryUpdate.InventoryId = selectedInventory;
            InventoryUpdate.Available = 0;
            
             var url = api_url + "/api/RentInventory/Close"
            console.log(InventoryUpdate);
            $.ajax({
                dataType: "json",
                url: url,
                data: JSON.stringify(InventoryUpdate),
                type: 'post',
                async: false,
                contentType: 'application/json',
                success: function (data) {
                    
                    alert(JSON.stringify(data));
                    var Response = data.Response;
                    if (Response == "OK") {
                        document.getElementById("lblMessage").innerHTML = "Your inventory is closedfor Rent";
                    }
                    else {
                        document.getElementById("lblMessage").innerHTML = "Could not submitt, Please contact admin";
                    }

                },
                error: function (data, errorThrown) {
                    alert('Inventory Closed failed :' + errorThrown);
                    // sessionStorage.clear();
                }

            });

        }

    </script>
    <style>
        .result_row {
            /* border-bottom: 1px solid #bfbfbf; */
            background-color: #c9c9c9;
            border-radius: 5px;
        }

        .desc-row {
            height: 30px;
            padding-left: 25px;
            text-size-adjust: auto;
            font-size: medium;
            font-weight: 200;
            color: red;
        }

        .owner-row {
            height: 40px;
            padding-left: 25px;
            text-size-adjust: auto;
            font-size: medium;
            font-weight: 200;
            color: blue;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>

    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-3  col-xs-12">
                <h3 class="pull-left ">My House:</h3>
            </div>
            <div class="col-sm-6 hidden-xs" style="padding: 0px;">
                <div id="HouseDetails" class="content_div">
                    <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                        <div class="col-sm-4">
                            <label class="data_heading">House Number :</label>
                            <label class="data_label" id="lblFlatNumber"><%= HouseNo%></label>
                        </div>
                        <div class="col-sm-4">
                            <label class="data_heading">Address :</label>
                            <label class="data_label" id="lblFlatFloor"><%= Address%></label>
                        </div>
                        <div class="col-sm-4">
                            <label class="data_heading">City :</label>
                            <label class="data_label" id="lblIntercomNumber"><%= City%></label>
                        </div>
                    </div>
                </div>

            </div>
            <div class="col-sm-3 hidden-xs" style="vertical-align: middle;">
            </div>
        </div>

        <div class="row">

            <div class="col-sm-2 hidden-xs"></div>
            <div class="col-sm-8 col-xs-12">
                <label id="lblMessage"></label>
                <button type="button" class="btn btn-primary btn-sm" onclick="InitiateRent()">Add for Rent</button>
                <div id="inventoryData"></div>

            </div>
            <div class="col-sm-4 hidden-xs"></div>
        </div>

        <div id="addTenantModal" class="modal">
            <div class="modal-content" style="border: 0px solid; width: 550px; margin: auto;">

                <div class="modal-header" style="color: white; background-color: #5ca6de; height: 50px;">
                    <button type="button" id="Close_mod" class="close" onclick="CloseRentalBox()" style="color: #000;">&times;</button>
                    <h4 id="title" class="modal-title" style="margin-top: 5px;">Available for Rent:
                                         <var>House Number</var></h4>
                </div>

                <div class="modal-body">

                    <div class="row" style="margin-top: 5px; margin-bottom: 5px">

                        <div class="col-sm-6">
                            <label class="labelwidth">Inventory :</label>
                            <select id="inventory" onblur="" style="width: 120px">
                            </select>
                        </div>
                        <div class="col-sm-6">
                            <label class="labelwidth">Type :</label>
                            <select id="type" onblur="" style="width: 120px">
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <label class="labelwidth">Rent: </label>
                            <input id="inRent" onblur="" style="width: 120px" />

                        </div>


                    </div>
                    <div class="row" style="margin-top: 5px; margin-bottom: 5px">

                        <div class="col-sm-6">
                            <label class="labelwidth">Description</label>
                            <input id="description" style="width: 120px" class="txtbox_style" tabindex="2" />
                        </div>
                        <div class="col-sm-6">
                            <label class="labelwidth">Contact Person:</label>
                            <input id="contactName" style="width: 120px" class="txtbox_style" tabindex="3" />
                        </div>

                    </div>
                    <hr />
                    <div class="row" style="margin-top: 5px; margin-bottom: 5px">

                        <div class="col-sm-6">
                            <label class="labelwidth">Contact Number:</label>
                            <input id="contactNumber" style="width: 120px" class="txtbox_style" tabindex="3" />
                        </div>
                        <div class="col-sm-6">
                            <label class="labelwidth">Lastname :</label>
                            <input id="endDate" style="width: 120px" class="txtbox_style" tabindex="3" />
                        </div>

                    </div>
                </div>

                <div class="panel-footer" style="text-align: right;">
                    <button type="button" id="btnCancel" style="margin-top: 5px;" onclick="CloseRentalBox()" data-dismiss="modal" class="btn btn-danger">Cancel</button>
                    <button type="button" id="btnSubmit" style="margin-top: 5px;" onclick="AddRentInventory();" class="btn btn-primary">Submit</button>

                </div>
            </div>

            <div id="progressBar" class="container-fluid" style="text-align: center; height: 200px;">
                <img src="Images/Icon/ajax-loader.gif" style="width: 20px; height: 20px; margin-top: 50px;" />
            </div>
        </div>

        <div id="updateDialog" class="modal">
            <div class="modal-content" style="border: 0px solid; width: 550px; margin: auto;">

                <div class="modal-header" style="color: white; background-color: #5ca6de; height: 50px;">
                    <button type="button" id="Close_Update" class="close" onclick="CloseUpdateBox()" style="color: #000;">&times;</button>
                    <h4 id="updateTitle" class="modal-title" style="margin-top: 5px;">Update:
                                       </h4>
                </div>

                <div class="modal-body">

                    <div class="row" style="margin-top: 5px; margin-bottom: 5px">

                        <div class="col-sm-12">
                            <label class="labelwidth">Confirn following Inventory is not available:</label>
                            
                        </div>
                        <div class="col-sm-12">
                            <label id="lblInventory" class="labelwidth"></label>
                            
                        </div>
                    </div>
                  
                  
                 
                </div>

                <div class="panel-footer" style="text-align: right;">
                    <button type="button" id="btnUpdateCancel" style="margin-top: 5px;" onclick="CloseUpdateBox()" data-dismiss="modal" class="btn btn-danger">Cancel</button>
                    <button type="button" id="btnUpdateSubmit" style="margin-top: 5px;" onclick="UpdateInventory();" class="btn btn-primary">Submit</button>

                </div>
            </div>

            <div id="updateProgressBar" class="container-fluid" style="text-align: center; height: 200px;">
                <img src="Images/Icon/ajax-loader.gif" style="width: 20px; height: 20px; margin-top: 50px;" />
            </div>
        </div>

    </div>


</body>
</html>
