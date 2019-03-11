﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Flats.aspx.cs" Inherits="Flats" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
     <script src="Scripts/jquery-1.12.0.js"></script>
    <link rel="Stylesheet" href="CSS/ApttLayout.css"/>
    <link rel="stylesheet" href="CSS/ApttTheme.css" />
      <link rel="stylesheet" href="CSS/NewAptt.css" />
   
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- jQuery library -->
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
   
    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css"/>  

 <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js"></script>  
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>  
    <link rel="Stylesheet" href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.10/themes/redmond/jquery-ui.css" /> 



    

    <style>
        
         .modalFlat {
           display: none;   /*Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 2%; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto;  /*Enable scroll if needed*/
            background-color: #e6e2e2;
            background-color: rgba(0,0,0,0.4); 
        }
                 .modal {
             display: none;  /*  Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
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
         .lbltxt{
          padding-left:5%;
          font-size:small;
          white-space:nowrap;
        }

          .close{
            position:absolute;
            right:-14px;
            top:-14px;
            cursor:pointer;
            border-radius:50%;
        }
           .selected_row
        {
            background-color:#4598c8;
            color:white;
        }
        .FlatsGrid_Text
        {
            text-align:left;
            padding-left:1%;
        }
        .form-control {
            display: inline;
            width: 41%;
            margin-left:-5px;
            border-radius: 1px;

        }
       


  .invalid { border-color: red; }
  #error { color: red }


    </style>


     <script>
         
       

        $(function () {
            $("#txtFlltsOwnernme").autocomplete({
                source: function (request, response) {
                    var param = {
                        empName: $('#txtFlltsOwnernme').val() };
                   
                    $.ajax({
                        url: "Flats.aspx/GetOwnerName",
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
            $("#txtFltsFlatNmbr").autocomplete({
                source: function (request, response) {
                    var param = {
                        FlatNumber: $('#txtFltsFlatNmbr').val()
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
       

        $(function ShowSelected() {
            $("[id*=FlatGrid] td:has(button)").bind("click", function () {
                var row = $(this).parent();
                $("[id*=FlatGrid] tr").each(function () {
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
            $('html').click(function () {
                
                $("#Flat_dropdown").hide();
              
            });

        });


        $(document).ready(function () {
     
        $("[id*=FlatGrid] td:has(button)").bind("click", function (event) {
                var row = $(this).parent();
               
                $("td", row).each(function () {

                    if ($('#Flat_dropdown').is(':visible')) {
                        $("#Flat_dropdown").show();
                    } else {

                        $("#Flat_dropdown").hide();
                    }
                });

                event.stopPropagation();
        });

        });

        function HideAddFlatModal()
        {
            $("#myModalPopup").hide();
          
            document.getElementById("txtAddfltMobile").value = "";
            document.getElementById("txtAddflatFirstname").value = "";
            document.getElementById("drpFlatGender").value = "";
            document.getElementById("txtAddfltParentName").value = "";
            document.getElementById("txtAddfltEmail").value = "";
            document.getElementById("txtAddflatLastName").value = "";
            document.getElementById("txtAddflatUserLogin").value = "";
            document.getElementById("txtAddfltAddrs").value = "";
            document.getElementById("txtFltAdd").value = "";
            document.getElementById("txtAddBlock").value = "";
            document.getElementById("txtAddfltFlr").value = "";
            document.getElementById("txtFlatArea").value = "";
            document.getElementById("drpAddflatBHK").value = "";
            document.getElementById("txtAddflatIntrc").value = "";
        }


           function AddFlatError()
        {
            $("#data_loading").hide();
          
         }


          function AddFlatError()
        {
            $("#data_loading").hide();
             document.getElementById("txtAddfltMobile").value = "";
            document.getElementById("txtAddflatFirstname").value = "";
            document.getElementById("drpFlatGender").value = "";
            document.getElementById("txtAddfltParentName").value = "";
            document.getElementById("txtAddfltEmail").value = "";
            document.getElementById("txtAddflatLastName").value = "";
            document.getElementById("txtAddflatUserLogin").value = "";
            document.getElementById("txtAddfltAddrs").value = "";
            document.getElementById("txtFltAdd").value = "";
            document.getElementById("txtAddBlock").value = "";
            document.getElementById("txtAddfltFlr").value = "";
            document.getElementById("txtFlatArea").value = "";
            document.getElementById("drpAddflatBHK").value = "";
            document.getElementById("txtAddflatIntrc").value = "";
         }


        function MobileExist(result)
        {

            if (result == false) {
                document.getElementById('txtAddfltMobile').focus();
            }else {
                document.getElementById('txtAddfltEmail').focus();
               
            }

        }
        function EmailExist(result) {

            if (result == false) {
                document.getElementById('txtAddfltEmail').focus();
            } else {
                document.getElementById('txtAddflatFirstname').focus();
            }

        }


        function ShowDialog(UserLogin, FlatNumber, theElement) {
            document.getElementById("HiddenField1").value = UserLogin;
            document.getElementById("HiddenField2").value = FlatNumber;

            var Posx = 0;
            var Posy = 0;

            while (theElement != null) {
                Posx += theElement.offsetLeft;
                Posy += theElement.offsetTop;

                theElement = theElement.offsetParent;
            }
                     
                $("#Flat_dropdown").slideDown();
           

            document.getElementById("Flat_dropdown").style.top = Posy - 10 + 'px';
            document.getElementById("Flat_dropdown").style.left = Posx + 25 + 'px';
        }

    
        //$("#btnCancelAddFlat").click(function () {
        //    $("#myModalPopup").hide();
        //    $("input:text").val("");
        //    $("#lblstatus").html("");



        //});
         //added by aarshi to clear all fields on cancel click

        function Reset() {
            document.getElementById("FlatsDataUpload").value = "";
         
        }

        function CloseWindow()
        {
           
            $("#myModalPopup").hide();

            //added by aarshi to clear all fields on cancel click
            var txts = document.getElementsByClassName('flats_textboxes');
            var sels = document.getElementsByClassName('flats_dropdownlist');

            for (var i = 0; i < txts.length; i++)
                txts[i].value = '';

            for (var i = 0; i < sels.length; i++) {
                sels[i].selectedIndex = 0;
            }

            return false;
        }

        function PopupFlats() {
          
            setTimeout(function ()
            {
            var FlatNumber = document.getElementById('<%=txtFltAdd.ClientID%>').value;

            if (FlatNumber != "") {
                document.getElementById("myModalPopup").style.display = "block";
            }
           
            if (HiddenEditID.value != "") {             
                document.getElementById("myModalEditPopup").style.display = "block";
            }

            if (HiddenAddTID.value != "") {
                document.getElementById("myModalAddTPopup").style.display = "block";
            }

            var ImportStatus = document.getElementById('<%=lblFileUploadstatus.ClientID%>');
            if (ImportStatus.textContent != "") {
                document.getElementById("myModalPopupImport").style.display = "block";
            }
           
            if (HiddenImportPopup.value != "")
            {
                document.getElementById("Popup").style.display = "block";
                document.getElementById("myModalPopupImport").style.display = "none";
                
            }            

            }, 1000);
         }
          
         $(document).ready(function () {
             $("#txtAddflatFirstname,#txtAddflatLastName,#txtAddfltParentName,#drpFlatGender,#txtAddfltAddrs").attr('disabled', true);
            
         });

        $(document).ready(function () {
            $("#btncancel").click(function () {
                $("#Popup").hide();
                $("#HiddenImportPopup").val("");
                $("#myModalPopupImport").hide();
                $("#lblFileUploadstatus").textContent('');
                 
            });
        });

        //Button click popup events --------------------------------------------------------------------------///
        $(document).ready(function () {
            $("#Add_Flat_Button").click(function () {
                $("#myModalPopup").show();
            });
        });



        $(document).ready(function () {
            $("#Flats_Edit_Cancel").click(function () {
                $("#myModalEditPopup").hide();
                $("#HiddenEditID").val("");
            });
        });

        function CloseAddFlat()
        {
            $("#myModalPopup").hide();
        }
     
       
        $(document).ready(function () {
            $("#Cancel_Popup").click(function () {
                
                $("#myModalPopup").hide();
                $("input:text").val("");
                $("#lblAddflatStatus").html("");
                $("#lblDefalutBillText").html("");
            });
        });

        $(document).ready(function () {
            $("#Flats_AddT_Cancel").click(function () {
                $("#myModalAddTPopup").hide();
                $("#HiddenAddTID").val("");
                $("input:text").val("");
                $("#lblResStatus").html("");

            });
        });

        $(document).ready(function () {
            $("#Import_Data").click(function () {
                $("#myModalPopupImport").show();
            });
        });

        $(document).ready(function () {
            $("#Import_close").click(function () {
                $("#myModalPopupImport").hide();
                $("#lblFileUploadstatus").html('');
              });
        });

        //done by aarshi on 20 July 2017
        function ValidateImport() {
            var uploadfile = document.getElementById('FlatsDataUpload');
            if (uploadfile.value == '') {
                document.getElementById('lblFileUploadstatus').innerHTML = 'Select a file to upload';
              
                return false;
            }
        }

        function Blur(element,value)
        { }

        function Focus(element, value) { }
        function ShowLoader() {
            
            $("#data_loading").show();
        }

       function isNumberKey(evt)
      {
         var charCode = (evt.which) ? evt.which : evt.keyCode;
         if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;    
         return true;
      }

    </script>
</head>
<body  style="background-color:#f7f7f7;">
    <form id="form1" runat="server">
     <div class="container-fluid">
            <div class="row" style="height:50px;margin-top:15px">
                 <div class="col-sm-2 hidden-xs" >
                     <div><h4 class="pull-left " style="margin:0px;">Flats : </h4></div>
                      
                 </div>
                <div class="col-sm-6 col-xs-12">
                                          <div class="form-group" >
                                            <asp:TextBox ID="txtFltsFlatNmbr" placeholder="Flat" runat="server"  CssClass="form-control"></asp:TextBox>
                                            <asp:TextBox ID="txtFlltsOwnernme" placeholder="First Name" runat="server" CssClass="form-control" ></asp:TextBox>
                                          <asp:LinkButton runat="server" BackColor="Transparent" CausesValidation="false" ForeColor="Black" OnClick="btnFlatnumbrSrch_Click"> <span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                              
                                              </div>
                                      </div>
                 <div class="col-sm-4 hidden-xs" style="vertical-align:middle;">
                    <div style=" align-content">
                          <button id="Add_Flat_Button" type="button" class="btn-sm btn btn-primary pull-right" style="cursor:pointer;margin-right:30px;"><i class="fa fa-plus"></i> Add Flat</button>  
                         <a id="linkTemplate" type="button"  class="btn-sm btn btn-primary pull-right"  href="http://www.myaptt.com/NewTestApp/Excel_Format.zip" download="true" style="cursor:pointer;border-color:#2ECC71!important;"><i class="fa fa-plus"></i> Template</a>
                    </div>
                 </div>
             </div>
        



     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


         <div class ="container-fluid zero-margin" style="padding-bottom:10px;">
                              <div class="col-xs-12 col-sm-12">

              <asp:DataList ID="dataListFlats" runat="server" cellpadding="0"  
                                        width="100%"
                                        headerstyle-font-name="Verdana"
                                        headerstyle-font-size="12pt"
                                        headerstyle-horizontalalign="center"
                                        OnPageIndexChanging="FlatGrid_PageIndexChanging" 
                                        RepeatColumns="0"
                                        HorizontalAlign="Center"
                                        headerstyle-font-bold="True"
                                        BackColor ="Transparent" 
                                        footerstyle-font-size="9pt"
                                        footerstyle-font-italic="True"  Height="1px" ForeColor="#CCCCCC" 
                                        >
                                   
                                           <ItemStyle ></ItemStyle>
                                           <ItemTemplate>
                                                <div class="row layout_shadow_table ">
                                               
                                                    <table>
                                                        <div class="col-sm-3" style="text-align:center;">
                                                            
                                                            <%-- <asp:Image CssClass="UserImage" ID="user_image" runat="server" style="border-radius:50%;border:2px solid #dcdbdb;width:40px;height:40px;" ImageUrl='<%# "GetImages.ashx?ResID="+ Eval("ResidentID") %>' /><br />--%>
                                                               <img src='<%# "GetImages.ashx?UserID="+ Eval("OwnerUserID")+"&Name="+Eval("OwnerFirstName") +"&UserType=Owner" %>' class="profile-image" /> <br /> 
                                                               <%-- <asp:Label ID="lblFlatNumber" runat="server" Text='<%# Bind("FlatNumber") %>' ></asp:Label> --%>
                                                           <label id="lblFlatNumber" style="color:black; font-weight:bold;" ><%# Eval("FlatNumber") %> </label> 
                                                                
                                                             <%--   <asp:Label ID="lblUserLogin" runat="server" ForeColor="#6699cc"   Text='<%# Eval("UserLogin") %>'></asp:Label><br />  --%>      
                                                      
                                                                
                                                         </div>
                                                        <div class="col-sm-3">
                                                        
                                                            
                                                                Floor: <asp:Label ID="lblFloor" runat="server" Text='<%# Eval("Floor") %>'></asp:Label><br />
                                                           
                                                           
                                                               Block: <asp:Label ID="lblBlock" runat="server" Text='<%# Eval("Block") %>'></asp:Label>
                                                            
                                                        </div>
                                                         <div class="col-sm-3">
                                                          
                                                                Intercom <asp:Label ID="Label2" runat="server" Text='<%# Eval("IntercomNumber") %>'></asp:Label><br />
                                                           
                                                            
                                                                BHK: <asp:Label ID="Label3" runat="server" Text='<%# Eval("BHK") %>'></asp:Label>
                                                            
                                                              
                                                                  
              

                                                              </td>
                                                        </div>

                                                        <div class="col-sm-3" style="border-left:solid 2px black;">
                                                            
                                                                 Owner Name: <asp:Label ID="Label1" runat="server" Text='<%# Eval("OwnerFirstName") + " "+ Eval("OwnerLastName") %>'></asp:Label><br />

                                                            
                                                                  Address: <asp:Label ID="Label4" runat="server" Text='<%# Eval("OwnerAddress") %>'></asp:Label>
                                                            
                                                            
                                                       </div>

                                                        </table>  
                                                   
                                                     </div>
                                          </ItemTemplate>
                              
                                      <EditItemStyle Height="0px" BackColor="Transparent" />                       
                                    <SeparatorStyle BackColor="Transparent" Height="50px" />
                          </asp:DataList>


         </div>

</div>

   <table id="sample" style="margin-top: 1%; width: 100%;  border: 1px solid #f2f2f2; display:none; box-shadow: 2px 2px 5px #bfbfbf; border-collapse: collapse;min-height:500px;">
                        

                        <tr>
                            <td style="width: 10%;"></td>
                            <td colspan="5" style="width: 80%; padding-top:0px;">

                                <%-- Gridview Starts from here---%>
                <asp:GridView ID="FlatGrid" runat="server"  Width="80%" 
                    HeaderStyle-HorizontalAlign="Center" 
                    HeaderStyle-BackColor="#6eab91" 
                    HeaderStyle-BorderStyle="None"
                    BorderStyle="None"
                    GridLines="None"
                    BackColor="#E8E8E8"
                    AutoGenerateColumns="false"  
                    OnPageIndexChanging="FlatGrid_PageIndexChanging" 
                    HorizontalAlign="Center" 
                    PageSize="15" EmptyDataText="No Records Found" ShowHeaderWhenEmpty="True" 
                    Font-Names="Calibri" ForeColor="#666666"  
                    AllowPaging="True" AllowSorting="True">                                
                 <AlternatingRowStyle BackColor="#ffffff" HorizontalAlign="Center" />                                  
                  <Columns>                                                                         
                    <asp:TemplateField HeaderStyle-Width="70px" HeaderText="FlatNumber">
                         <ItemTemplate>
                           <asp:LinkButton ID="lnkFlatNumber"  runat="server" ForeColor="#004993" CausesValidation="false" Font-Underline="true" Text='<%# Bind("FlatNumber") %>'></asp:LinkButton>
                         </ItemTemplate>
                    </asp:TemplateField> 
                    
                      <asp:BoundField DataField="UserLogin" HeaderText="UserLogin" ItemStyle-CssClass="FlatsGrid_Text" HeaderStyle-Width="120px" />
                       <asp:BoundField DataField="Floor" HeaderText="Floor"  HeaderStyle-Width="80px"/>
                        <asp:BoundField DataField="Block" HeaderText="Block" HeaderStyle-Width="80px" />
                           <asp:BoundField DataField="IntercomNumber" HeaderText="Intercom"  HeaderStyle-Width="80px"/>
                             <asp:BoundField DataField="BHK" HeaderText="BHK" ItemStyle-Width="50px"/>                   
                             <asp:BoundField DataField="OwnerName" HeaderText="OwnerName" ItemStyle-Width="100px" HeaderStyle-Width="100px"/>
                             <asp:BoundField DataField="Address" HeaderText="Address" ItemStyle-Width="100px" HeaderStyle-Width="100px"/>
                             <asp:TemplateField HeaderStyle-Width="20px">
                                    <ItemTemplate>
                                      <button  onclick="ShowDialog('<%# Eval("UserLogin") %>' , '<%# Eval("FlatNumber") %>',this)" type="button" style="width: 20px; background-color: transparent; border: none; outline: 0; height: 20px; background-repeat: no-repeat;">
                                      <i class="fa fa-angle-double-right" id="left_icon" style="color:gray;   font-size:20px"></i>
                                    </ItemTemplate>
                             </asp:TemplateField>
                              </Columns>
                                      <EmptyDataRowStyle  HorizontalAlign="Center" BackColor="#CCCCCC"/>
                                 
                                    
                                    <PagerSettings Mode="NumericFirstLast" />
                                      <PagerStyle BackColor="White" BorderColor="#F0F5F5" Font-Bold="False" HorizontalAlign="Center" ForeColor="#4774D1" Font-Names="Berlin Sans FB" Font-Size="Medium" />
                                       <RowStyle ForeColor="#666666" HorizontalAlign="Center" Font-Size="Medium" />
                                </asp:GridView>

                            </td>
                            <td style="width: 10%;vertical-align:top;">
                                <div>

                                <div id="Flat_dropdown" class="layout-dropdown-content theme-dropdown-content">
                                     <asp:Button ID="btnAddTenant" runat="server" CausesValidation="False" CssClass="layout_dropdown_Button" Text="Add Tenant" OnClick="btnAddTenant_Click" />                               
                                     <asp:Button ID="btnFlatsEdit" runat="server" CausesValidation="False" CssClass="layout_dropdown_Button" Text="Edit" OnClick="btnFlatsEdit_Click" />
                                     <asp:Button ID="btnAddBill" runat="server" CausesValidation="False" CssClass="layout_dropdown_Button" Text="Edit Bill"  Visible="true" OnClick="btnAddBill_Click"/>
                                    <asp:HiddenField ID="HiddenImportPopup" runat="server" />
                                     <%-- <asp:BoundField DataField="EmailId" HeaderText="ResidentEmail" /> --%>
                                </div>
                                     </div>
                                <asp:HiddenField ID="HiddenField1" runat="server" />
                                 <asp:HiddenField ID="HiddenField2" runat="server" />
                                 <asp:HiddenField ID="HiddenEditID" runat="server" />
                                <asp:HiddenField ID="HiddenAddTID" runat="server" />
                            </td>
                        </tr>
                         <tr>
                            <td colspan="7" style="text-align:center;">
                                 <asp:Label ID="lblFlatGridEmptyText" runat="server" ForeColor="#42A0FF"></asp:Label><br /><br />
                                <asp:Label ID="totalFlats" runat="server" ForeColor="#007cf9" Text="Total Flats:"></asp:Label>
                                <asp:Label ID="lblTotalFlats" runat="server" ForeColor="#4774d1" Text=""></asp:Label>
                                <br />
                                <asp:Label ID="lblFlatEditStatus" runat="server" ForeColor="#359AFF"></asp:Label>                 
                            </td>
                        </tr>
                        <tr style="height: 5px;text-align:center;">
                            <td colspan="9" style="height: 10px;">
                                <asp:Button ID="btnFltsShwall" runat="server" CssClass="btn_style" OnClick="btnFltsShwall_Click" Text="Show All" CausesValidation="False" />
                                <asp:HiddenField ID="hfCustomerId" runat="server" />                    
                          <asp:Button ID="btnFlatnumbrSrch" runat="server" Text="Button" Visible="false"  OnClick="btnFlatnumbrSrch_Click"/> 
                            </td>
                        </tr>               
                    </table>

        <%-- <asp:BoundField DataField="EmailId" HeaderText="ResidentEmail" /> --%>
                         <div id="Popup" class="modalFlat">
                         <div draggable="true" style="width:40%;margin-left:30%; text-align:center;border-color:#1f90e2;padding:0% 1% 1% 2% ;background-color:#ded9d9;box-shadow:2px 2px 2px #808080;">      
                            <br />
                            <asp:Label ID="lblDuplicate" runat="server" CssClass="GridHeader_text" Text="Duplicate Values:"></asp:Label>
                 
                            <asp:CheckBox ID="chkFlats" runat="server" ForeColor="#4382c0" Text="Update all flats" TextAlign="Left"/>

                             <%-- <asp:BoundField DataField="EmailId" HeaderText="ResidentEmail" /> --%>
                        <div  id="DuplicateScroll_Div" runat="server" style="overflow:auto; width:100%;height:200px;">
                                 <asp:GridView ID="ImportduplicateGrid" runat="server"  HorizontalAlign="Center" AutoGenerateColumns="false" Width="100%" PageSize="15"   ShowHeader="true">
                                     <HeaderStyle BackColor="#3eb1ff"  ForeColor="White" />
                                     <EditRowStyle  BackColor="#f2f2f2"/>
                                           <Columns>                          
                                                   <asp:BoundField DataField="ID" ItemStyle-Width="20px" HeaderText="ID" ControlStyle-Width="15%" />
                                                   <asp:BoundField DataField="FlatNumber" ItemStyle-Width="20px" HeaderText="FlatNumber" />
                                                   <asp:BoundField DataField="Floor" ItemStyle-Width="20px" HeaderText="Floor" />
                                                   <asp:BoundField DataField="Block" ItemStyle-Width="20px" HeaderText="Block" />     
                                                   <asp:BoundField DataField="LastName" ItemStyle-Width="20px" HeaderText="LastName"/>   
                                          </Columns>
                                     <PagerStyle BackColor="White" ForeColor="#4170CF"  HorizontalAlign="Center"/>
                                </asp:GridView>
                          </div>

                            <br /><br />
                            <asp:Label ID="lblNewvalues" runat="server" CssClass="GridHeader_text" Text="New Values :"></asp:Label>
                            <span style="margin-top:3%;"></span>
                             <%--  <asp:Button ID="btnUserMap" runat="server" CausesValidation="False" CssClass="list_type"  Visible="false" Text="Map Resident" OnClick="btnUserMap_Click" />--%>
                             <div id="NewValueScroll_Div" runat="server" style="overflow:auto; width:100%;height:200px;">
                                        <asp:GridView ID="ImportNewRecordGrid" runat="server" AutoGenerateColumns="false" HorizontalAlign="Center" Width="100%" PageSize="15"  ShowHeader="true">
                                           <HeaderStyle BackColor="#3eb1ff"  ForeColor="White"  />
                                              <EditRowStyle  BackColor="#f2f2f2"/>
                                                  <Columns>
                                                           <asp:BoundField DataField="ID" ItemStyle-Width="20px" HeaderText="ID" />
                                                           <asp:BoundField DataField="FlatNumber" ItemStyle-Width="30px" HeaderText="FlatNumber" />
                                                           <asp:BoundField DataField="Floor" ItemStyle-Width="20px" HeaderText="Floor" />
                                                           <asp:BoundField DataField="Block" ItemStyle-Width="20px" HeaderText="Block" />     
                                                           <asp:BoundField DataField="UserLogin" ItemStyle-Width="20px" HeaderText="UserLogin" /> 
                                                           <asp:BoundField DataField="LastName" ItemStyle-Width="25px" HeaderText="LastName"/>   
                                                   </Columns>
                                              <PagerStyle BackColor="White" ForeColor="#648AD9" />
                                       </asp:GridView>
                               </div>
                                <br />
                               <asp:Button ID="btnselsectdata" runat="server" Text="Import" OnClick="btnselsectdata_Click" BackColor="#3399FF" ForeColor="White" Height="25px" Width="100px"  CausesValidation="false"/>
                            <span style="margin-left:6%;"></span>
                            <asp:Button ID="btncancel" runat="server" Text="Cancel" OnClick="btncancel_Click" BackColor="#0099FF" ForeColor="White" Height="25px" Width="100px" CausesValidation="false"  />
                            </div>
                             </div>


           <%-- Import pop up window --%>

              <div id="myModalPopupImport" class="modalFlat">
  
         <table style="width:40%;background-color:white;margin-left:30%;margin-top:15%;border-radius:5px;">
             <tr>
                 <td colspan="2" style="text-align:right;border-bottom:1px solid #f2f2f2;">
                  <button type="button" id="Import_close" onclick="Reset()" style="background-color:white;border:0;outline:0;color:#bfbfbf; font-weight:bold;">X</button>
                 </td>
             </tr>
             <tr>
                 <td colspan="2" style="color:#696868;text-align:center;font-size:large;background-color:#f5f1f1;padding-bottom:1.5%;"> Upload a File </td>
             </tr>
               <tr>
                 <td colspan="2" style="color:#807e7e;text-align:center;font-size:small;padding:2% 0 1% 0;"> Select a Excel file to upload data  <br /> supported files (.xls ,.xlsx) </td>
             </tr>
             <tr>
                 <td style="width:60%;text-align:right;padding:5% 0 5%;">
                        <asp:FileUpload ID="FlatsDataUpload" runat="server"/>
                 </td> 
                 
                  <td style="width:40%;text-align:left;padding:5% 0 5%;"> 
                         <asp:Button ID="FlatsDataUploadSubmit" runat="server" Text="Submit" CssClass="send" OnClientClick="javascript:return ValidateImport()" OnClick="FlatsDataUploadSubmit_Click"   CausesValidation="false" />
                  </td>
             </tr>
              <tr>
                 <td colspan="2" style="text-align:center;padding:2% 0 5% 0;">
                     <asp:Label ID="lblFileUploadstatus"  runat="server" Text="" ForeColor="Red"></asp:Label>
                 </td>
             </tr>
         </table>     
   </div>



        <%---------------------------------------------Add Flats Section UI  ---------------------------------------------------------------------------------------------------------------------------------%>


         <div class="modal" id="myModalPopup">

        <asp:UpdatePanel ID="UpdatePanel1" runat="server" EnableViewState="true">
            <ContentTemplate>
              <div class="container-fluid">
                <div class="panel panel-primary"  style="width:520px;background-color:#f2f2f2;margin: auto;">
                    <div class="panel-heading">
                        
                            Add Flat
                       <span class="fa fa-close" onclick="HideAddFlatModal()" style="color:white;float:right; cursor:pointer;"></span>
                        
                    </div>
                    <form class="form-group"autocomplete="off">
                    <div class="panel-body" style="background-color:#fff;" >
                             <div class="row">
                                 <div class="col-xs-12"><asp:RegularExpressionValidator ID="RegularExpressionValidator15" runat="server" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Please enter valid Email" Font-Size="Small" ForeColor="#FF5050" ControlToValidate="txtAddfltEmail" ValidationGroup="Add_Flat" Display="Dynamic"></asp:RegularExpressionValidator> </div>
                             </div>
                             <div class="row"  style="border-top-left-radius:10px;">
                                 <div class="col-xs-12">
                                    <b> User Details:</b>
                                 </div>
                                 </div>
                                 <div class="row">
                                     <div class="col-xs-6 ">

                                         <label style="width: 100px;">
                                             Mobile :
                                         </label>

                                         <asp:TextBox Width="100px" ID="txtAddfltMobile" onkeypress="return isNumberKey(event)" runat="server" MaxLength="10" Height="25px" OnTextChanged="txtAddfltMobile_TextChanged" onclick="Reset()" TabIndex="1" AutoPostBack="True"></asp:TextBox>

                                         <asp:Image ID="mobileMsg" Height="1px" Width="1px" runat="server" />
                                         <i id='mobInvalid' class="fa fa-circle" style="color: green; display: none;" aria-hidden="true"></i>
                                     </div>
                                     <div class="col-xs-6">

                                         <label style="width: 100px;">
                                             Email :
                                         </label>

                                         <asp:TextBox Width="100px" ID="txtAddfltEmail" runat="server" Height="25px" onfocus="Focus(this.id,'in Sqfts.')" onblur="Blur(this.id,'in Sqfts.')" TabIndex="2" AutoPostBack="True" OnTextChanged="txtAddfltEmail_TextChanged"></asp:TextBox>

                                         <asp:Image ID="emailMsg" Height="10px" Width="10px" runat="server" />
                                         <span style="display:none;"><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red"  ControlToValidate="txtAddfltEmail" ValidationGroup="Add_Flat"></asp:RequiredFieldValidator></span>
                                     </div>

                                   
                                 </div>
                        <hr />
                           <div class="row">
                                       <div class="col-xs-6">
                                         <label style="width: 100px;">
                                             FirstName :
                                         </label>
                                         <asp:TextBox Width="100px" ID="txtAddflatFirstname" BorderWidth="0" runat="server" onClick="Reset()" ReadOnly="true"  Height="25px" TabIndex="3"></asp:TextBox>
                                         <asp:RequiredFieldValidator ID="RequireAddflatOwnername" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtAddflatFirstname" ValidationGroup="Add_Flat"></asp:RequiredFieldValidator>

                                     </div>
                                     <div class="col-xs-6">
                                         <label style="width: 100px;">
                                             LastName :
                                         </label>

                                         <asp:TextBox Width="100px" ID="txtAddflatLastName" ReadOnly="true" BorderWidth="0" runat="server" Height="25px" TabIndex="4"></asp:TextBox>

                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator23" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtAddflatLastName" ValidationGroup="Add_Flat"></asp:RequiredFieldValidator>
                                     </div>
                                 </div>
                                 <div class="row">
                                     <div class="col-xs-6">
                                         <label style="width: 100px;">
                                             Gender :
                                         </label>

                                         <asp:DropDownList Width="100px" ID="drpFlatGender" ReadOnly="true" BorderWidth="0" runat="server" Height="25px" TabIndex="5">
                                             <asp:ListItem>Male</asp:ListItem>
                                             <asp:ListItem>Female</asp:ListItem>
                                         </asp:DropDownList>
                                     </div>
                                     <div class="col-xs-6">
                                         <label style="width: 100px;">
                                             Parent Name :
                                         </label>

                                         <asp:TextBox Width="100px" ID="txtAddfltParentName" ReadOnly="true" BorderWidth="0" runat="server" Height="25px" TabIndex="6"></asp:TextBox>

                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtAddfltParentName" ValidationGroup="Add_Flat"></asp:RequiredFieldValidator>

                                     </div>
                                 </div>
                              
                             
                        <div class="row">

                            <div class="col-sm-6" style="display:none;">
                                <label style="width: 100px;">
                                    UserLogin :
                                </label>

                                <asp:TextBox Width="100px" ID="txtAddflatUserLogin" Enabled="false" runat="server" Height="25px" OnTextChanged="txtAddflatUserLogin_TextChanged" TabIndex="7" AutoPostBack="True"></asp:TextBox>

                                <asp:Image ID="loginMsg" Height="1px" Width="1px" runat="server" />
                            </div>
                            <div class="col-sm-6">


                                <label style="width: 100px;">
                                    Address :
                                </label>

                                <asp:TextBox Width="100px" ID="txtAddfltAddrs" ReadOnly="true" BorderWidth="0" runat="server" Height="42px" TabIndex="8"></asp:TextBox>


                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtAddfltAddrs" ValidationGroup="Add_Flat"></asp:RequiredFieldValidator>


                            </div>
                        </div>
                        <hr />
                        <div class="row" style="margin-bottom:5px!important;">

                            <div class="col-sm-6">
                                <asp:Label ID="lblUserExist" CssClass="lbltxt" runat="server" style="display:none;" Font-Size="Small" ForeColor="#59ACFF"></asp:Label>

                                <asp:CheckBox ID="checkFlatsOnly" Text="Add Flats for existing user" runat="server" OnCheckedChanged="checkFlatsOnly_CheckedChanged" Visible="false" AutoPostBack="true" Font-Size="Small" />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <b>Flat Details: </b>
                            </div>
                            <div class="col-xs-12">
                                <asp:Label ID="lblAddfltAvailble" runat="server" Font-Size="Small" ForeColor="#FF5050"></asp:Label>
                                <asp:Label ID="lblAddflatStatus" runat="server" Font-Size="Small" ForeColor="#4AA5FF"></asp:Label>
                                <asp:Label ID="lblDefalutBillText" runat="server" Font-Size="Small" ForeColor="#48A4FF"></asp:Label>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ValidationExpression="^[0-9]{5}$" runat="server" ControlToValidate="txtAddflatIntrc" ErrorMessage="Please Enter 5  Digits" Font-Size="Small" ForeColor="#FF5050" ValidationGroup="Add_Flat" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>

                        </div>
                        <div class="row">

                            <div class="col-xs-6">

                                <label style="width: 100px;">
                                    Flat number :
                                </label>

                                <asp:TextBox Width="100px" ID="txtFltAdd" runat="server" AutoPostBack="True" Height="25px" OnTextChanged="txtFltAdd_TextChanged" TabIndex="9"></asp:TextBox>

                                <asp:Image ID="flatMsg" Height="10px" Width="10px" runat="server" />
                                <span style="display:none;"><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtFltAdd" ValidationGroup="Add_Flat"></asp:RequiredFieldValidator></span>
                            </div>
                            <div class="col-xs-6">
                                <label style="width: 100px;">
                                    Block :
                                </label>

                                <asp:TextBox Width="100px" ID="txtAddBlock" runat="server" Height="25px" TabIndex="10"></asp:TextBox>

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtAddBlock" ErrorMessage="*" ForeColor="Red" InitialValue="0" ValidationGroup="Add_Flat"></asp:RequiredFieldValidator>
                            </div>

                        </div>
                        <div class="row">

                            <div class="col-xs-6">

                                <label style="width: 100px;">
                                    Floor :
                                </label>

                                <asp:TextBox  Width="100px" ID="txtAddfltFlr" runat="server" Height="25px" TabIndex="11" MaxLength="3"></asp:TextBox>

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="txtAddfltFlr" ErrorMessage="*" ForeColor="Red" ValidationGroup="Add_Flat"></asp:RequiredFieldValidator>

                                <td style="width: 100px;">
                            </div>
                            <div class="col-xs-6">

                                <label style="width: 100px;">
                                    Flat Area :
                                </label>

                                <asp:TextBox Width="100px" ID="txtFlatArea" runat="server" Height="25px" onfocus="Focus(this.id,'in Sqfts.')" onblur="Blur(this.id,'in Sqfts.')" ToolTip="In sqfts." TabIndex="12"></asp:TextBox>

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtFlatArea" ErrorMessage="*" ForeColor="Red" InitialValue="0" ValidationGroup="Add_Flat"></asp:RequiredFieldValidator>


                            </div>
                        </div>
                                                <label style="width:100px;">
                                                     BHK :
                                                </label>
                                               
                                                     <asp:DropDownList Width="100px" ID="drpAddflatBHK" runat="server" Height="25px" TabIndex="13">
                                                     <asp:ListItem Value="0">Select</asp:ListItem>
                                                     <asp:ListItem>1</asp:ListItem>
                                                     <asp:ListItem>2</asp:ListItem>
                                                     <asp:ListItem>3</asp:ListItem>
                                                     <asp:ListItem>4</asp:ListItem>
                                                  </asp:DropDownList>
                                                
                                                <label style="width:151px; padding-left: 47px;">
                                                    InterCom :
                                                </label>
                                              
                                                    <asp:TextBox Width="100px" ID="txtAddflatIntrc" runat="server" MaxLength="5" Height="25px" TabIndex="14"></asp:TextBox>
                                              
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator28" runat="server" ControlToValidate="txtAddflatIntrc" ErrorMessage="*" ForeColor="Red" ValidationGroup="Add_Flat"></asp:RequiredFieldValidator>
                                            

                                 </div>
                        </form>
                             
                         <asp:Label ID="msg" runat="server" ForeColor="Red" text=""></asp:Label>
                             <div class="panle-footer" style="text-align:right;padding-right:10px;margin:10px;">
                               
                                     <asp:Button ID="btnAddflatSubmit" runat="server" Text="Submit" OnClientClick=""   OnClick="btnAddflatSubmit_Click" TabIndex="15" ValidationGroup="Add_Flat" class="btn btn-primary"/>
                                
                                     <button type="button" id="btnCancelAddFlat"  onclick="HideAddFlatModal()" class="btn btn-danger">Cancel</button>
                                </div>
                    </div>
                        
                    
                
                <div id="data_loading" class="layout-overlay" style="background-color:#000; width:100%; height:100%; opacity: 0.5; filter: alpha(opacity=50); text-align:center;vertical-align:middle;">
                                       <img src="Images/Icon/ajax-loader.gif" style="width:20px; height:20px;margin-top:200px;" />

                                 </div>
             
                  </div>
               </ContentTemplate>
            </asp:UpdatePanel>
            
       </div>
       

        <%------------------------------------------------------------------------------Flats edit section starts from here ------------------------------------------------------------------------------------- --%>
       


          <div id="myModalEditPopup" class="modalFlat">

              <table style="width:30%; margin-left:30%; border:1px solid #f2f2f2;box-shadow:2px 2px 5px #bfbfbf;background-color:#f2f2f2;border-radius:10px;padding:0% 0 2% 0;">
            <tr style="background-color:#5ca6de;">
                <td colspan="4" style="text-align:left;padding:1% 0 1% 3%;">  
                     Edit Flat :
                </td>     
             </tr>  
          <tr>
                <td colspan="4" style="height:15px; ">  
                  
                </td>   
              </tr> 
          <tr>  
               <td class="lbltxt"  style="width:20%;">
                   FlatNumber :</td>
                <td style="width:15%">
                    <asp:TextBox ID="txtEditFlatNumber" runat="server" CssClass="txtbox_style" ReadOnly="True"></asp:TextBox>
                </td>
                <td style="width:1%;">
                    <asp:RequiredFieldValidator ID="RequireEditFlatName" runat="server" ControlToValidate="txtEditFlatNumber" ErrorMessage="*" ForeColor="Red" ValidationGroup="Edit_Flat"></asp:RequiredFieldValidator>
                </td> 
              <td style="width:2%;"> </td>       
              </tr>

          <tr>
            <td class="lbltxt">
                OwnerName :</td>
                <td style="width:15%;" >
                    <asp:TextBox ID="txtFlatOwnerName" runat="server" CssClass="txtbox_style"></asp:TextBox>
                </td>
              <td>
                  <asp:RequiredFieldValidator ID="RequireEditFlatNumber" runat="server" ControlToValidate="txtFlatOwnerName" ErrorMessage="*" ForeColor="Red" ValidationGroup="Edit_Flat"></asp:RequiredFieldValidator>
                </td>
                <td style="width:2%;"> </td>     
            </tr>

         <tr>
            <td class="lbltxt">
                Block :
                <td style="width:15%;">
                  <asp:TextBox ID="txtEditFlatBlock" runat="server"  CssClass="txtbox_style"></asp:TextBox>
                </td>
              <td>
                  <asp:RequiredFieldValidator ID="RequireEditFlatBlock" runat="server" ControlToValidate="txtEditFlatBlock" ErrorMessage="*" ForeColor="Red" ValidationGroup="Edit_Flat"></asp:RequiredFieldValidator>
                </td>
            </tr>

         <tr>
            <td class="lbltxt">
               Floor :
                <td style="width:15%;">
                  <asp:TextBox ID="txtEditFlatFloor" runat="server"  CssClass="txtbox_style"></asp:TextBox>
                </td>
              <td>
                  <asp:RequiredFieldValidator ID="RequireEditFlatFloor" runat="server" ControlToValidate="txtEditFlatFloor" ErrorMessage="*" ForeColor="Red" ValidationGroup="Edit_Flat"></asp:RequiredFieldValidator>
                </td>
            </tr>
          <tr>
            <td class="lbltxt">
                Intercom :</td>
                <td style="width:15%;">
                  <asp:TextBox ID="txtFltInterNum" runat="server"  CssClass="txtbox_style"></asp:TextBox>
                </td>
              <td>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtFltInterNum" ErrorMessage="*" ForeColor="Red" ValidationGroup="Edit_Flat"></asp:RequiredFieldValidator>
                </td>
            </tr>
  <tr>
            <td class="lbltxt">
               BHK :
            </td>
                <td style="width:15%;">
                  <asp:TextBox ID="txtFltBhk" runat="server"  CssClass="txtbox_style"></asp:TextBox>
                </td>
              <td>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="txtFltBhk" ErrorMessage="*" ForeColor="Red" ValidationGroup="Edit_Flat"></asp:RequiredFieldValidator>
                </td>
            </tr>
       
        <tr>
            <td class="lbltxt">
               Email :</td>
                <td style="width:15%;">
                  <asp:TextBox ID="txtFlatEmail" runat="server"  CssClass="txtbox_style"></asp:TextBox><br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtFlatEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Enter valid Email" Font-Size="Small" ForeColor="#FF5050" ValidationGroup="Edit_Flat" Display="Dynamic"></asp:RegularExpressionValidator>
                </td>
              <td>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ControlToValidate="txtFlatEmail" ErrorMessage="*" ForeColor="Red" ValidationGroup="Edit_Flat"></asp:RequiredFieldValidator>
                </td>
              <td style="width:2%;"> 
                  
            </td>     
            </tr><tr>
            <td  class="lbltxt">
                Mobile :</td>
                <td style="width:15%;">
                  <asp:TextBox ID="txtFlatMobile" runat="server"  CssClass="txtbox_style" MaxLength="10"></asp:TextBox><br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="txtFlatMobile" ValidationExpression="^[0-9]{10}$" ErrorMessage="Enter valid MobileNo" Font-Size="Small" ForeColor="#FF5050" ValidationGroup="Edit_Flat" Display="Dynamic"></asp:RegularExpressionValidator>
                 <asp:Label ID="lblMobileCheck" runat="server" ForeColor="#4AA5FF"></asp:Label>
                </td>
              <td>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ControlToValidate="txtFlatMobile" ErrorMessage="*" ForeColor="Red" ValidationGroup="Edit_Flat"></asp:RequiredFieldValidator>
                </td>
                  <td style="width:2%;"> 
                      
                </td>     
            </tr>
         <tr>
            <td  class="lbltxt">
               Address :</td>
                <td style="width:15%;">
                  <asp:TextBox ID="txtFlatAddress" runat="server"  CssClass="txtbox_style"></asp:TextBox>
                </td>
              <td>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ControlToValidate="txtFlatAddress" ErrorMessage="*" ForeColor="Red" ValidationGroup="Edit_Flat"></asp:RequiredFieldValidator>
                </td>
               <td style="width:2%;"> </td>     
            </tr>
        <tr>
            <td colspan="5" style="height:15px;"></td>
        </tr>
         <tr>
            <td colspan="5" style="text-align:center;">
                <asp:Label ID="lblfltEditstatus" runat="server" ForeColor="#4AA5FF"></asp:Label>
            </td>
        </tr>
         <tr>
            <td colspan="5" style="height:15px;"></td>
        </tr>
         <tr>
             
                 <td style="text-align:center;">
               
                   <asp:Button ID="btneditFlat" runat="server" Text="Submit" CssClass="btn_style" OnClick="btneditFlat_Click" ValidationGroup="Edit_Flat"/>
                </td>
             <td style="text-align:right;">

                 <%--  <asp:RadioButton ID="RadioFalt" type="Radio" runat="server" onclick="javascript:CheckOtherIsCheckedByGVID(this);" GroupName="UserSelector" AutoPostBack="false" Visible="false" />--%>

                 <button type="button" id="Flats_Edit_Cancel" class="btn_style">Cancel</button>

             </td>
            </tr>

                  <tr>
                      <td colspan="4" style="height:15px;">  </td>
                  </tr>
        </table>
</div>


        <%----------------------- --%>
       
         <div id="myModalAddTPopup" class="modalFlat"> 

                    
           <table style="width:70%; margin-left:10%;box-shadow:2px 2px 5px #bfbfbf;background-color:#f2f2f2;border-radius:10px;padding:0% 0 2% 0;">
                       <tr>
                           <td colspan="8" style="color:dodgerblue;background-color:#5ca6de; text-align:left;padding:1% 0 1% 3%;">  
                                <asp:Label ID="Label34" runat="server" ForeColor="White" Font-Size="Large" Text="Add Tenant:"></asp:Label>                             
                            </td>                   
                       </tr>
             <tr>  
                 <td colspan="8" style="height:15px;">  </td>
             </tr>
                        <tr>
                            <td colspan="8" style="color:dodgerblue; text-align :center;"> 
                                <asp:Label ID="lblHeadText" runat="server" Font-Names="Arial Unicode MS"></asp:Label>
                            </td>                                        
                        </tr>
             <tr>
                 <td colspan="8" style="height: 15px;"></td>
             </tr>
                         <tr>
                            <td class="lbltxt" style="width:20%;">
                                <asp:Label ID="Label35" runat="server"  Text="Flat number :"></asp:Label>
                             </td>
                               <td style="width:10%;">                              
                                           <asp:TextBox ID="txtAddTFlatNo" runat="server" CssClass="txtbox_style" TabIndex="1"></asp:TextBox>                                        
                              </td> 
                              <td style="width:1%;">
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" ControlToValidate="txtAddTFlatNo" Display="Dynamic" ErrorMessage="*" ForeColor="#FF4A4A" ValidationGroup="Add_Tenant"></asp:RequiredFieldValidator>
                            </td> 
                              <td style="width:2%;">  </td> 
                              <td  class="lbltxt" style="width:20%;">
                                <asp:Label ID="Label36" runat="server"  Text="Mobile :"></asp:Label></td> 
                              <td style="width:10%;">
                                  <asp:UpdatePanel ID="UpdatePanel9" runat="server">
                                      <ContentTemplate>
                             <asp:TextBox ID="txtAddTMobile" runat="server" CssClass="txtbox_style" MaxLength="10" TabIndex="7" AutoPostBack="True" OnTextChanged="txtMobile_TextChanged"  autocomplete ="off"></asp:TextBox>    <br />
                                          <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ValidationExpression="^([0-9]{10})+$" ErrorMessage="Please enter valid  number" Font-Size="Small" ForeColor="#FF5050" ControlToValidate="txtAddTMobile" ValidationGroup="Add_Tenant" Display="Dynamic"></asp:RegularExpressionValidator>                        
                                   <asp:Label ID="lblAddTMobilechck" runat="server" Font-Size="Small" ForeColor="#FF5050"></asp:Label>
                                             </ContentTemplate>
                                  </asp:UpdatePanel>
                                        
                            </td> 
                              <td style="width:1%;">  
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtAddTMobile" ValidationGroup="Add_Tenant"></asp:RequiredFieldValidator>
                              </td> 
                              <td style="width:2%;">
                                  
                                                       
                              </td>
                       </tr>
                       <tr>
                            <td class="lbltxt">
                                <asp:Label ID="Label38" runat="server"  Text="Firstname :"></asp:Label>
                            </td>
                            <td>

                    <asp:TextBox ID="txtAddTFirstName" runat="server" CssClass="txtbox_style" TabIndex="2"></asp:TextBox><br />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server" ValidationExpression="^[A-Za-z]+(\s[A-Za-z]+)?" ErrorMessage="enter valid name" ForeColor="#FF5050" ControlToValidate="txtAddTFirstName" Font-Size="Small" ValidationGroup="Add_Tenant" Display="Dynamic"></asp:RegularExpressionValidator>

                            </td>
                            <td> 
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" ErrorMessage="*" ControlToValidate="txtAddTFirstName" ForeColor="#FF2424" ValidationGroup="Add_Tenant"></asp:RequiredFieldValidator>
                            </td>
                            <td> 
                                
                            </td>
                            <td class="lbltxt">
                                <asp:Label ID="Label39" runat="server" Text="Address :" ></asp:Label>
                              </td>
                            <td>
                             
                                <asp:TextBox ID="txtAddTAddress" runat="server" CssClass="txtbox_style"  TabIndex="8" autocomplete ="off"></asp:TextBox>          <br />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator11" runat="server" ValidationExpression="^[A-Za-z]+(\s[A-Za-z]+)?" ErrorMessage="enter valid name" ForeColor="#FF5050" ControlToValidate="txtAddTLastName" Font-Size="Small" ValidationGroup="Add_Tenant" Display="Dynamic"></asp:RegularExpressionValidator>                
                                   
                                </td>
                            <td>
                                </td>
                               <td>  </td>                 
                        </tr>
                        <tr>
                            <td class="lbltxt">
                                <asp:Label ID="Label40" runat="server" Text="Lastname :"></asp:Label>
                             </td>
                            <td>
                    <asp:TextBox ID="txtAddTLastName" runat="server" CssClass="txtbox_style" TabIndex="3"></asp:TextBox>

                            </td>  <td >
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" ErrorMessage="*" ControlToValidate="txtAddTLastName" ForeColor="#FF2424" ValidationGroup="Add_Tenant"></asp:RequiredFieldValidator>
                            </td><td>
                                
                            </td>
                            <td class="lbltxt">
                                <asp:Label ID="Label43" runat="server" Text="Email  :" ></asp:Label>
                              </td>                      
                             <td>
                                 <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                                     <ContentTemplate>                                   
                                  <asp:TextBox ID="txtAddTEmailID" runat="server" CssClass="txtbox_style" TabIndex="9" OnTextChanged="txtEmailID_TextChanged" AutoPostBack="True" autocomplete ="off"></asp:TextBox> 
                                 <br />
                                 
                         <asp:RegularExpressionValidator ID="regAddTEmailCheck" runat="server" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Please enter valid Email" Font-Size="Small" ForeColor="#FF5050" ControlToValidate="txtAddTEmailID" ValidationGroup="Add_Tenant" Display="Dynamic"></asp:RegularExpressionValidator>                                   
                          <asp:Label ID="lblAddTEmailChck" runat="server" ForeColor="#FF5050" Font-Size="Small"></asp:Label>                        
                           </ContentTemplate>
                                 </asp:UpdatePanel>
                                   </td>
                             <td>                             
                                <asp:RequiredFieldValidator ID="RequireAddTEmail" runat="server" ControlToValidate="txtAddTDeactiveDate" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Add_Tenant"></asp:RequiredFieldValidator>                                 
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                           <td class="lbltxt">
                             <asp:Label ID="lblGender" runat="server" Text="Gender :"></asp:Label></td>
                            <td>
                        <asp:DropDownList ID="drpAddTGender" runat="server" CssClass="flats_dropdownlist" TabIndex="4">
                            <asp:ListItem Value="0">Select</asp:ListItem>
                            <asp:ListItem>Male</asp:ListItem>
                            <asp:ListItem>Female</asp:ListItem>
                        </asp:DropDownList>
                            </td>
                            <td>
                    <asp:RequiredFieldValidator ID="RequireGender" runat="server" ErrorMessage="*" ControlToValidate="drpAddTGender" ForeColor="#FF2424" InitialValue="0" ValidationGroup="Add_Tenant"></asp:RequiredFieldValidator>
                              </td>
                            <td>  </td>
                            <td  class="lbltxt">
                                <asp:Label ID="lbluserlogin" runat="server"  Text="UserLogin :"></asp:Label>
                              </td>
                            <td>
                                <asp:UpdatePanel ID="UpdatePanel11" runat="server">
                                    <ContentTemplate>
                                         <asp:TextBox ID="txtAddTUserLogin" runat="server" CssClass="txtbox_style" AutoPostBack="True" OnTextChanged="txtUserLogin_TextChanged" TabIndex="10"></asp:TextBox>      <br />
                                        <asp:Label ID="lblAddTenantUserCheck" runat="server" Font-Size="Small" ForeColor="#FF5050"></asp:Label>
                                  <asp:RegularExpressionValidator ID="regUserLoginexp" runat="server" ValidationExpression="^[A-Za-z 0-9 _ @ .]+(\s [A-Za-z]+)?" ErrorMessage="enter valid name" ForeColor="#FF5050" ControlToValidate="txtAddTUserLogin" Font-Size="Small" ValidationGroup="Add_Tenant" Display="Dynamic"></asp:RegularExpressionValidator>
                                          </ContentTemplate>
                                </asp:UpdatePanel>
                                         </td>
                            <td>
                    <asp:RequiredFieldValidator ID="requireUserLogin" runat="server" ErrorMessage="*" ControlToValidate="txtAddTUserLogin" ForeColor="#FF2424" ValidationGroup="Add_Tenant"></asp:RequiredFieldValidator>
                            </td>
                            <td>                                                            
                            </td>
                         </tr>
                         <tr>
                              <td class="lbltxt">
                                <asp:Label ID="lblParent" runat="server"  Text="ParentName :"></asp:Label></td>
                            <td>
                        <asp:TextBox ID="txtAddTParentName" runat="server" CssClass="txtbox_style" TabIndex="5"></asp:TextBox>
                            </td>
                            <td> 
                    <asp:RequiredFieldValidator ID="RequireParentName" runat="server" ErrorMessage="*" ControlToValidate="txtAddTParentName" ForeColor="#FF2424" ValidationGroup="Add_Tenant"></asp:RequiredFieldValidator>
                              </td>
                            <td>
                            </td>           
                            <td class="lbltxt"> 
                                <asp:Label ID="lblPassword" runat="server"  Text="Password :"></asp:Label>
                              </td>
                            <td>                         
                                <asp:TextBox ID="txtAddTPassword" runat="server" CssClass="txtbox_style" TextMode="Password" TabIndex="11"></asp:TextBox><br />
                                <asp:RegularExpressionValidator ID="regexpPassword" runat="server" ControlToValidate="txtAddTPassword" Display="Dynamic" ErrorMessage="Please enter a valid password, Ex : Password@123" Font-Size="Small" ForeColor="#FF5050" ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&amp;])[A-Za-z\d$@$!%*?&amp;]{8,}" ValidationGroup="Add_Tenant"></asp:RegularExpressionValidator>
                                 
                               </td>
            
                            <td> 
                                       <asp:RequiredFieldValidator ID="requirepassword" runat="server" ErrorMessage="*" ForeColor="#FF5050" ControlToValidate="txtAddTPassword" ValidationGroup="Add_Tenant"></asp:RequiredFieldValidator>
                              </td>
                            <td>                     
                              </td>
                        </tr>
                         <tr>
                            <td class="lbltxt">
                                <asp:Label ID="Label41" runat="server" Text="Deactive date :"></asp:Label>
                                
                             </td>
                            <td>
                                <asp:TextBox ID="txtAddTDeactiveDate" runat="server" CssClass="txtbox_style"  onchange="ValidateDate();"   TabIndex="6" ></asp:TextBox>
                            </td>
                            <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator24" runat="server" ErrorMessage="*" ControlToValidate="txtAddTEmailID" ForeColor="#FF2424" ValidationGroup="Add_Tenant"></asp:RequiredFieldValidator>
                                 </td>
                            <td>                                                               
                            </td>
                            <td class="lbltxt">
                                <asp:Label ID="lblConfirmPassword" runat="server"  Text="Confirm Password :"></asp:Label>
                             </td>
                            <td>                                                    
                      <asp:TextBox ID="txtAddTConfirmPassword" runat="server" CssClass="txtbox_style" TextMode="Password" TabIndex="12"></asp:TextBox><br />
                                <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToCompare="txtAddTPassword" ControlToValidate="txtAddTConfirmPassword" ErrorMessage="Password is not matching" Font-Size="Small" ForeColor="#FF5050" ValueToCompare="Add_Tenant" Display="Dynamic"></asp:CompareValidator>
                               
                             </td>
                            <td>   
                                <asp:RequiredFieldValidator ID="requireconfirmPassword" runat="server" ControlToValidate="txtAddTConfirmPassword" ErrorMessage="*" ForeColor="#FF3300" ValidationGroup="Add_Tenant"></asp:RequiredFieldValidator>
                             </td>
                            <td>  
                             </td>
                       </tr>
                        <tr>
                            <td colspan="8"></td>                    
                       </tr>
                        <tr>
                            <td colspan="8">   </td>
                        </tr>
                        <tr>
                            <td colspan="8" style="text-align:center;"> 
                            <asp:HiddenField ID="HiddenResType" runat="server" />

                    <asp:Label ID="lblResStatus" runat="server" ForeColor="#55AAFF" Font-Size="Small"></asp:Label>                              
                            </td> </tr>
                        <tr>
                            <td colspan="8" style="height:15px;"> </td>
                        </tr>
                        <tr>
                            <td colspan="4" style="text-align:center;">                                             
                               <asp:Button ID="btnDeactivate" runat="server" CssClass="btn_style_flats" OnClick="btnDeactivate_Click" Text="Deactivate"  OnClientClick=" return ValidateDate();" Visible="False" ValidationGroup="Add_Tenant"/>
                                 <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn_style_flats" OnClick="btnSubmit_Click" ValidationGroup="Add_Tenant" />             
                            </td> 

                            <td colspan="4" style="text-align:center;"> 
                                 <button type="button" id="Flats_AddT_Cancel"  class="btn_style_flats">Cancel</button>    
                            </td>
                        </tr>  
               <tr>
                   <td colspan="8" style="height:15px;">  </td>
               </tr>  
      </table>                
</div>
       
    </div>
    </form>
  
</body>
</html>
