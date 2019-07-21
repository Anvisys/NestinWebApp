<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <meta name="viewport" content="width=device-width, initial-scale=1"/>
            <!-- Latest compiled and minified CSS -->
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>

            <!-- jQuery library -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

            <!-- Latest compiled JavaScript -->
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
           
           <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css"/>
       
           <script src="Scripts/jquery-1.11.1.min.js"></script>
        
        <link rel="stylesheet" href="CSS/ApttTheme.css" />
    <link rel="stylesheet" href="CSS/ApttLayout.css" />
   
    <style>

         .dashboard_box{
       margin-top:1%;
       top:70px; 
      padding-left:5px;
       cursor:pointer;
       border-radius:5px;
       vertical-align:central;
       overflow:hidden;

            
     }
         .myclass2{
             padding-bottom:10px;
 
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);

  
         }
         .dashboard_box:hover{
             box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2), 0 5px 10px 0 green;
         }

         .dashboard_box p{
           text-align:center;
         }

        .dashboard_box label{
            align-self:initial;
            margin-left:5px;
            padding-left:5px;
            text-overflow: ellipsis;
        }
        .panel-body {
            
        }
        .panel-success>.panel-heading {
    color: #000;
    background-color: #dff0d8;
    border-color: #d6e9c6;
    font-family: verdana;
}

    </style>
    <script>



</script>

</head>
<body style="background-color:#f7f7f7">
      <div class="container-fluid">
        <div class="row">
            <div class="col-xs-12">
    <form id="form1" runat="server">
            
    <div class="container-fluid" style="width:100%;">
        <div class="row" style="margin-top:15px;">
            <div class="col-xs-12 col-sm-4 col-md-4" style="margin-top:2px;">
                   <div class="panel panel-success myclass2" onclick="location.href='MyFlat.aspx'" style="background-color:#2ECC71;cursor:pointer;height:170px; color:#fff">
                        <div class="panel-heading">Society Information</div>
                       <div class="panel-body zero-margin">
                           <table style="width: 100%;margin-top:20px;">
                               <tr>
                                    <td style="width: 40%; text-align:center;">
                                       <span class="fa fa-home fa-4x"></span>

                                   </td>
                                   <td style="width: 60%;">
                                       <asp:Label ID="lblFlatInfo" runat="server"></asp:Label>

                                   </td>
                                  
                               </tr>
                           </table>
                           </div>
                   </div>
            </div>
            <div class="col-xs-12 col-sm-4 col-md-4" style="margin-top:2px;">
                   <div class="panel panel-success myclass2" onclick="location.href='BillPayments.aspx'" style="background-color:#E74C3C;cursor:pointer;height:170px; color:white;">
                   <div class="panel-heading">My Bills</div> 
                    <div class="panel-body">
                    <table style="width:100%;">
                        <tr>
                            
                            <td style="width:40%;">
                                <asp:Chart ID="billChart" runat="server" Height="85px" Width="85px" BackColor="#E74C3C" >
                                                            <%--  <Series>
                                                               <asp:Series Name="Series1" ChartType="Pie"  LegendText="#VALX" ChartArea="billChartArea" Legend="billLegend" CustomProperties="PieDrawingStyle=SoftEdge" MarkerSize="0" MarkerStyle="Circle">
                                                               </asp:Series>
                                                             </Series>
                                                         
                                                           <ChartAreas>
                                                              <asp:ChartArea Name="billChartArea" BackColor="#E74C3C">
                                                              </asp:ChartArea>   
                                                           </ChartAreas>--%>
                                            </asp:Chart>
                            </td>
                            <td style="width:60%;">
                              <asp:Label ID="lblpending" runat="server"></asp:Label>
                                 
                             <ol>
                                <li>Maintance: ₹2000 - Due</li>
                                <li>Electricity: ₹500 - Paid</li>
                                <li>Clud: ₹2500 - Not Generated</li>
                            </ol>
                            
                            </td>
                        </tr>
                    </table>
                </div>
                    </div>
            </div>
            <div class="col-xs-12 col-sm-4 col-md-4" style="margin-top:2px;">
                <div class="panel panel-success myclass2" onclick="location.href='ViewComplaints.aspx'" style="background-color:#138D75;height:170px;cursor:pointer; color:white;">
                   <div class="panel-heading">Complaints</div> 
                    <div class="panel-body zero-margin">
                    <table style="width:100%;margin-top:20px;">
                        <tr>
                            <td style="width:40%;text-align:center">
                                <span class="fa fa-flag-o fa-4x" ></span>
                                 </td>
                            <td style="width:60%;">
                            <asp:Label ID="lblComplaintInfo" runat="server"></asp:Label>
                            </td>
                            
                        </tr>
                    </table>
                </div>
                    </div>
            </div>
    
               <div class="col-xs-12 col-sm-4 col-md-4" style="margin-top:2px;">
                   <div class="panel panel-success myclass2" onclick="location.href='Discussions.aspx'" style="background-color:cadetblue;height:178px;cursor:pointer; color:white;">
                   <div class="panel-heading">Discussion</div> 
                    <div class="panel-body">
                    <table style="width:100%;">
                        <tr>
                            <td style="width:60%;">
                            <asp:Label ID="lblTopForum" runat="server"></asp:Label>
                            </td>
                            
                        </tr>
                    </table>
                </div>
                    </div>
               </div>
               <div class="col-xs-12 col-sm-4 col-md-4" style="margin-top:2px;">
                   <div class="panel panel-success myclass2" onclick="location.href='Notifications.aspx'" style="background-color:#F39C12;height:178px;cursor:pointer; color:white;">
                   <div class="panel-heading">RWA Notice</div> 
                    <div class="panel-body">
                    <table style="width:100%;">
                        <tr>
                            <td style="width:60%;">
                            <asp:Label ID="lblTopNotice" runat="server"></asp:Label>
                            </td>
                            
                        </tr>
                    </table>
                </div>
                    </div>
               </div>
               <%--<div class="col-xs-12 col-sm-4 col-md-4" style="margin-top:2px;">
                                     <div class="panel panel-success myclass2" onclick="location.href='ViewComplaints.aspx'" style="background-color:#2471A3;cursor:pointer; height:178px;">
                                                <div class="panel-heading">Complaints Age</div> 
                                         <asp:Chart ID="BarChart" runat="server" Height="110px" Width="218px" BackColor="#2471A3">
                                                    
                
                                                  <Series>
                                                      <asp:Series Name="Series1" ChartType="Bar"></asp:Series>
                                                  </Series>
                                                  <ChartAreas>
                                                      <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                                                  </ChartAreas>
                                              </asp:Chart>
                   <asp:Label ID="lblEmptyDataText" runat="server" ForeColor="#999999" ></asp:Label>
                   </div>               
               </div>--%>
          
               <div class="col-xs-12 col-sm-4 col-md-4" style="margin-top:2px;">
                   <div class="panel panel-success myclass2" onclick="location.href='Poll.aspx'" style="background-color:#E67E22;height:195px;cursor:pointer; color:white;">
                   <div class="panel-heading">Opinion Polls</div> 
                    <div class="panel-body">
                    <table style="width:100%;">
                        <tr>
                            <td style="width:60%;">
                            <asp:Label ID="lblTopPoll" runat="server"></asp:Label>
                            </td>
                            
                        </tr>
                    </table>
                </div>
                    </div>
                    </div>
               <div class="col-xs-12 col-sm-4 col-md-4" style="margin-top:2px;">
                <div class="panel panel-success myclass2" onclick="location.href='Vendors.aspx'" style="background-color:#16A085;height:195px;cursor:pointer; color:white;">
                   <div class="panel-heading">Vendor Directory</div> 
                    <div class="panel-body">
                    <table style="width:100%;">
                        <tr>
                            <td style="width:60%;">
                            <asp:Label ID="lblOffer" runat="server"></asp:Label>
                            </td>
                            
                        </tr>
                    </table>
                </div>
                    </div>
                   </div>
             <div class="col-xs-12 col-sm-4 col-md-4" style="margin-top:2px;">
                <div class="panel panel-success myclass2" onclick="#" style="background-color:black;height:195px;cursor:pointer; color:white;">
                   <div class="panel-heading">Car Pool</div> 
                    <div class="panel-body">
                    <table style="width:100%;">
                        <tr>
                            <td style="width:60%;">
                            <label typeof="text"> No Car pool Yet to display !! </label>
                            </td>
                            
                        </tr>
                    </table>
                </div>
                    </div>
                   </div>
            <div class="col-xs-12 col-sm-4 col-md-4" style="margin-top:2px;">
                <div class="panel panel-success myclass2" onclick="#" style="background-color: plum;height:195px;cursor:pointer; color:white;">
                   <div class="panel-heading">Rent in & out</div> 
                    <div class="panel-body">
                    <table style="width:100%;">
                        <tr>
                            <td style="width:60%; color: black;">
                            <h6>Flat On rent </h6>
                             <ol>
                                <li>3bhk,Nestin Demo Society</li>
                                <li>2bhk,Nestin Demo Society</li>
                                <li>1bhk,Nestin Demo Society</li>
                            </ol>
                            </td>
                        </tr>
                    </table>
                </div>
                    </div>
                   </div>
<%--               <div class="col-xs-12 col-sm-4 col-md-4" style="margin-top:2px;">
                  
                   <div class="panel panel-success myclass2" onclick="location.href='ViewComplaints.aspx'" style="background-color:#58D68D; height:195px;cursor:pointer; vertical-align:middle; margin-top:0px;">
                       <div class="panel-heading">Complaint Distribution</div>
                                            <asp:Chart ID="Piechart" runat="server" Height="110px" Width="218px" BackColor="#58D68D" >
                                                
                                                              <Series>
                                                               <asp:Series Name="Series1" ChartType="Pie"  LegendText="#VALX" ChartArea="ChartArea1" Legend="Legend1" CustomProperties="PieDrawingStyle=SoftEdge" MarkerSize="0" MarkerStyle="Circle">
                                                               </asp:Series>
                                                             </Series>
                                                            <Legends>  
                                            <asp:Legend Alignment="Center" Docking="Left" IsTextAutoFit="False" Name="Legend1"  BackColor="#58D68D" 
                                                LegendStyle="Column" />  
                                        </Legends>

                                                           <ChartAreas>
                                            
                                                              <asp:ChartArea Name="ChartArea1" BackColor="#58D68D">
                                                              </asp:ChartArea>   
                                                           </ChartAreas>
                                            </asp:Chart>
                        <asp:Label ID="lblpiechart" runat="server" CssClass="lblpiechartText" Text=""></asp:Label>
               </div>
                </div>--%>
           </div>
    
    </div>
  
    </form>
                </div>
            
            </div>
   </div>
</body>
</html>