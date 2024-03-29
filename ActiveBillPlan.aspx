﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ActiveBillPlan.aspx.cs" Inherits="ActiveBillPlan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <script src="Scripts/jquery-1.11.1.min.js"></script>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css" />

    <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>

    <link rel="Stylesheet" href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.10/themes/redmond/jquery-ui.css" />



    <link rel="stylesheet" href="CSS/ApttLayout.css" />
    <link rel="stylesheet" href="CSS/ApttTheme.css" />
    <style>
        .modal {
            display: none; /*  Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
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

        .form-control {
            display: inline;
            width: 25%;
            border-radius: 2px;
            margin-left: -5px;
        }

        .glyphicon {
            background-color: #607D8B;
            padding: 10px;
            margin-left: -7px;
            top: 2px;
        }

        td {
            padding: 5px;
        }

        th {
            padding: 8px;
        }

        .m-right {
            align-content: center;
        }
    </style>
    <script>


        $(function () {
            $("#txtActBillsFlats").autocomplete({
                source: function (request, response) {
                    var param = {
                        FlatNumber: $('#txtActBillsFlats').val()
                    };
                    $.ajax({
                        url: "ActiveBillPlan.aspx/GetFlatNumber",
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

        $(document).ready(function () {

            $("#txtCyclestart").datepicker({
                format:"dd-MM-yyyy"
            });
            $("#txtCycleend").datepicker({
               format:"dd-MM-yyyy"
            });


            $(document).click(function () {
                $("#ActiveBillDropdown").hide();

            });

            $("#btnActivateBill").click(function () {
                $("#ActivateBillForm").show();
            });

            $("#btnBillGencancel").click(function () {

                $("#ActivateBillForm").hide();
            });

               $("#txtStartDate").datepicker(
                {
                    dateFormat: "dd-mm-yy"
                });
         
         

            $("#txtBillDate").datepicker(
                {
                    dateFormat: 'dd-mm-yy',
                    minDate: new Date($("#txtStartDate").val())
                });

         

            $("#btnBillactvationcancel").click(function () {
                $("#ActivateBillForm").hide();
                $("#HiddenBillActvFlat").val("");
                $("#txtCyclestart").val("");
                $("#txtCycleend").val("");
                $('#lblbilltypeexist').html('');

            });


        });

        function ActiveBillPopup(SocietyBillID, FlatID, FlatArea, BillType, Rate, ChargeType, FlatNumber , Element) {


            // var status = Element.parentNode.parentNode.cells[7].innerHTML;

           // console.log("150    "+BillID ,FlatID ,FlatArea ,BillType ,Rate ,ChargeType ,Element , +"Flat Number= "+FlatNumber);

            document.getElementById("HiddenField1").value = FlatID;
            document.getElementById("HiddenField2").value = SocietyBillID;
            document.getElementById("Hiddenflatnumber").value = FlatNumber;
            document.getElementById("txtFlatID").value = FlatID;
            document.getElementById("labelRate").value = Rate;
            document.getElementById("labelchargeType").value = ChargeType;
            document.getElementById("lablebillType").value = BillType;

            var Posx = 0;
            var Posy = 0;
            while (Element != null) {

                Posx += Element.offsetLeft;
                Posy += Element.offsetTop;
                Element = Element.offsetParent;
            }




            document.getElementById("ActiveBillDropdown").style.top = Posy + 'px';
            document.getElementById("ActiveBillDropdown").style.left = Posx - 100 + 'px';


            document.getElementById("HiddenBillID").value = SocietyBillID;
            document.getElementById("HiddenFieldFlatArea").value = FlatArea;
            document.getElementById("HiddenFieldRate").value = Rate;
            // document.getElementById("HiddenFieldCycleType").value = CycleType;
            /* document.getElementById("HiddenFieldChargeType").value = ChargeType;
             document.getElementById("HiddenFieldCycleStart").value = cyclestart;
 
 
             var Currentdate = new Date();
             var CurrentDateFormat = Currentdate.toLocaleDateString();
             var cyclestartdatenew = new Date(cyclestart);
             var cycleenddatenew = new Date(cycleEnd);
             var cyclestartdate = cyclestartdatenew.toLocaleDateString();
             var cycleenddate = cycleenddatenew.toLocaleDateString();*/

            if (status == "InActive") {

                document.getElementById("btnActivateBill").style.display = "block";
                document.getElementById("btnDeactivate").style.display = "none";


            }

            if (status == "Active") {

                document.getElementById("btnActivateBill").style.display = "none";
                document.getElementById("btnDeactivate").style.display = "block";
            }


            if (status == "DeActive") {

                document.getElementById("btnActivateBill").style.display = "block";
                document.getElementById("btnDeactivate").style.display = "none";

            }

            $("#ActiveBillDropdown").slideDown();
            event.stopPropagation();

        }

        function ShowActivateBillForm() {
           
            document.getElementById("ActivateBillForm").style.display = "block";

        }

        function closeAddFlat() {
            $("#txtBillDate").val("");
            $("#txtFlatBillAmt").val("");
            $("#txtBillGenSingleFlatdesc").val("");
            $("#ActivateBillForm").hide();
        }

    </script>
</head>
<body style="background-color: #f7f7f7;">
    <div class="container-fluid">
        <div class="col-xs-12 col-sm-12">
            <form id="form1" runat="server">
                <asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager>
                <div class="container-fluid">


                    <div class="row" style="height: 50px; margin-top: 15px;">
                        <div class="col-sm-3 hidden-xs">
                            <div>
                                <h4 class="pull-left ">Active Bill : </h4>
                            </div>
                        </div>
                        <div class="col-sm-9 col-xs-12">
                            <div class="form-group">
                                <asp:DropDownList ID="drpBillStatusype" Visible="false" runat="server" CssClass="form-control">
                                    <asp:ListItem>Show All</asp:ListItem>
                                    <asp:ListItem>Active</asp:ListItem>
                                    <asp:ListItem>DeActive</asp:ListItem>
                                    <asp:ListItem>InActive</asp:ListItem>
                                </asp:DropDownList>
                                <asp:DropDownList ID="drpActivatedBillType" runat="server" CssClass="form-control" />
                                <asp:TextBox ID="txtActBillsFlats" runat="server" ToolTip="Enter Flat" placeholder="Flat Number" CssClass="form-control"></asp:TextBox>
                                <asp:LinkButton runat="server" BackColor="Transparent" ForeColor="Black" OnClick="searchActivatedBills_Click" ValidationGroup="Flat_Search"> <span class="glyphicon glyphicon-search"></span></asp:LinkButton>

                            </div>
                        </div>

                    </div>


                </div>

                <table id="tblFlatBills" runat="server" style="margin-top: 1%; width: 100%;">

                    <tr>
                        <td colspan="4" style="text-align: center;">Activated :
                           <asp:Label ID="lblActivateCount" runat="server" Text=""></asp:Label>
                            Deactivated :
                            <asp:Label ID="lblDeactivateCount" runat="server" Text=""></asp:Label>
                            Not Activated :
                           <asp:Label ID="lblNotActivateCount" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="4" style="text-align: center; height: 10px;"></td>
                    </tr>

                    <tr style="height: 3vh; text-align: center;">

                        <td colspan="4" style="text-align: center;">
                            <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                         <ContentTemplate>--%>

                            <asp:GridView ID="FlatsBillsGrid" runat="server" AllowPaging="True"
                                HeaderStyle-BackColor="#271573"
                                OnSelectedIndexChanged="FlatsBillsGrid_SelectedIndexChanged"
                                HeaderStyle-ForeColor="#ffffff"
                                HeaderStyle-BorderStyle="None"
                                AutoGenerateColumns="false" BackColor="#E8E8E8" BorderColor="Silver" BorderStyle="Solid"
                                BorderWidth="1px" EmptyDataText="No Records Found" Font-Names="Calibri" ForeColor="#666666"
                                HorizontalAlign="Center" PageSize="15"
                                ShowHeaderWhenEmpty="True" Style="margin-bottom: 0px; width: 100%;"
                                OnPageIndexChanging="FlatsBillsGrid_PageIndexChanging" OnRowDataBound="FlatsBillsGrid_RowDataBound"
                                OnRowCommand="ActivateBill_RowCommand">

                                <AlternatingRowStyle BackColor="#f5f5f5" />
                                <Columns>
                                    <asp:BoundField DataField="SocietyBillID" HeaderText="SocietyBillID" ItemStyle-CssClass="BillActiveGrid" HeaderStyle-Width="30px" />
                                    <asp:BoundField DataField="FlatNumber" HeaderText="FlatNumber" ItemStyle-CssClass="BillActiveGrid" HeaderStyle-Width="60px" />
                                    <asp:BoundField DataField="FlatArea" HeaderText="FlatArea" ItemStyle-CssClass="BillActiveGrid" HeaderStyle-Width="60px" />
                                    <asp:BoundField DataField="BillType" HeaderText="BillType" ItemStyle-CssClass="BillActiveGrid" HeaderStyle-Width="80px" />
                                    <asp:BoundField DataField="Rate" HeaderStyle-Width="70px" HeaderText="Rate" ItemStyle-Width="70px" ItemStyle-CssClass="BillActiveGrid">
                                        <HeaderStyle Width="70px" />
                                        <ItemStyle Width="70px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ChargeType" HeaderText="ChargeType" ItemStyle-CssClass="BillActiveGrid" HeaderStyle-Width="60px" />
                                    <asp:BoundField DataField="CycleType" HeaderText="CycleType" ItemStyle-CssClass="BillActiveGrid" HeaderStyle-Width="80px" />

                                    <%-- <asp:BoundField DataField="CycleStart" HeaderText="CycleStart" DataFormatString="{0:dd/MMM/yyyy}" ItemStyle-Font-Size="Small"  HeaderStyle-Width="80px"/>
                                       <asp:BoundField DataField="CycleEnD" HeaderText="CycleEnD" DataFormatString="{0:dd/MMM/yyyy}" ItemStyle-Font-Size="Small"  HeaderStyle-Width="80px"/>
                                    --%>
                                    <asp:BoundField Visible="false" HeaderText="Status" ItemStyle-CssClass="BillActiveGrid" ItemStyle-Wrap="false" ItemStyle-Width="50px" HeaderStyle-Width="60px" />
                                    <asp:TemplateField HeaderStyle-Width="20px">
                                        <ItemTemplate>

                                            <asp:LinkButton ID="btnBillHistory" runat="server"
                                                            CommandName="Activate"
                                                            CommandArgument='<%# Eval("SocietyBillID")+ ","+ Eval("FlatID") %>'
                                                            Text="Activate" CssClass="btn btn-info btn-sm" CausesValidation="false" />


                                            <%--<button id="button" onclick="ActiveBillPopup('<%# Eval("SocietyBillID") %>' ,'<%# Eval("FlatID") %>' , '<%# Eval("FlatArea") %>' ,'<%# Eval("BillType") %>','<%# Eval("Rate") %>','<%# Eval("ChargeType") %>','<%# Eval("CycleType") %>','<%# Eval("CycleStart") %>','<%# Eval("CycleEnD") %>',this)" type="button" style=" width:20px;background-color:transparent;border:none;outline:0; height:20px;">--%>
                                            <button  id="button" onclick="ActiveBillPopup('<%# Eval("SocietyBillID") %>' ,'<%# Eval("FlatID") %>' , '<%# Eval("FlatArea") %>' ,'<%# Eval("BillType") %>','<%# Eval("Rate") %>','<%# Eval("ChargeType") %>' ,'<%# Eval("FlatNumber") %>' ,this)" type="button" style="width: 20px; background-color: transparent; border: none; outline: 0; height: 20px; visibility:hidden">
                                                <i class="fa fa-angle-double-right" id="left_icon" style="color: gray; font-size: 20px"></i>

                                               <%-- <asp:HiddenField ID="HiddenBillID" runat="server" />
                                                <asp:HiddenField ID="HiddenField1" runat="server" />
                                                <asp:HiddenField ID="HiddenField2" runat="server" />
                                                <asp:HiddenField ID="Hiddenflatnumber" runat="server" />

                                                <asp:HiddenField ID="HiddenBillActvFlat" runat="server" />
                                                <asp:HiddenField ID="HiddenActDeact" runat="server" />
                                                <asp:HiddenField ID="HiddenbillType" runat="server" />


                                                <asp:HiddenField ID="HiddenFieldRate" runat="server" />
                                                <asp:HiddenField ID="HiddenFieldFlatArea" runat="server" />
                                                <asp:HiddenField ID="HiddenFieldCycleType" runat="server" />
                                                <asp:HiddenField ID="HiddenFieldChargeType" runat="server" />
                                                <asp:HiddenField ID="HiddenFieldCycleStart" runat="server" />--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataRowStyle BackColor="Silver" />

                                <PagerSettings Mode="NumericFirstLast" />
                                <PagerStyle BackColor="White" BorderColor="#F0F5F5" Font-Bold="False" Font-Names="Berlin Sans FB" Font-Size="Medium" ForeColor="#62BCFF" HorizontalAlign="Center" />
                            </asp:GridView>
                        </td>

                        <td style="">
                            <asp:HiddenField ID="HiddenBillID" runat="server" />
                            <asp:HiddenField ID="HiddenField1" runat="server" />
                            <asp:HiddenField ID="HiddenField2" runat="server" />
                            <asp:HiddenField ID="Hiddenflatnumber" runat="server" />
                            <asp:HiddenField ID="txtFlatID" runat="server" />

                            <asp:HiddenField ID="HiddenBillActvFlat" runat="server" />
                            <asp:HiddenField ID="HiddenActDeact" runat="server" />
                            <asp:HiddenField ID="HiddenbillType" runat="server" />


                            <asp:HiddenField ID="HiddenFieldRate" runat="server" />
                            <asp:HiddenField ID="HiddenFieldFlatArea" runat="server" />
                            <asp:HiddenField ID="HiddenFieldCycleType" runat="server" />
                            <asp:HiddenField ID="HiddenFieldChargeType" runat="server" />
                            <asp:HiddenField ID="HiddenFieldCycleStart" runat="server" />


                            <div id="ActiveBillDropdown" class="layout-dropdown-content theme-dropdown-content">
                                <asp:Button ID="btnFlatbillGen" runat="server" CssClass="layout_dropdown_Button" CausesValidation="false" Text="Generate Bill " OnClick="btnFlatbillGen_Click" />
                                <asp:Button type="button" ID="btnActivateBill" CssClass="layout_dropdown_Button" CausesValidation="false" runat="server"  Text="Activate" OnClick="btnActivateBill_Click" />
                                <asp:Button ID="btnDeactivate" runat="server" Text="Deactivate" CssClass="layout_dropdown_Button" CausesValidation="false" OnClick="btnDeactivatebill_Click" />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="height: 10px;"></td>
                    </tr>

                    <tr>
                        <td colspan="4" style="text-align: center;">
                            <asp:Label ID="lblBillGenStatus" runat="server" ForeColor="#4FA7FF"></asp:Label></td>
                    </tr>
                    <tr>
                        <td colspan="4" style="text-align: center;">
                            <asp:Label ID="Label26" runat="server" Text="Total Count :" ForeColor="#0099FF"></asp:Label>
                            <span style="margin-left: 1%;"></span>
                            <asp:Label ID="lblActvBillsCount" runat="server" ForeColor="#0099FF"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="height: 10px;"></td>
                    </tr>
                </table>
                <asp:Button ID="btnActiveExport" runat="server" Text="Export" CausesValidation="false" OnClick="ExportToExcelActive" /><%--Added by Aarshi on 14 - Sept - 2017 for bug fix--%>

                <%----------------------------------------------   Bill description ---------------------------------------------  --%>



                <%----------------------------------------------------- Activate a Bill for flat----------------------------------------------------%>
                <%--  <div id="Mymodalactivatenewplan" class="modal"> --%>
                <%--                <div id="" class="modal">
                    <table style="width: 50%; margin-left: 15%; margin-top: 3%; background-color: #e0dada;">
                        <tr style="background-color: #5ca6de; color: #579ed4; padding: 2% 0 2% 0;">
                            <td colspan="6" style="text-align: left; color: white; font-weight: bold; font-size: large; padding: 1% 0 1% 3%;">New Bill :
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 15px;"></td>
                        </tr>
                        <tr>
                            <td class="lbltxt" style="width: 50%;">Flat Number :
                            </td>
                            <td>
                               
                            </td>
                            <td style="width: 1%;">

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtFlatID" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td class="lbltxt" style="width: 50%; visibility:hidden">Society BillID :
                            </td>
                            <td style="width: 50%;">
                                <asp:TextBox ID="TextBox2" runat="server" CssClass="txtbox_style" Visible="false"></asp:TextBox>
                            </td>
                            <td style="width: 1%;">

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtFlatID" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>

                        <tr>
                            <td class="lbltxt" style="width: 50%;">Current Bill Amount :
                            </td>
                            <td style="width: 50%;">
                                
                            </td>
                            <td style="width: 1%;">

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtFlatID" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td class="lbltxt" style="width: 50%;">Payment Due Date :
                            </td>
                            <td style="width: 50%;">
                                <asp:TextBox ID="" runat="server" CssClass="txtbox_style"></asp:TextBox>
                            </td>
                            <td style="width: 1%;">

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtFlatID" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>

                        <tr>
                            <td class="lbltxt" style="width: 50%;">Amount Paid:
                            </td>
                            <td style="width: 50%;">
                                
                            </td>
                            <td style="width: 1%;">

                             <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtFlatID" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                         </td>
                                          
                         <%-- </td>
                            <td class="lbltxt" style="width: 50%;">Current Month Balance :

                            </td>               
                            <td class="lbltxt" style="width: 50%;  visibility:hidden"">Current Month Balance :

                            </td>
                            <td style="width: 50%;">
                                <asp:TextBox ID="TextBox5" runat="server" CssClass="txtbox_style" Visible="false"></asp:TextBox>
                            </td>
                            <td style="width: 1%;">

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtFlatID" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="lbltxt" style="width: 50%;">Modified at :
                            </td>
                            <td style="width: 50%;">
                                
                            </td>
                            <td style="width: 1%;">

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="txtFlatID" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td class="lbltxt" style="width: 50%;">Bill Description :
                            </td>
                            <td style="width: 50%;">
                                
                            </td>
                            <td style="width: 1%;">

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="txtFlatID" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="lbltxt" style="width: 50%;">BillType :
                            </td>
                            <td style="width: 50%;">
                                
                            </td>
                            <td style="width: 1%;">

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtBillType" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td class="lbltxt" style="width: 50%;">Charge Type:
                            </td>
                            <td style="width: 50%;">
                                
                            </td>
                        </tr>
                        <tr>
                            <td class="lbltxt" style="width: 50%;">Rate:
                            </td>
                            <td style="width: 50%;">
                               
                            </td>
                            <td class="lbltxt" style="width: 50%;">CycleType:
                            </td>
                            <td style="width: 80%;">
                                <asp:DropDownList ID="drpCycletype" runat="server" CssClass="ddl_style" Enabled="false">
                                    <asp:ListItem>Monthly</asp:ListItem>
                                    <asp:ListItem>Quarterly</asp:ListItem>
                                    <asp:ListItem>Yearly</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="lbltxt" style="width: 10%;">Cyclestart :
                            </td>
                            <td style="width: 10%;">
                               
                            </td>

                            <td class="lbltxt">CycleEnd :
                            </td>
                            <td>
                               </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 30px; text-align: center;">
                                <asp:Label ID="lblbilltypeexist" runat="server" Font-Size="Small" ForeColor="#FF6262"></asp:Label>
                            </td>
                        </tr>
                        <tr style="text-align: center;">
                            <td style="text-align: center;">
                                <asp:Button ID="btnBillcycleSubmit" runat="server" Text="Activate" CssClass="btn_style" OnClick="btnBillcycleSubmit_Click" />
                            </td>
                            <td style="text-align: center;">
                                <button type="button" id="btnBillactvationcancel" class="btn_style btn-danger">Cancel</button>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 15px;"></td>
                        </tr>
                    </table>

                </div>--%>

                <div id="ActivateBillForm2" class="modal">
                    <div class="row" style="width: 80%; margin-left: 15%; margin-top: 3%; background-color: #e0dada;">
                        <div class="row" style="background-color: #5ca6de; color: #579ed4; padding: 2% 0 2% 0;">
                            <div class="col-md-6 col-sm-6" style="text-align: left; color: white; font-weight: bold; font-size: large; padding: 1% 0 1% 3%;">
                                New Bill :
                            </div>
                        </div>
                        <div class="row">
                            <div class="col" style="height: 15px;"></div>
                        </div>
                        <!-- Model Content -->
                        <div class="row" style="margin-top: 5px;">
                            <div class="">
                                    Flat Number : 
                                    <asp:Label ID="lblFlatNumber" runat="server" CssClass="txtbox_style"></asp:Label>
                            </div>
                            <div class="">
                                Bill Type : 
                            <asp:Label ID="lablebillType" runat="server" CssClass="txtbox_style"></asp:Label>
                            </div>
                        </div>

                        <div class="row" style="margin-top: 5px;">
                            <div class="col-md-6 col-sm-6 lbltxt">
                                Charge Type : 
                            <asp:Label ID="labelchargeType" runat="server" CssClass="txtbox_style"></asp:Label>
                            </div>
                            <div class="col-md-6 col-sm-6 lbltxt">
                                Rate : 
                             <asp:Label ID="labelRate" runat="server" CssClass="txtbox_style"></asp:Label>
                            </div>
                        </div>

                        <div class="row" style="margin-top: 5px;">
                            <div class="col-md-6 col-sm-6 lbltxt">
                                Cycle Type : 
                            <asp:Label ID="labelcycletype" runat="server"></asp:Label>
                            </div>
                            <div class="col-md-6 col-sm-6 lbltxt">
                                Current Bill Amount : 
                             <asp:TextBox ID="txtbillamt" runat="server" CssClass="txtbox_style"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row" style="margin-top: 5px;">
                            <div class="col-md-6 col-sm-6 lbltxt">
                                Payment Due Date : 
                            <asp:TextBox ID="txtdue" runat="server" CssClass="txtbox_style" ForeColor="#808080"></asp:TextBox>
                            </div>
                            <div class="col-md-6 col-sm-6 lbltxt">
                                Amount Paid : 
                             <asp:TextBox ID="txtamtpaid" runat="server" CssClass="txtbox_style"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row" style="margin-top: 5px;">
                            <div class="col-md-6 col-sm-6 lbltxt">
                                Start Date : 
                             <asp:TextBox ID="txtCyclestart" runat="server" CssClass="txtbox_style" ForeColor="#808080"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCyclestart" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-6 col-sm-6 lbltxt">
                                End Date : 
                              <asp:TextBox ID="txtCycleend" runat="server" CssClass="txtbox_style" ForeColor="#808080"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtCycleend" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="row" style="margin-top: 5px;">
                            <div class="col-md-12 col-sm-12" style="height: 30px; text-align: center;">
                                <asp:Label ID="lblbilltypeexist" runat="server" Font-Size="Small" ForeColor="#FF6262"></asp:Label>
                            </div>
                        </div>

                        <div class="row" style="margin-top: 5px;">
                            <div class="col-md-12 col-sm-12 lbltxt">
                                Description : 
                            <asp:TextBox ID="txtdesc" runat="server" CssClass="txtbox_style" Width="70%" TextMode="MultiLine"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row" style="text-align: center; margin-top: 5px;">
                            <div class="col-md-6 col-sm-6" style="text-align: center;">
                                <asp:Button ID="btnBillcycleSubmit" runat="server" Text="Activate" CssClass="btn_style" OnClick="btnBillcycleSubmit_Click" />
                            </div>
                            <div class="col-md-6 col-sm-6" style="text-align: center;">
                                <button type="button" id="btnBillactvationcancel" class="btn_style btn-danger">Cancel</button>
                            </div>
                        </div>

                        <div class="row" style="width: 50%; visibility: hidden">
                            <asp:TextBox ID="TextBox2" runat="server" CssClass="txtbox_style"></asp:TextBox>
                            <asp:TextBox ID="TextBox6" runat="server" CssClass="txtbox_style"></asp:TextBox>
                            <asp:TextBox ID="TextBox5" runat="server" CssClass="txtbox_style"></asp:TextBox>
                        </div>
                    </div>
                </div>




                <%------------------------------------------------------- end of the bills activation page----------------------------------%>



                <%--   ---------------------------    Activated Bills View Section Ends Here     -------------  -------- --------------%>
                <%-- ------------------------------------------------- ActivateBillForm For Single Flat ---------------------------------------------------  --%>
                <%--    Activated Bills View Section Ends Here     -------------  -------- --------------%>
                <%-- ------------------------------------------------- GenerateDeActivateBillForm For Single Flat ---------------------------------------------------  --%>

                <div id="ActivateBillForm" class="modal">
                    <div class="panel panel-primary" style="width: 400px; margin-left: 155px; position: absolute;">
                        <div class="panel-heading">
                            FlatBill Summary :
                            <a onclick="CloseAddFlat()" style="cursor: pointer;"><span class="fa fa-close" style="color: white; float: right;"></span></a>
                        </div>
                        <div class="panel-body">
                            <table>

                                <tr>
                                    <td class="lbltxt" style="width: 100px;">Flat :</td>
                                    <td style="width: 100px;">
                                        <asp:Label ID="lblFlatNuber" runat="server" Font-Size="Small"></asp:Label>
                                    </td>
                                     <td class="lbltxt" style="width: 100px;">Bill Type :  </td>
                                    <td style="width: 100px;">
                                        <asp:Label ID="lblBillType" runat="server" Font-Size="Small"></asp:Label>
                                    </td>
                                </tr>

                                <tr>
                                   

                                </tr>

                                <tr>
                                    <td class="lbltxt" style="width: 100px;">Flat Area : </td>
                                    <td style="width: 100px;">
                                        <asp:Label ID="lblFlatArea" runat="server" Font-Size="Small"></asp:Label>
                                    </td>
                                    <td class="lbltxt" style="width: 100px;">Type :</td>
                                    <td style="width: 100px;">
                                        <asp:Label ID="lblChargeType" runat="server" Font-Size="Small"></asp:Label>
                                    </td>
                                </tr>

                                <tr>
                                    

                                </tr>

                                <tr>
                                     <td class="lbltxt" style="width: 100px;">Previous Balance : </td>
                                    <td style="width: 100px;">
                                        <asp:Label ID="lblPreviousBalance" runat="server" Font-Size="Small"></asp:Label>
                                    </td>
                                    <td class="lbltxt" style="width: 100px;">Rate :</td>
                                    <td style="width: 100px;">
                                        <asp:Label ID="lblRate" runat="server" Font-Size="Small"></asp:Label>
                                    </td>

                                </tr>

                                <tr>
                                    <td class="lbltxt" style="width: 100px;">From Date : <br />
                                          <asp:TextBox ID="txtStartDate" Width="80" runat="server"></asp:TextBox>
                                        <%--<asp:Label ID="lblFromDate" runat="server" Font-Size="Small"></asp:Label>--%>
                                    </td>
                                    <td style="width: 100px;">
                                        
                                    </td>
                                    <td class="lbltxt" style="width: 100px;">Till Date : <br />
                                        <asp:TextBox type="text" ID="txtBillDate" Width="80" runat="server"></asp:TextBox>
                                    </td>
                                    <td style="width: 100px;">
                                           <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>
                                                <%--<asp:Button ID="btnCalculate" runat="server" Text="Calculate"  Width="30" Height="30" CausesValidation="false" OnClick="btnCalculateOnEnddate_Click" />--%>
                                                <asp:LinkButton ID="lblcalc" CssClass="fa fa-calculator" runat="server" Font-Size="20"  Width="20" Height="20" CausesValidation="false" OnClick="btnCalculateOnEnddate_Click" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                        <%-- >  <asp:Label ID="lblTillDate" runat="server" Font-Size="Small"></asp:Label>--%>
                                 
                                    </td>
                                </tr>
                                <tr>
                                   

                                </tr>
                                <tr>
                                    
                                    <td colspan="2" style="width: 10px;">
                                     
                                    </td>

                                </tr>



                                <tr>
                                    <td class="lbltxt" style="width: 100px;">Amount : </td>
                                    <td colspan="3"  style="width: 100px;">
                                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                            <ContentTemplate>
                                                <asp:TextBox ID="txtFlatBillAmt" runat="server" CssClass="txtbox_style" Visible="False"></asp:TextBox>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>


                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtFlatBillAmt" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Textbox" InitialValue="0"></asp:RequiredFieldValidator>


                                </tr>

                                <tr>
                                    <td class="lbltxt">Description :</td>
                                    <td colspan="3">
                                        <asp:TextBox ID="txtActivateDescription" style="resize:none;" runat="server" TextMode="MultiLine" Rows="3" Width="250px" Height="50px" ></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="4" style="height: 15px; text-align: center;">
                                        <asp:Label ID="lblBillDuplicate" runat="server" Font-Size="Small" ForeColor="#55AAFF"></asp:Label>

                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="panel-footer" style="text-align: right;">
                            <asp:Button ID="btnSingleFlatGenerate" runat="server" Text="Generate Bill" CssClass="btn btn-primary" OnClick="btnActivateFlatBill_Click" ValidationGroup="Textbox" />

                            <button type="button" id="btnBillGencancel" onclick="closeAddFlat();" class="btn btn-danger">Cancel</button>

                            <%--<asp:Button ID="btnBillGencancel" runat="server" Text="Cancel"  CssClass="btn_style" OnClick="btnBillGencancel_Click"/>--%>
                        </div>



                    </div>
                </div>

            </form>
        </div>

    </div>
</body>
</html>
