rr<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Totalusers.aspx.cs" Inherits="Totalusers" %>

<!DOCTYPE html>
<!--  This Total  code  is  licenced
    Developed By Anvisys Technologies Pvt Ltd.
    
    Copyright © 2016 Anvisys Technologies Pvt. Ltd.All rights reserved.
    -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="Page-Enter" content="blendTrans(Duration=.3)" />
    <meta http-equiv="Page-Exit" content="blendTrans(Duration=.3)" />


    <script src="Scripts/jquery-1.11.1.min.js"></script>
    <link rel="stylesheet" href="CSS/NewAptt.css" />
    <link rel="Stylesheet" href="CSS/ApttTheme.css" />
    <link rel="stylesheet" href="CSS/ApttLayout.css" />


    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css" />

    <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>
    <link rel="Stylesheet" href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.10/themes/redmond/jquery-ui.css" />
    
    <script type="text/javascript">

        var CurrentUserType;

        function myFunction() {

            $("#lblScreen").text(window.innerWidth);
            if (window.innerWidth <= 768) {

                hideColumn();
            }
            else {
                showColumn();
            }

        }

      

        $(function () {
            $("#txtUserSrch,#txtFlatNoFilter").autocomplete({
                source: function (request, response) {
                   
                    var param = {
                        FlatNumber: $('#txtUserSrch,#txtFlatNoFilter').val(),
                                          };

                    $.ajax({
                        url: "Totalusers.aspx/GetFlatNumber",
                        data: JSON.stringify(param),
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataFilter: function (data) { return data; },
                        success: function (data) {

                            response($.map(data.d, function (item) {
                                return {
                                    value: item
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
                minLength: 2 //This is the Char length of inputTextBox  
            });
        });

        function DConfirmationbox() {
            var result = confirm('Are you sure you want to Deactivate selected User(s)?');

            if (result) {
                return true;
            }
            else {
                return false;
            }
        }

        $(function ShowSelected() {
            $("[id*=UserGrid] td:has(button)").bind("click", function () {
                var row = $(this).parent();
                $("[id*=UserGrid] tr").each(function () {
                    if ($(this)[0] != row[0]) {
                        $("td", this).removeClass("selected_row");
                    }
                });
                $("td", row).each(function () {
                    if (!$(this).hasClass("selected_row")) {
                        $(this).addClass("selected_row");
                    } else {
                        $(this).removeClass("selected_row");
                    }
                });
            });
        });

        $(document).ready(function () {
            $(document).on('click', function () {
                console.log("click");
            });
        });


        $(document).ready(function () {
            $(document).click(function () {

                $("#resident_dropdown").hide();
            });
           //CurrentUserType = '<%=Session["UserType"] %>';aDD
            //Added by Aarshi on 18 auh 2017 for session storage
            CurrentUserType ='<%=SessionVariables.UserType %>';

        });

        $(document).ready(function () {


            $("[id*=UserGrid] td:has(button)").bind("click", function (event) {
                var row = $(this).parent();

                $("td", row).each(function () {

                    if ($('#resident_dropdown').is(':visible')) {
                        $("#resident_dropdown").show();
                    } else {

                        $("#resident_dropdown").hide();
                    }
                });

                //event.stopPropagation();
            });

        });

        function PageIndexChange() {

            $("[id*=UserGrid] td:has(button)").bind("click", function (event) {
                var row = $(this).parent();

                $("td", row).each(function () {

                    if ($('#resident_dropdown').is(':visible')) {
                        $("#resident_dropdown").show();
                    } else {

                        $("#resident_dropdown").hide();
                    }
                });

                //event.stopPropagation();
            });

        }

        function ShowDialog(UserID, Type, FlatNumber, DeactiveDate, theElement) {


            document.getElementById("HiddenField1").value = UserID;
            document.getElementById("HiddenField2").value = FlatNumber;
            document.getElementById("HiddenDeactivedate").value = DeactiveDate;

            var Posx = 0;
            var Posy = 0;

            while (theElement != null) {
                Posx += theElement.offsetLeft;
                Posy += theElement.offsetTop;
                theElement = theElement.offsetParent;
            }

            document.getElementById("resident_dropdown").style.top = Posy + 'px';
            document.getElementById("resident_dropdown").style.left = Posx + 'px';
            $("#resident_dropdown").slideDown();
            event.stopPropagation();
        }



        function CheckOtherIsCheckedByGVID(rb) {
            var isChecked = rb.checked;
            var row = rb.parentNode.parentNode;

            var currentRdbID = rb.id;
            //parent = document.getElementById("");
            //var items = parent.getElementsByTagName('input');

            //for (i = 0; i < items.length; i++) {
            //    if (items[i].id != currentRdbID && items[i].type == "radio") {
            //        if (items[i].checked) {
            //            items[i].checked = false;
            //        }
            //    }
            //}
        }


        function HideUserLabel() {
            document.getElementById('<%= lblCheckDeactive.ClientID %>').style.display = "none";
        }
        setTimeout("HideUserLabel();", 4000);

        function HideUserEdiitLabel() {
            document.getElementById('<%= lbleditstatus.ClientID %>').style.display = "none";
        }
        setTimeout("HideUserEdiitLabel();", 3000);



        //   $(document).ready(function () {
        // $("#btnusersEdit").click(function () {
        //     $("#myModalEditPopup").show();
        // });
        //});

        $(document).ready(function () {

                $('#chkChangePassword').click(function () {
                if ($(this).is(':checked')) {
                    $("#tdCnfPwd").show();
                    $("#tdNewPwd").show();
                    $(".UserEditInfo").attr("readonly", true);
                    $("#hiddenChangeField").val("Password");

                } else {
                    $("#tdCnfPwd").hide();
                    $("#tdNewPwd").hide();
                    $(".UserEditInfo").attr("readonly", false);
                    $("#hiddenChangeField").val("UserInfo");
                }
            });

             $("#Users_Add_Data").click(function () {
                $(".dropdown-content").toggle();
            });

              $("#dropdown-sample").mouseleave(function () {
                $("#dropdown-sample").hide();
            });

             $("#Add_Resident").click(function () {

                $("#myModalPopup").show();

            });

            $("#Cancel_Popup").click(function () {
                $("#myModalPopup").hide();
                $("input:text").val("");
                $("#lblstatus").html('');

            });

              $("#Edit_Cancel,#Cross_Cancel").click(function () {
                $("#myModalEditPopup").hide();
                // $("#EditHidedenFlat").val("");
                $("#lblEditMobileCheck").html('');
                $("#lblEditEmailCheck").html('');
            });

             $("#btnDactiveUsrCancel,#Cross_cancel").click(function () {
                $("#confirmDeactivatBox").hide();
                //$("#HiddenCompDeactiveID").val("");
            });

              $("#btnDeactiveUserConfirm").click(function () {
                $("#confirmDeactivatBox").hide();
                $("#HiddenCompDeactiveID").val("");
            });

            $("#txtEndDate").datepicker({ dateFormat: 'dd-mm-yy' });

             $("#txtStartDate").datepicker({ dateFormat: 'dd-mm-yy' });
        });

       
          

        function ShowAddTenant() {
            setTimeout(function () {

                document.getElementById("myModalPopup").style.display = "block";
            }, 1000);
        }


        function HideAddRes() {
            $("#myModalPopup").hide();
        }

        function AddUserClick() {
           
            // $('[id$=btnAdduserres]').attr("disabled", "disabled")

        }

        function Verify() {
            if ($('#chkChangePassword').is(':checked')) {
                $("#tdCnfPwd").show();
                $("#tdNewPwd").show();
                $(".UserEditInfo").attr("readonly", true);
                $("#hiddenChangeField").val("Password");

            } else {
                $("#tdCnfPwd").hide();
                $("#tdNewPwd").hide();
                $(".UserEditInfo").attr("readonly", false);
                $("#hiddenChangeField").val("UserInfo");
            }
        }


        function ShowUserInfo(IntercomNumber, EmailId) {
            alert(IntercomNumber + ", " + EmailId);

        }

        function CloseAddResident() {
            $("#myModalPopup").hide();
        }


        //$(document).ready(function () {
        //    $('table[id$="residentsDataList"] tr:even').css("background-color", "#EEEEEE");
        //    $('table[id$="residentsDataList"] tr:odd').css("background-color", "#AAAAAA");
        //});


        function ShowEditForm(UserID, FirstName, LastName, MobileNo,ParentName, EmailId, type, FlatNumber, DeactiveDate) {
           // document.getElementById("EditHidedenFlat").value = UserLogin;
            document.getElementById("HiddenField1").value = UserID;
            document.getElementById("HiddenField2").value = FlatNumber;
            document.getElementById("HiddenDeactivedate").value = DeactiveDate;


            //document.getElementById("txtEditFlatNumber").value = FlatNumber;
            $("#txtEditFlatNumber").val(FlatNumber);


            $("#txtEditFirstname").val(FirstName);
            //$("#txtEditMiddlename").val(MiddleName);
            $("#txtEditlastname").val(LastName);
            $("#txtEditusrParentN").val(ParentName);
            $("#txtEditMobileNo").val(MobileNo);
            $("#txtEditEmailID").val(EmailId);

           

            $("#myModalEditPopup").show();
        }

        function ShowDeactivateForm(UserID, type, FlatNumber, DeactiveDate) {

            document.getElementById("HiddenField1").value = UserID;
            document.getElementById("HiddenField2").value = FlatNumber;
            document.getElementById("HiddenDeactivedate").value = DeactiveDate;
            $("#confirmDeactivatBox").show();
        }

        function ShowActivateForm(UserID, type, ResID, DeactiveDate) {

             document.getElementById("HiddenField1").value = UserID;
            document.getElementById("HiddenField2").value = ResID;
       
            $("#confirmActivateBox").show();

        }

        function CancelActivate() {
             $("#confirmActivateBox").hide();
        }

        function ActivateResult(result) {

            if (result) {
                $("#confirmAcconfirmActivateBoxtivateBox").hide();
                $("#lblHeaderMessage").text("Resident Activated");
            }
            else {
                 $("#confirmActivateBox").hide();
                $("#lblHeaderMessage").text("Failed to Activate Resident");
            }
        }


        function validateEmail(emailField){
        var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;

        if (reg.test(emailField.value) == false) 
        {
            alert('Invalid Email Address');
            return false;
        }

        return true;

}
         function isNumberKey(evt)
      {
         var charCode = (evt.which) ? evt.which : evt.keyCode;
         if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;    
         return true;
        }


    </script>


    <style>
            .glyphicon {
                   background-color: #607d8b;
    padding: 10px;
    margin-left: -3px;
    top: 0px!important;
    
            }
        .lbltxt {
            font-size:16px!important;
        }
        .txtbox_style {
            height:30px;
            margin-top: 3px;
                width: 100%!important;
        }
        .Zero_margin {
            margin: 0px;
        }
        .lblHead {
    width: 48%!important;
}
        .selected_row {
            background-color: #4598c8;
            color: white;
        }

        .Deactivate_button {
            padding: 1% 0 1% 0;
            color: white;
            border: none;
            background-color: #5ca6de;
        }

        .lbltxt {
            padding-left: 3%;
            font-size: small;
        }

        .modal {
            display: none; /*  Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 10; /* Sit on top */
            padding-top: 2%; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /*Enable scroll if needed  */
            background-color: #e6e2e2;
            background-color: rgba(0,0,0,0.4);
        }



        .Resident_table {
            background-color: #faf9f9;
            border-radius: 10px 10px 10px 10px;
            border-collapse: collapse;
            margin: 5px;
            /* border: 1px solid #c1c1c1;*/
            box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2), 0 5px 10px 0 rgba(0, 0, 0, 0.19);
            width: 100%;
            text-align: center;
            padding: 4%;
        }
        .topbar_style {
            border-radius:0px;
        }

        .message {
            text-align: center;
            color: #f2eeee;
            padding: 2% 0 2% 0;
            margin-bottom: 8px;
            border-bottom: 1px solid #bfbfbf;
            font-size: medium;
            font-family: 'Bookman Old Style';
            background-color: #7cb2db;
        }

        .message_Below {
            text-align: center;
            padding: 3% 0 2% 0;
            color: #a19b9b;
        }

        .auto-style2 {
            height: 35px;
        }

        .odd-row :nth-child(even) {
            background-color: #dcdcdc;
        }

        .odd-row :nth-child(odd) {
            background-color: #aaaaaa;
        }
    </style>

</head>
<body onresize="myFunction()" style="background-color: #f7f7f7">

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-10">

                <form id="form1" runat="server">
                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                    <div>
                        <div class="container-fluid">

                            <div class="row" style="height: 56px; margin-top: 15px;">
                                <div class="col-sm-4 hidden-xs">
                                    <h4 style="margin: 0px">Resident:</h4>
                                </div>
                                <div class="col-sm-3 col-xs-4 zero-margin">
                                    <div class="form-group">
                                        <asp:DropDownList ID="drpResidentFilter" runat="server" CssClass="topbar_style form-control">
                                            <asp:ListItem Selected="True">Owner & Tenant</asp:ListItem>
                                            <asp:ListItem>Owner</asp:ListItem>
                                            <asp:ListItem>Tenant</asp:ListItem>

                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-sm-2 col-xs-2 zero-margin">
                                    <asp:TextBox ID="txtFlatNoFilter" placeholder="Flat Number" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="col-sm-1 col-xs-1 zero-margin">
                                    <asp:LinkButton runat="server" BackColor="Transparent" ForeColor="Black" ValidationGroup="Flat_Search" OnClick="btnSearch_OnClick"> 
                                       <span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                </div>
                                <div class="col-sm-2 col-xs-5">
                                    <asp:LinkButton ID="btnReview" CausesValidation="false" runat="server" OnClick="btnReview_OnClick">
                                        <asp:Label runat="server" ID="lblInReview" ForeColor="Black"></asp:Label></asp:LinkButton>
                                    <button type="button" id="Add_Resident" class="btn btn-sm btn-primary pull-right">Add User</button>
                                </div>
                            </div>
                            <div class="row">
                                <label id="lblHeaderMessage"></label>
                            </div>
                            <%--   <div class="row layout_header theme_third_bg font_size_2 vcenter" style="height: 40px; margin: 0px; display: none;">
                                <div class="col-xs-3 hidden-xs">
                                    <div>
                                        <label class="pull-left ">Resident : </label>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-xs-6">

                                    <div class="layout_filter_box" style="width: 260px;">
                                        <asp:DropDownList ID="drpUserResTypeFilter" runat="server" CssClass="layout_ddl_filter">
                                            <asp:ListItem Value="0">Owner & Tenant</asp:ListItem>
                                            <asp:ListItem>Owner</asp:ListItem>
                                            <asp:ListItem>Tenant</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtUserSrch" runat="server" Width="100px" placeholder="Flat Number" CssClass="layout_txtbox_filter" ValidationGroup="Search"></asp:TextBox>
                                        <asp:LinkButton runat="server" BackColor="Transparent" ForeColor="Black" CausesValidation="false" OnClick="ImgFltSearch_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                    </div>
                                </div>
                                <div class="col-xs-3 hidden-xs" style="vertical-align: middle;">
                                    <div>
                                        <%--<a  id="Add_Resident" class="Add_Button" style="cursor:pointer;">Add Resident</a> --%>
                        </div>
                        <%-- </div>
                            </div>--%>
                    </div>

                    <div id="confirmDeactivatBox" class="modal">
                        <div class="container-fluid" style="margin-top: 50px; width: 350px;">
                            <div class="panel panel-primary" style="position: relative; margin: 0px;">
                                <div class="panel-heading">
                                    Delete Confirmation
                        <span class="fa fa-times" id="Cross_cancel" style="float: right; cursor: pointer;"></span>
                                </div>
                                <div class="panel-body">

                                    <table>
                                        <tr>
                                            <td colspan="2" style="text-align: center;">You  are about  to  Deactivate  Resident,  it  will permanantly  Deactivated from database Continue ?
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="height: 15px;"></td>
                                        </tr>

                                    </table>
                                </div>
                                <div class="panel-footer" style="text-align: right;">
                                    <asp:Button ID="btnDeactiveUserConfirm" CausesValidation="false" CssClass="btn btn-primary" runat="server" OnClick="btnDeactiveUserConfirm_Click" Text="Yes" />
                                    <button type="button" id="btnDactiveUsrCancel" class="btn btn-danger">No</button>
                                </div>
                            </div>
                        </div>
                    </div>

                        <div id="confirmActivateBox" class="modal">
                        <div class="container-fluid" style="margin-top: 50px; width: 350px;">
                            <div class="panel panel-primary" style="position: relative; margin: 0px;">
                                <div class="panel-heading">
                                    Delete Confirmation
                                    <span class="fa fa-times" onclick="CancelActivate()" id="cancelAct" style="float: right; cursor: pointer;"></span>
                                </div>
                                <div class="panel-body">

                                    <table>
                                        <tr>
                                            <td colspan="2" style="text-align: center;">Activate  Resident
                                            </td>
                                        </tr>
                                        <tr>
                                              <td  style="height: 15px;">  Active From </td>
                                         <td  style="height: 15px;">   <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" ></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                             <td  style="height: 15px;">  Active Till </td>
                                         <td  style="height: 15px;">   <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control"  onchange="ValidateDate()"  ></asp:TextBox></td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="panel-footer" style="text-align: right;">
                                    <asp:Button ID="btnActivate" CausesValidation="false" CssClass="btn btn-primary" runat="server" OnClick="btnActivateUser_Click" Text="Yes" />
                                    <button type="button" onclick="CancelActivate()" class="btn btn-danger">No</button>
                                </div>
                            </div>
                        </div>
                    </div>


                    <asp:HiddenField ID="HiddenCompDeactiveID" runat="server" />
                    <div id="UserTable" class="row" style="margin: 1px;">

                        <div class="col-sm-12 ">
                            <asp:MultiView ID="MultiView1" runat="server">
                                <asp:View ID="View1" runat="server">
                                    <asp:DataList
                                        ID="residentsDataList" runat="server" HorizontalAlign="Center"
                                        RepeatColumns="1" RepeatDirection="Horizontal" Width="100%" OnSelectedIndexChanged="ResidentList_DataBound">

                                        <ItemStyle />
                                        <ItemTemplate>

                                            <div class="row layout_shadow_table" style="margin-left: 10px;">

                                                <div class="col-sm-4 col-xs-4" style="text-align: center;">

                                                    <img class="profile-image" src='<%# "GetImages.ashx?ResID="+ Eval("ResID")+"&Name="+Eval("FirstName") +"&UserType="+Eval("Type") %>' />
                                                    <br />

                                                    <%# Eval("FirstName") +" " + Eval("LastName") %> , <%# Eval("FlatNumber") %>
                                                    <br />
                                                    <hr style="margin: 0px;" />
                                                    <%# Eval("Type") %>
                                                </div>

                                                <div class="col-sm-4 col-xs-4">
                                                    <br />
                                                    <span class="fa fa-envelope" style="color: blue;"></span><%# Eval("Emailid") %>
                                                    <br />

                                                    <%--<span class="fa fa-phone-square" style="color:blue;"></span> <%# Eval("IntercomNumber") %><br />--%>
                                                    <span class="fa fa-phone" style="color: blue;"></span><%# Eval("MobileNo") %>
                                                    <%# Eval("ParentName") %>
                                                    <br />
                                                    <span class="fa fa-clock-o" style="color: blue;"></span><%# Eval("ActiveDate","{0:dd MMM,yy}") %>
                                                    <br />
                                                </div>


                                                <div class="col-sm-4 col-xs-4">
                                                    <div class="btn-group">
                                                        <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                            Action <span class="caret"></span>
                                                        </button>
                                                        <ul class="dropdown-menu">
                                                            <li><a href="#" onclick="ShowEditForm('<%# Eval("UserID") %>' ,'<%# Eval("FirstName") %>' ,'<%# Eval("LastName") %>','<%# Eval("MobileNo") %>','<%# Eval("ParentName") %>','<%# Eval("EmailId") %>' ,'<%# Eval("Type") %>', '<%# Eval("FlatNumber") %>','<%# Eval("DeActiveDate") %>')">Edit</a></li>
                                                            <li><a href="#" onclick="ShowAddTenant()">Tenant</a></li>
                                                            <li><a href="#" onclick="ShowDeactivateForm('<%# Eval("UserID") %>' ,'<%# Eval("Type") %>', '<%# Eval("FlatNumber") %>','<%# Eval("DeActiveDate") %>')">Deactivate</a></li>
                                                            <li></li>

                                                        </ul>
                                                    </div>
                                                </div>

                                            </div>



                                        </ItemTemplate>
                                        <AlternatingItemStyle />


                                    </asp:DataList>

                                    <div class="row">

                                        <div class="col-xs-4" style="text-align: center; padding: 8px;">
                                            <asp:Button ID="btnprevious" CausesValidation="false" runat="server" Font-Bold="true" Text="Prev" Height="31px" Width="60px" OnClick="btnprevious_Click" />

                                        </div>
                                        <div class="col-xs-4">
                                            <asp:Label ID="lblPage" runat="server" Font-Size="Small" ForeColor="#f9f9f9f"></asp:Label>
                                        </div>
                                        <div class="col-xs-4" style="text-align: center; padding: 8px;">
                                            <asp:Button ID="btnnext" CausesValidation="false" runat="server" Font-Bold="true" Text="Next" Height="31px" Width="60px" OnClick="btnnext_Click" />
                                        </div>
                                    </div>
                                </asp:View>
                                  <asp:View ID="View2" runat="server">
                                       <asp:DataList
                                        ID="dataListReview" runat="server" HorizontalAlign="Center"
                                        RepeatColumns="1" RepeatDirection="Horizontal" Width="100%" OnSelectedIndexChanged="ResidentList_DataBound">
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <div class="row layout_shadow_table" style="margin-left: 10px;">

                                                <div class="col-sm-4 col-xs-4" style="text-align: center;">

                                                    <img class="profile-image" src='<%# "GetImages.ashx?ResID="+ Eval("ResID")+"&Name="+Eval("FirstName") +"&UserType="+Eval("Type") %>' />
                                                    <br />

                                                    <%# Eval("FirstName") +" " + Eval("LastName") %> , <%# Eval("FlatNumber") %>
                                                    <br />
                                                    <hr style="margin: 0px;" />
                                                    <%# Eval("Type") %>
                                                </div>

                                                <div class="col-sm-4 col-xs-4">
                                                    <br />
                                                    <span class="fa fa-envelope" style="color: blue;"></span><%# Eval("Emailid") %>
                                                    <br />

                                                    <%--<span class="fa fa-phone-square" style="color:blue;"></span> <%# Eval("IntercomNumber") %><br />--%>
                                                    <span class="fa fa-phone" style="color: blue;"></span><%# Eval("MobileNo") %>
                                                    <%# Eval("ParentName") %>
                                                    <br />
                                                    <span class="fa fa-clock-o" style="color: blue;"></span><%# Eval("ActiveDate","{0:dd MMM,yy}") %>
                                                    <br />
                                                </div>
                                                <div class="col-sm-4 col-xs-4">
                                                    <div class="btn-group">
                                                        <button type="button" class="btn btn-primary btn-sm" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
                                                            onclick="ShowActivateForm('<%# Eval("UserID") %>' ,'<%# Eval("Type") %>', '<%# Eval("ResID") %>','<%# Eval("DeActiveDate") %>')">
                                                           Activate
                                                        </button>
                                                       
                                                    </div>
                                                </div>

                                            </div>

                                        </ItemTemplate>
                                        <AlternatingItemStyle />


                                    </asp:DataList>
                                  </asp:View>
                            </asp:MultiView>
                        </div>




                        <div id="resident_dropdown" class="layout-dropdown-content theme-dropdown-content " style="position: relative; margin-top: 20px; display: none;">
                            <asp:Button ID="btnusersEdit" runat="server" Text="Edit/Update" CausesValidation="false" CssClass="layout_list_type" OnClick="btnusersEdit_Click" />
                            <asp:Button ID="btnUsersDeactive" runat="server" CssClass="layout_list_type" Text="Deactivate" CausesValidation="false" OnClick="btnUsersDeactive_Click" />

                            <asp:Button ID="btnAddTenant" runat="server" Text="Add Tenant" CausesValidation="false" CssClass="layout_list_type" OnClick="btnAddUser_Click" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12" style="text-align: center;">
                            <asp:HiddenField ID="EditHidedenFlat" runat="server" />
                            <asp:HiddenField ID="HiddenFieldOwnerType" runat="server" />
                            <asp:HiddenField ID="HiddenDeactivedate" runat="server" />
                            <asp:HiddenField ID="HiddenField1" runat="server" />
                            <asp:HiddenField ID="HiddenField2" runat="server" />
                            <asp:Label ID="Label4" runat="server" ForeColor="#007cf9" Text="Total Residents :"></asp:Label>
                            <asp:Label ID="lblTotalResidents" runat="server" ForeColor="#4774d1" Text=""></asp:Label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12" style="text-align: center;">
                            <asp:Label ID="lblCheckDeactive" runat="server" ForeColor="#FF5050" Font-Size="Small"></asp:Label>
                            <asp:Label ID="lblGridEmptyDataText" runat="server" ForeColor="#46A3FF"></asp:Label>
                            <asp:Button ID="btnResidentShowAll" runat="server" CssClass="btn_style" OnClick="btnResidentShowAll_Click" Text="Show All" CausesValidation="False" />
                        </div>
                    </div>



                    <%----------------------------------------------------------------------- Add Resident Section starts from here----------------------------------------------------------------------------------------- --%>
                    <!--<div id="myModalPopup" class="modal">-->
                    <div id="myModalPopup" class="modal">
                        <asp:UpdatePanel ID="UpdatePanel15" runat="server" EnableViewState="true">
                            <ContentTemplate>
                                <div class="container-fluid">
                                    <div class="panel panel-primary popup_box_size" style="width: 630px; position: relative;">
                                        <div class="panel-heading">
                                            Add User :
                                                <a onclick="CloseAddResident()" style="cursor: pointer;"><span class="fa fa-close" style="color: white; float: right"></span></a>

                                        </div>
                                        <div class=" panel-body ">
                                            <form class="form-group" autocomplete="off">
                                                <div class="row">
                                                    <div class="col-xs-12">
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Enter valid name" ValidationExpression="^[a-zA-Z0-9.@]{0,25}$" Font-Size="Small" ForeColor="#FF5050" ControlToValidate="txtFirstname" ValidationGroup="Add_User" Display="Dynamic"></asp:RegularExpressionValidator>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="#FF5050" ControlToValidate="txtFirstname" ValidationGroup="Add_User"></asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Enter valid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Font-Size="Small" ForeColor="#FF5050" ControlToValidate="txtEmailId" ValidationGroup="Add_User" Display="Dynamic"></asp:RegularExpressionValidator>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ValidationExpression="^[0-9]+$" ControlToValidate="txtMobileno" ErrorMessage="Enter Valid No." Font-Size="Small" ForeColor="#FF5050" ValidationGroup="Add_User" Display="Dynamic"></asp:RegularExpressionValidator>
                                                        <asp:Label ID="lblusravailblerr" runat="server" Font-Size="Small" ForeColor="#FF5050" ViewStateMode="Disabled"></asp:Label>
                                                        <asp:Label ID="lblmobileavailbe" runat="server" Font-Size="Small" ForeColor="#FF5050"></asp:Label>
                                                        <asp:Label ID="lblEmailcheck" runat="server" Font-Size="Small" ForeColor="#FF5050" Text=""></asp:Label>
                                                        <asp:Label ID="lblstatus" runat="server" Font-Size="Small" ForeColor="#409FFF"></asp:Label>

                                                    </div>
                                                </div>


                                                <div class="row">

                                                    <div class="col-xs-6 col-sm-6" style="display: none;">
                                                        <label class="lblHead col-xs-8 ">Flat No. :</label>
                                                        <div class="col-xs-8">
                                                            <asp:TextBox ID="txtFlat" CssClass="form-control" runat="server" TabIndex="0"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-xs-12 col-sm-6">
                                                        <label class="col-xs-5">Email :</label>
                                                        <div class="col-xs-7">
                                                            <asp:TextBox ID="txtEmailId" runat="server" CssClass="form-control col-xs-8" AutoCompleteType="Disabled" TabIndex="8" onblur="validateEmail(this);" OnTextChanged="txtEmailId_TextChanged" AutoPostBack="True"></asp:TextBox>

                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ForeColor="#FF5050" ControlToValidate="txtEmailId" ValidationGroup="Add_User"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>

                                                    <div class="col-xs-12 col-sm-6">
                                                        <label class="col-xs-5">Mobile :</label>
                                                        <div class="col-xs-7">

                                                            <asp:TextBox ID="txtMobileno" onkeypress="return isNumberKey(event)" runat="server" CssClass="form-control" MaxLength="10" TabIndex="1" OnTextChanged="txtMobileno_TextChanged" AutoCompleteType="Disabled" AutoPostBack="True"></asp:TextBox>

                                                            <asp:RequiredFieldValidator ID="RequireUserMobileNo" runat="server" ControlToValidate="txtMobileno" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Add_User"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row" style="margin-bottom: 15px;">

                                                    <div class="col-xs-12 col-sm-6">
                                                        <label class="col-xs-5">First Name :</label>
                                                        <div class="col-xs-7">

                                                            <asp:TextBox ID="txtFirstname" CssClass="form-control" runat="server" TabIndex="2"></asp:TextBox>

                                                        </div>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-6">


                                                        <label class="col-xs-5">Middle Name:</label>
                                                        <div class="col-xs-7">

                                                            <asp:TextBox ID="txtMiddleName" runat="server" CssClass="form-control" TabIndex="3"></asp:TextBox>

                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row" style="margin-bottom: 15px;">

                                                    <div class="col-xs-12 col-sm-6">
                                                        <label class="col-xs-5">Last Name :</label>
                                                        <div class="col-xs-7">



                                                            <asp:TextBox ID="txtLastname" runat="server" CssClass="form-control" TabIndex="4"></asp:TextBox>

                                                        </div>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-6">
                                                        <label class="col-xs-5">Gender :</label>
                                                        <div class="col-xs-7">


                                                            <asp:DropDownList ID="drpAddusrGendr" runat="server" CssClass="form-control ddl_style" TabIndex="5">
                                                                <asp:ListItem>Male</asp:ListItem>
                                                                <asp:ListItem>Female</asp:ListItem>
                                                            </asp:DropDownList>

                                                        </div>

                                                    </div>
                                                </div>

                                                <div class="row">

                                                    <div class="col-xs-12 col-sm-6">

                                                        <label class="col-xs-5">ParentName :</label>
                                                        <div class="col-xs-7">


                                                            <asp:TextBox ID="txtParentname" runat="server" CssClass="form-control" TabIndex="6"></asp:TextBox>

                                                        </div>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-6">
                                                        <label class="col-xs-5">Address :</label>
                                                        <div class="col-xs-7">



                                                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TabIndex="9" AutoCompleteType="Disabled"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-xs-12 col-sm-6" style="display: none;">
                                                        <label class="col-xs-5">UserType :</label>
                                                        <div class="col-xs-7">



                                                            <asp:DropDownList ID="drpAddusertype" runat="server" CssClass="form-control ddl_style" TabIndex="7">
                                                                <asp:ListItem>Owner</asp:ListItem>
                                                                <asp:ListItem>Tenant
                                                                </asp:ListItem>
                                                            </asp:DropDownList>

                                                        </div>

                                                    </div>

                                                </div>

                                            </form>
                                        </div>


                                        <div class="panel-footer" style="text-align: right;">
                                            <asp:Button ID="btnAddUserResident" runat="server" CssClass="btn btn-primary" Text="Submit" ValidationGroup="Add_User" CausesValidation="False" OnClick="btnAddUserResident_Click" TabIndex="10" />
                                            <button type="button" id="btnusercancel" class="btn btn-danger" onclick="HideAddRes();">Cancel</button>
                                        </div>
                                    </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>


                    <%-------------------------------------------------------------------------------------Edit User Section ---------------------------------------------------------------------------%>           <%--   <div id="myModalEditPopup" class="modal">   --%>
                    <div id="myModalEditPopup" class="modal">
                        <div class="container-fluid" style="width: 400px; margin-top: 100px;">
                            <div class="panel panel-primary" style="position: relative; margin: 0px;">

                                <div class="panel-heading" style="height: 40px;">

                                    <span>Edit Userpan>

                                </div>
                                <div class="panel-body">
                                    <form class="from-group" autocomplete="off">
                                        <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                            <ContentTemplate>
                                                <table>
                                                    <tr>
                                                        <td class="lbltxt" style="width: 30%;">FlatNumber:</td>
                                                        <td style="width: 35%;">
                                                            <asp:TextBox ID="txtEditFlatNumber" runat="server" CssClass="form-control UserEditInfo" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td style="width: 1%;"></td>

                                                    </tr>

                                                    <tr>
                                                        <td class="lbltxt">FirstName:</td>
                                                        <td style="width: 35%;">
                                                            <asp:TextBox ID="txtEditFirstname" runat="server" Style="margin-top: 10px;" CssClass="form-control UserEditInfo"></asp:TextBox><br />
                                                            <asp:RegularExpressionValidator ID="regulareditusername" runat="server" ValidationExpression="^[a-zA-Z0-9.@]{0,25}$" ErrorMessage="enter valid name" ForeColor="#FF5050" ControlToValidate="txtEditFirstname" Font-Size="Small" ValidationGroup="Edit_User" Display="Dynamic"></asp:RegularExpressionValidator>
                                                        </td>
                                                        <td>
                                                            <asp:RequiredFieldValidator ID="RequireUserFirstname" runat="server" ControlToValidate="txtEditFirstname" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Edit_User"></asp:RequiredFieldValidator>
                                                        </td>
                                                        <td style="width: 2%;"></td>
                                                    </tr>

                                                    <tr style="display: none;">
                                                        <td class="lbltxt">MiddleName:</td>
                                                        <td style="width: 35%;">
                                                            <asp:TextBox ID="txtEditMiddlename" runat="server" CssClass="form-control UserEditInfo"></asp:TextBox><br />
                                                            <asp:RegularExpressionValidator ID="Regularedituserlastname" runat="server" ValidationExpression="^[a-zA-Z0-9.@]{0,25}$" ErrorMessage="enter valid name" ForeColor="#FF5050" ControlToValidate="txtEditMiddlename" Font-Size="Small" ValidationGroup="Edit_User" Display="Dynamic"></asp:RegularExpressionValidator>
                                                        </td>
                                                        <td>&nbsp;</td>
                                                        <td></td>
                                                    </tr>

                                                    <tr>
                                                        <td class="lbltxt">LastName:</td>
                                                        <td>
                                                            <asp:TextBox ID="txtEditlastname" runat="server" CssClass="form-control UserEditInfo"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="txtEditlastname" ErrorMessage="*" ForeColor="#FF5050"></asp:RequiredFieldValidator>
                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="lbltxt">EMailId:</td>
                                                        <td>

                                                            <asp:TextBox ID="txtEditEmailID" runat="server" Style="margin-top: 10px;" CssClass="form-control UserEditInfo" OnTextChanged="txtEditEmailID_TextChanged" AutoPostBack="True"></asp:TextBox><br />
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="txtEditEmailID" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Enter vaild mail" Font-Size="Small" ForeColor="#FF5050" ValidationGroup="Edit_User" Display="Dynamic"></asp:RegularExpressionValidator>
                                                            <asp:Label ID="lblEditEmailCheck" runat="server" Font-Size="Small" ForeColor="#FF5050"></asp:Label>


                                                        </td>
                                                        <td>

                                                            <asp:RequiredFieldValidator ID="RequiredUserEmailid" runat="server" ControlToValidate="txtEditEmailID" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Edit_User"></asp:RequiredFieldValidator>

                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="lbltxt">ParentName:</td>
                                                        <td>
                                                            <asp:TextBox ID="txtEditusrParentN" runat="server" CssClass="form-control UserEditInfo"></asp:TextBox>
                                                        </td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>

                                                    <tr>
                                                        <td class="lbltxt">MobileNo:</td>
                                                        <td style="width: 35%;">

                                                            <asp:TextBox ID="txtEditMobileNo" runat="server" Style="margin-top: 10px;" CssClass="form-control UserEditInfo" MaxLength="10" OnTextChanged="txtEditMobileNo_TextChanged" AutoPostBack="True"></asp:TextBox><br />
                                                            <asp:Label ID="lblEditMobileCheck" runat="server" Font-Size="Small" ForeColor="#FF5050"></asp:Label>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidatoredituser" runat="server" ErrorMessage="Enter valid No." ControlToValidate="txtEditMobileNo" ForeColor="#FF5050" ValidationExpression="^[01]?[- .]?(\([2-9]\d{2}\)|[2-9]\d{2})[- .]?\d{3}[- .]?\d{4}$" Font-Size="Small" ValidationGroup="Edit_User" Display="Dynamic"></asp:RegularExpressionValidator>

                                                        </td>
                                                        <td>

                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtEditMobileNo" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Edit_User"></asp:RequiredFieldValidator>

                                                        </td>
                                                        <td style="width: 2%;"></td>
                                                    </tr>


                                                    <tr>
                                                        <td colspan="4" style="height: 15px;">
                                                            <input type="checkbox" id="chkChangePassword" name="Change_Password" value="Change" />Change Password:
                                                        </td>
                                                    </tr>

                                                    <tr id="tdNewPwd" style="display: none; text-align: center">
                                                        <td colspan="4" class="lbltxt" style="padding: 5px;">New Password:
                                                <asp:TextBox ID="newPassword" CssClass="form-control" TextMode="Password" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr id="tdCnfPwd" style="display: none; text-align: center;">
                                                        <td colspan="4" class="lbltxt">Confirm Password:
                                                <asp:TextBox ID="cnfPassword" CssClass="form-control" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="4" style="text-align: center;">
                                                            <asp:CompareValidator ID="userprofilevalidator" runat="server" ControlToCompare="cnfPassword" ControlToValidate="newPassword" EnableClientScript="False" ErrorMessage="Password  Not Matching" Font-Size="Small" ForeColor="Red"></asp:CompareValidator>
                                                            &nbsp;
                <asp:Label ID="lbleditstatus" runat="server" ForeColor="#3C9DFF"></asp:Label>
                                                        </td>
                                                    </tr>

                                                </table>
                                                </div>
                            </div>
                            <div class="panel-footer" style="text-align: right;">
                                <asp:Button ID="btnedit" runat="server" Text="Submit" CssClass="btn btn-sm btn-primary" OnClientClick="Verify();" OnClick="btnedit_Click" ValidationGroup="Edit_User" />


                                <asp:HiddenField ID="hiddenChangeField" runat="server" />
                                <button type="button" id="Edit_Cancel" class="btn btn-sm btn-danger">Cancel</button>
                            </div>

                                            </ContentTemplate>
                                        </asp:UpdatePanel>


                                    </form>
                                </div>
                            </div>
                            <div class="col-md-2">
                            </div>
                        </div>
                    </div>

                </form>
            </div>
            <div class="col-md-2"></div>
        </div>
    </div>
</body>
</html>
