<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyHouse.aspx.cs" Inherits="MyHouse" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8"/>
   <meta name="viewport" content="width=device-width, initial-scale=1"/>
      
    <link href="Styles/MyFlat.css" rel="stylesheet" type="text/css" />
      <script src="Scripts/jquery-1.11.1.min.js"></script>
     
    <link rel="stylesheet" href="CSS/ApttTheme.css" />
    <link rel="stylesheet" href="CSS/ApttLayout.css" />

             <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
            <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
            <!-- jQuery library -->
            <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
   
            <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css"/>  

    <script>

        function InitiateRent() {
            $("#addTenantModal").show();
        }

        function CloseRentalBox() {
            $("#addTenantModal").hide();
        }


        const Inventory{ "1":"2BHK",
            "2": "3BHK",
            "3": "4BHK",
            "4":"Bed",
            "5": "Bed & Food",
            "6": "Floor"
        }

         const RentType{ "1":"Flat",
            "2": "PG",
            "3": "Studio",
            "4":"Independent",
            
        }
   
   
    </script>
      
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
    <div class="container-fluid">
        <div class="row">

            <div class="container-fluid">
                <div class="row" style="height: 40px;">
                    <div class="col-sm-3  col-xs-12">
                        <h3 class="pull-left ">My Flat:</h3>
                    </div>
                    <div class="col-sm-6 hidden-xs" style="padding: 0px;">
                    </div>
                    <div class="col-sm-3 hidden-xs" style="vertical-align: middle;">
                        <div>
                        </div>
                    </div>

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


                    <button type="button" class="btn btn-primary btn-sm" onclick="InitiateRent()">Add for Rent</button>

                </div>



                <div id="addTenantModal" class="modal">
                         <div class="modal-content" style="border: 0px solid;width: 550px; margin: auto;">

                             <div class="modal-header" style="color: white; background-color: #5ca6de; height: 50px;">
                                 <button type="button" id="Close_mod" class="close" onclick="CloseRentalBox()" style="color: #000;">&times;</button>
                                 <h4 id="title" class="modal-title" style="margin-top: 5px;">Available for Rent:
                                     <var>House Number</var></h4>
                             </div>

                             <div class="modal-body">

                                 <div class="row" style="margin-top: 5px; margin-bottom: 5px">
                                   
                                     <div class="col-sm-6">
                                         <label class="labelwidth">Type :</label>
                                         <select id="inAddTMobile" onblur="" style="width: 120px">
                                             <option >Independent House</option>
                                             <option >Flat</option>
                                             <option >PG-Shared</option>
                                             <option >Fully Furnished Room</option>
                                         </select>
                                     </div>
                                     <div class="col-sm-6">
                                         <label class="labelwidth">Rent: </label>
                                         <input id="inAddTEmailID" onblur="" style="width: 120px" />

                                     </div>


                                 </div>
                                 <hr />
                                 <div class="row" style="margin-top: 5px; margin-bottom: 5px">

                                     <div class="col-sm-6">
                                         <label class="labelwidth">Available from</label>
                                         <input id="startDate" style="width: 120px" class="txtbox_style" tabindex="2" />
                                     </div>
                                     <div class="col-sm-6">
                                         <label class="labelwidth">Lastname :</label>
                                         <input id="endDate" style="width: 120px" class="txtbox_style" tabindex="3" />
                                     </div>

                                 </div>
                             </div>

                             <div class="panel-footer" style="text-align: right;">
                                 <button type="button" id="btnCancel" style="margin-top: 5px;" onclick="CloseRentalBox()" data-dismiss="modal" class="btn btn-danger">Cancel</button>
                                 <button type="button" id="btnSubmit" style="margin-top: 5px;" onclick="AddUser();" class="btn btn-primary">Submit</button>

                             </div>
                         </div>

                     <div id="progressBar" class="container-fluid" style="text-align:center; height:200px;">
                        <img src="Images/Icon/ajax-loader.gif" style="width:20px;height:20px; margin-top:50px;" />
                    </div>
                     </div>

               </div>

               

            </div>


            </div>


</body>
</html>
