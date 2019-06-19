<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Poll.aspx.cs" Inherits="Poll" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
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

            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css" />

            <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js"></script>
            <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>
            <link rel="Stylesheet" href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.10/themes/redmond/jquery-ui.css" />
            <link rel="stylesheet" href="CSS/NewAptt.css" />
            <link rel="stylesheet" href="CSS/ApttLayout.css" />
            <link rel="stylesheet" href="CSS/ApttTheme.css" />
            <link rel="stylesheet" href="CSS/Nestin.css" />
            <link rel="stylesheet" href="CSS/Nestin-3rdParty.css" />




    <style>
        .theme_primary_bg a {
            color: #000;
        }

        td {
            padding: 6px;
        }


        .next_icon {
            background-image: url('Images/next_icon_1.png');
        }

        .btnpre {
            background-image: url('Images/Icon/pre.png');
            background-repeat: no-repeat;
            height: 30px;
            width: 30px;
            border-radius: 50%;
        }

        .btnnext {
            background-image: url('Images/Icon/next.png');
            background-repeat: no-repeat;
            height: 30px;
            width: 30px;
            border-radius: 50%;
        }


        .Poll_End_Label {
            float: right;
        }

        .btnPiechart1 {
            margin-top: 1%;
            margin-bottom: 1%;
            visibility: hidden;
            /*visible*/ /*hidden*/
        }

        .btnPiechart2 {
            margin-top: 1%;
            margin-bottom: 1%;
            visibility: hidden;
            /*visible*/ /*hidden*/
        }

        .Radio {
            text-align: center;
        }

        .lblStartdate {
            float: right;
        }


        .modal {
            display: none; /*  Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 2; /* Sit on top */
            padding-top: 0.5%; /* Location of the box */
            left: 0px;
            top: 0px;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /*Enable scroll if needed  */
            background-color: #e6e2e2;
            background-color: rgba(0,0,0,0.4);
        }

        .mymodalcontent {
            position: relative;
            left: 160px;
            top: 50px;
        }

        .lbltxt {
            padding-left: 10%;
            font-size: small;
        }

        .auto-style1 {
            width: 5%;
        }


        .shaded_div_box {
            background-color: #faf9f9;
            border-radius: 10px 10px 10px 10px;
            margin: 5px;
            box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2), 0 5px 10px 0 rgba(0, 0, 0, 0.19);
            text-align: left;
            padding: 5px;
        }

        .poll_header {
            border-radius: 4px;
            font-family: Verdana;
            font-size: 14px;
            width: 175px;
            border: 1px solid #cccccc;
            color: #000000;
            height: 30px;
            background-color: white;
            text-indent: 0.01px;
            outline: 0;
            text-align: center;
            padding: 1px;
            margin: 10px;
        }

        .no-resize {
            resize: none;
        }
    </style>
    <script>


        function RadioButtonCheck1(selectedButton) {

            var userType = '<%=Session["UserType"] %>';
            if (userType == "Admin") {
                document.getElementById("btnPieChart1").style.visibility = "hidden";
            }
            else {
                var ID = document.getElementById("HiddenField1").value;

                if (ID != 0) {
                    if (ID == selectedButton) {

                        document.getElementById("btnPieChart1").style.visibility = "hidden";
                    }

                    else {

                        document.getElementById("btnPieChart1").style.visibility = "visible";
                    }
                }
                else {

                    document.getElementById("btnPieChart1").style.visibility = "visible";
                }
            }
        }

        function RadioButtonCheck2(selectedButton) {

            var userType = '<%=Session["UserType"] %>';
            if (userType == "Admin") {
                document.getElementById("btnPieChart2").style.visibility = "hidden";
            }

            else {
                var ID = document.getElementById("HiddenField2").value;

                if (ID != 0) {
                    if (ID == selectedButton) {
                        document.getElementById("btnPieChart2").style.visibility = "hidden";
                    }
                    else {
                        document.getElementById("btnPieChart2").style.visibility = "visible";
                    }
                }

                else {
                    document.getElementById("btnPieChart2").style.visibility = "visible";
                }
            }

        }



        function ValidateDate() {
            var text = document.getElementById("txtEndDate");
            var textdate = new Date(text.value);

            var CurrDate = new Date();

            if (textdate < CurrDate) {
                alert("Entered Date  should  not  be  less than  current date");

                return false;
            }

            if (textdate > CurrDate) {

                return true;
            }
        }

        $(document).ready(function () {

            window.parent.FrameSourceChanged();

            $("#txtEndDate").datepicker({ dateFormat: 'dd-mm-yy' });

            var userType = '<%=Session["UserType"] %>';

            if (userType == "Admin") {

                document.getElementById("Add_Poll").style.visibility = 'visible';

            }
            else {
                document.getElementById("Add_Poll").style.visibility = 'hidden';
            }
        })


        $(document).ready(function () {
            $("#Add_Poll").click(function () {




                $("#myModal").show();
            });
        });

        $(document).ready(function () {
            $("#CancelPoll_Button").click(function () {
                $("#myModal").hide();
                $("#lblPollstatus").html('');
                $("input:text").val("");
            });
        });

        function funClear() {

            var PollQ = document.getElementById("txtPollQ");

            PollQ.value = "";
            $("#myModal").hide();
        }

        function ViewPopup() {
            alert(2);
            var PollQuestion = document.getElementById('<%=txtPollQ.ClientID%>').value;

            if (PollQuestion != "") {

                document.getElementById("myModal").style.display = "block";
            }
        }

        function SetActiveClass(name) {
            //alert(name);
            if (name == "Open") {
                $('#showOpen').addClass('btn-primary');
                $("#showClose").removeClass('btn-primary');
                $("#showAll").removeClass('btn-primary');
            }
            else if (name == "Close") {
                $('#showOpen').removeClass('btn-primary');
                $("#showClose").addClass('btn-primary');
                $("#showAll").removeClass('btn-primary');
            }
            else if (name == "All") {
                $('#showOpen').removeClass('btn-primary');
                $("#showClose").removeClass('btn-primary');
                $("#showAll").addClass('btn-primary');
            }
        }



    </script>
</head>
<body>

    <div class="container-fluid">
        <div class="row" id="scroll_div" style="min-height: 500px;">

            <div class="col-xs-12" style="background-color: #f7f7f7;">





                <form id="form1" runat="server" autocomplete="off">


                    <div class="container-fluid">
                        <div class="row" style="margin-top: 10px;">
                            <div class="col-sm-3  col-xs-3">
                                <div>
                                    <h4 class="pull-left ">Polls : </h4>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xs-6" style="text-align: center;">

                                <ul class="nav nav-pills" style="margin: auto; width: 170px;">
                                    <li role="presentation">
                                        <asp:Button runat="server" CssClass="btn btn-sm btn-primary" ID="showOpen" OnClick="showOpen_Click" Text="Open" CausesValidation="False" /></li>
                                    <li role="presentation">
                                        <asp:Button runat="server" CssClass="btn btn-sm btn-primary" ID="showClose" OnClick="showClose_Click" Text="Close" CausesValidation="False" /></li>
                                    <li role="presentation">
                                        <asp:Button runat="server" CssClass="btn btn-sm btn-primary" ID="showAll" OnClick="showAll_Click" Text="All" CausesValidation="False" /></li>
                                </ul>
                            </div>
                            <div class="col-sm-3 col-xs-3">
                                <div>
                                    <button id="Add_Poll" type="button" style="margin-top: 0px;" class="btn btn-primary pull-right btn-sm">Add Poll</button>
                            </div>
                        </div>
                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Label ID="lblEmptyPie1" runat="server" Visible="false" ForeColor="#E91E63"></asp:Label>

                            </div>
                        </div>

                        <div class="row" style="margin-top: 15px">
                            <div id="chartData" runat="server" class=" col-xs-12 col-sm-6 col-md-6 ">
                                <div class="layout_shadow_box">
                                    <div class="row">
                                        <asp:Label ID="lblPollP1" runat="server" ForeColor="#0066CC" Text="Poll"></asp:Label><br />
                                        <asp:Label ID="lblQ1" runat="server" Height="30px" Font-Size="Smaller" ForeColor="#4A4A4A"></asp:Label>
                                    </div>
                                    <div class="row rad">
                                        <div class="col-xs-10" style="text-align: left; padding-left: 25px;">
                                            <ol>
                                                <li>
                                                    <asp:RadioButton ID="RadioChart1Opt1" CssClass="Space" runat="server" GroupName="RadioGroup1" onchange="RadioButtonCheck1(1)" ViewStateMode="enabled" Font-Size="Smaller" required /></li>
                                                <li>
                                                    <asp:RadioButton ID="RadioChart1Opt2" CssClass="Space" runat="server" GroupName="RadioGroup1" onchange="RadioButtonCheck1(2)" ViewStateMode="enabled" Font-Size="Smaller" required /></li>
                                                <li>
                                                    <asp:RadioButton ID="RadioChart1Opt3" CssClass="Space" runat="server" GroupName="RadioGroup1" onchange="RadioButtonCheck1(3)" ViewStateMode="enabled" Font-Size="Smaller" required /></li>
                                                <li>
                                                    <asp:RadioButton ID="RadioChart1Opt4" CssClass="Space" runat="server" GroupName="RadioGroup1" onchange="RadioButtonCheck1(4)" ViewStateMode="enabled" Font-Size="Smaller" required /></li>
                                            </ol>
                                        </div>
                                    </div>

                                    <div class="row hcenter">
                                        <asp:Chart ID="PieChart1" runat="server" Width="180px" Height="150px" BackColor="Transparent">
                                            <Series>
                                                <asp:Series Name="Series1" ChartType="Doughnut" LegendText="#PERCENT"></asp:Series>
                                            </Series>
                                            <ChartAreas>
                                                <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                                            </ChartAreas>
                                        </asp:Chart>
                                        <br />
                                        <asp:Label ID="lblTotalVote1" runat="server" Font-Size="Small" ForeColor="#0055AA"></asp:Label>
                                        <br />


                                        <asp:Label ID="lblPie1date" runat="server" Text="Started On :" Font-Size="Small" ForeColor="#0055AA"></asp:Label>
                                        <br />

                                    </div>

                                    <asp:HiddenField ID="HiddenField1" runat="server" />
                                    <asp:Button ID="btnPieChart1" runat="server" CssClass="btnPiechart1" OnClick="btnPieChart1_Click" CausesValidation="false" Text="Submit" />

                                </div>
                            </div>
                            
                            <asp:Panel runat="server" ID="pnlchart2">
                                <div id="chart2data" runat="server" class="col-xs-12 col-sm-6 col-md-6 ">
                                    <div class="layout_shadow_box">
                                         <div class="row">
                                        <asp:Label ID="lblPollP2" runat="server" ForeColor="#0066CC" Text="Poll"></asp:Label><br />
                                        <asp:Label ID="lblQ2" runat="server" Height="30px" Font-Size="Small" ForeColor="#4A4A4A"></asp:Label>
                                    </div>
                                    <div class="row rad">
                                        <div class="col-xs-10" style="text-align: left; padding-left: 25px;">
                                            <ol>
                                                <li>
                                                    <asp:RadioButton ID="RadioChart2Opt1" CssClass="Space" runat="server" GroupName="RadioGroup2" onchange="RadioButtonCheck2(5)" ViewStateMode="enabled" Font-Size="Smaller" required /></li>
                                                <li>
                                                    <asp:RadioButton ID="RadioChart2Opt2" CssClass="Space" runat="server" GroupName="RadioGroup2" onchange="RadioButtonCheck2(6)" ViewStateMode="enabled" Font-Size="Smaller" required /></li>
                                                <li>
                                                    <asp:RadioButton ID="RadioChart2Opt3" CssClass="Space" runat="server" GroupName="RadioGroup2" onchange="RadioButtonCheck2(7)" ViewStateMode="enabled" Font-Size="Smaller" required /></li>
                                                <li>
                                                    <asp:RadioButton ID="RadioChart2Opt4" CssClass="Space" runat="server" GroupName="RadioGroup2" onchange="RadioButtonCheck2(8)" ViewStateMode="enabled" Font-Size="Smaller" required /></li>
                                            </ol>
                                        </div>
                                    </div>

                                    <div class="row hcenter">
                                        <asp:Chart ID="Piechart2" runat="server" Width="180px" Height="150px" BackColor="Transparent" BackSecondaryColor="192, 255, 255" BorderlineColor="Transparent">
                                            <Series>
                                                <asp:Series Name="Series1" ChartType="Doughnut" LegendText="#PERCENT"></asp:Series>
                                            </Series>
                                            <ChartAreas>
                                                <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                                            </ChartAreas>
                                        </asp:Chart>
                                        <br />
                                        <asp:Label ID="lblTotalVote2" runat="server" Font-Size="Small" ForeColor="#0055AA"></asp:Label>
                                        <br />

                                        <asp:Label ID="lblPie2Date" runat="server" Text="Started On :" Font-Size="Small" ForeColor="#0052A4"></asp:Label>
                                        <br />
                                    </div>

                                    <asp:HiddenField ID="HiddenField2" runat="server" />

                                    <asp:Button ID="btnPieChart2" runat="server" CssClass="btnPiechart2" OnClick="btnPieChart2_Click" CausesValidation="false" Text="Submit" />

                                </div>
                            </div>
                            </asp:Panel>
                            <div class="row" style="height: 25px;">
                                <div class="col-sm-4 col-xs-6" style="padding: 15px;">
                                    <asp:LinkButton ID="btnPreBottom" runat="server" Text="Prev" Height="20" Width="20px" ForeColor="Black" OnClick="btnPreBottom_Click" CausesValidation="False"></asp:LinkButton>

                                </div>
                                <div class="col-sm-4 hidden-xs">
                                    <asp:Label ID="lblPie1EmptyText" runat="server" Font-Size="Small" ForeColor="#3C9DFF"></asp:Label>
                                </div>
                                <div class="col-sm-4 col-xs-6" style="padding: 30px; padding-left: 210px;">
                                    <asp:LinkButton ID="btnNextBottom" runat="server" ForeColor="Black" Text="Next" OnClick="btnNextBottom_Click" CausesValidation="False"></asp:LinkButton>

                                </div>
                            </div>
                        </div>

                        <%------------------------------------------------------------------------------------Add- Poll section Starts from here ------------------------------------------------------------------------------%>




                        <div id="myModal" class="modal">
                            <div class="container-fluid" style="width: 100%;">
                                <div class="panel panel-primary popup_box_size">
                                    <div class="panel-heading">
                                        Add Poll 
                                            <span class="fa fa-times" style="float: right; cursor: pointer;" onclick="funClear()" aria-hidden="true"></span>
                                    </div>
                                    <div class="panel-body">
                                        <form class="form-group" autocomplete="off">

                                            <div class="row">
                                                <div class="col-xs-1"></div>
                                                <div class="col-xs-3">Question :</div>
                                                <div class="col-xs-7">
                                                    <asp:TextBox ID="txtPollQ" runat="server" CssClass="form-control no-resize" MaxLength="250" TextMode="MultiLine"></asp:TextBox><br />

                                                </div>
                                                <div class="col-xs-1">
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ErrorMessage="*" ValidationExpression="[a-zA-Z0-9 \s . & _ , ? @]+$" Font-Size="Small" ForeColor="#FF4040" ControlToValidate="txtPollQ" Display="Dynamic"></asp:RegularExpressionValidator>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPollQ" ErrorMessage="*" ForeColor="#FF5050" SetFocusOnError="True"></asp:RequiredFieldValidator>

                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-xs-1"></div>
                                                <div class="col-xs-3">
                                                    Answer1 :
                                                </div>
                                                <div class="col-xs-7">
                                                    <asp:TextBox ID="txtPollAns1" runat="server" MaxLength="100" CssClass="form-control"></asp:TextBox><br />


                                                </div>
                                                <div class="col-xs-1">
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtPollAns1" ValidationExpression="^[a-zA-Z0-9 \s ?,.&_ ! ]{1,30}$" ErrorMessage="*" Font-Size="Small" ForeColor="#FF5050" Display="Dynamic"></asp:RegularExpressionValidator>

                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtPollAns1" ErrorMessage="*" ForeColor="#FF5050" SetFocusOnError="True"></asp:RequiredFieldValidator>

                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-xs-1"></div>
                                                <div class="col-xs-3">Answer2 :</div>
                                                <div class="col-xs-7">
                                                    <asp:TextBox ID="txtPollAns2" runat="server" MaxLength="100" CssClass="form-control"></asp:TextBox><br />


                                                </div>
                                                <div class="col-xs-1">
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtPollAns2" ValidationExpression="^[a-zA-Z 0-9\s ?&,._ !]{1,40}$" ErrorMessage="*" Font-Size="Small" ForeColor="#FF5050" Display="Dynamic"></asp:RegularExpressionValidator>

                                                    <asp:RequiredFieldValidator ID="RequireAddflatOwnername" runat="server" ErrorMessage="*" ForeColor="#FF5050" ControlToValidate="txtPollAns2" SetFocusOnError="True"></asp:RequiredFieldValidator>

                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-xs-1"></div>
                                                <div class="col-xs-3">Answer3 :</div>
                                                <div class="col-xs-7">
                                                    <asp:TextBox ID="txtPollAns3" runat="server" MaxLength="100" CssClass="form-control"></asp:TextBox><br />


                                                </div>
                                                <div class="col-xs-1">
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Speacial character not allowed" ValidationExpression="^[a-zA-Z 0-9\s ?,&._ !]{1,50}$" Font-Size="Small" ForeColor="#FF5050" ControlToValidate="txtPollAns3" Display="Dynamic"></asp:RegularExpressionValidator>
                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-xs-1"></div>
                                                <div class="col-xs-3">Answer4 :</div>
                                                <div class="col-xs-7">
                                                    <asp:TextBox ID="txtPollAns4" runat="server" MaxLength="100" CssClass="form-control"></asp:TextBox><br />
                                                </div>
                                                <div class="col-xs-1">
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtPollAns4" ValidationExpression="^[a-zA-Z 0-9\s ?&._ !]{1,30}$" ErrorMessage="Speacial character not allowed" Font-Size="Small" ForeColor="#FF5050" Display="Dynamic"></asp:RegularExpressionValidator>

                                                </div>

                                            </div>

                                            <div class="row">
                                                <div class="col-xs-1"></div>
                                                <div class="col-xs-3">
                                                    End Date :
                                                </div>
                                                <div class="col-xs-7">
                                                    <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" onchange="ValidateDate()"></asp:TextBox>
                                                </div>
                                                <div class="col-xs-1">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*" ForeColor="#FF5050" ControlToValidate="txtEndDate" SetFocusOnError="True"></asp:RequiredFieldValidator>

                                                </div>
                                            </div>
                                            <div class="row">
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtPollAns1" ValidationExpression="^[a-zA-Z0-9 \s ?,.&_ ! ]{1,30}$" ErrorMessage="Speacial character not allowed" Font-Size="Small" ForeColor="#FF5050" Display="Dynamic"></asp:RegularExpressionValidator>
                                                <asp:Label ID="lblPollstatus" runat="server" ForeColor="#409FFF" Font-Size="Small"></asp:Label>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="panel-footer" style="text-align: right;">
                                        <button type="button" id="CancelPoll_Button" onclick="funClear()" class="btn btn-danger">Cancel</button>
                                        <asp:Button ID="btnPollSubmit" runat="server" Text="Submit" CssClass="btn btn-success" OnClick="btnPollSubmit_Click" />
                                    </div>
                                </div>
                            </div>

                        </div>






                    </div>
                </form>
            </div>


        </div>

    </div>



</body>
</html>
