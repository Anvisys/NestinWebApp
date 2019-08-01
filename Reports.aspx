<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Reports.aspx.cs" Inherits="Reports" %>

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
           
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    
            <script src="Scripts/jquery-1.11.1.min.js"></script>
            <link rel="stylesheet" href="mystylesheets.css" /> 
            <link rel="stylesheet" href="/CSS/ApttTheme.css" />
            <link rel="stylesheet" href="CSS/ApttLayout.css" />
      
    
           
    <script>

        $(document).ready(function () {

            window.parent.FrameSourceChanged();
        });
    </script>
</head>
<body style="background-color:#f7f7f7;"> 

          <div class="container-fluid">
           <div class="row">          
            <div  class="col-xs-12 col-sm-12">
               <form id="form1" runat="server">
                <div class="container-fluid">
                         <div class="row" style="height: 50px;">
                            <div class="col-sm-3  col-xs-2">
                                <div>
                                    <h4 class="pull-left ">Report :</h4>
                               </div>
                            </div>
                         </div>
                               <div class="row">
                                <div class="col-md-12" style="font-size: 20px !important; font-family:'Times New Roman', Times, serif !important; color: red !important; text-align:center; margin-top: 20%;">
                                    <asp:Label ID="lblmessage" runat="server"></asp:Label>
                                </div>
                               </div>
                     
                    <div class ="row" style="margin-top:5px;" id="reports" runat="server">
                        <div class="col-sm-6 hcenter" style="margin-top:10px;" >
                               <div class="layout_shadow_box">
                                   <asp:Chart ID="ReportBarchart" runat="server" IsMapAreaAttributesEncoded="True" Height="250px" BackColor="white">
                                   <Titles>
                                     <asp:Title Font="Verdana, 12pt" Name="Title1" Text="Age Of Complaints">
                                     </asp:Title>
                                   </Titles>
                                   <series>
                                     <asp:Series Name="Series1" IsXValueIndexed="True" IsVisibleInLegend="True">
                                     </asp:Series>
                                   </series>
                                   <chartareas>
                                     <asp:ChartArea Name="ChartArea1" BackColor="white" >
                                     </asp:ChartArea>
                                   </chartareas>
                                </asp:Chart>
                                   <asp:Label ID="lblbarchart" runat="server" ForeColor="Gray"></asp:Label>
                               </div>
                        </div>

                        <div class="col-sm-6 hcenter" style="margin-top:10px;">
                            <div class="layout_shadow_box">
                                 <asp:Chart ID="ReportPieChart" runat="server" EnableViewState="True" AlternateText="Percentage Of Complaints" Height="250px">
                                    <Titles>
                                        <asp:Title Font="verdana,12pt" Name="Title1" Text="Complaint Categories"></asp:Title>
                                    </Titles>
                                   <Series>
                                      <asp:Series Name="Series1" ChartType="Pie" LegendMapAreaAttributes="#VALX" LegendText="#VALX"   ChartArea="ChartArea1" Legend="Legend1" CustomProperties="PieDrawingStyle=SoftEdge" MarkerSize="0" MarkerStyle="Circle" Font="Microsoft Sans Serif, 8.25pt" LabelAngle="8" LabelBackColor="Transparent" LabelForeColor="White">
                                      </asp:Series>
                                   </Series>
                                   <ChartAreas>
                                      <asp:ChartArea Name="ChartArea1" BackColor="white">
                                      </asp:ChartArea>   
                                   </ChartAreas>
                                   <Legends>
                                      <asp:Legend Name="Legend1" 
                                          IsDockedInsideChartArea="False" HeaderSeparator="Line" BackColor="White" TitleFont="Microsoft Sans Serif, 11.25pt" Docking="Bottom" Font="Microsoft Sans Serif, 8.25pt" IsTextAutoFit="False" Alignment="Center">
                                         <CustomItems>
                                           <asp:LegendItem ImageStyle="Marker">
                                           </asp:LegendItem>
                                         </CustomItems>
                                      </asp:Legend>
                                   </Legends>
                                      <BorderSkin PageColor="white" />
                                </asp:Chart>
                                 <asp:Label ID="lblpiechart" runat="server" ForeColor="Gray"></asp:Label>
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
