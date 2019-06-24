<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyFlat.aspx.cs" Inherits="MyFlat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Flat</title>
    <meta charset="utf-8"/>
   <meta name="viewport" content="width=device-width, initial-scale=1"/>
      
   <%-- <link href="Styles/MyFlat.css" rel="stylesheet" type="text/css" />--%>
      <script src="Scripts/jquery-1.11.1.min.js"></script>
     
    <link rel="stylesheet" href="CSS/ApttTheme.css" /> 
    <link rel="stylesheet" href="CSS/ApttLayout.css" />

     <link rel="stylesheet" href="CSS/Nestin.css" />


             <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
            <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
            <!-- jQuery library -->
            <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
   
            <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css"/>  

      <script type="text/javascript" src="Scripts/datetime.js"></script>
   
    <script type="text/javascript" src="https://momentjs.com/downloads/moment.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.43/js/bootstrap-datetimepicker.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.43/css/bootstrap-datetimepicker.min.css"/>
 
          

    <script id="MyFlatData">
        var CurrentUserType, ResID, UserID, Type, BHK, FirstName, LastName, MobileNo, EmailId, FlatID, FlatNumber, Address, ParentName, SocietyID, SocietyName, Gender, ActiveDate, DeActiveDate, TenantUserID;
        var MobileExist, EmailExist, TenantResID, chkExistingUser = false;
        var api_url = "www.kevintech.in/";
        var _ResID = 0;
        var currentInvetoryID = 0;

        $(document).ready(function () {

            api_url = '<%=Session["api_url"] %>';
           // alert("45 ==>> "+api_url);
            _ResID = <%=ResID%>;
            GetData();
            filladmindata();
            var x = document.getElementById("inAddTMobile");
            // x.addEventListener("focusin", myFocusFunction);
            // x.addEventListener("focusout", ValidateMobile);
            $("#chkUser").prop("checked", true);
            checkbox();
            window.parent.FrameSourceChanged();
            $("#inAddTDeactiveDate").click(function () {
                // $("#inAddTDeactiveDate").attr("min", ReverseDateFormat(ChangeDateformat($("#inAddTActiveDate").val())));
                var ele = ReverseDateFormat(ChangeDateformat($("#inAddTActiveDate").val()));
                $("#inAddTDeactiveDate").attr("min", ele);
                //alert(ele);
            });


            $('#newDeactiveDate').datetimepicker({
                //  format: 'YYYY-MM-DD'
                format: 'DD-MM-YYYY'
            });

             $('#date_return').datetimepicker( {
            format: 'DD-MM-YYYY'
        });

            function filladmindata() {
                var url = "http://localhost:5103/" + "api/admin/society/" + SocietyID;

                $.ajax({
                    dataType: "json",
                    url: url,
                    success: function (data) {
                        var da = JSON.stringify(data);
                        var js = jQuery.parseJSON(da);

                        $("#lblAdminName").html(js.FirstName + "  " + js.LastName);
                        $("#lblAdminemail").html(js.EmailId);
                        $("#lblAdminContact").html(js.MobileNo);

                    },
                    error: function (data, errorThrown) {

                        alert('request failed :' + errorThrown);
                    }

                });
            }

            $('#date_return').datetimepicker({
                //format: 'DD-MM-YYYY'
                format: "YYYY-MM-DD"
            });




            $(window).scroll(function () {
                if ($(this).scrollTop() > 2) {
                    $('#header').addClass("medicom-header medical-nav");
                    // $("#social_icon").hide();
                }
                else {
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
            UserID = '<%=Session["UserID"] %>';

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
            TenantResID = js.TenantResID;
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

                document.getElementById("TenantImage").src = "GetImages.ashx?UserID=" + js.TenantUserID + "&Name=" + js.TenantFirstName + "&UserType=Tenant";

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

         //   alert("197 ==>> " + api_url);

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

                document.getElementById("lblRentalType").innerHTML = obj[0].AccomodationType;
                document.getElementById("lblInventory").innerHTML = obj[0].InventoryType;
                document.getElementById("lblRentValue").innerHTML = obj[0].RentValue;
                document.getElementById("lblRentContactName").innerHTML = obj[0].ContactName;
                document.getElementById("lblRentContactNumber").innerHTML = obj[0].ContactNumber;
                document.getElementById("lblRentDescription").innerHTML = obj[0].Description;

            }

        }

        //For tenant popup//

        function PopulateAddModal2() {
            var url = api_url + "/api/RentInventory/Find/" + FlatID + "/0";
            // var url = api_url + "/api/RentInventory/Find";

            $.ajax({
                dataType: "json",
                url: url,
                success: function (data) {
                    //alert("In poppulateadd modal ===>244");
                    PopulateAddModal();


                },
                error: function (data, errorThrown) {

                    alert('request failed :' + errorThrown);
                }

            });


            //  sessionStorage.setItem("maxvalue", maxvalue);

        }

        //End//


        function GetImageByMobile(Mobile, element) {

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

        function ShowDialog() {
            document.getElementById("modalAdd").style.display = "block";
            //document.getElementsByClassName("loader").hide();
        }

        function ModalClose() {
            document.getElementById("modalAdd").hide();
        }


        function ValidateMobile(element) {
            var MobileNo = element.value;
            // alert(MobileNo);
            //  alert(MobileNo.length);
            if (element.value.length < 10) {
                document.getElementById("lblMessage").textContent = "Mobile Number Should be of 10 digits..";
                // element.focus();
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
                        //alert("329 ===>> " +da.length);
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
                            document.getElementById("lblMessage").innerHTML = "Registered Mobile Number.."
                            //document.getElementById("inAddTEmailID").disabled = false;
                            document.getElementById("lblMessage").style.color = "Green";
                            // alert(chkExistingUser);

                            //set focus to email id box
                        }
                        else {
                            //document.getElementById("lblMessage").textContent = "Mobile No is in use. Either check the Existing User or use another mobile"
                            ////document.getElementById("inAddTEmailID").disabled = false;
                            //document.getElementById("lblMessage").style.color = "Red";
                            //// alert(chkExistingUser);
                        }
                        MobileExist = true;
                    }
                    else {
                        MobileExist = false;

                        document.getElementById("lblMessage").textContent = "Mobile Number is not registered.. register first !! 359";
                        document.getElementById("lblMessage").style.color = "Red";
                        document.getElementById("inAddTEmailID").disabled = false;
                    }

                },
                error: function (data, errorThrown) {
                    document.getElementById("lblMessage").innerHTML = "Could not validate, try again or later"
                    document.getElementById("lblMessage").style.color = "Red";
                    document.getElementById("inAddTEmailID").disabled = false;
                }

            });

        }

        function ValidateEmail(element) {
            try {

                document.getElementById("lblMessage").textContent = "Validating Email ID"

                if ($("#inAddTMobile").val() == "" || EmailId == null) {
                    document.getElementById("lblMessage").innerHTML = "<b>Email Address and Mobile Number field should not be empty...!!</b>";
                    document.getElementById("lblMessage").style.color = "Blue";
                }

                else if (MobileExist == true) {
                    if (EmailId.toLowerCase() == element.value.toLowerCase()) {
                        EmailExist = true;
                        document.getElementById("lblMessage").innerHTML = "<b>User Details Found...</b>"
                        document.getElementById("lblMessage").style.color = "Green";

                        FillUserData();
                    }
                    //else if (EmailId == null)
                    //{
                    //     document.getElementById("lblMessage").innerHTML = "Email Address and Mobile Number field should not be empty...!!"  
                    //      document.getElementById("lblMessage").style.color = "Blue";
                    //}
                    else {
                        EmailExist = false;
                        document.getElementById("lblMessage").innerHTML = "<b>Email Address is not registred with Mobile Number Entered...</b>"
                        document.getElementById("lblMessage").style.color = "Red";
                        // alert("Your Mobile Number Matches with our records... do we know you ?");
                    }
                }

                else {
                    // alert("at 409 ==>>" + $("#inAddTMobile").val() == null);
                    document.getElementById("lblMessage").innerHTML = "<b>Mobile Number is not registered.. Register first.!!</b>"
                    document.getElementById("lblMessage").style.color = "Red";
                    //    GetUserByMail(element.value);
                }

            }
            catch (err) {
                document.getElementById("lblMessage").innerHTML = "Error validating mail"
                document.getElementById("lblMessage").style.color = "Red";
            }
        }

        function GetUserByMail(mail) {

            if (mail.length < 3) {

                return;
            }

            var url = api_url + "/api/Resident/Email/" + mail + "/";
            $.ajax({
                dataType: "json",
                url: url,
                success: function (data) {
                    if (data != null) {

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

                        document.getElementById("lblMessage").textContent = "Email Address Exist2";
                        document.getElementById("inAddTEmailID").disabled = false;
                        EmailExist = true;
                    }
                    else {
                        EmailExist = false;
                        document.getElementById("lblMessage").textContent = "Email Adress is not registered.. Register first.!! getbyemail";
                        document.getElementById("inAddTEmailID").disabled = false;
                    }

                },
                error: function (data, errorThrown) {
                    document.getElementById("lblMessage").innerHTML = "Could not validate, try again or later"

                    document.getElementById("inAddTEmailID").disabled = false;
                }

            });

        }

        function FillUserData() {
            document.getElementById("inAddTFirstName").value = FirstName;
            document.getElementById("inAddTAddress").value = BHK;
            document.getElementById("inAddTLastName").value = LastName;
            document.getElementById("inAddTEmailID").value = EmailId;
            document.getElementById("inAddTAddress").value = LastName;
            document.getElementById("inAddTParentName").value = LastName;
        }


        function AddUser() {
            if ((MobileExist == true && EmailExist == false) || (MobileExist == false && EmailExist == true)) {
                document.getElementById("lblMessage").innerHTML = "Either of Mobile and Email does not match, other property match;";
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
            ActiveDate = ChangeDateformat(document.getElementById("inAddTActiveDate").value);
            DeActiveDate = ChangeDateformat(document.getElementById("inAddTDeactiveDate").value);

            var e = document.getElementById("mgender");
            Gender = e.options[e.selectedIndex].text;
            var HouseID = 0;

            if (MobileExist == true && EmailExist == true) {
                // var reqBody = "{\"StartIndex\":" + minvalue + ",\"EndIndex\":" + maxvalue + "}";
                //var reqBody = "{\"UserType\":\"Tenant\", \"FirstName\":\"" + FirstName + "\",\"LastName\":\"" + LastName + "\", \"MobileNo\":\"" + MobileNo
                //    + "\", \"EmailId\":\"" + EmailId + "\", \"Address\":\"" + Address + "\", \"Gender\":\"" + Gender + "\", \"Parentname\":\"" + ParentName
                //    + "\", \"SocietyId\":" + SocietyID + ", \"UserLogin\":\"" + UserLogin + "\", \"Password\":\"" + Password + "\", \"FlatID\":\"" + FlatID + "\", \"HouseID\":\"" + HouseID + "}";

                var reqBody = "{\"FirstName\":\"" + FirstName + "\",\"LastName\":\"" + LastName + "\",\"Parentname\":\"" + ParentName + "\",\"Gender\":\"" + Gender + "\",\"Address\":\"" + Address + "\",\"MobileNo\":\"" + MobileNo + "\",\"EmailId\":\"" + EmailId + "\",\"UserLogin\":\"" + EmailId + "\",\"Password\":\"" + Password + "\"} ";
                var url = api_url + "/api/User/Add/Register";

                // alert(url);

                //AddTenant(100111);
                AddTenant(UserID);
                //$.ajax({
                //    dataType: "json",
                //    url: url,
                //    data: reqBody,
                //    type: 'post',
                //    async: false,
                //    contentType: 'application/json',
                //    success: function (data) {
                //        var da = JSON.stringify(data);
                //        //  alert(da);
                //        var js = JSON.parse(da);
                //        var Response = js.result;
                //        alert(jQuery.type(Response));
                //        alert(Response.localeCompare("Ok"));
                //        if (Response.localeCompare("Ok")===0) {
                //            document.getElementById("lblMessage").innerHTML = "User Login Created. Attaching User with Flat...";
                //            var UserID = js.UserData.UserID;
                //            alert(UserID);
                //            AddTenant(UserID);
                //        }
                //        else {
                //            document.getElementById("lblMessage").innerHTML = "Could not Add User, try again or later";
                //        }

                //    },
                //    error: function (data, errorThrown) {

                //        alert('User Creation failed :' + errorThrown);
                //        // sessionStorage.clear();
                //    }

                //});
                location.reload();
            }
            else {
                if (UserID != null) {
                    //AddTenant(UserID);
                    document.getElementById("lblMessage").innerHTML = "Could not Add User, try again or later";

                }

            }
        }

        function AddTenant(UserID) {
            var reqBody2 = "{\"UserID\":" + UserID + ",\"FlatID\":\"" + FlatID + "\",\"Type\":\"Tenant\",\"FirstName\":\"" + FirstName +
                "\",\"LastName\":\"" + LastName + "\",\"MobileNo\":\"" + MobileNo + "\",\"EmailId\":\"" + EmailId + "\",\"Addres\":\"" + Address +
                "\",\"Status\":\"2\",\"SocietyID\":\"" + SocietyID + "\",\"ActiveDate\":\"" + ActiveDate + "\",\"DeActiveDate\":\"" + DeActiveDate + "\"}";
            //document.getElementById("lblMessage").innerHTML = reqBody2;
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
            //var chkdate = new Date("10-12-1970");
            var date = new Date(inputdate);
            //alert("alert 607 ==>>inputdate date obj== " + chkdate);
            var day = date.getDate().toString();
            if (day.length == 1) { day = "0" + day; }

            var month = (date.getMonth() + 1).toString();
            if (month.length == 1) { month = "0" + month; }

            var year = date.getFullYear();

            var strDate = day + "/" + month + "/" + year;
            // alert("616 ===> strDate==" +  inputdate.getDate());
            return strDate;
        }

        function ReverseDateFormat(inputDate) {
            if (inputDate != undefined) {
                var date = inputDate.split("/");
                var newdate = date[2] + "-" + date[1] + "-" + date[0];
                return newdate;
            }
        }

        function PopulateAddModal() {


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

        function ChangeDeactiveDate() {
            document.getElementById("ChangeDate").style.display = "block";
            $('#newDeactiveDate').attr("min", ReverseDateFormat(ActiveDate))
            $('#newDeactiveDate').datetimepicker({
                format: 'YYYY-MM-DD'
            });

        }

        function UpdateDeactiveDate() {
            DeActiveDate = ChangeDateformat(document.getElementById("newDeactiveDate").value);

            var reqBody3 = "{\"id\":" + TenantResID + ",\"date\":\"" + DeActiveDate + "\"}";
            //  alert("662 ===>> "+DeActiveDate);
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
                        $("#ChangeDate").hide();
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


        //jQuery(document).ready(function () {

        //    //$("#chkUser").click(function () {
        //    //    $('#inAddTFirstName,#inAddTLastName,#inAddTParentName,#mgender,#inAddTAddress,#inAddPassword,#inTConfirmPassword').attr("disabled", $(this).is(":checked"));
        //    //    if ($(this).is(":checked")) {

        //    //        chkExistingUser = true;
        //    //    }
        //    //    else {

        //    //        chkExistingUser = false;
        //    //    }
        //    //});
        //    checkbox();
        //});

        function checkbox() {
            //  alert("672 ==>> " + jQuery.type($("#chkUser").is(":checked")));
            if ($("#chkUser").is(":checked")) {
                // alert("675 in if");
                $('#inAddTFirstName,#inAddTLastName,#inAddTParentName,#mgender,#inAddTAddress,#inAddPassword,#inTConfirmPassword').attr("disabled", "disabled");
                chkExistingUser = true;
            }
            else {
                //alert("681 in else");
                chkExistingUser = false;
            }

        }

        $(document).ready(function () {
            $("#btnCancel,#Close_mod").click(function () {
                $("#addTenantModal").hide();
            });
        });
        </script>
      
   
    <script id="Pool-Script">

        var MyPoolCount = 0;

        $(document).ready(function () {

            GetMyPoolOffers();

        });


        function GetMyPoolOffers() {

            var abs_url = api_url + "/api/CarPool/self/" + SocietyID + "/" + _ResID + "/0/20";

            $.ajax({
                url: abs_url,
                dataType: "json",
                success: MyPoolData,
                failure: function (response) {
                    alert(response.d);
                    sessionStorage.clear();
                }
            });

        };

        function MyPoolData(response) {
            var strMyData = "";
            $("#MyPool").html("");
            var results = response.$values;// jQuery.parseJSON(response.$values);
            MyPoolCount = results.length;
            if (results.length > 0) {
                for (var i = 0; i < results.length; i++) {

                    var JourneyDTime = DisplayDateTime(results[i].JourneyDateTime);
                    var ReturnDTime = DisplayDateTime(results[i].ReturnDateTime);
                    var SeatRemaining = parseInt(results[i].AvailableSeats) - parseInt(results[i].InterestedSeatsCount);

                    strMyData = strMyData + "<div class=\"col-xs-4\" style=\"margin:0px;padding:10px;\">"
                        + "<div class=\"panel panel-success\" >"
                        + "<div class='panel-heading'>"
                        + "<div> " + results[i].Destination + "<p> on </p>" + JourneyDTime + "</div>"
                        + "<div><label class='small_label'> " + results[i].InitiatedDateTime + " </label>" + "</div>"
                        + "</div>"
                        + "<div class='panel-body'> "

                        + "<div> <label class='data_label'> Description :  </label>  " + results[i].Description + "</div>"
                        + "<div> <label class='data_label'> Available :  </label>  " + SeatRemaining + " of " + results[i].AvailableSeats + "</div>"
                        + "<a class='dropdown-toggle' id='dropdownMenu1' onclick='ShowEngagement(" + results[i].VehiclePoolID + ")'><span class='fa fa-automobile' style='color:green;'></span></a>"

                        + "<div id='detail_" + results[i].VehiclePoolID + "' ></div>"
                        + "</div>"
                        + "<div class='panel-footer'><a onclick='CloseThisPool(" + results[i].VehiclePoolID + ")'><span class='fa fa-trash'></span></a>" + results[i].InterestedCount
                        + "</div>"
                        + "</div>"
                        + "</div>";

                }

            }
            else {
                strMyData = "<div class=\"col-xs-12\" style=\"margin:0px;padding:10px;\"> No Car Pool From me</div>"

            }
            $("#MyPool").html(strMyData);
        }


        function ShowEngagement(VehiclePoolID) {
            var abs_url = api_url + "/api/CarPool/self/" + VehiclePoolID;
            console.log(api_url);
            $.ajax({
                url: abs_url,
                dataType: "json",
                success: DisplayEngagement,
                failure: function (response) {
                    alert(response.d);
                    sessionStorage.clear();
                }
            });
        }

        function DisplayEngagement(data) {
            console.log(data);
            var engData = data.$values;


            var id = "detail_" + engData[0].VehiclePoolId;
            console.log(id);

            var strMyData = "";
            $("#poolInterest").html(strMyData);

            if (engData.length > 0) {
                for (var i = 0; i < engData.length; i++) {
                    var ImageSource = "GetImages.ashx?ResID=" + engData[i].ResID + "&Name=" + engData[i].FirstName + "&UserType= Owner";
                    //var JourneyDTime = DisplayDateTime(results[i].JourneyDateTime);
                    //var ReturnDTime = DisplayDateTime(results[i].ReturnDateTime);
                    //var SeatRemaining = parseInt(results[i].AvailableSeats) - parseInt(results[i].InterestedSeatsCount);

                    strMyData = strMyData

                        + "<div class='row' syle='border-bottom: solid 1 px #c9c9c9'>"
                        + "<div class='col-xs-2'></div>"
                        + "<div class=\"col-xs-4\" style=\"margin:0px;padding:10px;\">" + engData[0].FirstName + engData[0].LastName + "<br/>" + engData[0].FlatNumber + "<br/>" + engData[0].Mobile + "</div>"
                        + "<div class=\"col-xs-4\" style=\"margin:0px;padding:10px;\">" + "<img class='image_medium' src='" + ImageSource + "' />" + "</div>"
                        + "<div class='col-xs-2'></div>"
                        + "</div>";

                }

                $("#poolInterest").html(strMyData);

                $("#showInterestedInPool").show();

            }
            else {
                alert('No Data to Display');

            }

        }

        function ClosePoolInterested() {
            $("#showInterestedInPool").hide();
        }


        function CloseThisPool(VehiclePoolID) {
            selectedPoolId = VehiclePoolID;
            $("#showCloseModal").show();
        }
        function CloseCloseThisPool() {
            $("#showCloseModal").hide();
        }


        function ClosePoolOffer() {
            var CarPool = {};
            CarPool.VehiclePoolID = selectedPoolId;
            CarPool.ResID = <%=ResID%>;
            CarPool.Active = 0;

            var url = api_url + "/api/CarPool/Status";
            var CarPoolString = JSON.stringify(CarPool);

            $.ajax({
                dataType: "json",
                url: url,
                data: CarPoolString,
                type: 'post',
                async: false,
                contentType: 'application/json',
                success: function (data) {
                    if (data.Response == "Ok") {
                        $("#showCloseModal").hide();
                        GetMyPoolOffers();
                    }
                    else {
                        alert('Could not close : try later');
                    }

                },
                error: function (data, errorThrown) {
                    alert('Could not close :' + errorThrown);
                    // sessionStorage.clear();
                }

            });
        }

        $(function () {
            $('#time_return').datetimepicker({
                format: 'HH:mm'
            });
        });


        $(function () {
            $('#time_when').datetimepicker({
                format: 'HH:mm'
            });

            $('#date_when').datetimepicker({
                format: 'YYYY-MM-DD'
                // format: 'DD-MM-YYYY'
            });


            //$('#date_return').datetimepicker({ format: 'YYYY-MM-DD' });

            //$('#date_return').attr("min", "10-10-2020");
            //$('#newDeactiveDate').attr("min", "2020-06-10")

        });


        function ShowPoolModal() {

            if (MyPoolCount >= 2) {
                alert("You already have 2 pool offer. Close existing pools to create new");
            }
            else {
                $("#addCarPoolModal").show();
            }


        }


        function ClosePoolModal() {
            $("#addCarPoolModal").hide();
        }

        function AddPoolOffer() {
            $("#ProgressBar").show();
            var CarPool = {};
            CarPool.OneWay = 0;  // pool_type
            CarPool.PoolTypeID = 1; //pool_cycle   // 1, onetime, 2 for regular
            CarPool.Active = 1;
            CarPool.Destination = $("#destination").val();
            CarPool.InitiatedDateTime = GetDateTimeinISO(new Date());
            var date = $("#date_when").val();
            var time = $("#time_when").val();
            var datetime = date + "T" + time + ":00";
            CarPool.JourneyDateTime = datetime;
            var date_return = $("#date_return").val();
            var time_return = $("#time_return").val();


            var datetime_return = date_return + "T" + time_return + ":00";

            CarPool.ReturnDateTime = datetime_return;

            CarPool.VehicleType = $("#vehicle_type").val();
            CarPool.AvailableSeats = $("#seats").val();
            CarPool.SharedCost = $("#Shared_cost").val();
            CarPool.Description = $("#pool_description").val();
            CarPool.ResID = <%=ResID%>;
            CarPool.SocietyID = <%=SocietyID%>;

            var url = api_url + "/api/CarPool/Add";

            var CarPoolString = JSON.stringify(CarPool);

            console.log("CarPoolString " + CarPoolString);
            $.ajax({
                dataType: "json",
                url: url,
                data: CarPoolString,
                type: 'post',
                async: false,
                contentType: 'application/json',
                success: function (data) {
                    if (data.Response == "Ok") {
                        $("#addCarPoolModal").hide();
                        GetMyPoolOffers();
                    }
                    else {
                        alert('Could not add : try later');
                    }

                },
                error: function (data, errorThrown) {
                    alert('CarPool Creation failed :' + errorThrown);
                    // sessionStorage.clear();
                }

            });
            $("#ProgressBar").hide();
        }


    </script>

   <script id="inventoryData">

       $(document).ready(function () {
           api_url = '<%=Session["api_url"] %>';
           // populateType();
           //populateSelect();
           GetInventoryTypeData();
           GetAccomodationType(1);
           $('#InventoryType').on('change', function () {
               GetAccomodationType(this.value);

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


       function populateAccomodationType(data) {
           // THE JSON ARRAY.
           var Inventory = data.$values;

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
           document.location.reload();

       }


       function AddRentInventory() {

           var RentInventory = {};
           RentInventory.AccomodationTypeID = $("#AccomodationType").val();
           RentInventory.InventoryTypeID = $("#InventoryType").val();
           RentInventory.RentValue = $("#inRent").val();
           RentInventory.Available = true;
           RentInventory.Description = $("#description").val();
           RentInventory.ContactName = $("#contactName").val();
           RentInventory.ContactNumber = $("#contactNumber").val();
           RentInventory.UserID = <%=UserID%>;
           RentInventory.HouseID = 0;
           RentInventory.FlatID = FlatID;

           var url = api_url + "/api/RentInventory/New"

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

       function AddTenantDetails() {
           var data = "<div class=\"row\" style=\"margin-bottom: 5px;\">" +
               "<div class=\"col-sm-3 style=\"margin-top: 40px; margin-left: 10px;\">" +
               "<img id=\"TenantImage\" src=\"Images/Icon/profile.jpg\" height=\"150\" width=\"150\" style=\"border-radius: 50%;\" />" +
               "</div> <div class=\"col-sm-6\"> <h3 style=\"font-family: Open Sans; text-align: center;\"><b>Tenant Info</b></h3> </div>" +
               " <div class=\"row\" style=\"margin-top: 5px; margin-bottom: 5px;\">" +
               " <div class=\"col-sm-5\">" +
               "<label style=\"width: 100px;\" class=\"data_heading\">Name :</label>" +
               "<label class=\"data_label\" id=\"lblFlatTenantName\">...</label><br />" +
               "<label style=\"width: 100px;\" class=\"data_heading\">Email :</label>" +
               " <label style=\"width: 50px;\" class=\"data_label\" id=\"lblFlatTenantEmail\">...</label><br />" +
               " <label style=\"width: 100px;\" class=\"data_heading\">Contact :</label>" +
               " <label style=\"width: 50px;\" class=\"data_label\" id=\"lblFlatTenantMobile\">...</label><br />" +
               "<label style=\"width: 100px;\" class=\"data_heading\">Address :</label>" +
               "<label class=\"data_label\" id=\"lblFlatTenantAddress\">...</label><br />" +
               "<label style=\"width: 100px;\" class=\"data_heading\">From :</label>" +
               "<label style=\"width: 50px;\" class=\"data_label\" id=\"lblFlatTenantFrom\">...</label><br />" +
               "<label style=\"width: 100px;\" class=\"data_heading\">Till :</label>" +
               "<label style=\"width: 50px;\" class=\"data_label\" id=\"lblFlatTenantTo\">...</label>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp" +
               "<button id=\"btnEdit\" type=\"button\" class=\"btn btn-danger\" style=\"display: none\" onclick=\"ChangeDeactiveDate()\">Set End Date</button>" +
               " <div id=\"ChangeDate\" style=\"display: none\">" +
               "<input type=\"date\" id=\"newDeactiveDate\" style=\"width: 150px\" />" +
               "<button id=\"btnUpdate\" type=\"button\" onclick=\"UpdateDeactiveDate();\">Update</button>" +
               "</div>" +
               "</div>" +
               "</div>" +
               "</div>"
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
       function openForm() {
           document.getElementById("myForm").style.display = "block";
       }

       function closeForm() {
           document.getElementById("myForm").style.display = "none";
       }

       function pop_close() {
           CloseRental();
           PopulateAddModal();
       }
       function pop_open() {

           PopulateAddModal();
       }

       function fill() {
           var emailfield = document.getElementById("inAddTEmailID").value;
           var numberfield = document.getElementById("inAddTMobile").value;
           if (emailfield == null || numberfield == null) {
               alert("Email Address or Mobile Number should not be empty ..!");
           }
           else if (MobileExist && EmailExist) {
               GetUserByMail(emailfield);
               FillUserData();
           }
           else {

           }
       }


    </script>

<style>
    .data_label {
        color: #000;
    }



    .modal {
        display: none; /*  Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 100; /* Sit on top */
        padding-top: 8%; /* Location of the box */
        padding-bottom: 2%;
        left: 0px;
        border-radius: 5px;
        top: 0px;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /*Enable scroll if needed  */
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
                     <div id="AdminDetils" class="content_div">
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
                        <div class="row" style="margin-bottom: 5px;">
                            <div class="col-md-3">
                                <img src="Images/Icon/profile.jpg" id="OwnerImage" height="150" width="150" style="border-radius: 50%;" />
                            </div>
                            <div class="col-md-6">
                                <h3 style="font-family: Open Sans; text-align: center;"><b>Owner Info</b></h3>
                            </div>
                       
                        <div class="row" style="margin-top: 5px; margin-bottom: 10px;">                        
                            <div class="col-mds-5">
                                <label style="width: 100px;" class="data_heading">Name :</label>
                                <label style="width: 50%;" class="data_label" id="lblFlatOwner">...</label><br />
                                <label style="width: 100px;" class="data_heading">Email :</label>
                                <label style="width: 50%;" class="data_label" id="lblFlatOwnerEmail">...</label><br />
                                <label style="width: 100px;" class="data_heading">Contact :</label>
                                <label style="width: 50%;" class="data_label" id="lblFlatOwnerMobile">...</label>
                            </div>
                            </div>
                            </div>
                        </div>
                    </div>


                        <div id="TenantDetail" class="content_div">
                             <div class="row" style="margin-bottom: 5px;">
                                <div class="col-sm-3" style="margin-top: 40px; margin-left: 10px;">
                                    <img id="TenantImage" src="Images/Icon/profile.jpg" height="150" width="150" style="border-radius: 50%;" />
                                </div>
                                  <div class="col-sm-6">
                                         <h3 style="font-family: Open Sans; text-align: center;"><b>Tenant Info</b></h3>
                                  </div>
                               <div class="row" style="margin-top: 5px; margin-bottom: 5px;">
                                <div class="col-sm-5">
                                    <label style="width: 100px;" class="data_heading">Name :</label>
                                    <label class="data_label" id="lblFlatTenantName">...</label><br />
                                    <label style="width: 100px;" class="data_heading">Email :</label>
                                    <label style="width: 50px;" class="data_label" id="lblFlatTenantEmail">...</label><br />
                                    <label style="width: 100px;" class="data_heading">Contact :</label>
                                    <label style="width: 50px;" class="data_label" id="lblFlatTenantMobile">...</label><br />
                                    <label style="width: 100px;" class="data_heading">Address :</label>
                                    <label class="data_label" id="lblFlatTenantAddress">...</label><br />
                                    <label style="width: 100px;" class="data_heading">From :</label>
                                    <label style="width: 50px;" class="data_label" id="lblFlatTenantFrom">...</label><br />
                                    <label style="width: 100px;" class="data_heading">Till :</label>
                                    <label style="width: 50px;" class="data_label" id="lblFlatTenantTo">...</label>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                                    <button id="btnEdit" type="button" class="btn btn-danger" style="display: none" onclick="ChangeDeactiveDate()">Set End Date</button>
                                    <div id="ChangeDate" style="display: none">
                                        <%--<input type="date" id="newDeactiveDate" style="width: 150px" />--%>

                                        <div class="row" style="margin-top: 10px;">
                            
                               
                             <div class="col-sm-8">  
                               
                                    <%--<input type='date'  id='date_return' max='' min='10-09-2019' class="form-control"  tabindex="7" />--%>
                                 <input type='text'  id='newDeactiveDate' class="form-control" placeholder="DD/MM/YYYY" tabindex="5"  />
                                 
                              </div>
                          
                              <div class="col-sm-4">
                                  <button id="btnUpdate" type="button" onclick="UpdateDeactiveDate();">Update</button>
                              </div>

                                    <button id="btnEdit" type="button" class="btn btn-danger" style="display: none;" onclick="ChangeDeactiveDate()">Set End Date</button>
                                    <div id="ChangeDate" style="display: none; margin-top: 10px;" class="row" >
                                      <%--  <input type="date" id="newDeactiveDate" style="width: 150px" />--%>

                                    
                          
                                         <div class="col-sm-8">  
                               
                                   
                                           <input type='text'  id='newDeactiveDate' class="form-control" placeholder="DD/MM/YYYY" tabindex="5"  />
                                 
                                          </div>
                                        <div class=" col-sm-4 "> 
                                
                                            <button id="btnUpdate" type="button" onclick="UpdateDeactiveDate();">Update</button>

                                        </div>
                             

                                    </div>


                                        <%--<button id="btnUpdate" type="button" onclick="UpdateDeactiveDate();">Update</button>--%>
                                
                                 </div> 
                                </div>
                               </div>
                            </div>
        
                     <div class="row" style="margin-left:10px; margin-right:10px;">
                         <div class="col-sm-12">
                             <button id="btnAdd" class="btn btn-info btn-sm" onclick="PopulateAddModal2()" type="button">Add Tenant</button>
                             <button id="btnAddForRent" class="btn btn-primary btn-sm" onclick="InitiateRent()" type="button">Add for Rent</button>
                        
                             <%--<button id="" type="button" class="btn btn-primary btn-sm" onclick="InitiateRent()">Add for Rent</button>--%>
                         </div>


                    </div>
                    <div id="RentalDetail" class="content_div">
                        <div class="row" style="margin-bottom: 5px; text-align: center;">
                            <div class="col-xs-12">
                                <h3 style="font-family: Open Sans; text-align: center;"><b>Rental offer</b></h3>

                            </div>
                        </div>
                        <div class="row" style="margin-top: 20px; margin-bottom: 10px;">

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
                                <label style="width: 100px;" class="data_heading">Number :</label>
                                <label class="data_label" id="lblRentContactNumber">...</label><br />
                                <label style="width: 100px;" class="data_heading">other</label>
                                <label class="data_label" id="">...</label>
                            </div>
                            <div class="col-sm-12">
                                <label style="width: 100px;" class="data_heading">Description :</label>
                                <label class="data_label" id="lblRentDescription">...</label>
                            </div>

                            <div class="col-xs-12" id="Close">
                                <button id="btnClose" type="button" class="btn btn-primary btn-sm pull-right" onclick="CloseRental();">Close</button>
                            </div>
                        </div>


                    </div>

                                <div id="PoolData" class="content_div" style="margin-left:10px; margin-right:10px;">
                                    <button class="btn btn-primary" onclick="ShowPoolModal()">Add New Trip</button>
                                </div>
                                        
                <div id="MyPool"></div>
                                
             
                    <div id="addTenantModal" class="modal">
                        <div class="modal-content" style="border: 0px solid; width: 550px; margin: auto;">

                            <div class="modal-header" style="color: white; background-color: #5ca6de; height: 50px;">
                                <button type="button" id="Close_mod" class="close" data-dismiss="modal" style="color: #000;">&times;</button>
                                <h4 id="title" class="modal-title" style="margin-top: 5px;">Add Tenant to:
                                     <var>FlatNumber</var></h4>
                            </div>

                            <div class="modal-body">

                           <b style="color:midnightblue; font-weight:600; font-size:14px">  Enter Mobile Number and Email Address of a Registered User ...</b>
                                <input id="chkUser" type="checkbox" style="display:none;"/>
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
                            
                            <h4 id="close" class="modal-title" >Close for Rent:<var>House Number</var></h4>
                            </div>
                            <div class="layout_modal_body container-fluid">
                              ! please confirm if you want to close
                            </div>

                            <div class="panel-footer" style="text-align: right;">
                                <button type="button" id="btnCloseCancel" style="margin-top: 5px;" onclick="CloseCloseBox()" data-dismiss="modal" class="btn btn-danger">Cancel</button>
                                <button type="button" id="btnCloseSubmit" style="margin-top: 5px;" onclick="CloseRentInventory();" class="btn btn-primary">Submit</button>

                            </div>
                        </div>
                    </div>


                 <div id="addCarPoolModal" class="modal">
                       <div class="modal-content" style="border-radius:5px; width: 580px; margin: auto;margin-top:0px">

                <div class="modal-header" style="color: white; background-color: #337ab7; height: 50px;">
                    <i class="fa fa-close" style="float:right;cursor:pointer;" onclick="ClosePoolModal()"></i>
                    
                    <h4 id="" class="modal-title" style="margin-top: 5px;font-family:Helvetica Neue,Helvetica,Arial,sans-serif; font-size:14px">Offer for Pool:</h4>
                </div>
                <div class="layout_modal_body container-fluid">
                    <form name="CarPool">
                      
                        <div class="row" style="margin-top: 20px;">

                            <div class="col-sm-6">
                                <label class="labelwidth col-sm-4 col-form-label">Type :</label>
                                <div class="col-sm-8">
                                <select id="pool_type" class="form-control form-control-sm" onblur="" tabindex="1" >
                                    <option "1">One Way</option>
                                    <option "2">Two Way</option>
                                </select>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <label class="labelwidth col-sm-4 col-form-label">Duration</label>
                                <div class="col-sm-8">
                                <select id="pool_cycle" class="form-control form-control-sm" onblur="" tabindex="2" >
                                    <option>One Time</option>
                                    <option>Daily</option>
                                </select>
                            </div>
                            </div>
                        </div>
                        <div class="row"style="margin-top: 10px;" >
                            <div class="col-sm-6">
                                <label class="labelwidth col-sm-4 col-form-label">Where: </label>
                                <div class="col-sm-8">
                                <input type="text" id="destination" class="form-control form-control-sm" onblur="" tabindex="3" />
                               </div>
                            </div>
                            <div class="col-sm-6">
                                <label class="labelwidth col-sm-4 col-form-label">Available Seat</label>
                                <div class="col-sm-8">
                                <input type="number" id="seats"  class="form-control form-control-sm" tabindex="4" />
                            </div>
                          </div>
                        </div>
                        <div class="row" style="margin-top: 0px;">
                            <div class="col-sm-6">
                                <label class="labelwidth col-sm-4 col-form-label">When: </label>
                                <div class="col-sm-8">
                                <%--<div class="form-group">
                                <div class='input-group date'>--%>
                                    <input type='text'  id='date_when' class="form-control" placeholder="DD/MM/YYYY" tabindex="5"  />
                              <%--      <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                             </div>--%>
                                </div>
                                </div>
                            <div class="col-sm-6">
                                <label class="labelwidth col-sm-4 col-form-label">Time:</label>
                                <div class="col-sm-8">
                                
                                         <input type='text'  id='time_when' class="form-control" placeholder="00 : 00 AM" tabindex="6" />
                                        
                               </div>
                            </div>
                        </div>
                         <div class="row" style="margin-top: 10px;">
                            <div class="col-sm-6">
                                <label class="labelwidth col-sm-4 col-form-label">Return:</label>
                             <div class="col-sm-8">  
                               
                                    <%--<input type='date'  id='date_return' max='' min='10-09-2019' class="form-control"  tabindex="7" />--%>
                                 <input type='text'  id='date_return' class="form-control" placeholder="DD/MM/YYYY" tabindex="5"  />
                                 
                              </div>
                            </div>
                             <div class="col-sm-6">
                                 <label class="labelwidth col-sm-4 col-form-label">Time:</label>
                                 <div class="col-sm-8">
                                         <input id='time_return' type='text' placeholder="00 : 00 AM" class="form-control" tabindex="8" />
                                 </div>
                             </div>
                        </div>
                        <div class="row" style="margin-top:10px;">
                            <div class="col-sm-6">
                                <label class="labelwidth col-sm-4 col-form-label">Vehicle Type:</label>
                                 <div class="col-sm-8">
                                <input id="vehicle_type" class="form-control form-control-sm" tabindex="9" />
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <label class="labelwidth col-sm-4 col-form-label">Cost / Seat</label>
                                <div class="col-sm-8">
                                <input id="Shared_cost" type="number" class="form-control form-control-sm" tabindex="10" />
                            </div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 5px; margin-bottom: 15px">
                            <div class="col-sm-12">
                                <label class="labelwidth col-sm-2 col-form-label">Description:</label>
                                <div class="col-sm-10">
                                <input type="text" id="pool_description" class="form-control form-control-lg" style="max-height:inherit" tabindex="11"  />
                                </div>
                            </div>
                        </div>
                        </form>
                    </div>

                    <div class="panel-footer" style="text-align: right;">
                        <button type="button" id="btnPoolCancel" style="margin-top: 5px;" onclick="ClosePoolModal()" data-dismiss="modal" class="btn btn-danger">Cancel</button>
                        <button type="button" id="btnPoolSubmit" style="margin-top: 5px;" onclick="AddPoolOffer();" class="btn btn-primary">Submit</button>
                    </div>
                </div>

            <div id="invProgressBar" class="container-fluid" style="text-align: center; height: 200px; display: none;">
                <img src="Images/Icon/ajax-loader.gif" style="width: 20px; height: 20px; margin-top: 50px;" />
            </div>
        </div>

           

                   <div id="showCloseModal" class="modal">
                    <div class="modal-content"style="border-radius:5px; width: 350px; margin: auto; margin-top:150px;position:relative;">

                        <div class="modal-header" style="color: white; background-color: #337ab7; height: 50px;">
                              <i class="fa fa-close" style="float:right;cursor:pointer;" onclick="CloseCloseThisPool()"></i>
                            <h4 id="close_Close" class="modal-title" style="margin-top: 5px;font-family:Helvetica Neue,Helvetica,Arial,sans-serif; font-size:14px">Close Selected Pool</h4>
                   
                        </div>

                        <div class="modal-body">
                            <div class="row">
                                <div class="col-sm-12">
                                    <label class="labelwidth col-sm-4 col-form-label">Seats: </label>
                                    <div class="col-sm-8">
                                    <input id="close_seats" type="number" onblur="" class="form-control form-control-sm" tabindex="1"/>
                                    </div>
                                </div>
                            </div>
                            <div class="row" style="margin-top: 10px; margin-bottom: 10px">
                                <div class="col-sm-12">
                                    <label class="labelwidth col-sm-4 col-form-label">Comments:</label>
                                 <div class="col-sm-8">
                                    <input id="close_comments"  class="form-control rows="2" form-control-sm" tabindex="2" />
                                </div>
                              </div>
                            </div>
                        </div>

                        <div class="panel-footer" style="text-align: right;">
                            <button type="button" id="btnCloseClosePool" style="margin-top: 5px;" onclick="CloseCloseThisPool()" data-dismiss="modal" class="btn btn-danger">Cancel</button>
                            <button type="button" id="btnClosePoolSubmit" style="margin-top: 5px;" onclick="ClosePoolOffer();" class="btn btn-primary">Submit</button>

                        </div>

                          <div id="closeProgressBar" class="container-fluid" style="text-align: center; height: 200px; position:absolute;">
                                <img src="Images/Icon/ajax-loader.gif" style="width: 20px; height: 20px; margin-top: 50px;" />
                            </div>

                    </div>
                    </div>

            <br />

                <div id="showInterestedInPool" class="modal">
                    <div class="modal-content"style="border-radius:5px; width: 350px; margin: auto; margin-top:150px;position:relative;">

                        <div class="modal-header" style="color: white; background-color: #337ab7; height: 50px;">
                              <i class="fa fa-close" style="float:right;cursor:pointer;" onclick="ClosePoolInterested()"></i>
                            <h4 id="PoolInterested_Close" class="modal-title" style="margin-top: 5px;font-family:Helvetica Neue,Helvetica,Arial,sans-serif; font-size:14px">Interested in Pool</h4>
                   
                        </div>

                        <div class="modal-body">
                            <div class="row" id="poolInterest">
                               
                            </div>
                     
                        </div>

                    
                    </div>
                    </div>

            </div>


        </div>
    <!-- Alert popup -->
    
                <button id="pop_pop" class="open-button" onclick="openForm()" hidden></button>
                <div class="form-popup" id="myForm">
                  <form action="/action_page.php" class="form-container">     
                      <p style="font-family: 'Times New Roman'; font-size: 20px; text-align: center;">Do you want to remove your rental Information ?</p>
                      <button type="button" class="btn btn-primary " onclick="pop_close()">YES</button>
                      <button type="button" class="btn btn-primary " onclick="pop_open()">No</button>
                      <button type="button" class="btn cancel" onclick="closeForm()">Close</button>
                  </form>
                </div>

   
        <!-- Alert popup End-->
  
</body>
</html>
