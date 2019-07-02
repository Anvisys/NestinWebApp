<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LatestBill.aspx.cs" Inherits="LatestBill" %>

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

    <script>

        $(function () {
            $("#txtLatestFlatFilter").autocomplete({
                source: function (request, response) {
                    var param = {
                        FlatNumber: $('#txtLatestFlatFilter').val()
                    };

                    $.ajax({
                        url: "LatestBill.aspx/GetLatestFlatNumber",
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
        })
        
        $(document).ready(function () {
            window.parent.FrameSourceChanged();
            $("#btnImport").click(function () {
                document.getElementById("importModal").style.display = "block";
                //$("#importModal").show();

            });


            $("#btnClose").click(function () {
                document.getElementById("importModal").style.display = "none";
                //$("#importModal").show();

            });

            $("#btnPaycancel").click(function () {
                $("#PaymentForm").hide();
            });

            $(document).click(function () {
                $("#current_dropdown").hide();

            });

            $("#txtBillDate").datepicker({ dateFormat: 'dd-mm-yy' });
            $("#txtStartDate").datepicker({ dateFormat: 'dd-mm-yy' });
            $("#txtEndDate").datepicker({ dateFormat: 'dd-mm-yy' });

            $("#BillDescpCancel").click(function () {
                $("#generatedbilldescriptnmodal").hide();
                $("#lblBillGeneraStatus").html('');
                $("#HiddenBillDescp").val("");
                $("input:text").val("");
            });

                        
        })

        function CloseBillImport()
        {
            $("#importModal").hide();
           
        }


       

        //Added by Aarshi on 26 Sept 2017
        $(document).ready(function () {

            $("#btnPayNow").click(function () {
               
                var text = document.getElementById("HiddenBillData").value;
               // FlatNumber + "&" + BillStartDate + "&" + BillEndDate + "&" + CurrentBillAmount + "&" + CycleType + "&" + PreviousMonthBalance + "&" + BillID + "&" + PayID + "&" + CurrentMonthBalance;
                var res = text.split("&");
                flatNumber = res[0];
               // alert(flatNumber);

                $("#lblFlat").html(res[0]);
                $("#lblBillTypee").html("");
                $("#lblDueDate").html(res[1]);
                $("#lblAmtPaid").html(res[3]);
                $("#lblAmountPaid").html(res[3]);
                $("#lblBalance").html(res[8]);
                $("#lblTotalPay").html("");
                $("#lblDueFor").html(res[2]);
                $("#lblBillGenDate").html(res[2]);
                $("#HiddenPayMannualID").val(res[7]);
             //   alert(res[7]);
              

                $("#newPaymentForm").show();


            });


            $("#btnBillPay").click(function () {
                //alert(1);
               // ShowPaymentForm();
            });

            $("#btnBillGencancel").click(function () {
                $("#GenerateDeActivateBillForm").hide();

            });
        })

        function HideGenerateForm() {
             $("#GenerateDeActivateBillForm").hide();
        }

        function ShowPaymentForm()
        {
           
            $("#lblFlat").html(flatNumber);
            $("#lblBillTypee").html(billType);
            $("#lblDueDate").html(dueDate);
            $("#lblAmtPaid").html(amount);
            $("#lblAmountPaid").html(amountPaid);
            $("#lblBalance").html(amountBalance);
            $("#lblTotalPay").html(totalPayable);
            $("#lblDueFor").html(dueForDate);
            $("#lblBillGenDate").html(billGeneratedDate);
            $("#HiddenPayMannualID").val(flatNumber);
          

            if (amountPaid == totalPayable) {
                $('#<%=txtAmt.ClientID %>').val("0");

            }
            else {
                $('#<%=txtAmt.ClientID %>').val(currentMonthBalance);

            }

         
            $("#PaymentForm").show();

        }

        function LatestBillPopup(PayID, BillID, FlatNumber, BillType, DueDate, Amount, Balance, TotalPay,
                                    DueFor, BillGendate, AmountPaidDate, BillStartDate, BillEndDate, CurrentBillAmount, CycleType,
                                    PaymentDueDate, BillMonth, PreviousMonthBalance, ModifiedAt, AmountPaid, CurrentMonthBalance, theElement) {
          
                                    document.getElementById("hiddenSelectedPayID").value = PayID;
                                    document.getElementById("HiddenFlatNumberHistory").value = FlatNumber;

                                    document.getElementById("HiddenBillTypeHistory").value = BillType;

                                    //Added by Aarshi on 14-Sept-2017 for bug fix
                                    document.getElementById("HiddenGeneratedBillData").value = FlatNumber + "&" + BillStartDate + "&" + BillEndDate + "&" + CurrentBillAmount + "&" + CycleType + "&" + PreviousMonthBalance + "&" + BillID + "&" + PayID + "&" + CurrentMonthBalance;

                                    document.getElementById("HiddenAmountPaidDate").value = AmountPaidDate;
                                  //  alert(a);
                                    var status = theElement.parentNode.parentNode.cells[7].innerHTML;
                                 //   alert(b);
                                    //Added by Aarshi on 26 Sept 2017
                                    flatNumber = FlatNumber;
                                    billType = BillType;
                                    dueDate = DueDate;
                                    amount = Amount;
                                    amountBalance = Balance;
                                    totalPayable = TotalPay;
                                    dueForDate = DueFor;
                                    billGeneratedDate = BillGendate;
                                    payID = PayID;
                                    amountPaidDate = AmountPaidDate;
                                    amountPaid = AmountPaid;
                                    currentMonthBalance = CurrentMonthBalance;
                                    //Ends here
                                  //  alert(1);
                                    var Posx = 0;
                                    var Posy = 0;

                                    while (theElement != null) {
                                        Posx += theElement.offsetLeft;
                                        Posy += theElement.offsetTop;
                                        theElement = theElement.offsetParent;

                                    }

                                    document.getElementById("current_dropdown").style.top = Posy + 'px';
                                    document.getElementById("current_dropdown").style.left = Posx + 'px';

                                    $("#current_dropdown").slideDown();
                                    event.stopPropagation();
        }

        function ShowGenerateDeActivateBillForm()
        {
            document.getElementById("GenerateDeActivateBillForm").style.display = "block";
        }

        function ShowGenerateBillPreview()
        {
            document.getElementById("generatedbilldescriptnmodal").style.display = "block";
        } 

    </script>
    <style>
        
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


        .form-control {
            display: inline;
            width: 38%;
            border-radius: 2px;
            margin-left: -5px;
        }
        .glyphicon {
                background-color: #607d8b;
                padding: 10px;
                margin-left: -7px;
                top: 2px;
            }
         .layout-overlay 
                {
                background:#f7f6f6;
                top: 0px;
                display:none;
                height:100px;
                position: absolute;
                transition: height 500ms ease 0s;
                width: 80%;
                opacity:0.5;
            }
         #lblBillDuplicate {
             margin-left:130px;
         }

        </style>

</head>
<body style="background-color:#f7f7f7;">
      <div class="container-fluid">

          <div class="row">
             <div class="col-md-12">
               <form id="form1" runat="server">
                   <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                   <asp:HiddenField ID="hiddenSelectedPayID" runat="server" />
                   
                    <asp:MultiView ID="MultiView1" runat="server">
              <asp:View ID="Latest_Bill_View" runat="server">
                       <div class="container-fluid">
                         <div class="row" style="height:50px;margin-top:15px;">
                                     <div class="col-sm-3 hidden-xs" >
                                         <h4 class="pull-left ">Latest Bills :</h4>
                                     </div>
                                    <div class="col-sm-6 col-xs-12" >
                                        <div class="form-group" >
                                              <asp:DropDownList ID="drpCurrentBillType" runat="server" CssClass="form-control"></asp:DropDownList> 
                                                <asp:TextBox ID="txtLatestFlatFilter" placeholder="Flat Number" runat="server" CssClass="form-control "></asp:TextBox>
                                            
                                              <asp:LinkButton runat="server" BackColor="Transparent" ForeColor="Black" OnClick="searchLatestGenBill_Click" ValidationGroup="Flat_Search"> <span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                         </div>
                                      </div>
                                     <div class="col-sm-3 hidden-xs" style="vertical-align:middle;">
                                        
                                            <button type="button" id="btnImport" class="btn-sm btn btn-primary"><i class="fa fa-cogs"></i> Generate Bill</button>  
                                        
                                     </div>
                                 </div>
                   

                           <div class="row" style="display:none;">
                                 <asp:CheckBox ID="chckLatestBills" runat="server" Text="Show Plan Details"  AutoPostBack="true" OnCheckedChanged="chckLatestBills_CheckedChanged"/>
                                  <asp:Label ID="lblLatestBillGrid" runat="server" ForeColor="Red"></asp:Label>
                           </div>

                      
                     
                    
                                                      
                              <asp:GridView ID="GridlatestBills" runat="server"
                                              AutoGenerateColumns="false" 
                                              AllowPaging="True" 
                                  GridLines="None"
                                                                  Width="100%"                                 
                                HorizontalAlign="Center" PageSize="15" EmptyDataText="No Records Found" 
                                 ShowHeader="false"
                                  OnPageIndexChanging="GridlatestBills_PageIndexChanging" 
                                  OnRowDataBound="GridlatestBills_RowDataBound" OnRowCommand="LatestBill_RowCommand">                                          
                     
                       <Columns>              
                                       <asp:TemplateField FooterStyle-BorderStyle="None" >
                                            <ItemTemplate>   
                                                  <div class="row layout_shadow_table"> 
                                                   
                                                      
                                                      <span style="font-size:medium; color:#000;margin:10px;">  <asp:Label ID="lblFlatNumar" runat="server" Text='<%# Eval("FlatNumber") %>' ></asp:Label>, 
                                                           <asp:Label ID="lblBillType" runat="server" Text='<%# Eval("BillType") %>' ></asp:Label></span>
                                                      <span style="padding:5px;float:right;color:#03a9f4;">Invoice ID <asp:Label ID="lblPayID" runat="server"  Text='<%#Eval("PayID") %>' ></asp:Label></span>
                                                      <hr style="margin-bottom:10px; margin-top:10px;" />


                                                    <div class="col-xs-4 " style="padding: 7px 30px;" >
                                                         
                                                           <img   class="profile-image" src='<%# "GetImages.ashx?UserID="+ Eval("OwnerUserID")+"&Name="+Eval("OwnerFirstName") +"&UserType=Owner" %>' 
                                                            /><br />
                                                          
                                                            <asp:Label ID="Label8" runat="server" Text='<%# "Owner: " + Eval("OwnerFirstName") %>' ></asp:Label>
                                                       
                                                      </div>

                                                      <div class="col-xs-4 ">
                                                          
                                                          Amount: <asp:Label ForeColor="Red" ID="Label2" runat="server" Text='<%# (int)Eval("CurrentBillAmount") -  (int)Eval("AmountPaid") %>' ></asp:Label> to be  paid by:
                                                         <span style="color:#009688">  <asp:Label ID="Label5" runat="server" Text='<%# Eval("PaymentDueDate", "{0:dd/MMM/yy}") %>' ></asp:Label></span><br />
                                                          Current Bill: <%# "Rs. "+ Eval("CurrentBillAmount") %>
                                                            <%# "Paid: "+ Eval("AmountPaid") %><br />
                                                            

                                                           <asp:Button ID="btnBillPay" runat="server"
                                                                CommandName="Pay" 
                                                                CommandArgument="<%# Container.DataItemIndex %>"
                                                               Text="Pay"  CssClass="btn btn-primary btn-sm" CausesValidation="false" />
                                                          
                                                        <asp:Button ID="btnBillHistory" runat="server" 
                                                            CommandName="History" 
                                                            CommandArgument="<%# Container.DataItemIndex %>"
                                                            Text="Details" CssClass="btn btn-info btn-sm" CausesValidation="false"    />

                                                      </div>
                                                   <div class="col-xs-4 ">
                                                        From:   <%# Eval("BillStartDate", "{0:dd/MMM/yy}") %>
                                                        To:  <%#  Eval("BillEndDate", "{0:dd/MMM/yy}") %><br />
                                                      
                                                           Payment Date: <%#  Eval("AmountPaidDate", "{0:dd/MMM/yy}")  %> <br />

                                                                               <asp:Button ID="btnLatestGenBill" runat="server"
                                                            CommandName="Generate" 
                                                            CommandArgument="<%# Container.DataItemIndex %>"
                                                           Text="Generate"  CssClass="btn btn-success btn-sm" CausesValidation="false"   />
                                                   </div>

                                                      <div class="col-xs-12">
                                                          

                             
                              
                             
                               


                                                      </div>
                                                  </div>  

                                      </ItemTemplate>
                                     </asp:TemplateField>
                      
                       <asp:TemplateField Visible="false">
                            <ItemTemplate>        
                            <asp:HiddenField  ID="hdnModifiedAt" Value='<%# Eval("ModifiedAt") %>' runat="server"></asp:HiddenField>  
                                                    
                            </ItemTemplate>
                        </asp:TemplateField>
                       
                       
                       
                       </Columns>
                          <EmptyDataRowStyle BackColor="#EEEEEE" />
                          
                        <PagerSettings Mode="NumericFirstLast" />
                        <PagerStyle   Font-Bold="False" HorizontalAlign="Center"  Font-Names="Berlin Sans FB" Font-Size="Medium" />
                       </asp:GridView>&nbsp;
                             
                              <%--Added by Aarshi on 27-Sept-2017 for bug fix--%>
                              <asp:HiddenField ID="HiddenFlatNumberHistory" runat="server" />
                              <asp:HiddenField ID="HiddenBillTypeHistory" runat="server" />
                              <asp:HiddenField ID="HiddenGeneratedBillData" runat="server" />
			                  <asp:HiddenField ID="HiddenAmountPaidDate" runat="server" />
                      
                           <div id="current_dropdown" class="layout-dropdown-content theme-dropdown-content" style="width:8%;margin-left:0.5%;">           
                               <asp:Button ID="btnBillHistory" runat="server"  Text="Details" CssClass="layout_dropdown_Button" CausesValidation="false" OnClick="btnBillHistory_Click"   />
                               <%--Added by Aarshi on 26 Sept 2017--%>
                               <asp:Button ID="btnBillPay" runat="server" Text="Pay"  CssClass="layout_dropdown_Button" CausesValidation="false" OnClick="btnBillPay_Click" />
                               <%--Added by Aarshi on 27-Sept-2017--%>
                               <%--<button type="button" id="btnBillPay" class="layout_dropdown_Button">Pay</button> <br/>--%>
                               <asp:Button ID="btnLatestGenBill" runat="server" CssClass="layout_dropdown_Button" Text="Generate" CausesValidation="false"  OnClick="btnLatestGenBill_Click" />
                          </div>                                                                 
                 
              
                     <div class="row" style="text-align:center;">
                              <asp:Label ID="Label27" runat="server" Text="Total Count:" ForeColor="#0099FF"></asp:Label>
                              <span style="margin-left:1%;"></span>
                              <asp:Label ID="lblLatestBillCount" runat="server" ForeColor="#0099FF"></asp:Label>
                       </div>
                      
                    
                 </div>
         <%--------------------------------------------------------- Pay the  Amount Section starts from here  ---------------------------------------------------------------------------------- --%>
                         

                  </asp:View>

              <asp:View ID="Bill_Detail_View" runat="server">

                <div class="container-fluid">
                       <div class="" style="height:40px;">
                                 <div class="col-sm-2 hidden-xs" >
                                     <div><label class="pull-left ">Bill Details : </label></div>
                                 </div>
                                <div class="col-sm-9 col-xs-9" style="">
                                    <div class="" style="">
                                        <asp:TextBox ID="txtGenBillsFlatfilter" runat="server" CssClass="layout_txtbox_filter"></asp:TextBox>
                                        <asp:DropDownList ID="drpGeneratedBillType" runat="server" CssClass="layout_ddl_filter"></asp:DropDownList> <span style="margin-left:10px" ></span> 
                                        <asp:TextBox ID="txtStartDate" runat="server" Width="" CssClass="layout_txtbox_filter"></asp:TextBox>                                      
                                        <asp:Label ID="Label36" runat="server" ForeColor="#999999" Text="To"></asp:Label>                                                                   
                                        <asp:TextBox ID="txtEndDate" runat="server" Width="" CssClass="layout_txtbox_filter"></asp:TextBox>                                
                                        <asp:LinkButton runat="server" BackColor="Transparent" ForeColor="Black" CausesValidation="false" OnClick="searchGenerateBill_Click"> <span class="glyphicon glyphicon-search"></span></asp:LinkButton> 
                                    </div>           
                                 </div>
                                 <div class="col-sm-1" style="vertical-align:middle;">
                                    
                                        <asp:LinkButton runat="server" BackColor="Transparent" ForeColor="White" CausesValidation="false" OnClick="BillBack_Click"><span class="glyphicon glyphicon-backward"></span></asp:LinkButton> 
                                  
                                 </div>
                             </div>
                </div>
                
                 <table  style="width:95%; margin-top:1%;">   
                     
            <tr>
                <td colspan="1" style="width:15%; "> 
                     <asp:HiddenField ID="HiddenBillData" runat="server" />
                    
                </td>
                <td colspan="1" style="width:70%; text-align:left;"> 
                    <asp:CheckBox ID="ChckBillsGenerated" runat="server"  Text="Show Details" AutoPostBack="true" OnCheckedChanged="ChckBillsGenerated_CheckedChanged"/>
                </td>
                <td colspan="1" style="width:15%;text-align:center;"> 
                   
                </td>
            </tr>
            
            <tr>
                <td colspan="3" style="text-align:right;">
                    <asp:Label ID="lblPaymentCheck" runat="server"></asp:Label>
                </td>
          
            </tr>

             <tr>
                        
                    <td colspan="3" style="text-align:center;">
                        <asp:GridView ID="GeneratedBillsGrid" runat="server" AllowPaging="True" AutoGenerateColumns="false" BackColor="#E8E8E8"  BorderStyle="Solid" 
                            EmptyDataText="No Records Found" Font-Names="Calibri" ForeColor="#666666" HorizontalAlign="Center" 
                            OnPageIndexChanging="GeneratedBillsGrid_PageIndexChanging" OnRowDataBound="GeneratedBillsGrid_RowDataBound" PageSize="15" ShowHeaderWhenEmpty="True" 
                            style="margin-bottom: 0px" Width="80%">
                            <AlternatingRowStyle BackColor="#ffffff" />
                            <Columns>
                                <%--<asp:BoundField DataField="FlatNumber" HeaderText="Flat" />--%>
                                <asp:TemplateField HeaderStyle-Width="50px">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblFlat" runat="server" Text="Flats"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkFlatNumber" runat="server" CssClass="BillActiveGrid"  Font-Bold="true" Font-Underline="true" ForeColor="#0066cc" Text='<%# Bind("FlatNumber") %>'></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="BillType" HeaderStyle-Width="100px" HeaderText="BillType" ItemStyle-CssClass="BillActiveGridLeftAlign" />
                                <asp:BoundField DataField="Rate" HeaderStyle-Width="40px" HeaderText="Rate" ItemStyle-CssClass="BillActiveGrid" ItemStyle-Width="40px">
                                <HeaderStyle Width="40px" />
                                <ItemStyle Width="40px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="FlatArea" HeaderText="FlatArea" />
                                <%--  <asp:BoundField DataField="BillStartDate" DataFormatString="{0:dd/MMM/yy}" HeaderText="From:" />
                                <asp:BoundField DataField="BillEndDate" DataFormatString="{0:dd/MMM/yy}" HeaderText="To:" />--%>
                                <asp:BoundField DataField="CurrentBillAmount" HeaderText="CurrentBillAmount" />
                                 <asp:BoundField DataField="ModifiedAt" DataFormatString="{0:dd/MMM/yy}" HeaderText="Bill Date" />
                                <asp:BoundField DataField="CycleType" HeaderText="CycleType" />
                                <asp:BoundField DataField="PaymentDueDate" DataFormatString="{0:dd/MMM/yyyy}" HeaderText="PaymentDueDate" ItemStyle-Font-Size="Small">
                                <ItemStyle Font-Size="Small" />
                                </asp:BoundField>
                               <%-- <asp:BoundField DataField="BillMonth" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Bill Gen Month" ItemStyle-Font-Size="Small" ItemStyle-Width="120px" />--%>
                                <asp:BoundField DataField="PreviousMonthBalance" HeaderStyle-Width="70px" HeaderText="PreviousMonthBalance" ItemStyle-CssClass="BillActiveGrid" />
                                <asp:BoundField DataField="CurrentBillAmount" HeaderStyle-Width="70px" HeaderText="Current Amount" ItemStyle-CssClass="BillActiveGrid" />
                                <asp:BoundField DataField="AmountTobePaid" HeaderStyle-Width="70px" HeaderText="AmountTobePaid" ItemStyle-CssClass="BillActiveGrid" />
                                <asp:BoundField DataField="AmountPaidDate" DataFormatString="{0:dd/MMM/yyyy}" HeaderStyle-Width="80px" HeaderText="AmountPaidDate" ItemStyle-Font-Size="Small" />
                                <asp:BoundField DataField="AmountPaid" HeaderStyle-Width="70px" HeaderText="AmountPaid" />
                                
                                <asp:BoundField DataField="BillDescription" HeaderText="BillDescription" ItemStyle-CssClass="BillActiveGrid">
                                <ItemStyle Width="300px" />
                                <HeaderStyle Width="300px" />
                                </asp:BoundField>
                           
                            </Columns>
                            <EmptyDataRowStyle BackColor="#EEEEEE" />
                            <HeaderStyle BackColor="#0065A8" Font-Bold="false" Font-Names="Modern" Font-Size="Small" ForeColor="White" Height="30px" />
                            <PagerSettings Mode="NumericFirstLast" />
                            <PagerStyle BackColor="White" BorderColor="#F0F5F5" Font-Bold="False" Font-Names="Berlin Sans FB" Font-Size="Medium" ForeColor="#62BCFF" HorizontalAlign="Center" />
                        </asp:GridView>
                    </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="text-align:center;">
                         <asp:Label ID="lblTotal" runat="server" ForeColor="#2facff" Text="Total Bills :"></asp:Label>    
                            <asp:Label ID="lblTotalBillscount" runat="server" ForeColor="#35aeff" Text=""></asp:Label><br />
                             <asp:Label ID="lblGeneratebill" runat="server" Font-Size="Small" ForeColor="#FF6262" Visible="False"></asp:Label>
                        </td>
                         </tr>
                    <tr>
                        <td colspan="1" style="text-align:center; width:15%;">
                             <asp:Button ID="btnExport" runat="server" Text="Export" CssClass="theme-btn-primary" CausesValidation="false" OnClick="ExportToExcel" />

                        </td>
                                <td colspan="1" style="text-align:center; width:30%;">
                            

                        </td>
                                <td colspan="1" style="text-align:center; width:15%;">
                                  <!--  <button type="button" id="btnPayNow" class="theme-btn-primary">Pay</button>-->
                                     <asp:LinkButton ID="linkPay" runat="server" OnClick="PayLink_Click" CausesValidation="false" CssClass="theme-btn-primary"> Pay Now</asp:LinkButton>
                            <!-- <asp:Button ID="Button2" runat="server" Text="PayNow" CssClass="theme-btn-primary" CausesValidation="false" OnClick="PayNow_Click" />-->

                        </td>
                    </tr>
                </table>

                  <div id="newPaymentForm" class="layout_modal_Window">
                      <div class="container-fluid">
                          <div class="row layout_header theme_primary_bg" style="height:30px;">
                              <div class="col-xs-12">
                                    PayBill:
                                  </div>
                        </div>
                      </div>

                  </div>
               
            </asp:View>

              <asp:View ID="PaymentView" runat="server">

                               <table style="width:70%;margin-left:15%;">
                                   <tr>
                                       <td colspan="2" style="text-align:center;color:#ff6a00;font-family:Arial, Helvetica, sans-serif;font-size:large;height:10px;">
                                           Detail Bill:</td>
                                   </tr>
                                  <tr>
                                      <td colspan="2" style="height:10px;border-bottom:1px solid #d5d3d3;">

                                      </td>
                                  </tr>
                                   
                                    <tr>
                                       <td  style="width:50%;text-align:right;">
                                          Flat Number :
                                       </td>
                                          <td style="width:50%;padding-left:3%;">
                                              <asp:Label ID="lblFlat" runat="server"></asp:Label>
                                          </td>
                                       
                                   </tr>
                                      <tr>
                                       <td  style="width:50%;text-align:right;">
                                           Bill Type :
                                       </td>
                                          <td style="width:50%;padding-left:3%;">
                                              <asp:Label ID="lblBillType" runat="server"></asp:Label>
                                          </td>
                                   </tr>

                                    <tr>
                                       <td style="width:50%;text-align:right;">
                                           Due Date :
                                       </td>
                                          <td  style="width:50%;padding-left:3%;">
                                              <asp:Label ID="lblDueDate" runat="server"></asp:Label>
                                          </td>
                                   </tr>

                                      <tr>
                                        <td  style="width:50%;text-align:right;">
                                           Bill Amount :
                                  </td>
                                          <td  style="width:50%;padding-left:3%;">
                                              <asp:Label ID="lblBillAmount" runat="server"></asp:Label>
                                          </td>
                                   </tr>

                                    <tr>
                                        <td  style="width:50%;text-align:right;">
                                           Previous Balance :
                                  </td>
                                          <td  style="width:50%;padding-left:3%;">
                                              <asp:Label ID="lblBalance" runat="server"></asp:Label>
                                          </td>
                                   </tr>
                                   
                                    <tr>
                                        <td  style="width:50%;text-align:right;">
                                            Total Payble :
                                  </td>
                                          <td  style="width:50%;padding-left:3%;">
                                              <asp:Label ID="lblTotalPay" runat="server"></asp:Label>
                                          </td>
                                   </tr>
                                      <tr>
                                        <td  style="width:50%;text-align:right;">
                                            Due For :
                                  </td>
                                          <td  style="width:50%;padding-left:3%;">
                                              <asp:Label ID="lblDueFor" runat="server"></asp:Label>
                                          </td>
                                   </tr>

                                   <tr>
                                        <td  style="width:50%;text-align:right;">
                                           Cycle Type :
                                  </td>
                                          <td  style="width:50%;padding-left:3%;">
                                              <asp:Label ID="lblCycletype" runat="server"></asp:Label>
                                          </td>
                                   </tr>

                                      <tr>
                                        <td  style="width:50%;text-align:right;">
                                         Due Date :
                                  </td>
                                          <td style="width:50%;padding-left:3%;">
                                              &nbsp;<asp:Label ID="lblCurrentTime" runat="server"></asp:Label>
                                          </td>
                                   </tr>
                                   
                                   <tr >
                                       <td colspan="2" style="height:30px;background-color:#f2f2f2;color:#bfbfbf;padding-left:3%;font-size:x-large;">
                                           Payment Made :
                                       </td>
                                   </tr>
                                   <tr >

                                       <td  style="width:50%;text-align:right;">
                                           Paid Amount :
                                  </td>
                                          <td  style="width:50%;padding-left:3%;">
                                              <asp:Label ID="lblAmountPaid" runat="server"></asp:Label>
                                          </td>

                                   </tr>
                                   <tr >

                                       <td  style="width:50%;text-align:right;">
                                           Paid On :
                                  </td>
                                          <td  style="width:50%;padding-left:3%;">
                                              <asp:Label ID="lblPaidDate" runat="server"></asp:Label>
                                          </td>

                                   </tr>

                                   <tr>
                                       <td colspan="2" style="height:50px;background-color:#f2f2f2;color:#bfbfbf;padding-left:3%;font-size:x-large;">
                                           Payment Mode :
                                       </td>
                                   </tr>
                                   <tr style="text-align:center;">
                                       <td>
                                           <a href="#" class="mode_button" id="lnkPaypal">PayPal Entry</a>
                                       </td>
                                       <td>
                                      <a href="#" class="mode_button" id="lnkmannual">Mannual Entry</a>
                                       </td>
                                     
                                   </tr>
                               </table>
                            
                               <table id="paymannual" style="width:70%;margin-left:15%;text-align:center;">
                                                   <tr>
                                                       <td colspan="3" style="width:92%;">
                                                            <asp:Label ID="lblPayment" runat="server" ForeColor="Red"></asp:Label>
                                                       </td>
                                                   </tr>
                                                   <tr>
                                                       <td style="width:40%;text-align:right;">
                                                           Amount :
                                                       </td>
                                                         <td style="width:60%;">
                                                             <asp:TextBox ID="txtAmt" runat="server" CssClass="txtbox_style"></asp:TextBox>
                                                       </td>

                                                        <td>
                                                       </td>
                                                   </tr>
                                                     <tr>
                                                       <td style="text-align:right;">
                                                           Payment Mode:
                                                       </td>
                                                         <td>
                                                             <asp:DropDownList ID="drpPayMode" runat="server"  CssClass="ddl_style"  >
                                                                 <asp:ListItem>Cash</asp:ListItem>
                                                                 <asp:ListItem>Cheque</asp:ListItem>
                                                             </asp:DropDownList>
                                                       </td>
                                                          <td>
                                                       </td>
                                                   </tr>
                                                     <tr>
                                                       <td style="text-align:right;"> 
                                                           Transaction ID:
                                                       </td>
                                                         <td>
                                                             <asp:TextBox ID="txtTransaID" runat="server" CssClass="txtbox_style"></asp:TextBox>
                                                       </td>
                                                          <td>
                                                              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTransaID" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                                             </td>
                                                   </tr>
                                                     <tr>
                                                       <td style="text-align:right;">
                                                           Invoice ID:
                                                       </td>
                                                         <td>
                                                             <asp:TextBox ID="txtInvID" runat="server" CssClass="txtbox_style"></asp:TextBox>
                                                       </td>
                                                          <td>
                                                              <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtInvID" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                                              </td>
                                                   </tr>
                                                   <tr>
                                                       <td colspan="3" style="text-align:center;">
                                                          
                                                       </td>
                                                   </tr>
                                                   <tr>
                                                       <td style="height: 50px;text-align:right;">
                                                           <asp:Button ID="btnPaySubmit" runat="server" Text="Submit" CssClass="send" OnClick="btnpaymannual_Click" />
                                                       </td>


                                                       <td colspan="2"  style="text-align:center;">
                                                             <asp:Button ID="btnPayCancel" runat="server" Text="Cancel" CssClass="send"  CausesValidation="False" OnClick="btnpayCancel_Click" />
                                                       </td>
                                                   </tr>
                                               </table>

               </asp:View>
        </asp:MultiView>

                  <%-- ------------------------------------------------- GenerateDeActivateBillForm For Single Flat ---------------------------------------------------  --%>
                 <%--   <div id="GenerateBillSingleFlat" class="modal">  --%>
                       <div id="GenerateDeActivateBillForm" class="modal">
                           <div class="container-fluid" style="width:400px;">
                               <div class="panel panel-primary">
                                   <div class="panel-heading">
                                         FlatBill Summary :
                                       <span class="fa fa-close" onclick="HideGenerateForm()" style="color:white;float:right; cursor:pointer;"></span>
                                   </div>
                                   <div class="panel-body">
                                    
                             <label  class="lbltxt" style="width:150px;">Flat Number :</label>
                              <asp:Label width="100" ID="lblFlatNuber"  runat="server" Font-Size="Small"></asp:Label> <br />

                                      
                             <label  class="lbltxt" style="width:150px;"> Bill Type :  </label>
                              <asp:Label width="100" ID="lblNewBillType" runat="server" Font-Size="Small"></asp:Label><br />
                            
                        
                            
                             <label  class="lbltxt"  style="width:150px;">Flat Area : </label>
                              <asp:Label width="100" ID="lblFlatArea" runat="server" Font-Size="Small"></asp:Label> <br />


                             <label  class="lbltxt"  style="width:150px;"> Charge Type :</label>
                             <asp:Label width="100" ID="lblChargeType" runat="server" Font-Size="Small"></asp:Label> <br />

                             <label  class="lbltxt"  style="width:150px;"> Rate :</label>
                              <asp:Label width="100" ID="lblRate" runat="server" Font-Size="Small"></asp:Label> <br />


                             <label  class="lbltxt"  style="width:150px;"> From Date :  </label>
                             <asp:Label width="100" ID="lblFromDate" runat="server" Font-Size="Small"></asp:Label> <br />

                             <label class="lbltxt" style="width:150px;"> Previous Balance : </label>
                              <asp:Label width="100" ID="lblPreviousBalance" runat="server" Font-Size="Small"></asp:Label> <br />
                          <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                              <ContentTemplate>
                             <label class="lbltxt" style="width:150px;">Till Date : </label>
                            
                                               
                                           <asp:TextBox ID="txtBillDate" CssClass="form-control" runat="server"></asp:TextBox>                     
                                <%-- >  <asp:Label ID="lblTillDate" runat="server" Font-Size="Small"></asp:Label>--%>
                                 
                           
                                
                                 
                                       <%--   <span runat="server" onclick="btnCalculateOnEnddate_Click" >  </span>--%>

                                          <asp:Button  CssClass="fa fa-calculator" ID="btnCalculate" runat="server" Text="Calculate"  CausesValidation="false" OnClick="btnCalculateOnEnddate_Click" />
                                      </ContentTemplate>
                                  </asp:UpdatePanel>
                                  
                                       <br />
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                  <ContentTemplate>
                                         <label class="lbltxt" style="width:150px;"> Amount : </label>
                            
                                             
                                                        <asp:TextBox width="100" ID="txtFlatBillAmt" runat="server" CssClass="form-control " Visible="False"></asp:TextBox>
                                                  </ContentTemplate>
                                              </asp:UpdatePanel>                        
                              
                           
                                           <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtFlatBillAmt" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Textbox" InitialValue="0"></asp:RequiredFieldValidator>
                                               <br />
                               
                                        <label class="lbltxt" style="width:150px;"> Description :</label>
                               
                                            <asp:TextBox width="100" ID="txtBillGenSingleFlatdesc" runat="server" onchange="ResizeBillGeTextbox();" CssClass="form-control "></asp:TextBox><br />
                               
                            
                                          <asp:Label  ID="lblBillDuplicate" runat="server" Font-Size="Small" ForeColor="#55AAFF" ></asp:Label>
                                           <span style="margin-left:5px;"></span> 
                          



                                   </div>
                                   <div class="panel-footer" style="text-align:right;">
                                          <button type="button" id="btnBillGencancel"  class="btn btn-danger">Cancel</button> 

                                      <asp:Button ID="btnSingleFlatGenerate" runat="server" Text="Generate Bill" CssClass="btn btn-success" OnClick="btnSingleFlatGenerate_Click" ValidationGroup="Textbox" />
                                  

                                   </div>

                              </div>
                             
                             </div>
                        </div>

                    <%--   Import Bill Form  --%>
                     <div id="importModal" class="modal">
                                  <div class="container-fluid" style="width:500px;">
                                            <div class="panel panel-primary">
                                                <div class="panel-heading">
                                                Generate Bill: <span class="fa fa-close" onclick="CloseBillImport()" style="float:right; cursor:pointer;"></span>
                                                                                 
                                            </div>
                                              <div class="panel-body">
                                                    <div class="row">
                                                        <div class="col-xs-12" style="height:10px;">
                                                            <asp:Label ID="lblGenerateStatus"  runat="server" Font-Size="Small" Text="" ForeColor="Red"></asp:Label>
                                                        </div>
                                                    </div>
                                                           <div class="row">
                                                        <div class="col-xs-6" style="text-align:left">
                                                            Generate by Rate :
                                                        </div>
                                                        <div class="col-xs-6">
                                                            <asp:DropDownList ID="drpGenBillForOnLatest" runat="server" CssClass="layout_ddl_filter"></asp:DropDownList>
                                                  
                                                        </div>
                                                
                                                        </div>
                                                           <div class="row" style="margin-top:10px;">
                                                      <div class="col-xs-6"></div>

                                                      <div class="col-xs-6" >
                                                     <asp:Button CssClass="btn btn-sm btn-primary" ID="btnGenerateLatest" runat="server" OnClientClick="return ValidateDropdown();" OnClick="btnGenerateLatestBill_Click" Text="Generate Bill" CausesValidation="false"/>
                                                          </div>
                                                  </div>
                                                  <hr />

                                                           <div class="row">
                                                        <div class="col-xs-6" style="text-align:left">
                                                           Import File :
                                                        </div>
                                                        <div class="col-xs-6">
                                                             <asp:FileUpload ID="BillsUpload" runat="server" />
                                                
                                                        </div>
                                                        <div class="col-xs-12" style="text-align:center;">
                                                 
                                                            </div>
                                                   </div>
                                                           <div class="row" style="margin-top:10px;">
                                                      <div class="col-xs-6"></div>

                                                      <div class="col-xs-6" >
                                                     <asp:Button CssClass="btn btn-primary" ID="BillsUploadSubmit" runat="server" CausesValidation="false" OnClick="BillsUploadSubmit_Click" Text="Submit" />
                                                          </div>
                                                  </div>

                                                  <hr/>
                                                           <div class="row">
                                                                <div class="col-xs-6" style="text-align:left">
                                                                    Export Grid Data :
                                                                </div>
                                                                <div class="col-xs-6">
                                                                    <asp:Button CssClass="btn btn-success" ID="btnExport2" runat="server" Text="Export" CausesValidation="false" OnClick="ExportLatestToExcel" />
                                                                </div>
                             
                                                            </div>
                                          
                                              </div>
                                    
                                                                            
                                            <div class="panel-footer" style="text-align:right;">
                                        
                                                        <button type="button" id="btnClose" class="btn btn-danger" >Close</button> 
                                     
                                            </div>
                                            </div>
                                      </div>
                             </div>

                      <%--   Generated Bill Form  --%>
                   <div id="generatedbilldescriptnmodal" class="modal"> 
                       <div class="container-fluid" style="width:400px;">
                       <div class="panel panel-primary">
                           <div class="panel-heading">
                               Bill Description : <span class="fa fa-close" onclick="" style="color:white; float:right; cursor:pointer;" ></span>
                           </div>
                           <div class="panel-body">
                               <div class="row">
                                   <div class="col-xs-6">Bill Type :</div>
                                    <div class="col-xs-6"><asp:Label ID="lblBilltypeDes" runat="server" Text=""></asp:Label></div>
                               </div>


                                <div class="row">
                                   <div class="col-xs-6">Chargetype :</div>
                                    <div class="col-xs-6"> <asp:Label ID="lblchargetypeDes" runat="server" Text=""></asp:Label></div>
                               </div>

                                <div class="row">
                                   <div class="col-xs-6">Rate :</div>
                                    <div class="col-xs-6">  <asp:Label ID="lblrateDes" runat="server" Text=""></asp:Label> </div>
                               </div>

                                <div class="row">
                                   <div class="col-xs-6"> Rows Effect : </div>
                                    <div class="col-xs-6"> <asp:Label ID="lblRowsEffectDes" runat="server" Text=""></asp:Label></div>
                               </div>

                                <div class="row">
                                   <div class="col-xs-6">  <asp:Label ID="lblBillGeneraStatus" runat="server" ForeColor="White" Text="status"></asp:Label></div>
                                    <div class="col-xs-6"></div>
                               </div>

                                <div class="row">
                                   <div class="col-xs-6">      <asp:FileUpload ID="uploadBill" runat ="server" Visible="false"/></div>
                                    <div class="col-xs-6"> <asp:Button ID="btnbillCaluclate" runat="server" CssClass="btn_style" OnClick="btnbillCaluclate_Click" Text="Generate Bill" ValidationGroup="BillGentype"  Visible="false"/>  </div>
                               </div>

                             

                           </div>
                           <div class="panel-footer" style="text-align:right;">
                                 <button type="button" id="BillDescpCancel" class="btn btn-danger" >Close</button>
                   
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
