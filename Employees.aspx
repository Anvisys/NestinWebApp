<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Employees.aspx.cs" Inherits="Employees" %>

<!DOCTYPE html>
<!--  This Total  code  is  licenced
    Developed By Anvisys Technologies Pvt Ltd.
    
    Copyright © 2016 Anvisys Technologies Pvt. Ltd.All rights reserved.
    -->
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


   

     <script>
        

         
         $(function () {
             $("#txtEmpNamesrch").autocomplete({
                 source: function (request, response) {
                     var param = {
                         FirstName: $('#txtEmpNamesrch').val()
                     };

                     $.ajax({
                         url: "Employees.aspx/GetFlatNumber",
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
             $("[id*=EmployeeGrid] td:has(button)").bind("click", function () {
                 var row = $(this).parent();
                 $("[id*=EmployeeGrid] tr").each(function () {
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
             $("#confirmActivate").hide();
             $('html').click(function () {

                 $("#dropdown-menu").hide();

             });

         });

         $(document).ready(function () {

             $("[id*=EmployeeGrid] td:has(button)").bind("click", function (event) {
                 var row = $(this).parent();

                 $("td", row).each(function () {

                     if ($('#dropdown-sample').is(':visible')) {
                         $("#dropdown-sample").show();
                     } else {

                         $("#dropdown-sample").hide();
                     }
                 });

                 event.stopPropagation();
             });

         });


         function ShowDialog(UserID, FlatNumber,DeactiveDate, Element) {
             document.getElementById("HiddenEmpUserID").value = UserID;
             document.getElementById("HiddenEmpFName").value = FlatNumber;
             document.getElementById("HiddenDeactivedate").value = DeactiveDate;
             
             var Posx = 0;
             var Posy = 0;

             while (Element != null) {
                 Posx += Element.offsetLeft;
                 Posy += Element.offsetTop;
                 Element = Element.offsetParent;
             }

            
                 $("#dropdown-menu").slideDown();
             

             document.getElementById("dropdown-menu").style.top = Posy + 'px';
         }

    

         function DConfirmationbox() {
             var result = confirm('Are you sure you want to delete selected User(s)?');
             if (result) {
                 return true;
             }
             else {
                 return false;
             }
         }

         function HideLabel() {
           
             document.getElementById('<%= lblDeactiveMsg.ClientID %>').style.display = "none";
         }
         setTimeout("HideLabel();", 4000);

         $(document).ready(function () {
             $("#Add_Employee").click(function () {
                 $("#AddEmployeeModal").show();
             });
         });
         
    

         $(document).ready(function () {
             $("#Cancel_AddEmployee").click(function () {
                 $("#AddEmployeeModal").hide();
                 $("input:text").val("");
                 $("#lblstatus").html('');
             });
         });
            $(document).ready(function () {
             $("#Cancel_cross").click(function () {
                 $("#AddEmployeeModal").hide();
                 $("input:text").val("");
                 $("#lblstatus").html('');
             });
         });

         $(document).ready(function () {
             $("#Edit_Cancel").click(function () {
                 $("#myModalEditPopup").hide();
                 $("#EditHiddenID").val("");
                 $("#lblEditEmpMobChck").html('');
                 
             });

             $("#btnActivateCancel,#Cancel_decativate").click(function () {
                 $("#confirmActivate").hide();
                 $("#HiddenEmpDeactiveID").val("");
                 $("#HiddenEmpUserID").val("");
                 return false;
             });
           
         });

         
         $(document).ready(function () {
             $("#btnDactiveEmpCancel,#Cancel_delete").click(function () {
                 $("#confirmBox").hide();
                 $("#HiddenEmpDeactiveID").val("");

             });
         });

         $(document).ready(function () {
             $("#btnDeactiveEmpConfirm").click(function () {
                 $("#confirmBox").hide();
                 $("#HiddenEmpDeactiveID").val("");
             });
         });

         function CloseAddEmployee()
         {
             $("#AddEmployeeModal").hide();
         }

         
         function EmployeeAdded(result) {
             
             if (result == 'true') {
                 $("#AddEmployeeModal").hide();
                 alert("Employee Added Successfully");
             }
             else if (result = 'false') {
                  alert("Employee Could not be added");
             }

         }

         function ShowEditForm(UserID, FirstName,LastName,Email,MobileNo)
         {
             $("#HiddenEmpUserID").val(UserID);
             $("[id*=txtEmpFname]").val(FirstName);
             $("[id*=txtEmpLname]").val(LastName);
            // $("[id*=txtAddress]").val(Address);
             $("[id*=txtEditEmpMobile]").val(MobileNo);
             $("[id*=txtEditEmpEmail]").val(Email);
           
             $("#myModalEditPopup").show();

         }

         function ShowDeativeForm(UserID)
         {
             
             $("#HiddenEmpUserID").val(UserID);
             $("#HiddenEmpDeactiveID").val(UserID);
             $("#confirmBox").show();
         }
        
         function ShowActivateForm(UserID) {

             $("#HiddenEmpUserID").val(UserID);
             $("#HiddenEmpDeactiveID").val(UserID);
             $("#confirmActivate").show();
         }
             $(document).ready(function () {
             $("#edit_cross").click(function () {
                 $("#myModalEditPopup").hide();
                 $("#EditHiddenID").val("");
                 $("#lblEditEmpMobChck").html('');
                 
             });
                  });

   </script>

    <style>
           .selected_row
        {

            color:#579ed4;
        }

         .lbltxt{
          padding-left:3%;
          font-size:small;
               }

       .modal {
            display: none;  /*  Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 2%; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto;  /*Enable scroll if needed  */
            background-color: #e6e2e2;
            background-color: rgba(0,0,0,0.4); 
        }


.confirmBox
{
    display: none; 
    position: fixed;
    width: 300px;
    left: 45%;
    top:20%;
    margin-left: -150px;
  
    
    text-align: center;
   
}
#confirmBox button:hover
{
   
}
 .message
{
    text-align: center;
    color:#f2eeee;
    padding:2% 0 2% 0;
    margin-bottom: 8px;
    
    font-size:medium;
    font-family:'Bookman Old Style';
    background-color:#286090;
       
}
 .message_Below{

     text-align:center;
     padding:3% 0 5% 0;
    
     color:#000;
 }
  .form-control {
            display: inline;
            width: 41%;
            margin-left:-5px;
            border-radius: 1px;

        }


    </style>
         

</head>
 <body  style="background-color:#f7f7f7;">

         <div class="container-fluid">
             <div class="row">
           <div class="col-md-10">      

    <form id="form1" runat="server">
        
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container-fluid">
         <div class="row" style="height:55px; margin-top:15px;">
                                     <div class="col-sm-3 hidden-xs" >
                                         <h4 class="pull-left " style="margin:0px;">Employee :</h4>
                                     </div>
                                     <div class="col-sm-6 col-xs-12"  >
                                         
                                          <div class="form-group">
                                                 <asp:DropDownList ID="drpEmpServtFilter" runat="server" CssClass="form-control" >
                                                                           
                                                                        </asp:DropDownList>
                            
                                                    <asp:TextBox ID="txtEmpNamesrch" runat="server"  placeholder="First Name" CssClass="form-control" ValidationGroup="Search"></asp:TextBox>
                                                       <asp:LinkButton runat="server"  CausesValidation="false" OnClick="ImgFlatSearch_Click"> <span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                                 
                                          
                        
                                             </div>




                                      </div>
                                     <div class="col-sm-3 hidden-xs" style="vertical-align:middle;">
                                       
                                               <button type="button" id="Add_Employee" style="margin:0px;"  class="btn btn_my btn-primary"><i class="fa fa-plus"></i> Add Employee</button>
                                       
                                     </div>
                         </div>
     

        <div id="confirmBox" class="modal"  style="z-index:10;">
            <div class="container-fluid " style="width:355px;margin-top:80px;">
                <div class="panel panel-primary">
                   <div class="panel-heading">
                        Delete Confirmation
                        <span class="fa fa-times" id="Cancel_delete" style="float:right;cursor:pointer;"></span>
                    </div>
                    <div class="panel-body">

                        <table class="layout_data_table">
                            <tr>
                                <td colspan="2" style="text-align: center;">You  are about  to  Deactivate  Employee,  it  will permanantly  Deactivated from database Continue ?
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 15px;"></td>
                            </tr>




                        </table>
                    </div>
                    <div class="panel-footer" style="text-align:right;">
                        <asp:Button ID="btnDeactiveEmpConfirm" CausesValidation="false" CssClass="btn btn-primary" runat="server" OnClick="btnDeactiveEmpConfirm_Click" Text="Yes" />
                        <button type="button" id="btnDactiveEmpCancel" class="btn btn-danger">No</button>
                    </div>
                </div>
                </div>
            </div>  
            </div>         

      
         <div id="confirmActivate" class="modal"  style="z-index:10;">
            <div class="container-fluid layout_shadow_box zero-margin" style="width:355px;margin-top:150px;">
                <div class="panel panel-primary" style="position: relative; margin: 0px;">
                    <div class="panel-heading">
                        Activate Confirmation
                        <span class="fa fa-times" id="Cancel_decativate" style="float:right;cursor:pointer;"></span>
                    </div>
                    <div class="panel-body">

                        <table class="layout_data_table">
                            <tr>
                                <td colspan="2" style="text-align: center;">You  are about  to  Activate  Employee,  Please Confirm ?
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 15px;"></td>
                            </tr>




                        </table>
                    </div>
                    <div class="panel-footer" style="text-align:right;">
                          <asp:Button ID="Button2" CausesValidation="false" CssClass="btn btn-primary"  runat="server"  OnClick="btnActivateConfirm_Click" Text="Yes" />
                                  <button id="btnActivateCancel" type="button" class="btn btn-danger">No</button> 
                    </div>
                </div>
            </div>  
            </div>
          
     <table style="width:100%; margin:10px;">
 
         <tr>
             <td colspan="9" style="text-align:center;">
                 <asp:Label ID="lblDeactivestatus" runat="server" Font-Size="Small" ForeColor="#5BADFF"></asp:Label>
             </td>
         </tr>
         
         <tr>
         <td >  </td>
             <td colspan="5" >


                    <asp:GridView ID="EmployeeGrid" runat="server" 
                        AutoGenerateColumns="false" 
                        EmptyDataText="No Records Found" Width="100%"
                        HorizontalAlign="Center" AllowPaging="true"
                        HeaderStyle-BackColor="#6eab91" 
                        HeaderStyle-BorderStyle="None"
                        RowStyle-Width="100px"
                       
                        BorderStyle="None"
                        GridLines="None"
                        ShowHeader="false"
                        OnPageIndexChanging="EmployeeGrid_PageIndexChanging" 
                        EmptyDataRowStyle-BorderColor="ActiveBorder" 
                        ShowHeaderWhenEmpty="True" 
                        OnSelectedIndexChanged="EmployeeGrid_SelectedIndexChanged" 
                        ForeColor="#666666" Font-Names="Calibri" OnRowDataBound="Employee_RowDataBound">
                       
                         <AlternatingRowStyle BackColor="#f7f7f7" />
                        <Columns>
                          
                            <%--<asp:BoundField DataField="UserID" HeaderText="ID" ControlStyle-CssClass="extra"  ItemStyle-Width="50px" HeaderStyle-Width="50px">
                                 <ItemStyle Width="50px"></ItemStyle>
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Name" >
                                    <ItemTemplate>
                                         
                                    </ItemTemplate>
                             </asp:TemplateField>--%>


                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div class="row layout_shadow_table">
                                     <div class="col-xs-4" style="padding:10px;text-align:left;">
                                    <img src='<%# "GetImages.ashx?ResID="+ Eval("UserID")+"&Name="+Eval("FirstName") +"&UserType=Employee"%>' height="40" width="40" style="border-radius:50%;" /> <br /> 
                                      <asp:Label ID="Label2" runat="server" Text='<%#Eval("FirstName")+ " " + Eval("LastName")%>' ></asp:Label> <br /> 
                                  
                                    <asp:Label ID="lblName" runat="server" Text='<%#Eval("MobileNo")%>' ></asp:Label>
                                    
                                     </div>

                                        <div class="col-xs-4" style="padding:10px;text-align:left;">
                                            <%#Eval("Emailid")%><br />
                                           Company : <%#Eval("CompanyName")%><br />
                                             <%#Eval("CompType")%>
                                         <%#Eval("Address")%>
                                        
                                     </div>

                                        <div class="col-xs-4" style="padding:10px;text-align:left;">
                                          Form:<asp:Label ID="Label6"  runat="server" Text='<%# "Active Date " + Eval("ActiveDate","{0:dd MMM,yy}")%>' ></asp:Label><br />
                                          <asp:Label ID="Label7" runat="server" Text='<%# "Till: " + Eval("DeActiveDate","{0:dd MMM,yy}")%>' >Till</asp:Label><br />
                                         <button id="button" onclick="ShowDialog('<%# Eval("UserID") %>' , '<%# Eval("FirstName") %>'  ,'<%# Eval("DeActiveDate") %>'  ,this)" type="button" style="display:none;  background-color:transparent;border:none;outline:0; height:20px;background-repeat:no-repeat;">
                                         <i class="fa fa-angle-double-right" id="left_icon" style="color:gray;   font-size:20px"></i>  </button>
                                        <button id="btnEmployeeEdit" runat="server" type="button" class="btn btn-info btn-sm" onclick='<%#"ShowEditForm(" + Eval("UserID")+",\""+ Eval("FirstName") +"\",\""+ Eval("LastName")+"\",\""+ Eval("Emailid")+"\",\""+ Eval("MobileNo") + "\")"%>'   >Edit</button>
                                        <button id="btnEmployeeActivate" runat="server" type="button" class="btn btn-success btn-sm" onclick='<%# "ShowActivateForm("+ Eval("UserID") +")"%>'>Activate</button>
                                        <button id="btnEmployeeDeActivate" runat="server" type="button" class="btn btn-danger btn-sm" onclick='<%# "ShowDeativeForm("+ Eval("UserID") +")"%>' >De-Activate</button>
                                             
                                     </div>

                                    </div>


                                </ItemTemplate>

                            </asp:TemplateField>
                       
                         <%--  <asp:BoundField DataField="MobileNo" HeaderText="MobileNo" ItemStyle-Width="100px" HeaderStyle-Width="100px"/>
                 
                        <asp:BoundField DataField="Emailid" HeaderText="Emailid"  ItemStyle-Width="150px" HeaderStyle-Width="150px"/>
                     
                        <asp:BoundField DataField="CompanyName" HeaderText="Company" ItemStyle-Width="100px" HeaderStyle-Width="100px"/>
                        
                        <asp:BoundField DataField="ServiceType" HeaderText="Service"  ItemStyle-Width="150px" HeaderStyle-Width="100px"/>                     
                          
                        <asp:BoundField DataField="ActiveDate" HeaderText="ActiveDate"  HeaderStyle-Width="150px" DataFormatString="{0:dd/MMM/yyyy}" ItemStyle-Font-Size="small" />
                            
                        <asp:BoundField DataField="DeActiveDate" HeaderText="DeActiveDate" HeaderStyle-Width="150px" DataFormatString="{0:dd/MMM/yyyy}" ItemStyle-Font-Size="small"/>                         
                        
                        <asp:TemplateField>
                           <ItemTemplate>   
                                                                       
                           </ItemTemplate>
                        </asp:TemplateField>--%>
                         </Columns>


                         <PagerSettings Mode="NumericFirstLast" />
                        <PagerStyle BackColor="#f7f7f7" BorderColor="#F0F5F5" Font-Bold="False" HorizontalAlign="Center" ForeColor="#62BCFF" Font-Names="Berlin Sans FB" Font-Size="Medium" VerticalAlign="Bottom" />
                            <RowStyle HorizontalAlign="Center" />
                   </asp:GridView>   
             </td>
              <td style="width:2%;">                                              
                          <div id="dropdown-menu" class="layout-dropdown-content theme-dropdown-content">             
                            <asp:Button ID="btnEmployeesEdit" runat="server" Text="Edit"   CssClass="layout_dropdown_Button"  OnClick="btnEmployeesEdit_Click"  />
                               <asp:Button ID="btnEmployeesDeactive" runat="server" Text="Deactivate"   CssClass="layout_dropdown_Button"   EnableViewState="False" OnClick="btnEmployeesDeactive_Click" />
                          </div>
                    

                  <asp:HiddenField ID="HiddenEmpUserID" runat="server" />
                  <asp:HiddenField ID="HiddenEmpFName" runat="server" />
                  <asp:HiddenField ID="EditHiddenID" runat="server" />
                  <asp:HiddenField ID="HiddenEmpDeactiveID" runat="server" />
                  <asp:HiddenField ID="HiddenDeactivedate" runat="server" />
                  <asp:HiddenField ID="HiddenScreenSize" runat="server" />

             </td>
         </tr>
         <tr style="height:30px;">

             <td  colspan="7" style="text-align:center;">  
                     <asp:Label ID="lblDeactiveMsg" runat="server" Font-Size="Small" ForeColor="#53A9FF"></asp:Label>
             </td>
         </tr>

          <tr style="height:15px;">
             <td colspan="7" style="text-align:center;">
                 
                   <asp:Label ID="lblTotalEmployees" runat="server" ForeColor="#4774d1" Text=""></asp:Label>   
             </td>
         </tr>

         <tr>
             <td colspan="7" style="text-align:center;"> 
                 <asp:Button ID="btnEmpShwall" runat="server" CssClass="btn_style" OnClick="btnEmpShwall_Click" Text="Show All" />
             </td>
         </tr>

        </table>  

     

           <%----------------------------------------------------------------------------------Add Employee Section Starts From here------------------------------------------------------  --%>
         <div id="AddEmployeeModal" class="modal">
             <asp:UpdatePanel ID="UpdatePanel15" runat="server" EnableViewState="true">
                            <ContentTemplate>
               <div class="container-fluid" style="width:400px;">
                   <div class="panel panel-primary" style="position:absolute;">

                    <div class="panel-heading" style="height:40px;">
                        
                         <span>Add Employee</span>
                         <span class="fa fa-times" id="Cancel_cross" style="float:right;cursor:pointer;"></span>
                 
                    </div>
                       <div class="panel-body">
                         


                   <div class="row">
                   
                        <div class="col-xs-12" style="display:none;">
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Enter valid name" ValidationExpression="^[a-zA-Z0-9.@]{0,25}$" Font-Size="Small" ForeColor="#FF5050" ControlToValidate="txtAddEmpFName" ValidationGroup="Add_Employee" Display="Dynamic"></asp:RegularExpressionValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Enter valid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Font-Size="Small" ForeColor="#FF5050" ControlToValidate="txtAddEmpEmailId" ValidationGroup="Add_Employee" Display="Dynamic"></asp:RegularExpressionValidator> 
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ValidationExpression="^([0-9]{10})+$" ErrorMessage="Please enter valid  number" Font-Size="Small" ForeColor="#FF5050" ControlToValidate="txtAddEmpMobile" ValidationGroup="Add_Employee" Display="Dynamic"></asp:RegularExpressionValidator> 
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Enter valid name" ValidationExpression="^[a-zA-Z0-9.@]{0,25}$" Font-Size="Small" ForeColor="#FF5050" ControlToValidate="txtAddEmpLName" ValidationGroup="Add_Employee" Display="Dynamic"></asp:RegularExpressionValidator>
                            
                            <asp:Label ID="lblEmpError" runat="server" Font-Size="Small" ForeColor="#48A4FF"></asp:Label><br />
                  
                        </div>
                    
                        <div class="col-md-6" >
                            <span style="text-align:center;font-size:16px;color:cornflowerblue;">User Details</span>
                            <table class="layout_data_table" style="line-height:30px;text-align:left;">
                                  <tr>
                                        <td style="width:100px;">
                                           Mobile :
                                        </td>
                                         <td style="width:100px;">
                                           <asp:TextBox ID="txtAddEmpMobile" runat="server" Height="25px" TabIndex="0" AutoCompleteType="Disabled" MaxLength="10" 
                                               OnTextChanged="txtAddEmpMobile_TextChanged" AutoPostBack="True"></asp:TextBox>
                                         </td>
                                         <td style="width:5px;">
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="txtAddEmpMobile" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Add_Employee">

                                             </asp:RequiredFieldValidator>   
                                         </td>
                                    </tr>
                                 <tr>
                                        <td style="width:100px;">
                                           Email :
                                        </td>
                                         <td style="width:100px;">
                                           <asp:TextBox ID="txtAddEmpEmailId" runat="server" Height="25px" AutoCompleteType="Disabled" TabIndex="1" OnTextChanged="txtAddEmpEmailId_TextChanged" AutoPostBack="True"></asp:TextBox> <br />
                                         </td>
                                         <td style="width:5px;">
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="#FF5050" ControlToValidate="txtAddEmpEmailId" ValidationGroup="Add_Employee"></asp:RequiredFieldValidator>              
                                         </td>
                                    </tr>
                               <tr>
                                        <td style="width:110px;">
                                           First Name :
                                        </td>
                                         <td style="width:100px;">
                                           <asp:TextBox ID="txtAddEmpFName" runat="server" Height="25px" TabIndex="2"></asp:TextBox>
                                         </td>
                                         <td style="width:5px;">
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="#FF5050" ControlToValidate="txtAddEmpFName" ValidationGroup="Add_Employee"></asp:RequiredFieldValidator>
                                         </td>
                                    </tr>

                                   <tr style="display:none;">
                                        <td style="width:100px;">
                                           Middle Name :
                                        </td>
                                         <td style="width:100px;">
                                           <asp:TextBox ID="txtAddEmpMName" runat="server" Height="25px"  TabIndex="3"></asp:TextBox>
                                         </td>
                                         <td style="width:5px;">
                                             
                                         </td>
                                    </tr>
                                   <tr>
                                        <td style="width:100px;">
                                           Last Name :
                                        </td>
                                         <td style="width:100px;">
                                           <asp:TextBox ID="txtAddEmpLName" runat="server" Height="25px" TabIndex="4"></asp:TextBox>
                                         </td>
                                         <td style="width:5px;">
                                              <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtAddEmpLName" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Add_Employee"></asp:RequiredFieldValidator>
                                         </td>
                                    </tr>
                                   <tr>
                                        <td style="width:100px;">
                                           Gender :
                                        </td>
                                         <td style="width:100px;">
                                            <asp:DropDownList ID="drpAddempGender" runat="server" Height="25px" Width="100%" TabIndex="5">
                                                <asp:ListItem>Male</asp:ListItem>
                                                <asp:ListItem>Female</asp:ListItem>
                                            </asp:DropDownList>
                                         </td>
                                         <td style="width:5px;">
                                             
                                         </td>
                                    </tr>
                                   <tr>
                                        <td style="width:100px;">
                                           Parent Name :
                                        </td>
                                         <td style="width:100px;">
                                           <asp:TextBox ID="txtAddempPName" runat="server" Height="25px" TabIndex="6"></asp:TextBox>
                                         </td>
                                         <td style="width:5px;">
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="txtAddempPName" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Add_Employee"></asp:RequiredFieldValidator>
                                         </td>
                                    </tr>
                                    <tr style="display:none;">
                                            <td style="width:100px;">
                                           UserType:
                                            </td>
                                             <td style="width:100px;">
                                                    <asp:DropDownList ID="drpAddEmpUserType" runat="server" Height="25px" TabIndex="7">
                                                        <asp:ListItem>Employee</asp:ListItem>
                                                    </asp:DropDownList>
                                             </td>
                                             <td style="width:5px;">
                                             
                                             </td>
                                    </tr>
                            </table>
                            </div>

                         <div class="col-md-6" style="text-align:left;">
                            <table class="layout_data_table" style="line-height:30px;">
                                  
                                 
                                   <tr>
                                        <td style="width:100px;">
                                           Address :
                                        </td>
                                         <td style="width:100px;">
                                           <asp:TextBox ID="txtAddEmpAddress" runat="server" Height="25px" TabIndex="8"></asp:TextBox>
                                         </td>
                                         <td style="width:5px;">
                                             
                                         </td>
                                    </tr>
                                   <tr style="display:none;">
                                        <td style="width:100px;">
                                           Userlogin :
                                        </td>
                                         <td style="width:100px;">
                                           <asp:TextBox ID="txtEmpUsrid" runat="server" Height="25px" TabIndex="9" OnTextChanged="txtEmpUsrid_TextChanged" AutoPostBack="True"></asp:TextBox>
                                         </td>
                                         <td style="width:5px;">
                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtEmpUsrid" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Add_Employee"></asp:RequiredFieldValidator>--%>
                                         </td>
                                    </tr>
                             
                                   
                                        <hr />
                                  <tr>
                                <span style="text-align:center;font-size:16px;padding-left: 112px;color:cornflowerblue;">Employee Details</span>
                                   
                                </tr>
                                   <tr>
                                        <td style="width:110px;">
                                           Company Name :
                                        </td>
                                         <td style="width:100px;">
                                            <asp:TextBox ID="txtAddempCompName" runat="server" Height="25px" OnTextChanged="txtAddempCompName_TextChanged" TabIndex="10"></asp:TextBox>
                                         </td>
                                         <td style="width:5px;">
                                             
                                         </td>
                                    </tr>
                                <tr>
                                        <td style="width:100px;">
                                           Service Type :
                                        </td>
                                         <td style="width:100px;">
                                            <asp:DropDownList ID="drpAddEmpSType" runat="server" Height="25px" Width="100%" TabIndex="11">
                                            </asp:DropDownList>
                                         </td>
                                         <td style="width:5px;">
                                              <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ControlToValidate="drpAddEmpSType" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Add_Employee" InitialValue="NA"></asp:RequiredFieldValidator>
                                         </td>
                                    </tr>
                            </table>
                            </div>
                   
                   </div>
                     
                    </div>
                        <div class="panel-footer" style="text-align:right;margin-top:5px;">
                            <asp:Button ID="btnAddEmpSubmit" runat="server" CssClass="btn btn-primary" Text="Submit" OnClick="btnAdduserres_Click" TabIndex="15" CausesValidation="true" ValidationGroup="Add_Employee" />
                             <button type="button" id="Cancel_AddEmployee"  class="btn btn-danger">Cancel</button>
                        </div>
                        
                    
                           
                   </div>
             </div>
  </ContentTemplate>
                        </asp:UpdatePanel>
             </div>
    


        <%-------------------------------------------------------------------------------------- Edit Employee Section Starts from here --------------------------------------------------------------------- %>
        <%--  <asp:Button ID="btnAddEmpcancel" runat="server" CssClass="btn_style" Text="Cancel" CausesValidation="False" TabIndex="16" OnClick="btnusercancel_Click" />--%>
        <div id="myModalEditPopup" class="modal">
            <div class="container-fluid zero-margin" style="width:300px;margin-top:60px;">
                   <div class="panel panel-primary" style="position:relative; margin:0px;">
               <div class="panel-heading">
                  <span style="text-align:left;"> Edit Employee </span>
                   <span class="fa fa-times" id="edit_cross" style="float:right;cursor:pointer;"></span>
               </div>
         <table   class="layout_data_table" style="line-height:30px;">
            

            
        <tr>
            <td colspan="4" style="height:15px;">
                 
            </td>
        </tr>

         <tr>
             <td class="lbltxt" style="width:25%; font-size:15px;  padding-left:5%;">
              First Name :</td>
             <td style="width:25%;">
                 <asp:TextBox ID="txtEmpFname" runat="server" CssClass="txtbox_style" ValidationGroup="Edit_Employee"></asp:TextBox><br />
                 <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="txtEmpFname" ErrorMessage="Enter valid name" Font-Size="Small" ForeColor="#FF5050" ValidationExpression="^[a-zA-Z0-9.@]{0,25}$" ValidationGroup="Edit_Employee" Display="Dynamic"></asp:RegularExpressionValidator>
             </td>
             <td style="width:1%;">
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEmpFname" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Edit_Employee"></asp:RequiredFieldValidator>
             </td>
             <td style="width:1%;">
                 
             </td>
         </tr>

          <tr>
             <td class="lbltxt" style="width:25%; font-size:15px;  padding-left:5%;">
                Last Name :</td>
             <td>
                 <asp:TextBox ID="txtEmpLname" runat="server" CssClass="txtbox_style" ValidationGroup="Edit_Employee"></asp:TextBox><br />
                 <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ControlToValidate="txtEmpLname" ErrorMessage="Enter valid name" Font-Size="Small" ForeColor="#FF5050" ValidationExpression="^[a-zA-Z0-9.@]{0,25}$" ValidationGroup="Edit_Employee" Display="Dynamic"></asp:RegularExpressionValidator>

             </td>
             <td>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtEmpLname" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Edit_Employee"></asp:RequiredFieldValidator>
             </td>
             <td>
                 
              </td>
         </tr>

         <tr>
             <td class="lbltxt" style="width:25%; font-size:15px;  padding-left:5%;">
                Addess :             </td>
             <td>
                  <asp:TextBox ID="txtAddress" runat="server" CssClass="txtbox_style" ValidationGroup="Edit_Employee"></asp:TextBox>
             </td>
             <td>

             </td>
             <td>

             </td>
         </tr>


          <tr>
            <td class="lbltxt" style="width:25%; font-size:15px;  padding-left:5%;">
               MobileNo :</td>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                        <ContentTemplate>
                              <asp:TextBox ID="txtEditEmpMobile" runat="server"  CssClass="txtbox_style" OnTextChanged="txtEditEmpMobile_TextChanged"  ValidationGroup="Edit_Employee"></asp:TextBox><br />
                            <asp:Label ID="lblEditEmpMobChck" runat="server" Font-Size="Small" ForeColor="#FF5050"></asp:Label>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidatoreditemp" runat="server" ForeColor="#FF5050" ErrorMessage="Enter valid  No." ControlToValidate="txtEditEmpMobile" ValidationExpression="^[01]?[- .]?(\([2-9]\d{2}\)|[2-9]\d{2})[- .]?\d{3}[- .]?\d{4}$" Display="Dynamic" Font-Size="Small" ></asp:RegularExpressionValidator>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                
                </td>
              <td>
                  <asp:RequiredFieldValidator ID="RequireEditEmpMobile" runat="server" ControlToValidate="txtEditEmpMobile" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Edit_Employee"></asp:RequiredFieldValidator>
                      </td>
              <td>   </td>       
           </tr>
        <tr>
            <td class="lbltxt" style="width:25%; font-size:15px;  padding-left:5%;">
                Email :</td>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel9" runat="server">
                        <ContentTemplate>
                             <asp:TextBox ID="txtEditEmpEmail" runat="server"  CssClass="txtbox_style" OnTextChanged="txtEditEmpEmail_TextChanged"  AutoPostBack="True" ValidationGroup="Edit_Employee"></asp:TextBox><br />
                            <asp:Label ID="lblEditEmailCheck" runat="server" Font-Size="Small" ForeColor="#FF5050"></asp:Label>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server" ErrorMessage="Enter valid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Font-Size="Small" ForeColor="#FF5050" ControlToValidate="txtEditEmpEmail" Display="Dynamic"></asp:RegularExpressionValidator>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                 
                </td>
              <td>
                  <asp:RequiredFieldValidator ID="RequireEditEmpEmail" runat="server" ControlToValidate="txtEditEmpEmail" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Edit_Employee"></asp:RequiredFieldValidator>
                </td>
            <td>   </td>
            </tr>
         <tr>
             <td colspan="4" style="width:25%; font-size:15px;  padding-left:5%;">
             </td>
         </tr>
         <tr>
             <td colspan="4" style="height:15px;text-align:center;">
                 <asp:Label ID="lblEditEmpstatus" runat="server" ForeColor="#51A8FF"></asp:Label>
             </td>
         </tr>
        
            
           
       </table>
 <div class="panel-footer" style="text-align:right;">
                   <asp:Button ID="btneditEmp" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="btneditEmp_Click" ValidationGroup="Edit_Employee"/>
                
                     <button type="button" id="Edit_Cancel" class="btn btn-danger">Cancel</button>
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
