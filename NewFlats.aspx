<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewFlats.aspx.cs" Inherits="NewFlats" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="Scripts/jquery-1.12.0.js"></script>



    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- jQuery library -->
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css" />

    <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>
    <link rel="Stylesheet" href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.10/themes/redmond/jquery-ui.css" />
    <link rel="stylesheet" href="CSS/mystylesheets.css" />

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
    </style>


    <script>

        function ShowAddFlat() {
            $("#addFlatModal").show();

        }

        function HideAddFlat() {
            $("[id*=txtblock]").val("");
            $("[id*=txtfloor]").val("");
            $("[id*=txtintercom]").val("");
            $("[id*=txtflatno]").val("");
            $("[id*=txtfltarea]").val("");
            $("#addFlatModal").hide();
        }


        function RemoveOwner(FlatID, FlatNumber, Block, OwnerUserID, FirstName, LastName) {

            $("[id*=HiddenField1]").val(FlatID);
            $("[id*=HiddenField2]").val(OwnerUserID);

            $("#removeFlatNumber").text(FlatNumber);
            $("#removeFlatBlock").text(Block);
            $("#removeOwnerName").text(FirstName + " " + LastName);
            $("#removeFlatOwnerModal").show();


        }

        function HideRemoveOwner() {
            $("#removeFlatNumber").text("");
            $("#removeFlatBlock").text("");
            $("#removeOwnerName").text("");
            $("#removeFlatOwnerModal").hide();
        }

        function ApproveOwner(ID, FlatNumber, Block, OwnerUserID, FirstName, LastName) {
            $("[id*=HiddenField1]").val(ID);
            $("[id*=HiddenField2]").val(OwnerUserID);

            $("#approveFlatNumber").text(FlatNumber);
            $("#approveFlatBlock").text(Block);
            $("#approveOwnerName").text(FirstName + " " + LastName);
            $("#approveFlatOwnerModal").show();

        }

        function HideApproveOwner() {
            $("#approveFlatNumber").text("");
            $("#approveFlatBlock").text("");
            $("#approveOwnerName").text("");
            $("#approveFlatOwnerModal").hide();
        }

        function RemoveTenant(FlatID, FlatNumber, Block, OwnerUserID, FirstName, LastName) {

              $("[id*=HiddenField1]").val(FlatID);
              $("[id*=HiddenField2]").val(OwnerUserID);
              alert("Remove Tenant");
             $("#modalremovetenant").show();
              //document.getElementById('modalremovetenant').setAttribute('display' ,'block');

            } 

        function AssignTenant(ID, FlatNumber, BHK, FlatArea, Floor, Block) {
            $("[id*=HiddenField3]").val("Tenant");
            $("[id*=HiddenField1]").val(ID);
            $("[id*=HiddenField1]").val(ID);
            $("[id*=assignFlatNumber]").val(FlatNumber);
            $("[id*=assignFlatArea]").val(FlatArea);
            $("[id*=assignFlatBHK]").val(BHK);
            $("[id*=assignFlatBlock]").val(Block);
            $("[id*=assignFlatFloor]").val(Floor);
            $("#newAssignFlatModal").show();
        }

        function AssignOwner(ID, FlatNumber, BHK, FlatArea, Floor, Block) {
            //alert();
            $("[id*=HiddenField3]").val("Owner");

            $("[id*=HiddenField1]").val(ID);
            $("[id*=assignFlatNumber]").val(FlatNumber);
            $("[id*=assignFlatArea]").val(FlatArea);
            $("[id*=assignFlatBHK]").val(BHK);
            $("[id*=assignFlatBlock]").val(Block);
            $("[id*=assignFlatFloor]").val(Floor);
            $("#newAssignFlatModal").show();
        }

        function hideAssignFlatModal() {
            $("[id*=newOwnerMobile]").val("");
            $("[id*=newOwnerEmail]").val("");
            $("[id*=newOwnerName]").val("");
            $("[id*=newOwnerParentName]").val("");
            $("[id*=newOwnerAddress]").val("");

            $("[id*=assignFlatNumber]").val("");
            $("[id*=assignFlatArea]").val("");
            $("[id*=assignFlatBHK]").val("");
            $("[id*=assignFlatBlock]").val("");
            $("[id*=assignFlatFloor]").val("");
            $("#newAssignFlatModal").hide();
        }

        $(function () {
            $("#txtFlatNumberSearch").autocomplete({
                source: function (request, response) {
                    var param = {
                        FlatNumber: $('#txtFlatNumberSearch').val()
                    };

                    $.ajax({
                        url: "Flats.aspx/GetFlatNumber",
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

        $(function () {

            $("#removeno").click(function () {
                $("#modalremovetenant").hide();

            });
            
            $("#txtFlltsOwnernme").autocomplete({
                source: function (request, response) {
                    var param = {
                        empName: $("#txtFlltsOwnernme").val()
                    };
                    $.ajax({

                        url: "Flats.aspx/GetOwnerName",
                        data: JSON.stringify(param),
                        dataType: 'json',
                        type: 'POST',
                        contentType: "application/json; charset=utf-8",
                        dataFilter: function (data) { return data; },
                        success: function (data) {
                          
                            response($.map(data.d, function (item) {
                                return {
                                    value:item
                                }
                            }))
                        },
                        error: function (XMLHttpRequest, textstatus, errorthrown) {
                            var err = eval("(" + XMLHttpRequest + ")");
                            alert(err.Message);
                             console.log("Ajax Error!");
                        }
                    });
                },
                minLength: 2
            });
        });

    </script>


</head>
<body style="background-color: #f7f7f7;">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <div class="container-fluid">

            <div class="row" style="height: 50px; margin-top: 15px">
                <div class="col-sm-2 hidden-xs">
                    <div>
                        <h4 class="pull-left " style="margin: 0px;">Flats: </h4>
                    </div>

                </div>
                <div class="col-sm-8 col-xs-12">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-4 zero-margin">
                            <asp:TextBox ID="txtFlatNumberSearch" placeholder="Flat" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-sm-4 zero-margin"  style="margin-left: -3px;">
                            <asp:TextBox ID="txtFlltsOwnernme" placeholder="First Name" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-sm-4 col-xs-6 zero-margin">
                            <asp:LinkButton runat="server" BackColor="Transparent" CausesValidation="false" ForeColor="Black" OnClick="btnFlatnumbrSrch_Click"> 
                                <span class="glyphicon glyphicon-search" style="background-color: #607d8b; padding: 10px; margin-left: -3px; top: 0px !important;"></span></asp:LinkButton>
                            </div>
                       </div>
                   </div>
               </div>
            <div class="col-sm-2 col-xs-12" style="vertical-align: middle;">
                <div style="align-content">
                    <button id="Add_Flat_New" type="button" class="btn-sm btn btn-primary pull-right" onclick="ShowAddFlat()" style="cursor: pointer; margin-right: 30px;"><i class="fa fa-plus"></i>Add New Flat</button>
                </div>
            </div>
        </div>
        <div class="col-sm-12" style="font-size: 20px !important; font-family:'Times New Roman', Times, serif !important; color: red; text-align:center; margin-top: 20%;">
           <asp:Label ID="lblFlatGridEmptyText" runat="server" ></asp:Label><br />
        </div>
        <br />
        <asp:Label ID="totalFlats" runat="server" ForeColor="#007cf9" Text="Total Flats:"></asp:Label>
        <asp:Label ID="lblTotalFlats" runat="server" ForeColor="#4774d1" Text=""></asp:Label>


        <div class="container-fluid zero-margin" style="padding-bottom: 10px;">
            <div class="col-xs-12 col-sm-12">

                <asp:DataList ID="dataListFlats" runat="server" CellPadding="0"
                    Width="100%"
                    headerstyle-font-name="Verdana"
                    HeaderStyle-Font-Size="12pt"
                    HeaderStyle-HorizontalAlign="center"
                    OnPageIndexChanging="FlatGrid_PageIndexChanging"
                    RepeatColumns="0"
                    HorizontalAlign="Center"
                    HeaderStyle-Font-Bold="True"
                    BackColor="Transparent"
                    FooterStyle-Font-Size="9pt"
                    FooterStyle-Font-Italic="True" Height="1px" ForeColor="#CCCCCC"
                    OnItemDataBound="DataListFlat_ItemDataBound">
                    <ItemStyle></ItemStyle>
                    <ItemTemplate>
                        <div class="row layout_shadow_table ">


                            <div class="col-sm-2 col-xs-6" style="text-align: center;">

                                <%-- <asp:Image CssClass="UserImage" ID="user_image" runat="server" style="border-radius:50%;border:2px solid #dcdbdb;width:40px;height:40px;" ImageUrl='<%# "GetImages.ashx?ResID="+ Eval("ResidentID") %>' /><br />--%>
                                <img src='<%# "GetImages.ashx?UserID="+ Eval("OwnerUserID")+"&Name="+Eval("OwnerFirstName") +"&UserType=Owner" %>' class="profile-image" />
                                <br />
                                <%-- <asp:Label ID="lblFlatNumber" runat="server" Text='<%# Bind("FlatNumber") %>' ></asp:Label> --%>
                                <label id="lblFlatNumber" style="color: black; font-weight: bold;"><%# Eval("FlatNumber") %> </label>

                                <%--   <asp:Label ID="lblUserLogin" runat="server" ForeColor="#6699cc"   Text='<%# Eval("UserLogin") %>'></asp:Label><br />  --%>
                            </div>
                            <div class="col-sm-3 col-xs-6">
                                Floor:
                                <asp:Label ID="lblFloor" runat="server" Text='<%# Eval("Floor") %>'></asp:Label><br />


                                Block:
                                <asp:Label ID="lblBlock" runat="server" Text='<%# Eval("Block") %>'></asp:Label>



                                Intercom
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("IntercomNumber") %>'></asp:Label><br />


                                BHK:
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("BHK") %>'></asp:Label>




                            </div>

                            <div class="col-sm-3 col-xs-6" style="border-left: solid 2px black;">
                                Owner Name:
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("OwnerFirstName") + " "+ Eval("OwnerLastName") %>'></asp:Label><br />
                                Status:
                                <asp:Label ID="Label5" runat="server" Text='<%# Eval("OwnerStatus") %>'></asp:Label>
                                Address:
                                <asp:Label ID="Label4" runat="server" Text='<%# Eval("OwnerAddress") %>'></asp:Label>

                                    <button id="btnRemove" class="btn-sm btn btn-success"
                                        onclick='<%#"RemoveOwner(" + Eval("OwnerResID")+",\""+ Eval("FlatNumber")+"\",\""+ Eval("Block") +"\","+ Eval("OwnerUserID")+",\""+ Eval("OwnerFirstName")+"\",\""+ Eval("OwnerLastName")+ "\")"%>' runat="server" type="button">
                                        Remove Owner</button>
                                    <button id="btnAssign" class="btn-sm btn btn-warning"
                                        onclick='<%#"AssignOwner(" + Eval("ID") +",\""+ Eval("FlatNumber")+"\",\""+ Eval("BHK")+"\",\""+ Eval("FlatArea")+"\",\""+ Eval("Floor")+"\",\""+ Eval("Block")+ "\");"%>' runat="server" type="button">
                                        Assign Owner</button>

                                <button id="btnApprove" class="btn-sm btn btn-primary"
                                    onclick='<%#"ApproveOwner(" + Eval("OwnerResID") +",\""+ Eval("FlatNumber")+"\",\""+ Eval("Block")+"\",\""+ Eval("OwnerUserID")+"\",\""+ Eval("OwnerFirstName")+"\",\""+ Eval("OwnerLastName")+ "\")"%>' runat="server" type="button">
                                    Approve Owner</button>

                            </div>
                            <div class="col-sm-3 col-xs-6" style="border-left: solid 2px black;">
                                Tenant Name:
                                <asp:Label ID="Label9" runat="server" Text='<%# Eval("TenantFirstName") + " "+ Eval("TenantLastName") %>'></asp:Label><br />
                                Status:
                                <asp:Label ID="Label11" runat="server" Text='<%# Eval("TenantStatus") %>'></asp:Label>
                                Address:
                                <asp:Label ID="Label12" runat="server" Text='<%# Eval("TenantAddress") %>'></asp:Label>

                                <button id="btnRemoveTenant" class="btn-sm btn btn-success"
                                    onclick='<%#"RemoveTenant(" + Eval("TenantResID")+",\""+ Eval("FlatNumber")+"\",\""+ Eval("Block") +"\","+ Eval("TenantUserID")+",\""+ Eval("TenantFirstName")+"\",\""+ Eval("TenantLastName")+ "\")"%>' runat="server" type="button">
                                    Remove Tenant</button>
                                <button id="btnAssignTenant" class="btn-sm btn btn-warning"
                                    onclick='<%#"AssignTenant(" + Eval("ID") +",\""+ Eval("FlatNumber")+"\",\""+ Eval("BHK")+"\",\""+ Eval("FlatArea")+"\",\""+ Eval("Floor")+"\",\""+ Eval("Block")+ "\")"%>' runat="server" type="button">
                                    Assign Tenant</button>

                                <button id="btnApproveTenant" class="btn-sm btn btn-primary"
                                    onclick='<%#"ApproveTenant(" + Eval("TenantResID") +",\""+ Eval("FlatNumber")+"\",\""+ Eval("Block")+"\",\""+ Eval("TenantUserID")+"\",\""+ Eval("TenantFirstName")+"\",\""+ Eval("TenantLastName")+ "\")"%>' runat="server" type="button">
                                    Approve Tenant</button>

                            </div>

                            <div class="row" style="float: right; margin-right: 5px;">
                                <%--<button id="btnOpen" class="btn-sm btn btn-info" onclick='<%#"ShowAssignConfirmation(" + Eval("CompID")+",\""+ Eval("FlatNumber") +"\",\""+ Eval("CompType")+ "\",3,\"Open\")"%>' runat="server" type="button">Open</button>
                                                        <button id="btnReopen" class="btn-sm btn btn-info" onclick='<%#"ShowAssignConfirmation(" + Eval("CompID")+",\""+ Eval("FlatNumber") +"\",\""+ Eval("CompType")+ "\",6,\"Re-open\")"%>' runat="server" type="button">Reopen</button>
                                                        <button id="btnClose" class="btn-sm btn btn-success" onclick='<%#"ShowAssignConfirmation(" + Eval("CompID")+",\""+ Eval("FlatNumber") +"\",\""+ Eval("CompType")+ "\",5,\"Close\")"%>' runat="server" type="button">Close</button>--%>
                            </div>
                        </div>
                    </ItemTemplate>
                    <EditItemStyle Height="0px" BackColor="Transparent" />
                    <SeparatorStyle BackColor="Transparent" Height="50px" />
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



            </div>

        </div>

        <div class="modal" id="newAssignFlatModal">

            <asp:UpdatePanel ID="UpdatePanel2" runat="server" EnableViewState="true">
                <ContentTemplate>
                    <div class="container-fluid">
                        <div class="panel panel-primary" style="width: 520px; background-color: #f2f2f2; margin: auto;">
                            <div class="panel-heading">
                                Assign Owner To Flat
                               <span class="fa fa-close" onclick="hideAssignFlatModal()" style="color: white; float: right; cursor: pointer;"></span>

                            </div>
                            <form class="form-group" autocomplete="off">
                                <div class="panel-body" style="background-color: #fff;">

                                    <div class="row" style="border-top-left-radius: 10px;">
                                        <b>User Details:</b>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6 col-xs-12">
                                            <label style="width: 100px;">Mobile : </label>
                                            <asp:TextBox Width="100px" ID="newOwnerMobile" onkeypress="return isNumberKey(event)" runat="server" MaxLength="10" Height="25px"
                                                OnTextChanged="txtAddfltMobile_TextChanged" onclick="Reset()" TabIndex="1" AutoPostBack="True"></asp:TextBox>
                                        </div>

                                        <div class="col-sm-6 col-xs-12">
                                            <label style="width: 100px;">Email : </label>
                                            <asp:TextBox Width="100px" ID="newOwnerEmail" runat="server" Height="25px"
                                                TabIndex="2" AutoPostBack="True" OnTextChanged="txtAddfltEmail_TextChanged"></asp:TextBox>
                                            <span style="display: none;">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="newOwnerEmail" ValidationGroup="Add_Flat"></asp:RequiredFieldValidator></span>
                                        </div>


                                    </div>
                                    <asp:Label runat="server" ID="lblUserCheck"></asp:Label>
                                    <hr />
                                    <div class="row">
                                        <div class="col-sm-6 col-xs-12">
                                            <label style="width: 100px;">Name : </label>
                                            <asp:TextBox Width="100px" ID="newOwnerName" BorderWidth="0" runat="server" onClick="Reset()" ReadOnly="true" Height="25px" TabIndex="0"></asp:TextBox>

                                        </div>
                                        <div class="col-sm-6 col-xs-12">
                                            <label style="width: 100px;">Parent Name : </label>
                                            <asp:TextBox Width="100px" ID="newOwnerParentName" ReadOnly="true" BorderWidth="0" runat="server" Height="25px" TabIndex="0"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="row">

                                        <div class="col-sm-6">
                                            <label style="width: 100px;">Address : </label>
                                            <asp:TextBox Width="100px" ID="newOwnerAddress" ReadOnly="true" BorderWidth="0" runat="server" Height="42px" TabIndex="0"></asp:TextBox>
                                        </div>
                                    </div>
                                    <hr />

                                    <div class="row">
                                        <div class="col-xs-12"><b>Flat Details: </b></div>
                                    </div>

                                    <div class="row">
                                        <div class="col-xs-6">
                                            <label style="width: 100px;">Flat number : </label>
                                            <asp:TextBox Width="100px" ID="assignFlatNumber" runat="server" AutoPostBack="True" Height="25px"> </asp:TextBox>
                                        </div>
                                        <div class="col-xs-6">
                                            <label style="width: 100px;">Block : </label>
                                            <asp:TextBox Width="100px" ID="assignFlatBlock" runat="server" AutoPostBack="True" Height="25px"> </asp:TextBox>
                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="col-xs-6">
                                            <label style="width: 100px;">Floor : </label>
                                            <asp:TextBox Width="100px" ID="assignFlatFloor" runat="server" AutoPostBack="True" Height="25px"> </asp:TextBox>
                                        </div>
                                        <div class="col-xs-6">

                                            <label style="width: 100px;">Flat Area :</label>
                                            <asp:TextBox Width="100px" Enabled="false" ID="assignFlatArea" runat="server" Height="25px" onfocus="Focus(this.id,'in Sqfts.')" onblur="Blur(this.id,'in Sqfts.')" ToolTip="In sqfts." TabIndex="0"></asp:TextBox>
                                        </div>
                                    </div>
                                    <label style="width: 100px;">
                                        BHK :
                                    </label>

                                    <asp:TextBox Width="100px" Enabled="false" ID="assignFlatBHK" runat="server" Height="25px"></asp:TextBox>



                                </div>
                            </form>

                            <asp:Label ID="Label10" runat="server" ForeColor="Red" Text=""></asp:Label>
                            <div class="panle-footer" style="text-align: right; padding-right: 10px; margin: 10px;">

                                <asp:Button ID="btnAssignSubmit" runat="server" Text="Submit" OnClientClick="" OnClick="btnAssignSubmit_Click" TabIndex="4" ValidationGroup="Add_Flat" class="btn btn-primary" />

                                <button type="button" id="btnCancelAssignFlat" onclick="hideAssignFlatModal()" class="btn btn-danger">Cancel</button>
                            </div>
                        </div>



                        <div id="data_loading_assign" class="layout-overlay" style="background-color: #000; width: 100%; height: 100%; opacity: 0.5; filter: alpha(opacity=50); text-align: center; vertical-align: middle;">
                            <img src="Images/Icon/ajax-loader.gif" style="width: 20px; height: 20px; margin-top: 200px;" />

                        </div>

                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>

        </div>


        <!--Add New Flat Model-->

        <div id="addFlatModal" class="modal">
            <div class="container-fluid" style="width: 500px;">
                <div class="panel panel-primary">
                    <div class="panel-heading">

                        <asp:Label runat="server" ID="lblassignHeading"> Add New Flat:</asp:Label>

                        <span class="fa fa-times" onclick="HideAddFlat()" style="float: right; cursor: pointer;"></span>
                    </div>

                    <div class="panel-body">
                        <div class="row" style="margin: 5px;">
                            <div class="col-xs-6">
                                New Flat Number:<br />
                                <asp:TextBox runat="server" ID="txtflatno" Width="100px" />
                            </div>
                            <div class="col-xs-6">
                                BHK:<br />
                                <asp:DropDownList runat="server" ID="drpbhk" Width="100px">
                                    <asp:ListItem Value="1"> 1 BHK</asp:ListItem>
                                    <asp:ListItem Value="2"> 2 BHK</asp:ListItem>
                                    <asp:ListItem Value="3"> 3 BHK</asp:ListItem>
                                    <asp:ListItem Value="4"> 4 BHK</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                        </div>
                        <div class="row" style="margin: 5px;">
                            <div class="col-xs-6">
                                Flat Area :  
                                <br />
                                <asp:TextBox runat="server" ID="txtfltarea" Width="100px" />
                            </div>
                            <div class="col-xs-6">
                                Intercom Number:<br />
                                <asp:TextBox runat="server" ID="txtintercom" Width="100px" />

                            </div>
                        </div>

                        <div class="row" style="margin: 5px;">
                            <div class="col-xs-6">
                                Block :<br />
                                <asp:TextBox runat="server" ID="txtblock" Width="100px" />
                            </div>
                            <div class="col-xs-6">
                                Floor :
                                <br />
                                <asp:TextBox runat="server" ID="txtfloor" Width="100px" />
                            </div>

                        </div>

                    </div>
                    <asp:Label runat="server" ID="lblAddFlatMessage" />
                    <div class="panel-footer" style="text-align: right; margin-top: 15px;">
                        <button class="btn btn-danger" type="button" onclick="HideAddFlat()">Cancel</button>
                        <asp:Button runat="server" name="AddFlatSubmit" Text="Add New Flat" ID="btnAddFlatSubmit" OnClick="btnAddFlatSubmit_Click" CssClass="btn btn-success" />
                    </div>
                </div>
            </div>
        </div>


        <!--Add New Flat Model-->


        <div id="removeFlatOwnerModal" class="modal">
            <div class="container-fluid" style="width: 500px;">
                <div class="panel panel-primary">
                    <div class="panel-heading">

                        <asp:Label runat="server" ID="Label6"> Remove Owner</asp:Label>

                        <span class="fa fa-times" onclick="HideRemoveOwner()" style="float: right; cursor: pointer;"></span>
                    </div>

                    <div class="panel-body">
                        <div class="row">
                            <div class="col-xs-6">
                                <label>Flat Number</label><label id="removeFlatNumber"></label>
                            </div>
                            <div class="col-xs-6">
                                <label>Block</label><label id="removeFlatBlock"></label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-6">
                                <label>Name: </label>
                                <label id="removeOwnerName"></label>
                            </div>
                            <div class="col-xs-6"></div>
                        </div>
                        <div class="row">
                            <div class="col-xs-6"></div>
                            <div class="col-xs-6"></div>
                        </div>

                    </div>
                    <asp:Label runat="server" ID="lblRemoveOwnerMessage" />
                    <div class="panel-footer" style="text-align: right; margin-top: 15px;">
                        <button class="btn btn-danger" type="button" onclick="HideRemoveOwner()">Cancel</button>
                        <asp:Button runat="server" name="RemoveOwnerSubmit" Text="Submit" ID="btnRemoveOwner" OnClick="btnRemoveOwnerSubmit_Click" CssClass="btn btn-success" />
                    </div>
                </div>
            </div>
        </div>

        <div id="approveFlatOwnerModal" class="modal">
            <div class="container-fluid" style="width: 500px;">
                <div class="panel panel-primary">
                    <div class="panel-heading">

                        <asp:Label runat="server" ID="Label7">Approve Owner Request</asp:Label>

                        <span class="fa fa-times" onclick="HideApproveOwner()" style="float: right; cursor: pointer;"></span>
                    </div>

                    <div class="panel-body">
                        <div class="row">
                            <div class="col-xs-6">
                                <label>Flat Number</label><label id="approveFlatNumber"></label>
                            </div>
                            <div class="col-xs-6">
                                <label>Block</label><label id="approveFlatBlock"></label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-6">
                                <label>Name: </label>
                                <label id="approveOwnerName"></label>
                            </div>
                            <div class="col-xs-6"></div>
                        </div>
                        <div class="row">
                            <div class="col-xs-6"></div>
                            <div class="col-xs-6"></div>
                        </div>

                    </div>
                </div>
            </div>
           
            <!-- Remove tenant -->
            <div class="modal" id="modalremovetenant">
                <div class="container-fluid" style="width: 500px;">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <asp:Label runat="server" ID="Label13">Remove Tenant</asp:Label>
                            <asp:Button CssClass="btn btn-danger" ID="removeyes" runat="server" Text="yes" OnClick="removeno_Click" />
                            <button class="btn btn-success" id="removeno">no</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div>
            <asp:HiddenField runat="server" ID="HiddenField1" />
            <asp:HiddenField runat="server" ID="HiddenField2" />
            <asp:HiddenField runat="server" ID="HiddenField3" />
        </div>

        </div>
    </form>
</body>
</html>
