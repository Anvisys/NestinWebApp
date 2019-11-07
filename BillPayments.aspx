<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillPayments.aspx.cs" Inherits="BillPayments" %>

<!DOCTYPE html>
<!--  This Total  code  is  licenced
    Developed By Anvisys Technologies Pvt Ltd.
    
    Copyright © 2016 Anvisys Technologies Pvt. Ltd.All rights reserved.
    -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Payment</title>
     
            <meta name="viewport" content="width=device-width, initial-scale=1"/>

             <script src="Scripts/jquery-1.12.0.js"></script>
            <link rel="stylesheet" href="CSS/ApttTheme.css" />
           <link rel="stylesheet" href="CSS/ApttLayout.css" />

              
            <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
            <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
            <!-- jQuery library -->
            <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
   
            <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css"/>  
          



 
    
     <script>

         $(document).ready(function () {

             window.parent.FrameSourceChanged();

             $("#lnkmannual").click(function () {
                 $("#paymannual").toggle("slow");


             });

         });


   </script>


    <style>
        .calendar{
            float:right;       
        }

        .UserBill
        {
       
         border-radius:5px;
         padding-left:10px;
         margin-top:20px;
         margin-bottom:20px;
         background-color: #ffffff;
       /*  box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2), 0 5px 10px 0 rgba(0, 0, 0, 0.19);*/

        }

        .bill_table{
             /*background-color: #f2f2f2;
            border-collapse:collapse;*/

            background-color:#faf9f9;
            border-radius:10px 10px 10px 10px;
            border-collapse:collapse;
            margin:5px;
           /* border: 1px solid #c1c1c1;*/
            box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2), 0 5px 10px 0 rgba(0, 0, 0, 0.19);
            width:100%;
            text-align:center;
            padding:4%;

        }
        .bill_table tr{
             background-color: #f2f2f2;
        }

        .heading_div{
            width:100%;
      
            text-align:left;
            margin:1px 0 1px;
            
        }

        .last_row td{

            border-bottom: 1px solid #cc0000;
        }
        td, th {
    padding: 4px;
}

        </style>
         
</head>

<body style="background-color:#f7f7f7;">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <form id="form1" runat="server">
        <%--<asp:ScriptManager ID="ScriptManager1" runat="server" />--%>
                <div>
                     <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
  
                         <asp:View ID="BillView" runat="server">

                            <div class="container-fluid">
                                   <div class="row" style="height:40px;">
                             <div class="col-sm-3 col-xs-12" >
                                 <h3 class="pull-left ">Bills To Pay:</h3>
                             </div>
                            <div class="col-sm-6 hidden-xs" style="padding:0px;">
                                      
                                                  </div>
                             <div class="col-sm-3 hidden-xs" style="vertical-align:middle;">
                                <div>
                         
                                </div>
                             </div>
                         </div>
                                <div class="row">
                            <div class="col-xs-12" style="font-family:'Times New Roman', Times, serif !important; color: red !important; text-align:center;">
                                 <asp:Label ID="lblResBillsEmptyText" runat="server" ForeColor="#999999" Text=""></asp:Label>
                            </div>

                        </div>


                             </div>




                             <asp:DataList ID="DataUserBills" CssClass="UserBill" runat="server" 
                                 Width="100%" HorizontalAlign="Center"  
                                 RepeatDirection="Vertical" 
                                 RepeatColumns="1"  CellSpacing="20" 
                                 BackColor="Transparent"
                                  OnItemDataBound="DataList_ItemDataBound">

                                        <ItemStyle />                           
                                        <ItemTemplate>
                                           <!-- <table style="width:100%; height:60px;border:1px solid #f1ebeb;border-collapse:collapse;border-bottom:none;">-->
                                            <div class="container-fluid " style="margin-top:10px;">

                                                <div class="row">
                                                  <div class="panel panel-default" style="margin-bottom:0px;">
                                                       <div class="panel-body layout_shadow_table">
                                                        <div class="col-xs-12">
                                                            <asp:Label ID="lblBilltype" runat="server" ForeColor="Blue" Font-Size="Large"   Text='<%# Eval("BillType") %>'></asp:Label>
                                                        </div>
                                                     <hr />
                                                    <div class="col-xs-3 col-md-3" style="margin-top:10px;">
                                                       Bill Month:   <asp:Label ID="lblBillMonth" runat="server" ForeColor="#000000" Text='<%# Eval("BillMonth","{0:MMM yyyy}") %>'></asp:Label>
                                                         </div>
                                                    <div class ="col-xs-3 col-md-3" style="margin-top:10px;">
                                                         Amount Paid: <asp:Label ID="lblAmountPaid" runat="server" ForeColor="#969696" Text='<%# Eval("AmountPaid") %>'></asp:Label>
                                                    </div>
                                                     <div class ="col-xs-3 col-md-3" style="margin-top:10px;">
                                                          Paid On:  <asp:Label ID="lblPaidOn" runat="server" ForeColor="#969696" Text='<%# Eval("AmountPaidDate","{0 :dd MMM yyyy}") %>'></asp:Label>
                                                     </div>
                                               
                                               
                                                    <div class="col-xs-3 col-md-3" style="margin-top:10px;">
                                                        Prev Balance :  <asp:Label ID="lblPrevBalance" runat="server"   Font-Bold="true" ForeColor="#808080" Font-Size="Small"   Text='<%# Eval("PreviousMonthBalance") %>' ></asp:Label> <br />
                                                    </div>
                                                     <div class="col-xs-3 col-md-3" style="margin-top:10px;">
                                                        Current Bill :  <asp:Label ID="lblCurrentBill" runat="server"   Font-Bold="true" ForeColor="#808080" Font-Size="Small"  Text='<%# Eval("CurrentBillAmount") %>' ></asp:Label>
                                         
                                                    </div>
                                                    <div class="col-xs-3 col-md-3" style="margin-top:10px;">
                                                        Total Due:  <asp:Label ID="lblTotalDue" runat="server" ForeColor="#000000" Font-Bold="true" Font-Size="Small" Text='<%# Eval("CurrentMonthBalance") %>'></asp:Label>
                                                    </div>
                                                    <div class="col-xs-3 col-md-3" style="margin-top:10px;">
                                                            Due On: <asp:Label ID="lblDueDate" runat="server" ForeColor="#333333" Font-Bold="true" Font-Size="Small" Text='<%# Eval("PaymentDueDate","{0:dd MMM yyyy}") %>'></asp:Label>
                                                    </div>
                                                          <div class="col-xs-3" style="margin-top:10px;">
                                                        <asp:LinkButton ID="linkDetail" runat="server" OnCommand="linkDetails_Click" CommandArgument='<%# Eval("PayID") %>' ForeColor="#000000" Font-Size="small" CommandName="linkDetails_Click"> Show Details</asp:LinkButton>
                                                    </div>
                                                    <div class="col-xs-3" style="margin-top:10px;">
                                                        <asp:LinkButton ID="linkPay" runat="server" OnCommand="PayLink_Click" CommandArgument='<%# Eval("PayID") %>' ForeColor="#ffffff" CssClass="btn btn-primary" Font-Size="small" CommandName="PayLink_Click"> Pay Now</asp:LinkButton>
                                                    </div>
                                                </div>

                                                    
                                                </div>
                                            </div>
                                                
                                            </div>
                              
                                        </ItemTemplate>
                     
                                 <AlternatingItemStyle />
          
                                    </asp:DataList>

                               <div style="text-align:center;width:70%;margin-left:15%;">
                                          <asp:Label ID="lblPaymentCheck" runat="server" ForeColor="#4FA7FF"></asp:Label>
                                  
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
                                                        Amount :
                                              </td>
                                                      <td  style="width:50%;padding-left:3%;">
                                                          <asp:Label ID="lblAmtPaid" runat="server"></asp:Label>
                                                      </td>
                                               </tr>

                                                <tr>
                                                    <td  style="width:50%;text-align:right;">
                                                        Balance :
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
                                                       Date :
                                              </td>
                                                      <td style="width:50%;padding-left:3%;">
                                                          &nbsp;<asp:Label ID="lblCurrentTime" runat="server"></asp:Label>
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
                                                                   <td colspan="3" style="width:100%;">

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
                                                                          <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtTransaID" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
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
                                                                       <asp:Label ID="lblBillPaidstatus" runat="server" ForeColor="Red"></asp:Label>
                                                                   </td>
                                                               </tr>
                                                               <tr>
                                                                   <td style="height: 50px;text-align:right;">
                                                                       <asp:Button ID="btnpaymannual" runat="server" Text="Submit" CssClass="send" OnClick="btnpaymannual_Click" />
                                                                   </td>


                                                                   <td colspan="2"  style="text-align:center;">
                                                                         <asp:Button ID="btnpayCancel" runat="server" Text="Cancel" CssClass="send"  CausesValidation="False" OnClick="btnpayCancel_Click" />
                                                                   </td>
                                                               </tr>
                                                           </table>

                           </asp:View>

                         <asp:View ID="BillDetailView" runat="server">
                             <div class="heading_div" >
                                <h3> Bill Details: </h3>
                             </div>
                             <asp:Label ID ="lblBillDetails" runat="server"></asp:Label>
          
                             <br />
                              <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn btn-default"  CausesValidation="False" OnClick="btnBack_Click" />
                              <asp:Button ID="btnPay" runat="server" Text="Pay Now" CssClass="btn btn-success"  CausesValidation="False" OnClick="btnPay_Click" />
                         </asp:View>
       
                        </asp:MultiView>
                </div>
     
                </form>
            </div>

        </div>
    </div>         
        
</body>
</html>
