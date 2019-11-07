<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SocietyDetails.aspx.cs" Inherits="SocietyDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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

    <script>


        var SocID;

        $(document).ready(function () {
                api_url = '<%=Session["api_url"] %>';
          SocID = getUrlVars()["SocID"];
               
           // filladmindata();
            GetUserList();
        });



           function filladmindata() {
                var url = api_url + "/api/admin/society/" + SocID;
                // console.log("74==>"+ url);

                $.ajax({
                    dataType: "json",
                    url: url,
                    success: function (data) {
                        var da = JSON.stringify(data);
                        var js = jQuery.parseJSON(da);
                        //  alert("82==>"+da);

                        $("#lblAdminName").html(js.FirstName + "  " + js.LastName);
                        $("#lblAdminemail").html(js.EmailId);
                        $("#lblAdminContact").html(js.MobileNo);

                    },
                    error: function (data, errorThrown) {

                        alert('request failed :' + errorThrown);
                    }

                });
        }


        function GetUserList() {
               var url = api_url + "/api/user/" + SocID;
               

                $.ajax({
                    dataType: "json",
                    url: url,
                    success: OnSuccess,
                    error: function (data, errorThrown) {

                        alert('request failed :' + errorThrown);
                    }

                });
        }


        function OnSuccess(response) {
             console.log(response);
            var strAdmin = "";
            var countAdmin = 0;
            var strOwners = "";
            var countOwners = 0;
            var strTenant = "";
            var countTenant = 0;
            var strEmployee = "";
            var countEmployee = 0;

            var results = response; //jQuery.parseJSON(response);
            console.log(results);
            if (results.length > 0) {
                for (var i = 0; i < results.length; i++) {
                    console.log(JSON.stringify(results[0]));

                    var strButton =""
                  /*  if (results[i].Status == 'Approved') {

                        strButton = "<button class='btn btn-primary btn-sm' disabled>Done</button>";

                    }
                    else if(results[i].Status == 'Applied'){
                        strButton = "<button class='btn btn-primary btn-sm' onClick='ApproveRequest(" + results[i].SocietyID + ")' >Approve</button>"
                            + " &nbsp&nbsp<button class='btn btn-primary btn-sm' onClick='RejectRequest(" + results[i].SocietyID + ")'>Reject</button> ";
                    }*/

                    var row = "<div class=\"row \" style=\"margin-top:5px;margin-left:100px;border-top:solid 1px black;\">"
                        + "<div class='row'><div class='col-xs-4'>" + results[i].Type + "</b></div>"
                        + "<div class='col-xs-4'>Login:" + results[i].EmailId + "</div><div class='col-xs-4'>ResID:" + results[i].ResID + "<b style='color:blue;'>UserID: " + results[i].UserID + "</div>"
                        + "</div>"
                        + "<div class='row'>"
                        + "<div class='col-xs-4'>Name:" + results[i].FirstName + " " + results[i].LastName + "</div> <div class='col-xs-4'> " + + "</div> <div class='col-xs-4'> City : " + results[i].MobileNo + "</div>"
                        + "</div>"
                        + "<div class='row'><div class='col-xs-8'>" + results[i].Address + "&nbsp&nbsp" + strButton + "</div> " +
                        "<div class='col-xs-4'>" + "<button class='btn btn-primary btn-sm' onClick='Details(" + results[i].SocietyID + ")' >Details</button>"
                        + "</div></div>"
                        
                        + "</div>";

                    if (results[i].Type === "Admin") {
                        strAdmin = strAdmin + row;
                        countAdmin = countAdmin + 1;
                    }
                    else if (results[i].Type === "Owner") {
                        strOwners = strOwners + row;
                        countOwners = countOwners + 1;
                    }
                    else if (results[i].Type === "Tenant") {
                        strTenant = strTenant + row;
                        countTenant = countTenant + 1;
                    }
                    else if (results[i].Type === "Employee") {
                        strEmployee = strEmployee + row;
                        countEmployee = countEmployee + 1;
                    }
                
                }
                strAdmin = "&nbsp;&nbsp;&nbsp;Admin " + countAdmin + "<br/>" + strAdmin;
                $("#AdminList").html(strAdmin);

               strOwners = "&nbsp;&nbsp;&nbsp;Owners " + countOwners + "<br/>" + strOwners;
                $("#OwnersList").html(strOwners);

                 strTenant = "&nbsp;&nbsp;&nbsp;Tenant " + countTenant + "<br/>" + strTenant;
                $("#TenantList").html(strTenant);

                 strEmployee = "&nbsp;&nbsp;&nbsp;Employee " + countEmployee + "<br/>" + strEmployee;
            $("#EmployeeList").html(strEmployee);
            }
            else {
                
            }

        }
       

        function getUrlVars()
        {
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for(var i = 0; i < hashes.length; i++)
            {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
                <div id="AdminDetils" class="content_div" style="display:none;">
                         <h4>Admin Details</h4>
                         <hr />
                        <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                            <div class="col-sm-4">
                                <label class="data_heading">Administrator :</label>
                                <label class="data_label" id="lblAdminName"></label>
                            </div>
                            <div class="col-sm-4">
                                <label class="data_heading">Email : </label>
                                <label class="data_label" id="lblAdminemail"></label>
                            </div>
                            <div class="col-sm-4">
                                <label class="data_heading">Contact Number :</label>
                                <label class="data_label" id="lblAdminContact"></label>
                            </div>
                        </div>
                    </div>


            <div class="row" id="AdminList" style="background:#a1a1a1; margin-top:50px;">

            </div>

            <div class="row" id="OwnersList" style="background:#d6d6d6; margin-top:50px;">

            </div>

            <div class="row" id="TenantList" style="background:#c2c2c2; margin-top:50px;">

            </div>

             <div class="row" id="EmployeeList" style="background:#4cff00; margin-top:50px;">

            </div>

        </div>
    </form>
</body>
</html>
