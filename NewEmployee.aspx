<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewEmployee.aspx.cs" Inherits="NewEmployee" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
     
     <script src="Scripts/jquery-1.12.0.js"></script>

    <link rel="stylesheet" href="CSS/mystylesheets.css" />
   
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- jQuery library -->
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
   
    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css"/>  

    <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js"></script>  
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>  
    <link rel="Stylesheet" href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.10/themes/redmond/jquery-ui.css" /> 

      

    <script>


        function ShowAddEmployee() {
          
            //$("[id*=newOwnerMobile]").val("");
            //$("[id*=newOwnerEmail]").val("");
            //$("[id*=newOwnerName]").val("");
            //$("[id*=newOwnerParentName]").val("");
            //$("[id*=newOwnerAddress]").val("");

            //$("[id*=assignFlatNumber]").val("");
            //$("[id*=assignFlatArea]").val("");
            //$("[id*=assignFlatBHK]").val("");
            //$("[id*=assignFlatBlock]").val("");
            //$("[id*=assignFlatFloor]").val("");
            $("#addEmployeeModal").show();
        }

        function hideAddEmployeeModal() {
               $("#addEmployeeModal").hide();
        }

        function ShowRemoveForm(ResID,FirstName,LastName,CompType)
        {
            $("[id*=HiddenField1]").val(ResID);
             $("#lblEmployeeName").text(FirstName + " " + LastName);
             $("#lblServiceType").text(CompType);
            
              $("#removeEmployee").show();

        }

        function hideRemoveEmployeeModal() {
             $("#removeEmployee").hide();
        }

    </script>

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
</head>
<body>
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
                               <asp:DropDownList ID="drpServiceTypeFilter" runat="server" CssClass="form-control" >                                                                          
                                                 </asp:DropDownList>
                            </div>
                            <div class="col-sm-4 zero-margin" style="margin-left: -3px;">
                                <asp:TextBox ID="txtEmployeeFilter" placeholder="First Name" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-sm-4 col-xs-6 zero-margin">
                                <asp:LinkButton ID="btnEmployeeSearch" runat="server" BackColor="Transparent" CausesValidation="false" ForeColor="Black" OnClick="btnEmployeeSearch_Click"> 
                                <span class="glyphicon glyphicon-search" style="background-color: #607d8b; padding: 10px; margin-left: -3px; top: 0px !important;"></span></asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-2 col-xs-12" style="vertical-align: middle;">
                    <div style="align-content">
                        <button id="Add_Employee_New" type="button" class="btn-sm btn btn-primary pull-right" onclick="ShowAddEmployee();" style="cursor: pointer; margin-right: 30px;"><i class="fa fa-plus"></i>Add Employee</button>
                    </div>
                </div>
            </div>
            
            <div class="col-sm-12" style="font-size: 20px !important; font-family: 'Times New Roman', Times, serif !important; color: red; text-align: center;">
                <asp:Label ID="lblFlatGridEmptyText" runat="server"></asp:Label><br />
            </div>
            
            <br />


             <div class="container-fluid zero-margin" style="padding-bottom: 10px;">
                <div class="col-xs-12 col-sm-12">

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
                        EmptyDataRowStyle-BorderColor="ActiveBorder" 
                        ShowHeaderWhenEmpty="True" 
                        ForeColor="#666666" Font-Names="Arial">
                       
                         <AlternatingRowStyle BackColor="#f7f7f7" />
                        <Columns>                                    
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div class="row layout_shadow_table">
                                     <div class="col-sm-4 col-xs-12" style="padding:10px;text-align:left;">

                                    <img src='<%# "GetImages.ashx?Type=Resident&ID="+ Eval("UserID")+"&Name="+Eval("FirstName") %>' height="40" width="40" style="border-radius:50%;" /> <br /> 
                                      <asp:Label ID="Label2" runat="server" Text='<%#Eval("FirstName")+ " " + Eval("LastName")%>' ></asp:Label> <br /> 
                                    <asp:Label ID="lblName" runat="server" Text='<%#Eval("MobileNo")%>' ></asp:Label>
                                     </div>

                                        <div class="col-sm-4 col-xs-12" style="padding:10px;text-align:left;">
                                            
                                        <span class="fa fa-user" style="color:black;"></span>&nbsp;&nbsp;Email : <%#Eval("Emailid")%><br />
                                        <span class="fa fa-building" style="color:black;"></span>&nbsp;&nbsp;Type : <%#Eval("CompType")%><br />
                                        <span class="fa fa-info-circle" style="color:black;"></span>&nbsp;&nbsp;Assigned: <%#Eval("AssignmentCount")%>
                                       
                                        </div>

                                        <div class="col-sm-4 col-xs-12" style="padding:10px;text-align:left;">

                                          <asp:Label ID="Label6"  runat="server" Text='<%# "From " + Eval("DeActiveDate","{0:dd MMM,yy}")%>' ></asp:Label><br />
                                          <asp:Label ID="Label7" runat="server" Text='<%# "Till: " + Eval("DeActiveDate","{0:dd MMM,yy}")%>' >Till</asp:Label><br />
                                         <button id="button" onclick="ShowDialog('<%# Eval("UserID") %>' , '<%# Eval("FirstName") %>'  ,'<%# Eval("DeActiveDate") %>'  ,this)" type="button" style="display:none;  background-color:transparent;border:none;outline:0; height:20px;background-repeat:no-repeat;">
                                         <i class="fa fa-angle-double-right" id="left_icon" style="color:gray;   font-size:20px"></i>  </button>
                                       <%-- <button id="btnEmployeeEdit" runat="server" type="button" class="btn btn-info btn-sm" onclick='<%#"ShowEditForm(" + Eval("UserID")+",\""+ Eval("FirstName") +"\",\""+ Eval("LastName")+"\",\""+ Eval("Emailid")+"\",\""+ Eval("MobileNo") + "\")"%>'   >Edit</button>
                                        <button id="btnEmployeeActivate" runat="server" type="button" class="btn btn-success btn-sm" onclick='<%# "ShowActivateForm("+ Eval("UserID") +")"%>'>Activate</button>--%>
                                        <button id="btnEmployeeDeActivate" runat="server" type="button" class="btn btn-danger btn-sm" onclick='<%# "ShowRemoveForm("+ Eval("ResID") +",\""+ Eval("FirstName") +"\",\""+ Eval("LastName")+"\",\""+ Eval("CompType")+"\")"%>' >Remove</button>
                                             
                                     </div>

                                    </div>


                                </ItemTemplate>

                            </asp:TemplateField>
                       
                      
                         </Columns>


                         <PagerSettings Mode="NumericFirstLast" />
                        <PagerStyle BackColor="#f7f7f7" BorderColor="#F0F5F5" Font-Bold="False" HorizontalAlign="Center" ForeColor="#62BCFF" Font-Names="Berlin Sans FB" Font-Size="Medium" VerticalAlign="Bottom" />
                            <RowStyle HorizontalAlign="Center" />
                   </asp:GridView>   


                    <div class="row">
                        <div class="col-xs-4" style="text-align: center; padding: 8px;">
                            <%--<asp:Button ID="btnprevious" CausesValidation="false" runat="server" Font-Bold="true" Text="Prev" Height="31px" Width="60px" 
                                OnClick="btnprevious_Click" />--%>
                        </div>
                        <div class="col-xs-4">
                            <asp:Label ID="lblPage" runat="server" Font-Size="Small" ForeColor="#f9f9f9f"></asp:Label>
                        </div>
                        <div class="col-xs-4" style="text-align: center; padding: 8px;">
                           <%-- <asp:Button ID="btnnext" CausesValidation="false" runat="server" Font-Bold="true" Text="Next" Height="31px" Width="60px" 
                                OnClick="btnnext_Click" />--%>
                        </div>
                    </div>



                </div>

            </div>



               <div class="modal" id="addEmployeeModal">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" EnableViewState="true">
                    <ContentTemplate>
                        <div class="container-fluid">
                            <div class="panel panel-primary" style="width: 520px; background-color: #f2f2f2; margin: auto;">
                                <div class="panel-heading">
                                    Add Employee
                               <span class="fa fa-close" onclick="hideAddEmployeeModal()" style="color: white; float: right; cursor: pointer;"></span>

                                </div>
                                <div class="panel-body" style="background-color: #fff;">
                                    <div class="row" style="border-top-left-radius: 10px;">
                                        <b>User Details:</b>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6 col-xs-12">
                                            <label style="width: 100px;">
                                            Mobile :
                                            </label>
                                            <asp:TextBox ID="employeeMobile" runat="server" AutoPostBack="True" Height="25px" MaxLength="10" onkeypress="return isNumberKey(event)" OnTextChanged="txtEmployeeMobile_TextChanged" TabIndex="1" Width="100px"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-6 col-xs-12">
                                            <label style="width: 100px;">
                                            Email :
                                            </label>
                                            <asp:TextBox ID="employeeEmail" runat="server" AutoPostBack="True" Height="25px" OnTextChanged="txtEmployeeEmail_TextChanged" TabIndex="2" Width="100px"></asp:TextBox>
                                            <span style="display: none;">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="employeeEmail" ErrorMessage="*" ForeColor="Red" ValidationGroup="Add_Flat"></asp:RequiredFieldValidator>
                                            </span>
                                        </div>
                                    </div>
                                    <asp:Label ID="lblUserCheck" runat="server"></asp:Label>
                                    <hr />
                                    <div class="row">
                                        <div class="col-sm-6 col-xs-12">
                                            <label style="width: 100px;">
                                            Name :
                                            </label>
                                            <asp:TextBox ID="employeeName" runat="server" BorderWidth="0" Height="25px" ReadOnly="true" TabIndex="0" Width="100px"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-6 col-xs-12">
                                            <label style="width: 100px;">
                                            Parent Name :
                                            </label>
                                            <asp:TextBox ID="employeeParentName" runat="server" BorderWidth="0" Height="25px" ReadOnly="true" TabIndex="0" Width="100px"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label style="width: 100px;">
                                            Address :
                                            </label>
                                            <asp:TextBox ID="employeeAddress" runat="server" BorderWidth="0" Height="42px" ReadOnly="true" TabIndex="0" Width="100px"></asp:TextBox>
                                        </div>
                                    </div>
                                    <hr />
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <b>Work Details: </b>
                                        </div>
                                    </div>
                                    <div class="row">
                                           <div class="col-xs-12 col-sm-6">
                                               <div class="col-xs-5">
                                           Company Name :
                                        </div>
                                         <div class="col-xs-6" >
                                            <asp:TextBox ID="txtEmployeeCompanyName" runat="server" CssClass="form-control"  TabIndex="10"></asp:TextBox>
                                         </div>
                                         <div class="col-xs-1">
                                             
                                         </div>
                                           </div>
                                    <div class="col-xs-12 col-sm-6">
                                         <div class="col-xs-5">
                                           Service Type :
                                        </div>
                                         <div class="col-xs-6">
                                            <asp:DropDownList ID="drpServiceType" runat="server" CssClass="form-control"  TabIndex="11">
                                            </asp:DropDownList>
                                         </div>
                                         <div class="col-xs-1">
                                              <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ControlToValidate="drpServiceType" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Add_Employee" InitialValue="NA"></asp:RequiredFieldValidator>
                                         </div>
                                           </div>
                                    </div>
                                </div>

                                <asp:Label ID="Label10" runat="server" ForeColor="Red" Text=""></asp:Label>
                                <div class="panle-footer" style="text-align: right; padding-right: 10px; margin: 10px;">

                                    <asp:Button ID="btnAssignSubmit" runat="server" Text="Submit" OnClientClick="" OnClick="btnEmployeeAdd_Click" TabIndex="4" ValidationGroup="Add_Flat" class="btn btn-primary" />

                                    <button type="button" id="btnCancelEmployee" onclick="hideAddEmployeeModal()" class="btn btn-danger">Cancel</button>
                                </div>
                            </div>



                            <div id="data_loading_assign" class="layout-overlay" style="background-color: #000; width: 100%; height: 100%; opacity: 0.5; filter: alpha(opacity=50); text-align: center; vertical-align: middle;">
                                <img src="Images/Icon/ajax-loader.gif" style="width: 20px; height: 20px; margin-top: 200px;" />

                            </div>

                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>


            <div id="removeEmployee" class="modal">
            <div class="container-fluid " style="width:355px;margin-top:80px;">
                <div class="panel panel-primary">
                   <div class="panel-heading">
                        Remove Employee
                        <span class="fa fa-times" id="Cancel_delete"  onclick="hideRemoveEmployeeModal()" style="float:right;cursor:pointer;"></span>
                    </div>
                    <div class="panel-body">

                        <table class="layout_data_table">
                            <tr>
                                <td colspan="2" style="text-align: center;">You  are about  to  Deactivate  Employee,  it  will permanantly  Deactivated from database Continue ?
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 15px;">
                                    Employee Name: <label id="lblEmployeeName"></label>
                                </td>
                            </tr>

                            <tr>
                                <td colspan="2" style="height: 15px;">
                                    Service Type: <label id="lblServiceType"></label>
                                </td>
                            </tr>


                        </table>
                    </div>
                    <div class="panel-footer" style="text-align:right;">
                        <asp:Button ID="btnDeactiveEmployee" CausesValidation="false" CssClass="btn btn-primary" runat="server" OnClick="btnRemoveEmployee_Click" Text="Yes" />
                        <button type="button" id="cancelDactiveEmployee" onclick="hideRemoveEmployeeModal()" class="btn btn-danger">No</button>
                    </div>
                </div>
                </div>
            </div> 
               <asp:HiddenField runat="server" ID="HiddenField1" />
        </div>
    </form>
</body>
</html>
