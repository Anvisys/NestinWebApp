<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Viewcomplaints.aspx.cs" Inherits="Viewcomplaints" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<!DOCTYPE html>
<!--  This Total  code  is  licenced
    Developed By Anvisys Technologies Pvt Ltd.
    
    Copyright © 2016 Anvisys Technologies Pvt. Ltd.All rights reserved.
    -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css" />

    <link rel="stylesheet" href="CSS/mystylesheets.css" />
    <script src="Scripts/jquery-1.11.1.min.js"></script>
    <link rel="stylesheet" href="CSS/ApttTheme.css" />
    <link rel="stylesheet" href="CSS/ApttLayout.css" />
    <%-- <link rel="stylesheet" href="CSS/Vendor.css" />--%>
   <%-- <link rel="stylesheet" href="CSS/NewAptt.css" />--%>

    <link rel="stylesheet" href="CSS/mystylesheets.css" />


    <link rel="stylesheet" href="CSS/Nestin.css" />

    <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>
    <link rel="Stylesheet" href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.10/themes/redmond/jquery-ui.css" />

    <script>

        var UserType, FlatNumber, Firstname, LastName;

        $(function () {
            $("#txtVcompFlatSrch").autocomplete({
                source: function (request, response) {
                    var param = {
                        FlatNumber: $('#txtVcompFlatSrch').val()
                    };

                    $.ajax({
                        url: "Viewcomplaints.aspx/GetFlatNumber",
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



            // ASP method is working, hence this is commented for now
            //$("#txtAddcompFlat").autocomplete({
            //    source: function (request, response) {
            //        var param = {
            //            FlatNumber: $('#txtAddcompFlat').val()
            //        };

            //        $.ajax({
            //            url: "Viewcomplaints.aspx/GetFlatNumber",
            //            data: JSON.stringify(param),
            //            dataType: "json",
            //            type: "POST",
            //            contentType: "application/json; charset=utf-8",
            //            dataFilter: function (data) { return data; },
            //            success: function (data) {

            //                response($.map(data.d, function (item) {
            //                    return {
            //                        value: item
            //                    }
            //                }))
            //            },
            //            error: function (XMLHttpRequest, textStatus, errorThrown) {
            //                var err = eval("(" + XMLHttpRequest.responseText + ")");
            //                alert(err.Message)
            //                console.log("Ajax Error!");
            //            }
            //        });
            //    },
            //    minLength: 2 //This is the Char length of inputTextBox  
            //});


        });

        $(document).ready(function () {

            window.parent.FrameSourceChanged();
        });


        function DConfirmationbox() {
            var result = confirm('Are you sure you want to delete selected User(s)?');
            if (result) {
                return true;
            }
            else {
                return false;
            }
        }

        $(document).ready(function () {

            if (UserType != "Admin") {
                FlatNumber = '<%=Session["FlatNumber"]%>';
               Firstname = '<%=Session["FirstName"]%>';
               LastName = '<%=Session["LastName"]%>';
           }

       });

        function funClear() {

            var ComplaintDes = document.getElementById("txtComplaintdescription");

            ComplaintDes.value = "";

            //Added by aarshi on 11-Sept-2017 for bug fix
            document.getElementById("txtAddcompFlat").value = "";
            document.getElementById("txtComplaintername").value = "";
            document.getElementById("txtAddcompFlat").value = "";
            document.getElementById("drpComplaintcategory").selectedIndex = 0;
            $('#drpAddcomAssign').empty();
            var newOption = $('<option value="NA">Select</option>');
            $('#drpAddcomAssign').append(newOption);
            $('#drpAddcomAssign').trigger("chosen:updated");
            //Ends here
            $("#AddComplaintPopup").hide();
        }

        function HideCompHistEmptyDataLabel() {
            setTimeout("HideCompHistEmptyDataLabel();", 4000);
            // document.getElementById('lblCompHistoryEmptyText.ClientID').style.display = "none";
        }




        $(document).ready(function () {



            $("#View_Complaints_Data").click(function () {
                $(".dropdown-content").show();
                $("#Gridview_dropdown_sample").hide();

                $("#Complaints_edit_sample").mouseleave(function () {

                    $("#Complaints_edit_sample").hide();
                });
            });
        });

        $(document).ready(function ShowSelected() {
            $("[id*=VComplaintsGrid] td:has(button)").bind("click", function () {
                var row = $(this).parent();
                $("[id*=VComplaintsGrid] tr").each(function () {
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



        //Added by Aarshi on 11-Sept-2017 for bug fix
        $(document).ready(function () {

            $("#Complaint_dropdown").mouseleave(function () {
                $("#Complaint_dropdown").hide();
            });
        });
        //Ends here



        function EditCompdata(FlatNumber, Description, CompStatus, severity, Assignedto, CompType) {
            document.getElementById("txtEditCompFlat").value = FlatNumber;
            document.getElementById("txtEditCompDescription").value = Description;

            EditHiddenValue.value = FlatNumber;


        }




        $(document).ready(function () {
            $('html').click(function () {

                $("#Complaint_dropdown").hide();

            });

        });

        $(document).ready(function () {

            $("[id*=VComplaintsGrid] td:has(button)").bind("click", function (event) {
                var row = $(this).parent();

                $("td", row).each(function () {

                    if ($('#Complaint_dropdown').is(':visible')) {
                        $("#Complaint_dropdown").show();
                    } else {

                        $("#Complaint_dropdown").hide();
                    }
                });

                event.stopPropagation();
            });

        });


        $(document).ready(function () {
            $("#btnAddComplaint").click(function () {

                UserType = '<%=Session["UserType"]%>';

                if (UserType != "Admin") {
                    FlatNumber = '<%=Session["FlatNumber"]%>';
                       Firstname = '<%=Session["FirstName"]%>';

                       // alert(FlatNumber);
                       document.getElementById('<%=txtAddcompFlat.ClientID%>').value = FlatNumber;

                       document.getElementById('<%=txtComplaintername.ClientID%>').value = Firstname;

                }


                else if (UserType == "Tenant" || UserType == "Owner") {

                    $("#txtAddcompFlat").val(FlatNumber);
                    $("#txtAddcompFlat").attr('readonly', true);

                    $("#txtComplaintername").val(Firstname + " " + LastName);
                    $("#txtComplaintername").attr('readonly', true);

                }
                else {
                    $("#txtAddcompFlat").val("");
                    $("#txtComplaintername").val("");
                }
                $("#AddComplaintPopup").show();

            });
        });

        $(document).ready(function () {
            $("#btnCompHistory").click(function () {
                $("#myModalCompHistoryPopup").hide();
            });
        });
        $(document).ready(function () {
            $("#CancelEdit_Button").click(function () {
                $("#myModalEditPopup").hide();
                $("#EditHiddenValue").val("");
            });
        });

        $(document).ready(function () {
            $("#CancelAddcomplaint").click(function () {
                $("#AddComplaintPopup").hide();
            });
        });

        $(document).ready(function () {
            $("#Cancel_Button").click(function () {
                $("input:text").val("");
                $("#btnAddcomplaintsubmit").val("Submit");
                //  $("txtComplaintdescription").html("");              
                $('#lblCompstatus').html('');

            });
        });

        $(document).ready(function () {
            $("#CancelEdit_Button").click(function () {
                $("input:text").val("");
                //$('#lblCompstatus').html('');
            });
        });

        $(document).ready(function () {
            $("#CancelCompHistory_Button").click(function () {
                $("#myModalCompHistoryPopup").hide();
            });
        });


        $(document).load(function () {
            $('.dvLoading_first').show();
        }).stop(function () {
            $('.dvLoading_first').hide();
        });


        function ShowAPopup() {
            setTimeout(function () {

                var FlatNumber = document.getElementById('<%=txtAddcompFlat.ClientID%>').value;
                if (FlatNumber != "") {

                    //  document.getElementById("myModalPopup").style.display = "block";
                }

                <%--var EditFlatNumber = document.getElementById('<%=txtEditCompFlat.ClientID%>').value;--%>
                if (EditHiddenValue.value != "") {

                    document.getElementById("myModalEditPopup").style.display = "block";
                }


                if (HiddenCompHistID.value != "") {

                    document.getElementById("myModalCompHistoryPopup").style.display = "block";
                    HiddenCompHistID.value = "";
                }
            }, 1000);
        };



        //Added by aarshi on 21-Sept-2017 for bug fix
        function GetCount(text, oCount) {
            var maxlength = new Number(250); // Change number to your max length.
            if (text.value.length > maxlength) {
                text.value = text.value.substring(0, maxlength);
                oCount.innerText = (maxlength - parseInt(text.value.length)).toString();
                return false;
            }
            else {
                oCount.innerText = (maxlength - parseInt(text.value.length)).toString();
                return true;
            }
        }

        function ShowCloseConfirmation(CompId, FlatNumber, Status) {

            document.getElementById('<%=lblComplaintStatus.ClientID%>').value = Status;
            $("[id*=lblComplaintStatus]").text(Status);
            document.getElementById('lblheading').innerHTML = Status;


            document.getElementById('<%=lblCompID.ClientID%>').value = CompId;
            $("[id*=lblFlat]").text(FlatNumber);
            //$("[id*=lblCompID]").text(CompId);
            //$("#lblStatus").text(Status);
            $("#myModalCloseComplaint").show();



        }

        function ConfirmClose() {
            $("#myModalCloseComplaint").hide();
        }

        function ShowAssignConfirmation(CompId, FlatNumber, ServiceType, Status, StatusText) {
            //  alert("404==>"+StatusText);
            $("#myModalAssignComplaint").show();

            SetEmployeeForService(ServiceType);
            $("#HiddenFlatNumber").val(FlatNumber);
            $("#HiddenCompID").val(CompId);
            $("#HiddenDesc").val("");
            $("#HiddenCompStatus").val(Status);
            $("#lblassignHeading").text(StatusText);

            $("[id*=btnUpdate]").val(StatusText);
            document.getElementById('<%=lblAssignStatus.ClientID%>').innerHTML = StatusText;

            $("#lblAssignCompID").text(CompId);
            $("[id*=lblassignFlat]").text(FlatNumber);

            // location.reload();


            //$("[id*=lblCompID]").text(CompId);
            //$("#lblStatus").text(Status);


        }

        function btnCancelAssign() {
            $('#selectEmployee').empty();
            $("#myModalAssignComplaint").hide();



        }


        function SetEmployeeForService(ServiceType) {


            var param = {
                service: ServiceType
            };

            $.ajax({
                url: "Viewcomplaints.aspx/GetEmployeeForService",
                data: JSON.stringify(param),
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataFilter: function (data) { return data; },
                success: function (data) {

                    var jArray = JSON.parse(data.d);
                    $.each(jArray, function (index, value) {

                        $('#selectEmployee').append('<option value="' + value.ResID + '">' + value.FirstName + '</option>');
                    });
                    SelectEmployee();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    var err = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(err.Message)
                    console.log("Ajax Error!");
                }
            });


        }

        function SelectEmployee() {
            //This pure java script method and below JQuery method both works
            //var e = document.getElementById("selectEmployee");
            //var EmpId = e.options[e.selectedIndex].value;

            var EmpId = $('#selectEmployee').val();
            $("#HiddenEmployeeID").val(EmpId);
        }

        function UpdateSuccessfully() {
            $("#myModalCloseComplaint").hide();


            // alert("Updated Successfully");
            //  location.reload();
        }

        $(document).ready(function () {
            var firstName = $('A').text();
            // var lastName = $('#lastName').text();
            var intials = $('#firstName').text().charAt(0);
            var profileImage = $('#user_image').text(intials);
        });

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }

    </script>

    <style type="text/css">
        .selected_row {
            background-color: #4598c8;
            color: white;
        }


        .GridViewTest {
            background-color: #3d94ba;
            color: white;
        }


        .GridViewTestNormal {
            background-color: #bfbfbf;
            color: black;
        }

        .hover {
            background-color: #e6dede;
        }

        .lbltxt {
            padding-left: 3%;
            font-size: small;
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


        .dvLoading_first {
            background: url(Images/loader_2.gif) no-repeat center center;
            opacity: 0.5;
            height: 130px;
            width: 100px;
            position: fixed;
            z-index: 1000;
            left: 48%;
            top: 50%;
            margin: -25px 0 0 -25px;
        }

        .Dtalist_txt {
            text-align: left;
            padding-left: 1%;
        }

        .Complaint_Category {
            margin-left: 0.5%;
        }

        .Complaint_Category_head {
            margin-left: 2%;
        }

        td, th {
        }

        .glyphicon {
             background-color: #607d8b;
             display: inline;
             height: 40px;
             top:40px;         
        }

        .my_padding {
            margin-left: 30px;
        }
    </style>

</head>
<body style="background-color: #f7f7f7;">


    <div class="container-fluid">
        <div class="row" style="overflow-x: hidden; overflow-y: hidden;">




            <form id="form1" runat="server">
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <div class="container-fluid">
                    <div class="row">
                        <asp:HiddenField ID="HiddenCompID" runat="server" />
                        <asp:HiddenField ID="HiddenFlatNumber" runat="server" />
                        <asp:HiddenField ID="HiddenCompHistID" runat="server" />
                        <asp:HiddenField ID="HiddenCompStatus" runat="server" />
                  
                        <asp:HiddenField ID="HiddenDesc" runat="server" />
                        <asp:HiddenField ID="HiddenResID" runat="server" />
                        <asp:HiddenField ID="HiddenComplaintData" runat="server" />
                        <asp:HiddenField ID="HiddenEmployeeID" runat="server" />
                        <%--Added by Aarshi on 22-Sept-2017 for bug fix--%>
                    </div>

                    <div class="row" style="margin-top: 10px;">
                        <div class="col-sm-3 hidden-xs">
                            <h4>Complaints:</h4>
                         
                        </div>
                        
                        <div class="col-sm-6 col-xs-12" style="align-content: center; text-align:center; margin: auto;" runat="server" id="topnav">
                            <asp:DropDownList EnableViewState="true" ID="drpVCompStatusF" runat="server" CssClass="search-dropdown">
                            </asp:DropDownList>
                            <asp:TextBox ID="txtVcompFlatSrch" runat="server" CssClass="search-text" placeholder="Flat Number" OnTextChanged="txtVcompFlatSrch_TextChanged"></asp:TextBox>
                            <asp:LinkButton ID="ImgCompSearch" runat="server" CssClass="search-button" BackColor="Transparent" ForeColor="white" OnClick="ImgCompSearch_Click"> <span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                        </div>

                      
                        <div class="col-sm-3 col-xs-2">
                            <button type="button" id="btnAddComplaint" style="margin-top: 0px;" class="pull-right btn btn-primary btn-sm">Add Complaint</button>
                        </div>
                    </div>


                    <div class="row hidden" style="margin-top: 5px;">
                        <div class="col-md-12 hidden-sm hidden-xs">
                            Initiated :<asp:Label ID="lblInitiatedcount" runat="server" Text="0" CssClass="Complaint_Category"></asp:Label>
                            Assigned :
                             <asp:Label ID="lblAssignedCount" runat="server" Text="0" CssClass="Complaint_Category"></asp:Label>
                            Ongoing :
                             <asp:Label ID="lblOngoingcount" runat="server" Text="0" CssClass="Complaint_Category"></asp:Label>
                            Resolved :
                             <asp:Label ID="lblResolvedcount" runat="server" Text="0" CssClass="Complaint_Category"></asp:Label>
                            Re-Open :<asp:Label ID="lblReOpenCount" runat="server" Text="0" CssClass="Complaint_Category"></asp:Label>
                        </div>
                    </div>


                    <asp:MultiView ID="MultiView1" runat="server">

                        <%-------------------------- View 2 with Data Grid of Complaints start here-------------------------%>
                        <asp:View ID="View1" runat="server">


                            <asp:DataList ID="dataListComplaint" runat="server" CellPadding="0"
                                OnItemDataBound="DataListComplaint_ItemDataBound"
                                Width="100%"
                                headerstyle-font-name="Verdana"
                                HeaderStyle-Font-Size="12pt"
                                HeaderStyle-HorizontalAlign="center"
                                RepeatColumns="0"
                                HorizontalAlign="Center"
                                HeaderStyle-Font-Bold="True"
                                BackColor="Transparent"
                                FooterStyle-Font-Size="9pt"
                                FooterStyle-Font-Italic="True" Height="1px" ForeColor="#CCCCCC"
                                OnSelectedIndexChanged="DataListComplaint_SelectedIndexChanged">

                                <ItemStyle></ItemStyle>
                                <ItemTemplate>

                                    <div class="row layout_shadow_table" style="margin-left: 7px !important;">

                                        <div class="col-sm-2 col-xs-6">

                                            <asp:Image CssClass="image_small" ID="user_image" runat="server"
                                                ImageUrl='<%# "GetImages.ashx?Type=Resident&ID="+ Eval("ResidentID")+"&Name="+Eval("FirstName") +"&UserType=Owner" %>' /><br />
                                            <asp:Label ID="lblComName" runat="server" ForeColor="Black" Text='<%# Eval("FirstName") + ", " + Eval("FlatNumber") %>'></asp:Label>


                                            <br />


                                        </div>
                                        <div class="col-sm-4 col-xs-6" style="color: black;">
                                            Ticket no:
                                         <asp:Label ID="Label4" runat="server" Text='<%# Eval("CompID") %>'></asp:Label><br />

                                            <h5 style="color: red; ">Issue:<asp:Label ID="lblCompDesc" runat="server" ForeColor="#6699cc" CssClass="margin-right-5p" Text='<%# Eval("InitialComment") %>'></asp:Label></h5>

                                            <h6>
                                                <asp:Label ID="lblCreatedDate" runat="server" CssClass="margin-right-5p" Text='<%# String.Format("Created At: {0:ddd, dd MMM yy hh:mm tt}",  Eval("InitiatedAt") )%>'></asp:Label></h6>

                                        </div>
                                        <hr class="hidden-sm col-xs-12 zero-margin" />
                                        <div class="col-sm-4 col-xs-6" style="color: black;">
                                            Type:
                                         <asp:Label ID="Label2" runat="server" Text='<%# Eval("CompType") %>'></asp:Label><br />
                                            Assigned To:
                                         <asp:Label ID="Label1" runat="server" Text='<%# Eval("EmployeeName") %> '></asp:Label>
                                           ( <%# Eval("Type") %> )
                                            <h6>
                                                <asp:Label ID="lblClosedDate" runat="server" CssClass="margin-right-5p" Text='<%# String.Format("Updated At: {0:ddd, dd MMM yy hh:mm tt}",  Eval("LastAt") )%>'></asp:Label></h6>

                                        </div>
                                        <div class="col-sm-2 col-xs-6">
                                            <span style="padding: 2px; color: green; font-size: 18px;">
                                                <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("LastStatus") %>'></asp:Label></span><br />


                                        </div>
                                        <div class="row" style="float: right; margin-right: 5px;">
                                            <button id="btnComplete" class="btn-sm btn btn-success" onclick='<%#"ShowAssignConfirmation(" + Eval("CompID")+",\""+ Eval("FlatNumber") +"\",\""+ Eval("CompType")+ "\",4,\"Complete\")"%>' runat="server" type="button">Work Complete</button>
                                            <button id="btnAssign" class="btn-sm btn btn-warning" onclick='<%#"ShowAssignConfirmation(" + Eval("CompID") +",\""+ Eval("FlatNumber")+"\",\""+ Eval("CompType")+ "\",2,\"Assign\")"%>' runat="server" type="button">Assign</button>
                                            <button id="btnOpen" class="btn-sm btn btn-info" onclick='<%#"ShowAssignConfirmation(" + Eval("CompID")+",\""+ Eval("FlatNumber") +"\",\""+ Eval("CompType")+ "\",3,\"Open\")"%>' runat="server" type="button">Open</button>
                                            <button id="btnReopen" class="btn-sm btn btn-info" onclick='<%#"ShowAssignConfirmation(" + Eval("CompID")+",\""+ Eval("FlatNumber") +"\",\""+ Eval("CompType")+ "\",6,\"Re-open\")"%>' runat="server" type="button">Reopen</button>
                                            <button id="btnClose" class="btn-sm btn btn-success" onclick='<%#"ShowAssignConfirmation(" + Eval("CompID")+",\""+ Eval("FlatNumber") +"\",\""+ Eval("CompType")+ "\",5,\"Close\")"%>' runat="server" type="button">Close</button>


                                        </div>


                                    </div>

                                </ItemTemplate>

                                <EditItemStyle Height="0px" BackColor="Transparent" />
                                <SeparatorStyle BackColor="Transparent" Height="50px" />
                            </asp:DataList>


                            <div class="row">

                                <div class="col-xs-3" style="text-align: center; padding: 8px;">
                                    <asp:Button ID="btnprevious" runat="server" Font-Bold="true" Text="Prev" Height="31px" Width="60px" OnClick="btnprevious_Click" />

                                </div>
                                <div class="col-xs-6" style="font-size: 20px !important; font-family:'Times New Roman', Times, serif !important; color: red; text-align:center;">
                                    <asp:Label ID="lblPage" runat="server"></asp:Label>
                                </div>
                                <div class="col-xs-3" style="text-align: center; padding: 8px;">
                                    <asp:Button ID="btnnext" runat="server" Font-Bold="true" Text="Next" Height="31px" Width="60px" OnClick="btnnext_Click" />
                                </div>
                            </div>
                            <%--<asp:Button id="btnClose" runat="server"  Text="Close" ></asp:Button>--%>
                            <div id="Complaint_dropdown" class="layout-dropdown-content theme-dropdown-content">

                                <asp:Button ID="btnCompHistory" runat="server" Text="History" CssClass="layout_dropdown_Button" CausesValidation="false" OnClick="btnCompHistory_Click" />
                            </div>
                        </asp:View>
                        <%-------------------------- View 2 with Data Grid of Complaints start here-------------------------%>
                        <%-------------------------- View 2 with Data Grid of Complaints start here-------------------------%>
                    </asp:MultiView>

                    <%-------------------------- View 2 with Data Grid of Complaints start here-------------------------%>
                </div>



                <div class="row">
                    <div class="col-sm-12">
                        <asp:Label ID="lblEmptyDataText" runat="server" ForeColor="#2D96FF" Visible="False"></asp:Label>

                    </div>
                </div>



                <div id="myModalAssignComplaint" class="modal">
                    <div class="container-fluid" style="width: 500px;">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                Confirm:
                                     <label id="lblassignHeading">Assign</label>

                                <span class="fa fa-times" onclick="btnCancelAssign()" style="float: right; cursor: pointer;"></span>
                            </div>

                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-xs-6">
                                        Flat:
                                             <label id="lblassignFlat"></label>
                                    </div>
                                    <div class="col-xs-6">
                                        Complaint ID:
                                             <label id="lblAssignCompID" runat="server"></label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        New Status:  
                                             <asp:Label ID="lblAssignStatus" runat="server"></asp:Label>
                                    </div>
                                    <div class="col-xs-6">
                                        Employee:   
                                            <select id="selectEmployee" onchange="SelectEmployee()" style="width: 100px; padding: 4px; border: none;">
                                            </select>
                                    </div>
                                </div>
                                <div class="row">

                                    <div class="col-xs-12">
                                        <div class="md-form">
                                            <i class="fas fa-pencil-alt prefix"></i>
                                            <label for="form10">
                                                Comments  
                                         <asp:TextBox ID="form10" CssClass="md-textarea form-control" Rows="3" Style="resize: none;" runat="server" ValidationGroup="comment" TextMode="MultiLine"></asp:TextBox>
                                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please give some comments...." ValidationGroup="comment" ControlToValidate="form10" ForeColor="#FF6600"></asp:RequiredFieldValidator></label>--%>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="panel-footer" style="text-align: right; margin-top: 15px;">
                                <button class="btn btn-danger" type="button" onclick="btnCancelAssign()">Cancel</button>
                                <asp:Button ID="btnUpdate" runat="server" CausesValidation="true" Text="Assign" CssClass="btn btn-success" OnClick="btnUpdate_Click" ValidationGroup="comment" />
                            </div>
                        </div>
                    </div>
                </div>





                <div id="AddComplaintPopup" class="modal">
                    <div class="panel panel-primary" style="width: 350px; margin: auto;">
                        <div class="panel-heading">
                            Add complaint <span class="fa fa-times" onclick="funClear()" style="float: right; cursor: pointer;"></span>

                        </div>
                        <br />
                        <div class="panel-body">
                            <form class="form-group" autocomplete="off">
                                <table style="vertical-align: top;">

                                    <tr>
                                        <td colspan="3" style=""></td>
                                    </tr>
                                    <tr>
                                        <td class="lbltxt" style="width: 50%;">FlatNumber : 
                                        </td>
                                        <td style="width: 50%;">
                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                <ContentTemplate>
                                                    <asp:TextBox ID="txtAddcompFlat" runat="server" CssClass="form-control" OnTextChanged="txtAddcompFlat_TextChanged" AutoPostBack="True" ValidationGroup="Add_Complaint"></asp:TextBox>

                                                    <asp:Label ID="lblcomperror" runat="server" Font-Size="Small" ForeColor="#FF5050"></asp:Label>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                        <td style="width: 1%;">
                                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                <ContentTemplate>
                                                    <asp:RequiredFieldValidator ID="RequireComplainterflat" runat="server" ErrorMessage="*" ForeColor="#FF5050" ControlToValidate="txtAddcompFlat" InitialValue="0" ValidationGroup="Add_Complaint"></asp:RequiredFieldValidator>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>

                                    </tr>

                                    <tr>
                                        <td class="lbltxt">Name :
                                        </td>
                                        <td>
                                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                <ContentTemplate>
                                                    <asp:TextBox ID="txtComplaintername" runat="server" Style="margin-top: 10px;" CssClass="form-control"></asp:TextBox>

                                                </ContentTemplate>
                                            </asp:UpdatePanel>

                                        </td>
                                        <td>
                                            <asp:RequiredFieldValidator ID="RequireAddAomplaintername" runat="server" ErrorMessage="*" ForeColor="#FF5050" ControlToValidate="txtComplaintername" ValidationGroup="Add_Complaint"></asp:RequiredFieldValidator>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="lbltxt">Category :
                                        </td>
                                        <td>
                                            <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                                <ContentTemplate>
                                                    <asp:DropDownList ID="drpComplaintcategory" Style="margin-top: 10px;" runat="server" OnSelectedIndexChanged="drpComplaintcategory_SelectedIndexChanged" CssClass="form-control txtDrop" AutoPostBack="True" ValidationGroup="Add_Complaint">
                                                    </asp:DropDownList>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>

                                        </td>
                                        <td>

                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="drpComplaintcategory" ErrorMessage="*" ForeColor="#FF5050" InitialValue="NA" ValidationGroup="Add_Complaint"></asp:RequiredFieldValidator>

                                        </td>
                                        <%--  <td> </td>--%>
                                    </tr>


                                    <tr>
                                        <td class="lbltxt">Description :
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtComplaintdescription" runat="server" CssClass="form-control" TextMode="MultiLine" Style="resize: none; margin-top: 10px;" ValidationGroup="Add_Complaint"></asp:TextBox><br />

                                        </td>
                                        <td>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtComplaintdescription" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Add_Complaint"></asp:RequiredFieldValidator>
                                        </td>
                                        <%-- <td> 
                             
                                  </td>--%>
                                    </tr>
                                    <tr>
                                        <td class="lbltxt">Assigned  To :
                                        </td>
                                        <td>
                                            <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                                <ContentTemplate>
                                                    <asp:DropDownList ID="drpAddcomAssign" runat="server" CssClass="form-control" ValidationGroup="Add_Complaint">
                                                    </asp:DropDownList>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>

                                        </td>
                                        <td>
                                            <asp:RequiredFieldValidator ID="requireassigned" runat="server" ControlToValidate="drpAddcomAssign" ErrorMessage="*" ForeColor="#FF5050" InitialValue="0" ValidationGroup="Add_Complaint"></asp:RequiredFieldValidator>
                                        </td>
                                        <%-- <td> </td>--%>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 10px;"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="text-align: center;">
                                            <asp:Label ID="lblCompstatus" runat="server" Font-Size="Small" ForeColor="#48A4FF"></asp:Label>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 10px;"></td>
                                    </tr>

                                </table>
                            </form>

                        </div>

                        <div class="panel-footer" style="text-align: right;">
                            <asp:Button ID="btnAddcomplaintsubmit" runat="server" Text="Submit" CssClass="btn-sm btn btn-success" OnClick="btnAddcomplaintsubmit_Click" ValidationGroup="Add_Complaint" />
                            <button type="button" id="CancelAddcomplaint" onclick="funClear()" class="btn-sm btn btn-danger">Cancel</button>
                        </div>
                    </div>

                </div>




                <%------------------------------------------------------ Add Complaint Section Starts from here------------------------------------------------------------- --%>


                <%-----------------------------------------DataBindingEdit_Complaint_btn HistoryEventArgs Section Starts from here ------------------------------------------------------------------------------%>


                <div id="myModalCompHistoryPopup" class="modal">
                    <table style="width: 50%; margin-left: 25%; border: 1px solid #f2f2f2; box-shadow: 2px 2px 5px #bfbfbf; padding: 1% 0 1% 0; background-color: #f2f2f2; border-radius: 10px; padding: 0% 0 1% 0;">
                        <tr style="background-color: #5ca6de; color: #579ed4; padding: 1% 0 1% 0; height: 40px; border-radius: 5%; border-collapse: collapse;">
                            <td colspan="7" style="padding-left: 2%;">Complaint History :
                            </td>
                        </tr>
                        <tr style="height: 5vh;">
                            <td colspan="7" style="height: 15px;"></td>
                        </tr>
                        <tr>
                            <td style="width: 11%; text-align: left;"></td>
                            <td style="width: 11%; text-align: right;"></td>
                            <td style="width: 11%; text-align: right;">Flat Number :

                            </td>
                            <td style="width: 11%;">
                                <asp:TextBox ID="txtCompHistFlatNumber" runat="server" ReadOnly="True" CssClass="txtbox_style"></asp:TextBox>
                            </td>
                            <td style="width: 11%; text-align: right;">&nbsp;</td>
                            <td style="width: 11%;"></td>
                            <td style="width: 11%;"></td>

                        </tr>
                        <tr style="height: 1vh;">
                            <td colspan="7" style="height: 15px;"></td>
                        </tr>
                        <tr>
                            <td style="width: 11%;"></td>
                            <td colspan="5">
                                <asp:GridView ID="CompHistorygrid" runat="server" Width="100%" HorizontalAlign="Center" AutoGenerateColumns="false" BackColor="#E8E8E8" AllowPaging="True" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Font-Names="Calibri" ForeColor="#666666">
                                    <AlternatingRowStyle BackColor="White" />
                                    <Columns>
                                        <asp:BoundField DataField="FirstName" HeaderText="FirstName" />
                                        <asp:BoundField DataField="LastName" HeaderText="LastName" />
                                        <asp:BoundField DataField="CompType" HeaderText="Type" />
                                        <asp:BoundField DataField="CompStatus" HeaderText="CompStatus" />
                                        <asp:BoundField DataField="Severity" HeaderText="Severity" />
                                        <asp:BoundField DataField="AssignedTo" HeaderText="AssignedTo" />
                                        <asp:BoundField DataField="Descrption" HeaderText="Descrption" HeaderStyle-Width="50%">
                                            <HeaderStyle Width="50%"></HeaderStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ModifiedAt" HeaderText="ModifiedAt" DataFormatString="{0:dd/MMM/yyyy}" HeaderStyle-Width="30%">
                                            <HeaderStyle Width="30%"></HeaderStyle>
                                        </asp:BoundField>
                                    </Columns>
                                    <EditRowStyle BackColor="#FF9933" />
                                    <HeaderStyle BackColor="#0065A8" ForeColor="White" Height="30px" Font-Names="Calibri" />
                                    <PagerSettings Mode="NumericFirstLast" />
                                    <PagerStyle BackColor="White" BorderColor="#F0F5F5" Font-Bold="False" HorizontalAlign="Center" ForeColor="#4774D1" Font-Names="Berlin Sans FB" Font-Size="Medium" />
                                </asp:GridView>

                            </td>
                            <td style="width: 11%;"></td>
                        </tr>
                        <tr style="height: 1vh;">
                            <td colspan="7" style="height: 15px;"></td>
                        </tr>
                        <tr>
                            <td style="width: 11%;"></td>
                            <td colspan="2" style="text-align: center;"></td>
                            <td style="width: 11%; text-align: center;">
                                <button type="button" id="CancelCompHistory_Button" class="btn_style">Close</button>
                            </td>
                            <td colspan="2"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="height: 15px;"></td>
                        </tr>
                    </table>
                </div>



                <div id="myModalCloseComplaint" class="modal">
                    <div class="panel panel-primary" style="margin-top: 50px; margin-left: 250px; margin-right: 250px;">
                        <div class="panel-heading">
                            Confirm:
                             <label id="lblheading"></label>
                        </div>
                        <div class="panel-body">
                            Flat:
                             <label id="lblFlat"></label>
                            <br />
                            Complaint ID:
                             <asp:TextBox ID="lblCompID" Style="margin: 5px;" runat="server"></asp:TextBox><br />
                            New Status:  
                             <asp:TextBox ID="lblComplaintStatus" Style="margin: 14px;" runat="server"></asp:TextBox><br />
                             Assigned:  
                             <asp:TextBox ID="TextBox1" Style="margin: 14px;" runat="server"></asp:TextBox><br />

                            <button style="margin-left: 92px;" type="button" onclick="ConfirmClose()">Cancel</button>
                            <asp:Button ID="btnUpdate2" runat="server" CausesValidation="false" Text="Update" OnClick="btnUpdate_Click2"></asp:Button>
                        </div>

                    </div>
                </div>
            </form>

        </div>


    </div>




</body>
</html>
