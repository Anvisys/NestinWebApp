<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillGeneration.aspx.cs" Inherits="BillGeneration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css" />

    
    <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js"></script>  
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>  
    <link rel="Stylesheet" href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.10/themes/redmond/jquery-ui.css" /> 


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

        $(document).ready(function () {
            window.parent.FrameSourceChanged();

            $("#newBillDate").datepicker({ dateFormat: 'dd-mm-yy'});

         });


          function ShowGenerateBillPreview() {
            document.getElementById("newBillDataSection").style.display = "block";
        }

        function HideGenerateBillPreview() {
             document.getElementById("newBillDataSection").style.display = "block";
        }

        
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
             <div id="GenerateBill">
                     
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Generate Bill: 

                                </div>
                                <div class="panel-body">

                                    <div class="row">
                                       
                                        <div class="col-xs-4">
                                         Generate <asp:DropDownList ID="drpGenBillForOnLatest" runat="server" CssClass="layout_ddl_filter"></asp:DropDownList> Bill

                                        </div>
                                        <div class="col-xs-4">
                                          till  <asp:TextBox ID="newBillDate" runat="server" ></asp:TextBox>
                                        </div>
                                        <div class="col-xs-4">
                                            <asp:Button CssClass="btn btn-sm btn-primary" ID="btnGenerateLatest" runat="server" OnClientClick="return ValidateDropdown();" OnClick="btnGenerateLatestBill_Click" Text="Generate Bill" CausesValidation="false" />
                                        </div>
                                    </div>
                                    
                                    <hr />

                                    <div class="row">
                                        <div class="col-xs-4" style="text-align: left">
                                            Import File :
                                        </div>
                                        <div class="col-xs-4">
                                            <asp:FileUpload ID="BillsUpload" runat="server" />

                                        </div>
                                        <div class="col-xs-4" style="text-align: center;">
                                              <asp:Button CssClass="btn btn-primary" ID="BillsUploadSubmit" runat="server" CausesValidation="false" OnClick="BillsUploadSubmit_Click" Text="Submit" />
                                        </div>
                                    </div>
                                                               

                                </div>


                            </div>
                     
                    </div>
            <div style="text-align:center;">

            <asp:Label ID="lblmessage" runat="server" ForeColor="Red" ></asp:Label>
            </div>
            <div id="newBillDataSection" >

                 <asp:GridView ID="NewGeneratedBill" runat="server" 
                     AutoGenerateColumns="false" HorizontalAlign="Center" Width="100%" PageSize="15"  ShowHeader="true" 
                     >
                           <HeaderStyle BackColor="#3eb1ff"  ForeColor="White"  />
                              <EditRowStyle  BackColor="#f2f2f2"/>
                                  <Columns>
                                           <asp:BoundField DataField="FlatID" ItemStyle-Width="20px" HeaderText="FlatID" />
                                           <asp:BoundField DataField="FlatNumber" ItemStyle-Width="30px" HeaderText="FlatNumber" />
                                           <asp:BoundField DataField="BillType" ItemStyle-Width="20px" HeaderText="BillType" />
                                          <%-- <asp:BoundField DataField="PreviousEndDate"  DataFormatString="{0:dd/MMM/yyyy}" ItemStyle-Width="20px" HeaderText="PreviousEndDate" />--%>
                                           <asp:BoundField DataField="BillStartDate"  DataFormatString="{0:dd/MMM/yyyy}" ItemStyle-Width="20px" HeaderText="BillStartDate" />
                                           <asp:BoundField DataField="BillEndDate"  DataFormatString="{0:dd/MMM/yyyy}" ItemStyle-Width="20px" HeaderText="BillEndDate" />   
                                           <asp:BoundField DataField="PaymentDueDate"  DataFormatString="{0:dd/MMM/yyyy}" ItemStyle-Width="20px" HeaderText="PaymentDueDate" /> 
                                           <asp:BoundField DataField="PreviousMonthBalance" ItemStyle-Width="25px" HeaderText="PreviousBalance"/>   
                                           <asp:BoundField DataField="CurrentBillAmount" ItemStyle-Width="25px" HeaderText="CurrentBillAmount"/>   
                                   </Columns>
                              <PagerStyle BackColor="White" ForeColor="#648AD9" />
                       </asp:GridView>

              <asp:Button CssClass="btn btn-primary" ID="btnUpdateDB" runat="server" Text="UpdateDatabase" CausesValidation="false" OnClick="btnUpdateDB_OnClick" />

              <asp:Button CssClass="btn btn-primary" ID="btnSaveExcel" runat="server" Text="Save As Excel" CausesValidation="false" OnClick="btnSaveExcel_OnClick" />
              <asp:Button CssClass="btn btn-primary" ID="btnClear" runat="server" Text="Clear" CausesValidation="false" OnClick="btnClearGrid_OnClick" />
            </div>

        </div>
    </form>
</body>
</html>
