<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyHouse.aspx.cs" Inherits="MyHouse" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8"/>
   <meta name="viewport" content="width=device-width, initial-scale=1"/>
      
    <link href="Styles/MyFlat.css" rel="stylesheet" type="text/css" />
      <script src="Scripts/jquery-1.11.1.min.js"></script>
     
    <link rel="stylesheet" href="CSS/ApttTheme.css" />
    <link rel="stylesheet" href="CSS/ApttLayout.css" />

             <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
            <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
            <!-- jQuery library -->
            <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
   
            <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css"/>  
      
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
    <div class="container-fluid">
        <div class="row">

            <div class="container-fluid">
                <div class="row" style="height: 40px;">
                    <div class="col-sm-3  col-xs-12">
                        <h3 class="pull-left ">My Flat:</h3>
                    </div>
                    <div class="col-sm-6 hidden-xs" style="padding: 0px;">
                    </div>
                    <div class="col-sm-3 hidden-xs" style="vertical-align: middle;">
                        <div>
                        </div>
                    </div>

                    <div id="HouseDetails" class="content_div">
                         <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                             <div class="col-sm-4">
                                 <label class="data_heading">House Number :</label>
                                 <label class="data_label" id="lblFlatNumber"><%= HouseNo%></label>
                             </div>
                             <div class="col-sm-4">
                                 <label class="data_heading">Address :</label>
                                 <label class="data_label" id="lblFlatFloor"><%= Address%></label>
                             </div>
                             <div class="col-sm-4">
                                 <label class="data_heading">City :</label>
                                 <label class="data_label" id="lblIntercomNumber"><%= City%></label>
                             </div>
                         </div>
                        </div>


                </div>
            </div>
        </div>
    </div>
</body>
</html>
