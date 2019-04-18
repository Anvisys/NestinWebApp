<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyFlat.aspx.cs" Inherits="MyFlat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Flat</title>
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
        var CurrentUserType, ResID, UserID, Type, BHK, FirstName, LastName, MobileNo, EmailId,FlatID, FlatNumber, Address, ParentName, SocietyID,SocietyName, Gender, ActiveDate, DeActiveDate,  TenantUserID;
        var MobileExist, EmailExist, TenantResID, chkExistingUser = false;
        var api_url = "";
        var currentInvetoryID = 0;

        $(document).ready(function () {

            api_url = '<%=Session["api_url"] %>';
            GetData();
            var x = document.getElementById("inAddTMobile");
            // x.addEventListener("focusin", myFocusFunction);
            x.addEventListener("focusout", ValidateMobile);

            window.parent.FrameSourceChanged();

                  $(window).scroll(function() {
                   if ($(this).scrollTop() > 2){  
                      $('#header').addClass("medicom-header medical-nav");
		             // $("#social_icon").hide();
                }
                else{
                   $('#header').removeClass("medicom-header medical-nav");
	                $("#social_icon").show();
                }
            });
   
	});


        function GetData() {
        FlatID = '<%=Session["FlatID"] %>';
	    FlatNumber = '<%=Session["FlatNumber"] %>';
	    SocietyID = '<%=Session["SocietyID"] %>';
	    CurrentUserType = '<%=Session["UserType"] %>';
        SocietyName = '<%=Session["SocietyName"] %>';
        UserName = '<%=Session["FirstName"] %>';
         ResID = '<%=Session["ResiID"] %>';
      UserID= '<%=Session["UserID"] %>';
        
            GetFlatInfo(FlatNumber);
            GetRentalInfo(FlatNumber);
	   
	}
        

        function GetFlatInfo(FlatNumber) {

            // alert("minimum val is "+minvalue);
            // alert("maximum value is "+maxvalue);
            $("#TenantDetail").hide();
         
            var url = api_url + "/api/Flat/" + FlatID;
            
                 $.ajax({
                dataType: "json",
                url: url,
                success: function (data) {
                    $("#progressBar").hide();
                    $("#main_div").show();
                    $("#ad_div").show();
                    
                    SetFlatInfo(data);
                },
                error: function (data, errorThrown) {
                    $("#progressBar").hide();
                    alert('request failed :' + errorThrown);
                }

            });


            //  sessionStorage.setItem("maxvalue", maxvalue);
        };

        function SetFlatInfo(data) {
          
            var da = JSON.stringify(data);
            var js = jQuery.parseJSON(da);
            document.getElementById("lblFlatNumber").innerHTML = js.FlatNumber;
            document.getElementById("lblFlatBHK").innerHTML = js.BHK;
            document.getElementById("lblFlatBlock").innerHTML = js.Block;
            document.getElementById("lblFlatArea").innerHTML = js.FlatArea;
            document.getElementById("lblFlatFloor").innerHTML = js.Floor;
            document.getElementById("lblIntercomNumber").innerHTML = js.IntercomNumber;
            document.getElementById("lblFlatOwner").innerHTML = js.OwnerFirstName + " " + js.OwnerLastName;
            document.getElementById("lblFlatOwnerMobile").innerHTML = js.OwnerMobile;
             TenantResID =  js.TenantResID;
              document.getElementById("OwnerImage").src =  "GetImages.ashx?UserID=<% =UserID %>&Name=<% =UserFirstName %>&UserType=Owner";;

            TenantUserID = js.TenantUserID;
            var OwnerElement = document.getElementById("OwnerImage");
            //GetImageByMobile(js.Ownermobile, OwnerElement);

            document.getElementById("lblFlatOwnerEmail").innerHTML = js.OwnerEmail;
           
        
            if (js.TenantMobile != null) {
                $("#TenantDetail").show();
                document.getElementById("lblFlatTenantName").innerHTML = js.TenantFirstName + " " + js.TenantLastName;
                document.getElementById("lblFlatTenantEmail").innerHTML = js.TenantEmail;
                document.getElementById("lblFlatTenantMobile").innerHTML = js.TenantMobile;
                var TenantElement = document.getElementById("TenantImage");
               // GetImageByMobile(js.TenantMobile, TenantElement);
                document.getElementById("lblFlatTenantAddress").innerHTML = js.TenantAddress;
                ActiveDate = ChangeDateformat(js.TenantFrom);
                document.getElementById("lblFlatTenantFrom").innerHTML = ActiveDate;
                DeActiveDate = ChangeDateformat(js.TenantTo);
                document.getElementById("lblFlatTenantTo").innerHTML = DeActiveDate;

               document.getElementById("TenantImage").src =  "GetImages.ashx?UserID=" + js.TenantUserID + "&Name=" + js.TenantFirstName + "&UserType=Tenant";

            }
            else {
                
                document.getElementById("lblFlatTenantEmail").innerHTML = "No Tenant in Flat";
                document.getElementById("lblFlatTenantMobile").innerHTML = js.TenantMobile;
                document.getElementById("TenantImage");
                $("#btnAdd").show();
                
            }
           
           
            if (CurrentUserType == "Owner") {
                if (js.TenantFirstName != null) {
                    // alert(js.TenantFirstName);
                    $("#btnEdit").show();
                }
                else {
                    $("#btnEdit").hide();
                }

                $("#btnAdd").show();

            }
            else if (CurrentUserType == "Tenant") {
                $("#btnEdit").hide();
                $("#btnAdd").hide();
            }
            else {
                 $("#btnEdit").hide();
                $("#btnAdd").hide();
            }
        };


            function GetRentalInfo(FlatNumber) {

           
         
            var url = api_url + "/api/RentInventory/Find/" + FlatID + "/0"; 
            
                 $.ajax({
                dataType: "json",
                url: url,
                success: function (data) {
                    
                    SetRentalInfo(data);
                },
                error: function (data, errorThrown) {
                 
                    alert('request failed :' + errorThrown);
                }

            });


            //  sessionStorage.setItem("maxvalue", maxvalue);
        };


        function SetRentalInfo(data) {

            var obj = data.$values;

            if (obj.length == 0) {
                $("#RentalDetail").hide();
                $("#btnAddForRent").show();
            }
            else {
                $("#RentalDetail").show();
                $("#btnAddForRent").hide();
                currentInvetoryID = obj[0].RentInventoryID;
                
                document.getElementById("lblRentalType").innerHTML = obj[0].RentType;
                document.getElementById("lblInventory").innerHTML = obj[0].Inventory;
                document.getElementById("lblRentValue").innerHTML = obj[0].RentValue;
                document.getElementById("lblRentContactName").innerHTML = obj[0].ContactName;
                document.getElementById("lblRentContactNumber").innerHTML = obj[0].ContactNumber;
                document.getElementById("lblRentDescription").innerHTML = obj[0].Description;

            }

        }


        function GetImageByMobile(Mobile,element) {

            var url = api_url + "/api/Image/GetByMobile/" + Mobile + "/";
            $.ajax({
                dataType: "json",
                url: url,
                success: function (data) {
                    if (data != null) {

                        var da = JSON.stringify(data);
                        var js = jQuery.parseJSON(da);
                        UserExist = true;
                        ResID = js.ID;
                        var ImageString = js.ImageString;
                       // alert("SettingImage:" + ImageString);
                        var Source = "data:image/jpeg;charset=utf-8;base64," + ImageString;
                        element.src = Source;
                       // element.src = Source;
                    }
                    else {
                        UserExist = false;
                        document.getElementById("lblMessage").textContent = "Email is available"
                        document.getElementById("inAddTEmailID").disabled = false;
                    }

                },
                error: function (data, errorThrown) {
                   // alert("Error getting Image");
                }

            });

        }

        function ShowDialog()
        {
            document.getElementById("modalAdd").style.display = "block";
            //document.getElementsByClassName("loader").hide();
        }

        function ModalClose()
        {
            document.getElementById("modalAdd").hide();
        }


        function ValidateMobile(element)
        {
            
            if (element.value.length<10)
            {
                document.getElementById("lblMessage").textContent = "Enter valid Mobile Number";
                element.focus();
                return;
            }
            // document.getElementsByClassName("txtbox_style").disabled = true;
            document.getElementById("lblMessage").textContent = "Validating Mobile Number"
           // document.getElementById("inAddTEmailID").disabled = true;
            $("input").disabled = true;
            var url = api_url + "/api/Resident/Mobile/" + element.value;

           
            $.ajax({
                dataType: "json",
                url: url,
                success: function (data) {
                    var da = JSON.stringify(data);
                    if (da != 'null') {
                        var js = jQuery.parseJSON(da);
                        MobileExist = true;
                        ResID = js.ResID;
                        UserID = js.UserID;
                        Type = js.Type;
                        BHK = js.BHK;
                        FirstName = js.FirstName;
                        LastName = js.LastName;
                        MobileNo = js.MobileNo;
                        EmailId = js.EmailId;
                        if (chkExistingUser == true) {
                            document.getElementById("lblMessage").textContent = "Mobile No Exist"
                            //document.getElementById("inAddTEmailID").disabled = false;
                            document.getElementById("lblMessage").style.color = "Blue";
                           // alert(chkExistingUser);

                            //set focus to email id box
                        }
                        else {
                             document.getElementById("lblMessage").textContent = "Mobile No is in use. Either check the Existing User or use another mobile"
                            //document.getElementById("inAddTEmailID").disabled = false;
                            document.getElementById("lblMessage").style.color = "Red";
                            // alert(chkExistingUser);
                        }
                    }
                    else {
                        MobileExist = false;
                      
                        document.getElementById("lblMessage").textContent = "Mobile number is available";
                        document.getElementById("lblMessage").style.color = "Blue";
                        document.getElementById("inAddTEmailID").disabled = false;
                    }
                    
                },
                error: function (data, errorThrown) {
                    document.getElementById("lblMessage").innerHTML = "Could not validate, try again or later"
                    
                    document.getElementById("inAddTEmailID").disabled = false;
                }
                
            });
            
        }

        function ValidateEmail(element)
        {
            try {
                
                document.getElementById("lblMessage").textContent = "Validating Email ID"
              
                if (MobileExist == true) {
                    if (EmailId.toLowerCase() == element.value.toLowerCase()) {
                        EmailExist = true;
                        document.getElementById("lblMessage").innerHTML = "User Data Matches"
                        FillUserData();
                    }
                    else {
                        EmailExist = false;
                        document.getElementById("lblMessage").innerHTML = "EMail do not match with Mobile Number"
                    }
                }
                else {
                   
                    GetUserByMail(element.value);
                }
              
            }
            catch (err)
            {
                document.getElementById("lblMessage").innerHTML = "Error validating mail"
            }
        }

        function GetUserByMail(mail)
        {
          
            var url = api_url + "/api/Resident/Email/" + mail + "/";
            $.ajax({
                dataType: "json",
                url: url,
                success: function (data) {
                    if (data != null)
                    {
                       
                       var da = JSON.stringify(data);
                        var js = jQuery.parseJSON(da);
                        EmailExist = true;
                        ResID = js.ResID;
                        UserID = js.UserID;
                        Type = js.Type;
                        BHK = js.BHK;
                        FirstName = js.FirstName;
                        LastName = js.LastName;
                        MobileNo = js.MobileNo;
                        EmailId = js.EmailId;
                        
                        document.getElementById("lblMessage").textContent = "Email already exist with some Mobile, use other Email"
                        document.getElementById("inAddTEmailID").disabled = false;
                    }
                    else {
                        EmailExist = false;
                        document.getElementById("lblMessage").textContent = "Email is available"
                        document.getElementById("inAddTEmailID").disabled = false;
                    }

                },
                error: function (data, errorThrown) {
                    document.getElementById("lblMessage").innerHTML = "Could not validate, try again or later"

                    document.getElementById("inAddTEmailID").disabled = false;
                }

            });

        }

        function FillUserData()
        {
            document.getElementById("inAddTFirstName").value = FirstName;
            document.getElementById("inAddTAddress").value = BHK;
            document.getElementById("inAddTLastName").value = LastName;
            document.getElementById("inAddTEmailID").value = EmailId;
            document.getElementById("inAddTAddress").value = LastName;
            document.getElementById("inAddTParentName").value = LastName;
        }


        function AddUser()
        {
            if ((MobileExist == true && EmailExist == false) || (MobileExist == false && EmailExist == true)) {
                document.getElementById("lblMessage").innerHTML = "Either of Mobile and Email does not match, other propert match;";
                return;
            }


            FirstName = document.getElementById("inAddTFirstName").value;
            LastName = document.getElementById("inAddTLastName").value;
            MobileNo = document.getElementById("inAddTMobile").value;
            EmailId = document.getElementById("inAddTEmailID").value;
            Address = document.getElementById("inAddTAddress").value;
            ParentName = document.getElementById("inAddTParentName").value;

            //UserLogin = document.getElementById("inAddTUserLogin").value;
            UserLogin = EmailId
            //Password = document.getElementById("inAddPassword").value;
            Password = "Password@123";
            ActiveDate =ChangeDateformat(document.getElementById("inAddTActiveDate").value);
            DeActiveDate =ChangeDateformat(document.getElementById("inAddTDeactiveDate").value);
            
            var e = document.getElementById("mgender");
            Gender = e.options[e.selectedIndex].text;

            if (MobileExist == false && EmailExist == false) {
                // var reqBody = "{\"StartIndex\":" + minvalue + ",\"EndIndex\":" + maxvalue + "}";
                var reqBody = "{\"UserType\":\"Tenant\", \"FirstName\":\"" + FirstName + "\",\"LastName\":\"" + LastName + "\", \"MobileNo\":\"" + MobileNo
                    + "\", \"EmailId\":\"" + EmailId + "\", \"Address\":\"" + Address + "\", \"Gender\":\"" + Gender + "\", \"Parentname\":\"" + ParentName
                    + "\", \"SocietyId\":" + SocietyID + ", \"UserLogin\":\"" + UserLogin + "\", \"Password\":\"" + Password + "\" }";

                var url = "http://www.kevintech.in/MyApttUserService/api/AddUser";

              //  alert(reqBody);
               
                //AddTenant(100111);

                $.ajax({
                    dataType: "json",
                    url: url,
                    data: reqBody,
                    type: 'post',
                    async: false,
                    contentType: 'application/json',
                    success: function (data) {
                        var da = JSON.stringify(data);
                      //  alert(da);
                        var js = jQuery.parseJSON(da);
                          var Response = js.Response;
                        if (Response == "OK") {
                            document.getElementById("lblMessage").innerHTML = "User Login Created. Attaching User with Flat...";
                            var UserID = js.UserID;
                            //alert(UserID);
                            AddTenant(UserID);
                        }
                        else {
                            document.getElementById("lblMessage").innerHTML = "Could not Add User, try again or later";
                        }

                    },
                    error: function (data, errorThrown) {
                        alert('User Creation failed :' + errorThrown);
                        // sessionStorage.clear();
                    }

                });
            }
            else {
                if (UserID != null) {
                    AddTenant(UserID);
                }

            }
        }

        function AddTenant(UserID)
        {
            var reqBody2 = "{\"UserID\":" + UserID + ",\"FlatID\":\"" + FlatID + "\",\"Type\":\"Tenant\",\"FirstName\":\"" + FirstName +
                "\",\"LastName\":\"" + LastName + "\",\"MobileNo\":\"" + MobileNo + "\",\"EmailId\":\"" + EmailId + "\",\"Addres\":\"" + Address +
                "\",\"SocietyID\":\"" + SocietyID   + "\",\"ActiveDate\":\"" + ActiveDate + "\",\"DeActiveDate\":\"" + DeActiveDate + "\"}";
            document.getElementById("lblMessage").innerHTML = reqBody2;
            //alert(reqBody2);
            var url = api_url + "/api/Tenant/New";
            //alert(url);
            $.ajax({
                dataType: "json",
                url: url,
                data: reqBody2,
                type: 'post',
                contentType: 'application/json',
                success: function (data) {
                    //alert(da);
                    var da = JSON.stringify(data);
                    var js = jQuery.parseJSON(da);
                    var Response = js.Response;
                    if (Response == "OK") {
                        document.getElementById("lblMessage").innerHTML = "Tenant Added Successfully"
                    }
                    else {
                        document.getElementById("lblMessage").innerHTML = "Could not Add User, try again or later"
                    }

                },
                error: function (data, errorThrown) {
                    alert('request failed :' + errorThrown);
                   // sessionStorage.clear();
                }

            });
        }
        
        function ChangeDateformat(inputdate) {
           
            var date = new Date(inputdate);
            var day = date.getDate().toString();
            if (day.length == 1)
            { day = "0" + day; }

            var month = (date.getMonth() + 1).toString();
            if (month.length == 1)
            { month = "0" + month;}

            var strDate = day + "/" + month + "/" + date.getFullYear();
            return strDate;
        }

        function ReverseDateFormat(inputDate)
        {
            if (inputDate != undefined)
            {
                var date = inputDate.split("/");
                var newdate = date[2] + "-" + date[1] + "-" + date[0];
                return newdate;
            }
        }

       function PopulateAddModal()
        {
           var title = "Add Tenant to: " + FlatNumber;
           $("#title").text(title);

           $("#inAddTActiveDate").attr("min", ReverseDateFormat(DeActiveDate));

           $("#addTenantModal").show();

       }

    
        $(document).ajaxStart(function () {
            $('.loader').show();
        }).ajaxStop(function () {
            $('.loader').hide();
        });

        $("div").focusout(function () {
            $(this).css("background-color", "#FFFFFF");
        });

        function ChangeDeactiveDate()
        {
            document.getElementById("ChangeDate").style.display = "block";
            $('#newDeactiveDate').attr("min", ReverseDateFormat(ActiveDate))
        }

        function UpdateDeactiveDate()
        {
            DeActiveDate = ChangeDateformat(document.getElementById("newDeactiveDate").value);
            var reqBody3 = "{\"id\":" + TenantResID + ",\"date\":\"" + DeActiveDate + "\"}";
           // alert(reqBody3);
            var url = api_url + "/api/Tenant/Update";

            $.ajax({
                dataType: "json",
                url: url,
                data: reqBody3,
                type: 'post',
                contentType: 'application/json',
                success: function (data) {
                   
                    var da = JSON.stringify(data);
                    var js = jQuery.parseJSON(da);
                    var Response = js.Response;
                    if (Response == "OK") {
                        document.getElementById("lblFlatTenantTo").innerHTML = DeActiveDate;
                    }
                    else {
                        alert("Failed to Update");
                    }

                },
                error: function (data, errorThrown) {
                    alert('request failed :' + errorThrown);
                    // sessionStorage.clear();
                }

            });
        }

      
        jQuery(document).ready(function () {

        $("#chkUser").click(function () {
            $('#inAddTFirstName,#inAddTLastName,#inAddTParentName,#mgender,#inAddTAddress,#inAddPassword,#inTConfirmPassword').attr("disabled", $(this).is(":checked"));
            if ($(this).is(":checked")) {
               
                chkExistingUser = true;
            }
            else {
                
                 chkExistingUser = false;
            }
        });
       });
        
          $(document).ready(function () {
            $("#btnCancel,#Close_mod").click(function () {
               $("#addTenantModal").hide();
            });
        });



        //**************add for rental*************//

          
        $(document).ready(function () {
            api_url = '<%=Session["api_url"] %>';
            // populateType();
            //populateSelect();
            GetInventoryTypeData();
            GetAccomodationType(1);
             $('#InventoryType').on('change', function () {
                  GetAccomodationType( this.value );

            });

            


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

            var ele = document.getElementById('InventoryType');
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

            var ele = document.getElementById('AccomodationType');
            ele.innerHTML = "";
            for (var i = 0; i < Inventory.length; i++) {
                // POPULATE SELECT ELEMENT WITH JSON.
                ele.innerHTML = ele.innerHTML +
                    '<option value="' + Inventory[i].AccomodationTypeID + '">' + Inventory[i].AccomodationType + '</option>';
            }
        }

            function InitiateRent() {
              
                $("#addInventoryModal").show();
            }

            function CloseRentalBox() {
                $("#addInventoryModal").hide();

            }


       
       


      

            function AddRentInventory() {

                var RentInventory = {};
                RentInventory.AccomodationTypeID = $("#AccomodationType").val();
                RentInventory.InventoryTypeID = $("#InventoryType").val();
                RentInventory.RentValue = $("#inRent").val();
                RentInventory.Available = 1;
                RentInventory.Description = $("#description").val();
                RentInventory.ContactName = $("#contactName").val();
                RentInventory.ContactNumber = $("#contactNumber").val();
                RentInventory.UserID = <%=UserID%>;
                RentInventory.HouseID =0;
                RentInventory.FlatID = FlatID;

                console.log(RentInventory);

                var url = api_url + "api/RentInventory/New"

                $.ajax({
                    dataType: "json",
                    url: url,
                    data: JSON.stringify(RentInventory),
                    type: 'post',
                    //async: false,
                    contentType: 'application/json',
                    success: function (data) {
                        //var da = JSON.stringify(data);
                        //var js = jQuery.parseJSON(da);
                        alert(JSON.stringify(data));
                        var Response = data.Response;
                        if (Response == "OK") {
                            document.getElementById("lblMessage").innerHTML = "Your inventory is submitted for Rent";
                        }
                        else {
                            document.getElementById("lblMessage").innerHTML = "Could not submitt, Please contact admin";
                        }

                    },
                    error: function (data, errorThrown) {
                        alert('Error submitting Rent Inventory :' + errorThrown);
                        // sessionStorage.clear();
                    }

                });
            }

        function CloseRental() {

            $("#closeInventoryModal").show();
        }


        function CloseCloseBox() {
             $("#closeInventoryModal").hide();
        }

        function CloseRentInventory() {
            var InventoryUpdate = {};
            InventoryUpdate.InventoryId = currentInvetoryID;
            InventoryUpdate.Status = 0;

            var url = api_url + "/api/RentInventory/Close"

                $.ajax({
                    dataType: "json",
                    url: url,
                    data: JSON.stringify(InventoryUpdate),
                    type: 'post',
                    async: false,
                    contentType: 'application/json',
                    success: function (data) {
                       $("#closeInventoryModal").hide();
                        var Response = data.Response;
                        if (Response == "Ok") {
                          
                            GetRentalInfo(FlatNumber);
                        }
                        else {
                            document.getElementById("lblMessage").innerHTML = "Could not submitt, Please contact admin";
                        }

                    },
                    error: function (data, errorThrown) {
                        alert('Error submitting Rent Inventory :' + errorThrown);
                        // sessionStorage.clear();
                    }

                });


        }

    </script>

<style>
    .data_label {
        color:#000;
    }

   
 
      .modal {
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
<body style="background-color:#f7f7f7;">
    <form id="form1" runat="server">
  </form>

    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12 col-xs-12">

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
                    </div>
                </div>



                <div id="main_div" style="display: none; margin: 10px;">
                    <div id="FlatDetails" class="content_div">
                        <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                            <div class="col-sm-4">
                                <label class="data_heading">Flat Number :</label>
                                <label class="data_label" id="lblFlatNumber">...</label>
                            </div>
                            <div class="col-sm-4">
                                <label class="data_heading">Flat Floor :</label>
                                <label class="data_label" id="lblFlatFloor">...</label>
                            </div>
                            <div class="col-sm-4">
                                <label class="data_heading">Intercom Number :</label>
                                <label class="data_label" id="lblIntercomNumber">...</label>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                            <div class="col-sm-4">
                                <label class="data_heading">BHK :</label>
                                <label class="data_label" id="lblFlatBHK">...</label>
                            </div>
                            <div class="col-sm-4">
                                <label class="data_heading">Block :</label>
                                <label class="data_label" id="lblFlatBlock">...</label>
                            </div>
                            <div class="col-sm-4">
                                <label class="data_heading">Flat Area :</label>
                                <label class="data_label" id="lblFlatArea">...</label>
                            </div>
                        </div>

                    </div>

                    <div id="OwnerDetail" class="content_div">
                        <div class="row" style="margin-top: 5px; margin-bottom: 5px; text-align: center;">
                            <div class="col-xs-12">
                                <h4 style="padding-right: 141px; font-family: Verdana;">Owner Info</h4>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                            <div class="col-sm-4">
                                <img src="Images/Icon/profile.jpg" id="OwnerImage" height="110" width="110" style="border-radius: 50%;" />
                            </div>
                            <div class="col-sm-8">
                                <label style="width: 100px;" class="data_heading">Name :</label>
                                <label style="width: 50%;" class="data_label" id="lblFlatOwner">...</label><br />
                                <label style="width: 100px;" class="data_heading">Email :</label>
                                <label style="width: 50%;" class="data_label" id="lblFlatOwnerEmail">...</label><br />
                                <label style="width: 100px;" class="data_heading">Contact :</label>
                                <label style="width: 50%;" class="data_label" id="lblFlatOwnerMobile">...</label>
                            </div>

                        </div>
                    </div>

                    <div id="TenantDetail" class="content_div">
                        <div class="row" style="margin-top: 5px; margin-bottom: 5px; text-align: center;">
                            <div class="col-xs-12">
                                <h4 style="padding-right: 141px; font-family: Verdana;">Tenant Info</h4>

                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                            <div class="col-sm-4">
                                <img id="TenantImage" src="Images/Icon/profile.jpg" height="110" width="110" style="border-radius: 50%;" />
                            </div>
                            <div class="col-sm-8">
                                <label style="width: 100px;" class="data_heading">Name :</label>
                                <label class="data_label" id="lblFlatTenantName">...</label><br />
                                <label style="width: 100px;" class="data_heading">Email :</label>
                                <label class="data_label" id="lblFlatTenantEmail">...</label><br />
                                <label style="width: 100px;" class="data_heading">Contact :</label>
                                <label class="data_label" id="lblFlatTenantMobile">...</label><br />
                                <label style="width: 100px;" class="data_heading">Address :</label>
                                <label class="data_label" id="lblFlatTenantAddress">...</label><br />
                                <label style="width: 100px;" class="data_heading">From :</label>
                                <label class="data_label" id="lblFlatTenantFrom">...</label><br />
                                <label style="width: 100px;" class="data_heading">Till :</label>
                                <label class="data_label" id="lblFlatTenantTo">...</label>
                                <button id="btnEdit" type="button" class="btn btn-danger" style="display: none" onclick="ChangeDeactiveDate()">Set End Date</button>
                                <div id="ChangeDate" style="display: none">
                                    <input type="date" id="newDeactiveDate" style="width: 150px" />
                                    <button id="btnUpdate" type="button" onclick="UpdateDeactiveDate();">Update</button>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div id="RentalDetail" class="content_div">
                        <div class="row" style="margin-top: 5px; margin-bottom: 5px; text-align: center;">
                            <div class="col-xs-12">
                                <h4 style="padding-right: 141px; font-family: Verdana;">Rental offer</h4>

                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px; margin-bottom: 10px;">

                            <div class="col-sm-4">
                                <label style="width: 100px;" class="data_heading">Type :</label>
                                <label class="data_label" id="lblRentalType">...</label><br />
                                <label style="width: 100px;" class="data_heading">Inventory :</label>
                                <label class="data_label" id="lblInventory">...</label><br />
                            </div>
                            <div class="col-sm-4">
                                <label style="width: 100px;" class="data_heading">Rent :</label>
                                <label class="data_label" id="lblRentValue">...</label><br />
                                <label style="width: 100px;" class="data_heading">Contact</label>
                                <label class="data_label" id="lblRentContactName">...</label><br />
                            </div>
                            <div class="col-sm-4">
                                <label style="width: 100px;" class="data_heading">Number</label>
                                <label class="data_label" id="lblRentContactNumber">...</label><br />
                                <label style="width: 100px;" class="data_heading">other</label>
                                <label class="data_label" id="">...</label>
                            </div>
                            <div class="row">
                                <label style="width: 100px;" class="data_heading">Description</label>
                                <label class="data_label" id="lblRentDescription">...</label>
                            </div>

                            <div class="col-xs-12" id="Close">
                                <button id="btnClose" type="button" class="btn btn-primary btn-sm pull-right" onclick="CloseRental();">Close</button>
                            </div>
                        </div>


                    </div>


                    <div class="row">
                        <div class="col-sm-12">
                            <button id="btnAdd" class="btn btn-info btn-sm" onclick="PopulateAddModal()" style="display: none" type="button">Add Tenant</button>

                            <button id="btnAddForRent" type="button" class="btn btn-primary btn-sm" onclick="InitiateRent()">Add for Rent</button>
                        </div>

                    </div>


                    <div id="addTenantModal" class="modal">
                        <div class="modal-content" style="border: 0px solid; width: 550px; margin: auto;">

                            <div class="modal-header" style="color: white; background-color: #5ca6de; height: 50px;">
                                <button type="button" id="Close_mod" class="close" data-dismiss="modal" style="color: #000;">&times;</button>
                                <h4 id="title" class="modal-title" style="margin-top: 5px;">Add Tenant to:
                                     <var>FlatNumber</var></h4>
                            </div>

                            <div class="modal-body">

                                <label class="labelwidth">Existing Users :</label>
                                <input id="chkUser" type="checkbox" />
                                &nbsp;
                            <label id="lblMessage"></label>
                                <br />
                                <div class="row" style="margin-top: 5px; margin-bottom: 5px">

                                    <div class="col-sm-6">
                                        <label class="labelwidth">Mobile :</label>
                                        <input id="inAddTMobile" onblur="ValidateMobile(this);" style="width: 120px" />
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="labelwidth">Email  :</label>
                                        <input id="inAddTEmailID" onblur="ValidateEmail(this);" style="width: 120px" />

                                    </div>


                                </div>
                                <hr />
                                <div class="row" style="margin-top: 5px; margin-bottom: 5px">

                                    <div class="col-sm-6">
                                        <label class="labelwidth">Firstname :</label>
                                        <input id="inAddTFirstName" style="width: 120px" class="txtbox_style" tabindex="2" />
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="labelwidth">Lastname :</label>
                                        <input id="inAddTLastName" style="width: 120px" class="txtbox_style" tabindex="3" />
                                    </div>

                                </div>

                                <div class="row" style="margin-top: 5px; margin-bottom: 5px">

                                    <div class="col-sm-6">
                                        <label class="labelwidth">ParentName :</label>
                                        <input id="inAddTParentName" style="width: 120px" class="txtbox_style" tabindex="5" />
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="labelwidth">Gender :</label>
                                        <select id="mgender" style="width: 120px; padding: 3px;">
                                            <option value="Male">Male</option>
                                            <option value="Female">Female</option>
                                        </select>
                                    </div>

                                </div>

                                <div class="row" style="margin-top: 5px; margin-bottom: 5px">
                                    <div class="col-sm-6">
                                        <label class="labelwidth">Address :</label>
                                        <input id="inAddTAddress" style="width: 120px" class="txtbox_style" tabindex="8" />
                                    </div>

                                    <div class="col-sm-6" style="display: none;">
                                        <label class="labelwidth">UserLogin  :</label>
                                        <input id="inAddTUserLogin" style="width: 120px" class="txtbox_style" tabindex="10" />
                                        <br />
                                    </div>
                                </div>


                                <div class="row" style="margin-top: 5px; margin-bottom: 5px; display: none;">


                                    <div class="col-sm-6">
                                        <label class="labelwidth">Password  :</label>
                                        <input id="inAddPassword" style="width: 120px" class="txtbox_style" tabindex="12" /><br />
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="labelwidth">Confirm Password :</label>
                                        <input id="inTConfirmPassword" style="width: 120px" class="txtbox_style" tabindex="12" /><br />
                                    </div>
                                </div>
                                <hr />
                                <div class="row" style="margin-top: 5px; margin-bottom: 5px">

                                    <div class="col-sm-6">
                                        <label class="labelwidth" style="width: 105px;">Active date :</label>
                                        <input type="date" id="inAddTActiveDate" max="" style="width: 135px" />
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="labelwidth" style="width: 105px;">Deactive date :</label>
                                        <input type="date" id="inAddTDeactiveDate" style="width: 135px" />
                                    </div>
                                </div>


                            </div>

                            <div class="panel-footer" style="text-align: right;">
                                <button type="button" id="btnCancel" style="margin-top: 5px;" data-dismiss="modal" class="btn btn-danger">Cancel</button>
                                <button type="button" id="btnSubmit" style="margin-top: 5px;" onclick="AddUser();" class="btn btn-primary">Submit</button>

                            </div>
                        </div>
                    </div>

                    <div id="addInventoryModal" class="modal">
                        <div class="modal-content" style="border-radius: 5px; width: 580px; margin: auto; margin-top: 120px">

                            <div class="modal-header" style="color: white; background-color: #337ab7; height: 50px;">
                                <i class="fa fa-close" style="float: right; cursor: pointer;" onclick="CloseRentalBox()"></i>
                                <h4 id="Title" class="modal-title" style="font-family: Helvetica Neue,Helvetica,Arial,sans-serif; font-size: 14px">Available for Rent:
                                        <var>House Number</var></h4>
                            </div>

                            <div class="layout_modal_body container-fluid">
                                <form name="AddRent">

                                    <div class="row " style="margin-top: 20px;">
                                        <div class="col-sm-6">
                                            <label class="labelwidth col-sm-4 col-form-label ">Inventory Type:</label>
                                            <div class="col-sm-8">
                                                <select id="InventoryType" onblur="" class="form-control form-control-sm "></select>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <label class="labelwidth col-sm-4 col-form-label ">Accomodation:</label>
                                            <div class="col-sm-8">
                                                <select id="AccomodationType" onblur="" class="form-control form-control-sm"></select>
                                            </div>
                                        </div>
                                        
                                    </div>
                                    <div class="row" style="margin-top: 10px;">
                                        <div class="col-sm-6">
                                            <label class="labelwidth col-sm-4 col-form-label">Description:</label>
                                            <div class="col-sm-8">
                                                <input id="description" type="text" class="form-control form-control-sm" tabindex="2" />
                                            </div>
                                        </div>

                                        <div class="col-sm-6">
                                            <label class="labelwidth col-sm-4 col-form-label">Rent: </label>
                                            <div class="col-sm-8">
                                                <input id="inRent" type="number" onblur="" class="form-control form-control-sm" />
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row" style="margin-top: 10px; margin-bottom: 10px">

                                        <div class="col-sm-6">
                                            <label class="labelwidth col-sm-4 col-form-label">Contact Person:</label>
                                            <div class="col-sm-8">
                                                <input id="contactName" type="text" class="form-control form-control-lg" tabindex="3" />
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <label class="labelwidth col-sm-4 col-form-label">Contact Number:</label>
                                            <div class="col-sm-8">
                                                <input id="contactNumber" type="number" class="form-control form-control-lg" tabindex="3" />
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>

                            <div class="panel-footer" style="text-align: right;">
                                <button type="button" id="btnInvCancel" style="margin-top: 5px;" onclick="CloseRentalBox()" data-dismiss="modal" class="btn btn-danger">Cancel</button>
                                <button type="button" id="btnInvSubmit" style="margin-top: 5px;" onclick="AddRentInventory();" class="btn btn-primary">Submit</button>

                            </div>
                        </div>
                    </div>

                </div>

                <div id="progressBar" class="container-fluid" style="text-align: center; height: 200px;">
                    <img src="images/icon/ajax-loader.gif" style="width: 40px; height: 40px; margin-top: 50px;" />
                </div>



                 <div id="closeInventoryModal" class="modal">
                        <div class="modal-content" style="border-radius: 5px; width: 580px; margin: auto; margin-top: 120px">

                            <div class="modal-header" style="color: white; background-color: #337ab7; height: 50px;">
                                <i class="fa fa-close" style="float: right; cursor: pointer;" onclick="CloseCloseBox()"></i>
                                <h4 id="close" class="modal-title" >Close for Rent:
                                        <var>House Number</var></h4>
                            </div>

                            <div class="layout_modal_body container-fluid">
                              ! please confirm if you want to cose
                            </div>

                            <div class="panel-footer" style="text-align: right;">
                                <button type="button" id="btnCloseCancel" style="margin-top: 5px;" onclick="CloseCloseBox()" data-dismiss="modal" class="btn btn-danger">Cancel</button>
                                <button type="button" id="btnCloseSubmit" style="margin-top: 5px;" onclick="CloseRentInventory();" class="btn btn-primary">Submit</button>

                            </div>
                        </div>
                    </div>

            </div>


        </div>
    </div>
   
        
  
</body>
</html>
