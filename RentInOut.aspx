<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RentInOut.aspx.cs" Inherits="RentInOut" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <meta charset="utf-8"/>
   <meta name="viewport" content="width=device-width, initial-scale=1"/>
      
   <%-- <link href="Styles/MyFlat.css" rel="stylesheet" type="text/css" />--%>
      <script src="Scripts/jquery-1.11.1.min.js"></script>
     
    <link rel="stylesheet" href="CSS/ApttTheme.css" />
    <link rel="stylesheet" href="CSS/ApttLayout.css" />
     <link rel="stylesheet" href="CSS/NewAptt.css" />

             <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
            <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
            <!-- jQuery library -->
            <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
   
            <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css"/>  
    
    <script>

          var UserId,SocietyID,api_url, selectedInventoryID;
       

        $(document).ready(function () {
            window.parent.FrameSourceChanged();
            UserId = <%=UserID %>;
            SocietyID = '<%=Session["SocietyID"] %>';
             api_url = '<%=Session["api_url"] %>';
            GetRentInventory();

        });


        function GetRentInventory() {
            var abs_url = api_url + "/api/RentInventory/" + SocietyID+"/1/5";
            console.log(abs_url);
             $.ajax({
                url: abs_url,
                dataType: "json",
                success: ShowRentInventory,
                failure: function (response) {
                    alert(response.d);
                    sessionStorage.clear();
                }
            });

        };


        function ShowRentInventory(results) {
            console.log(results);
               $("#ProgressBar").hide();
       var  js=  JSON.stringify(results);
              var strData = "";

       //     var js = response.$values;
       

            if (results.length > 0) {
                for (var i = 0; i < results.length; i++) {
                          var ImageSource = "GetImages.ashx?UserID=" + js[i].UserID + "&Name=" + results[i].ContactName + "&UserType= Owner";

                    strData = strData + "<div class=\"col-sm-3 col-xs-12 panel panel-success \" style=\"margin:20px;padding:0px; \">" +
                        "<div class='panel-heading'>" 
                        +"<div class='row'><div class='col-sm-8 col-xs-12'>"
                        + " <label class='data_label'>Inventory  :  </label>" + results[i].InventoryType
                        + "<br/><label class='data_label'> Type : </label>" + results[i].AccomodationType + "<br/><label class='data_label'>Rent : </label>"
                        + results[i].RentValue

                        +"</div><div class='col-sm-4 col-xs-12'>"
                        +"<img class='profile-image' src='" + ImageSource + "' />" 

                        + "</div></div></div>"


                        + "<div class='panel-body'> <span style='color:#006400;'></span>" + results[i].Description +"<hr style='margin:5px;paddiing:0px;'/>"
                        + "<div> <label class='data_label'> <span class='fa fa-user' style='color:#2b7a2d;'> </label>" + results[i].ContactName + "</div>"

                    

                        + "<div> <label class='data_label'> <span class='fa fa-phone' style='color:#2b7a2d;'></span>  </label>" + results[i].ContactNumber + "</div>"
                        + "<div> <label class='data_label'> <span class='fa fa-home' style='color:#2b7a2d;'></span> </label>" + results[i].FlatNumber + "</div>"

                        
                        + "</div>"

                        + "<div class='panel-footer'><a onclick='ShowInterest(" + results[i].RentInventoryID+"," +  results[i].UserID + ")'><span class='fa fa-thumbs-up'></span></a>" + results[i].InterestedCount
                        + "</div>"
                        + "</div>";
                }

            }
            else {
                strData = "No Rent Information Available!!";

            }
              $("#RentInView").html(strData);

        }

        function ShowInterest(RentInventoryID, HostId) {
            selectedInventoryID = RentInventoryID;
            if (HostId == UserId) {
                alert("!This is your own Inventory, Select another one.");
            }
            else {
                 $("#showInterestModal").show();
            }

        }

        function CloseInterestModal() {
              $("#showInterestModal").hide();
        }

        function AddInterest() {
                        var RentInterest = {};
            RentInterest.InventoryID = selectedInventoryID;
            RentInterest.InterestedUserId = <%=UserID%>;
            RentInterest.DealStatus = 1;
            RentInterest.Comments = $("#in_comments").val();

            var url = api_url + "/api/RentInventory/Add/Interest";
            var carPoolInterestData = JSON.stringify(RentInterest);
            console.log(carPoolInterestData);
            $.ajax({
                dataType: "json",
                url: url,
                data: carPoolInterestData,
                type: 'post',
                async: false,
                contentType: 'application/json',
                success: function (data) {

                    $("#showInterestModal").hide();
                    document.location.reload();
                },
                error: function (data, errorThrown) {
                    alert('User Creation failed :' + errorThrown);
                    // sessionStorage.clear();
                }

            });
        }


    </script>

    <style>
             .card {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
  max-width: 300px;
  margin: auto;
  text-align: center;
  font-family: arial;
  background-color:#fff;
}

             
      .model {
            display: none;  /*  Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 100; /* Sit on top */
            padding-top: 8%; /* Location of the box */
             padding-bottom: 2%;
            left: 0px;
            border-radius:5px;
            top: 0px;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto;  /*Enable scroll if needed  */
            background-color: #e6e2e2;
            background-color: rgba(0,0,0,0.4); 
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align:center">
        </div>
    </form>
     <div class="container-fluid"> 
         <div class="row" id="RentInView"></div>

     </div>
     <div id="ProgressBar" class="container-fluid" style="text-align: center; height: 200px;">
             <i class="fa fa-spinner fa-pulse fa-3x fa-fw" style="margin-top: 200px;"></i>
                <%--<img src="Images/Icon/ajax-loader.gif" style="width: 40px; height: 40px; margin-top: 250px;" />--%>
            </div>


    <div id="showInterestModal" class="model">
            <div class="modal-content" style="border-radius:5px; width: 350px; margin: auto; margin-top:150px;">
                <div class="modal-header" style="color: white; background-color: #337ab7; height: 50px;">
                    <i class="fa fa-close" style="float:right;cursor:pointer;" onclick="CloseInterestModal()"></i>
                    <h4 id="interestClose" class="modal-title" style="margin-top: 5px;font-family:Helvetica Neue,Helvetica,Arial,sans-serif; font-size:14px">I am Interested</h4>
                </div>

                <div class="modal-body">
                  

                    <div class="row" style="margin-top: 10px; margin-bottom: 10px">

                        <div class="col-sm-12">
                            <label class="labelwidth col-sm-4 col-form-label ">Comments:</label>
                         <div class="col-sm-8">
                            <input id="in_comments" class="form-control rows="2" form-control-sm" tabindex="2" />
                        </div>
                        </div>
                    </div>
                </div>

                <div class="panel-footer" style="text-align: right;">
                    <button type="button" id="btnInterestCancel" style="margin-top: 5px;" onclick="CloseInterestModal()" data-dismiss="modal" class="btn btn-danger">Cancel</button>
                    <button type="button" id="btnInterestSubmit" style="margin-top: 5px;" onclick="AddInterest();" class="btn btn-primary">Submit</button>

                </div>
            </div>

            <div id="intrestProgressBar" class="container-fluid" style="text-align: center; height: 200px; display:none">
                <img src="Images/Icon/ajax-loader.gif" style="width: 20px; height: 20px; margin-top: 50px;" />
            </div>
        </div>


</body>
</html>
