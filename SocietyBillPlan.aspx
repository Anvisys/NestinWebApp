<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SocietyBillPlan.aspx.cs" Inherits="SocietyBillPlan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <meta name="viewport" content="width=device-width, initial-scale=1"/>

       <script src="Scripts/jquery-1.11.1.min.js"></script>
             <!-- Latest compiled and minified CSS -->
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>

            <!-- jQuery library -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

            <!-- Latest compiled JavaScript -->
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
   

         <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css"/>  

        <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js"></script>  
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>  
        <link rel="Stylesheet" href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.10/themes/redmond/jquery-ui.css" /> 

     
       <link rel="stylesheet" href="CSS/NewAptt.css"/>
              <link rel="stylesheet" href="CSS/ApttLayout.css"/>
              <link rel="stylesheet" href="CSS/ApttTheme.css" />

    <style>
        
        .BillCycle_table {
            background-color:#fff;
            border-radius:10px 10px 10px 10px;
            border-collapse:collapse;
            margin:5px;
           /* border: 1px solid #c1c1c1;*/
            box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2), 0 5px 10px 0 rgba(0, 0, 0, 0.19);
            width:225px;
            text-align:center;
            padding:4%;
        }

        .Bill_Plan_Table
        {
            width:100%;
           
            padding:2% 0 1% 1%;
            border-collapse:collapse;
            margin-top:1%;
            min-height:350px;
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

    </style>
    <script>

        var varBillID;
        var varBillType;
        var varChargeType;
        var varCycletype;
        var varRate;
        var varApplyTo;


        $(document).ready(function () {


            $("#BillCancel_Button").click(function () {
               $('#NewEditSocietyPlanForm').hide();
            });


            $("#IDNewBill").click(function () {
                $('#NewEditSocietyPlanForm').show();
                $('#radioall').prop('checked', false);
                $('#radioselected').prop('checked', false);
                $('#drpAddBillType').prop('selectedIndex', 0);
                $('#drpchargetype').prop('selectedIndex', 0);
                $('#drpbillcycle').prop('selectedIndex', 0);

                lblNewEdit.innerHTML = "Add Plan";
                $("#btnBillingEdit").hide();
                $("#btnBillingsubmit").show();
                //$("#New_Plan").css("visibility", "visible");

            });


            $("html").click(function () {
                $("#BillPlans_dropdown").hide();
            });




            $("#btnEditPlan").click(function () {

                $('#NewEditSocietyPlanForm').show();
               
                if (varApplyTo == "1") {
                    $('#radioall').prop('checked', true);
                    $('#radioselected').prop('checked', false);
                }
                else {
                    $('#radioall').prop('checked', false);
                    $('#radioselected').prop('checked', true);
                }
                $('#radioselected').attr('disabled', true);
                $('#radioall').attr('disabled', true);

                $('#drpAddBillType').val(varBillType);
                $('#drpAddBillType').attr('disabled', true);
                $('#drpchargetype').val(varChargeType);
                $('#drpbillcycle').val(varCycletype);
                $('#drpbillcycle').attr('disabled', true);
                $('#txtBillRate').val(varRate);

                lblNewEdit.innerHTML = "Edit Plan";
                $("#btnBillingEdit").show();
                $("#btnBillingsubmit").hide();
                

            });


        });

        function CloseAddPlan()
        {
            $("#NewEditSocietyPlanForm").hide();

        }

        function EditPlansPopup(BillID, BillType, ChargeType, Rate, Cycletype, ApplyTo, Element) {
            //alert(Element);
            document.getElementById("HiddenPlanBillID").value = BillID;
            //document.getElementById("HiddenPlanBillType").value = BillType;
            //document.getElementById("HiddenChargeType").value = ChargeType;
            //document.getElementById("HiddenCycleType").value = Cycletype;
            //document.getElementById("HiddenEditSocietyRate").value = Rate;
            //document.getElementById("HiddenApplyTo").value = ApplyTo;

            varBillID = BillID;
            varBillType = BillType;
            varChargeType = ChargeType;
            varCycletype = Cycletype;
            varRate = Rate;
            varApplyTo = ApplyTo;

            var myArray = new Array();
            myArray[0] = BillType;
            myArray[1] = BillID;

            var Posx = 0;
            var Posy = 0;
            while (Element != null) {

                Posx += Element.offsetLeft;
                Posy += Element.offsetTop;
                Element = Element.offsetParent;
            }

         
                $("#BillPlans_dropdown").slideDown();
         
                document.getElementById("BillPlans_dropdown").style.left = Posx - 90 + 'px';
                document.getElementById("BillPlans_dropdown").style.top = Posy + 'px';
                event.stopPropagation();
        }
    </script>
</head>
<body style="background-color:#f7f7f7;">
   <div class="container-fluid">

        <div class="col-xs-12 col-sm-12">
            <form id="form1" runat="server">
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                             
                <div class="container-fluid">
                                <div class="row" style="height:50px;">
                                 <div class="col-sm-3 hidden-xs" >
                                     <div><h4 class="pull-left ">Bill Plans : </h4></div>
                                 </div>
                                <div class="col-sm-6 col-xs-12" style="padding:0px;">
                                                         
                                                      </div>
                                 <div class="col-sm-3 hidden-xs" style="vertical-align:middle;">
                                    <div>
                                        <button type="button" id="IDNewBill" class="btn_my btn btn-primary"><i class="fa fa-plus"></i> Add Plan</button>  
                                    </div>
                                 </div>
                             </div>
                    </div>

                    <table class="Bill_Plan_Table">
                       
                              
                  <tr>
                    <td colspan="2" style="padding-bottom:1%;padding-top:0%;">

                         <div id="BillPlans_dropdown" class="layout-dropdown-content theme-dropdown-content" style="width:10%;"> 
                             <button type="button" id="btnEditPlan" class="layout_dropdown_Button">Edit</button>                                                                                    
                     <asp:Button ID="btnsocietyPlanEdit" Visible="false" runat="server" CommandArgument="Hello" CausesValidation="false"  CssClass="layout_dropdown_Button"  Text="Edit"   OnClick="btnsocietyPlanEdit_Click"/>
                     <asp:Button ID="btnSocietyPlanDeactive" runat="server" Text="Deactivate" CausesValidation="false" CssClass="layout_dropdown_Button"  OnClick="btnSocietyPlanDeactive_Click"/>                                                                                                      
                 </div>    
                
                                      <asp:DataList 
                                          ID="BillPlanDataList" runat="server" HorizontalAlign="Center" 
                                          RepeatColumns="3" RepeatDirection="Horizontal" Width="80%"  CellSpacing="5" 
                                           OnItemDataBound="SocietyBillPlan_ItemDataBound"> 
                                       
                                        <ItemStyle />
                                        <ItemTemplate>
                                    <table class="BillCycle_table" >
                                        <tr class="layout_header theme_third_bg" style="height:35px; ">
                                            <td colspan="2" style="text-align:center;margin-top:5px;">
                                                <asp:Label ID="Label3" runat="server" ForeColor="White" Text='<%# Eval("BillType") %>'> </asp:Label>
                                                
                                            </td>
                                        </tr>
                                       <tr style="text-align:left;margin-top:5px;">
                                      
                                           <td style="color:#969393;padding-left:8%;"> ChargeType :</td>
                                           <td>
                                                <asp:Label ID="Label4" runat="server" ForeColor="#999999" Text='<%# Eval("ChargeType") %>'></asp:Label>
                                           </td>
                                       </tr>
                                           <tr style="text-align:left;">
                                               <td style="color:#969393;padding-left:8%;"> Rate : </td>
                                           <td>
                                                <asp:Label ID="Label5" runat="server" ForeColor="#808080" Text='<%# Eval("Rate") %>'></asp:Label>
                                           </td>
                                       </tr>
                                        <tr style="text-align:left;">
                                            <td style="color:#969393;padding-left:8%;"> CycleType:</td>
                                           <td>
                                                <asp:Label ID="Label6" runat="server" ForeColor="#808080" Text='<%# Eval("CycleType") %>'></asp:Label>
                                             
                                           </td>
                                       </tr>

                                        <tr style="text-align:left;">
                                            <td style="color:#969393;padding-left:8%;"> ApplyTo:
                                           </td>  
                                             <td>  <asp:Label ID="lblBillEntity" runat="server" ForeColor="#808080" Text='<%# Eval("Applyto") %>'></asp:Label></td>
                                        </tr>

                                        <tr style="text-align:left;">
                                            <td style="color:#969393;padding-left:8%;"> Total Flats : </td>
                                              <td>
                                                  <asp:Label ID="lblcount" runat="server" Text=""></asp:Label> </td>
                                        </tr>                                                                     
                                         <tr style="text-align:right;">
                          <td colspan="2">
                          <asp:Label ID="lblID" runat="server" ForeColor="White" Text='<%# Eval("BillID") %>'> </asp:Label>

                              <button type ="button" id="PlansEdit" style="border:none;border-radius:5px; background-color:#fff;" onclick="EditPlansPopup('<%# Eval("BillID") %>','<%# Eval("BillType") %>','<%# Eval("chargeType") %>','<%# Eval("Rate") %>','<%# Eval("CycleType") %>','<%# Eval("Applyto") %>',this)">
                                 <i class="fa fa-pencil-square-o fa-2x"  aria-hidden="true"></i>

                              </button>

                      <%--   <asp:LinkButton ID="LinkButton1" runat="server" CssClass="Edit_icon" CausesValidation="false"><img src="Images/icon-edit-1.png" style="width:30px; height:30px;" /></asp:LinkButton>
                          --%> 
                          </td>
                 </tr>
                                          
                                    </table>
                                </ItemTemplate>
                                <AlternatingItemStyle />

                                
                            </asp:DataList>

                </td>
                    </tr>
                       <tr>
                           <td style="text-align:center;">
                            <asp:Label ID="lblBillPlanStatus" runat="server" ></asp:Label>
                              <asp:HiddenField ID="HiddenPlanBillID" runat="server" />
                              <asp:HiddenField ID="HiddenPlanBillType" runat="server" />  
                              <asp:HiddenField ID="HiddenEditSocietyRate" runat="server" />
                               <asp:HiddenField ID="HiddenCycleType" runat="server" />
                               <asp:HiddenField ID="HiddenChargeType" runat="server" />
                                <asp:HiddenField ID="HiddenApplyTo" runat="server" />
                               <asp:HiddenField ID="HiddenEditsocietyID" runat="server" />
                             <asp:HiddenField ID="HiddenFormRequired" runat="server" />

                           </td>

                       </tr>
                </table>                          
                 <%------------------------------------------------------------------------Society Bill Plan View End ----------------------------------------------------------%>



                  <%---------------------------------------------------------- Add New Plan starts from here  -----------------------------------------------------------------%>

             <%--  <div id="my
                 NewBillPopup" class="modal">--%>
                

                
                 <div id="NewEditSocietyPlanForm" class="modal">
                     <div class="panel panel-primary popup_box_size" style="width:400px;">
                                 <div class="panel-heading">
              
                                        <asp:Label ID="lblNewEdit" runat="server" Text="New Plan " ForeColor="White"></asp:Label>
                   
                                         <span onclick="CloseAddPlan()" class="fa fa-close" style="color:white;float:right;cursor:pointer;"></span>
                        
                                </div>
                         
                             <div class="panel-body"style="margin:20px;">
                               
                                <div class="row">
                                    <div class="col-xs-4">   Bill Type :</div>
                                    <div class="col-xs-8"> 
                                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                <ContentTemplate>
                                                    <asp:DropDownList ID="drpAddBillType" runat="server" CssClass="form-control ddl_style" AutoPostBack="true" OnSelectedIndexChanged="drpAddBillType_SelectedIndexChanged">
                                                        <asp:ListItem Value="0">Select</asp:ListItem>
                                                        <asp:ListItem>Electricity</asp:ListItem>
                                                        <asp:ListItem>Maintenance</asp:ListItem>
                                                        <asp:ListItem>Club</asp:ListItem>
                                                        <asp:ListItem>Gas</asp:ListItem>
                                                        <asp:ListItem>Water</asp:ListItem>
                                                        <asp:ListItem>Security</asp:ListItem>
                                                        <asp:ListItem>CulturalActivities</asp:ListItem>
                                                    </asp:DropDownList> 
                                                    <asp:Label ID="lblBillCheck" runat="server" Font-Size="Small" ForeColor="#FF6666"></asp:Label>
                                                </ContentTemplate>

                                            </asp:UpdatePanel>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="drpAddBillType" ErrorMessage="*" ForeColor="#FF5050" InitialValue="0"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                             
                                  <div class="row" style="margin-top:0px;">
                                    <div class="col-xs-4">  Charge Type</div>
                                    <div class="col-xs-8">
                                        <asp:DropDownList ID="drpchargetype" runat="server"  CssClass="form-control ddl_style">
                                                  <asp:ListItem>Manual</asp:ListItem>
                                                  <asp:ListItem>Rate</asp:ListItem>
                                                  <asp:ListItem>Fixed</asp:ListItem>
                                              </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="drpchargetype"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                 
                                  <div class="row" style="margin-top:0px;">
                                    <div class="col-xs-4"> Rate</div>
                                    <div class="col-xs-8">
                                          <asp:TextBox ID="txtBillRate"  CssClass="form-control" runat="server" ></asp:TextBox>
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtBillRate"></asp:RequiredFieldValidator>
                                    </div>
                                </div> 
                                 <div class="row" style="margin-top:0px;">
                                     <div class="col-xs-4">
                                         Cycle
                                     </div>
                                     <div class="col-xs-8">
                                         <asp:DropDownList ID="drpbillcycle" runat="server" CssClass="form-control ddl_style">
                                                <asp:ListItem>Daily</asp:ListItem>
                                              <asp:ListItem>Monthly</asp:ListItem>
                                              <asp:ListItem>Quarterly</asp:ListItem>
                                          </asp:DropDownList>
                                          <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="drpbillcycle"></asp:RequiredFieldValidator>
                                     </div>
                                 </div>


                                 <div class="row" style="margin-top:0px;">
                                     <div class="col-xs-4">
                                          Apply To :
                                     </div>
                                     <div class="col-xs-8">
                                          <asp:RadioButton ID="radioall" runat="server"  GroupName="Radiobill"/>
                                                                <label>All</label><br />
                                                                <asp:RadioButton ID="radioselected" runat="server"  GroupName="Radiobill"/>
                                                                <label>Selected</label>
                                     </div>
                                 </div>
                                 <div class="row">
                                       <asp:Label ID="lblBillstatus" runat="server" ForeColor="#48A4FF" Font-Size="Small"></asp:Label>
                                 </div>
                                 </div>
                                 <div class="panel-footer" style="text-align:right;">
                                       

                                             <asp:Button ID="btnBillingsubmit" runat="server" CssClass="btn btn-primary" Text="Submit"  OnClick="btnPlanSubmit_Click" />
                                             <asp:Button ID="btnBillingEdit" runat="server" Text="Update"  CssClass="btn btn-warning"  OnClick="btnBillingEdit_Click"/>
                                         
                                               <button type="button" id="BillCancel_Button"  class="btn btn-danger">Cancel</button> 
                                            
            
                                     </div>
                         
                                  
                                 
                         </div>
                  </div>
                      
           
                
             <%---------------------------------------------------------------------Add New Plan  Ends Here ----------------------------------------------------------%>

            </form>
        </div>
        
  </div>
</body>
</html>
