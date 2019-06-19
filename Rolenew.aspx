<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Rolenew.aspx.cs" Inherits="Rolenew" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

        <head runat="server">
            <title></title>
            <meta name="viewport" content="width=device-width, maximum-scale=1, initial-scale=1, user-scalable=0" />
            <meta name="description" content="The MyAptt System is developed considering the day to day needs of society like complaints, Notification, social communication as well as managing the Residents, Vendors, and Employees Data of a society. Application caters the need of small to large societies and also provide the customization to meet your specific needs." />
            <meta name="keywords" content="Society Management,Residential Society Management,Complaint Management,Society Expenses,Billing Software" />
            <meta name="developer" content="Anvisys Technologies Pvt. Ltd." />

            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
            <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js"></script>
            <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>
            <link rel="Stylesheet" href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.10/themes/redmond/jquery-ui.css" />
            <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />
            <link href="CSS_3rdParty/settings.css" rel="stylesheet" type="text/css" />
            <link href="CSS_3rdParty/layout.css" rel="stylesheet" type="text/css" />
            <link href="CSS_3rdParty/layout-responsive.css" rel="stylesheet" type="text/css" />
            <link href="CSS/mystylesheets.css" rel="stylesheet" />
            <link rel="stylesheet" href="CSS_3rdParty/footer.css" />
            <link rel="stylesheet" href="CSS/IP.css" />
            <link rel="stylesheet" href="CSS/Nestin.css" />
            <link rel="stylesheet" href="CSS/Nestin-3rdParty.css" />
            <script type="text/javascript" src="Scripts/datetime.js"></script>
</head>
<body>

    <form id="form1" runat="server">
        <header id="topNav" class="layout_header" style="height: 75px; background-color: #727cf5; color: #fff;">

            <div class="container-fluid">
                <div class="col-sm-4 col-xs-6 zero-margin">
                    <!-- Mobile Menu Button -->

                    <a class="logo" href="MainPage.aspx">
                        <img src="Images/Icon/Logo1.png" height="50" alt="logo" />
                    </a>
                </div>
                <div class="col-sm-4 hidden-xs zero-margin">
                    <!-- Logo text or image -->

                    <h1 class="header-title" style="color: #fff; padding-top: 11px; text-align: center; font-size: x-large;">Society Management System</h1>
                    <!-- Top Nav -->

                </div>
                <div class="col-sm-4 col-xs-6 zero-margin">
                    <button class="btn btn-mobile" data-toggle="collapse" data-target=".nav-main-collapse"><i class="fa fa-bars"></i></button>
                    <div class="navbar-collapse nav-main-collapse collapse pull-right" style="margin-top: 9px; color: white; text-align: center;">
                        <nav class="nav-main mega-menu">
                            <ul class="nav nav-pills nav-main scroll-menu" id="topMain">
                                <li id="linkDashboard"><a href="MainPage.aspx">Dashboard</a></li>
                                <li>
                                    <asp:LinkButton ID="btnlogout" runat="server" Text="Logout" OnClick="btnlogout_Click"></asp:LinkButton></li>
                            </ul>
                        </nav>
                    </div>
                </div>
                <!-- /Top Nav -->

            </div>
        </header>


        <div style="margin-top: 100px;">

            <asp:GridView ID="gridViewRequests" runat="server"
                AutoGenerateColumns="false" OnRowDataBound="gridRequest_DataBound">
                <Columns>
                    <%--<asp:BoundField DataField="FlatNumber" HeaderText="Flat" />--%>
                    <asp:TemplateField HeaderStyle-Width="50px">
                        <HeaderTemplate>
                            <asp:Label ID="lblFlat" runat="server" Text="Flat"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <label onclick='<%# "Click(" + Eval("ResID")+","+Eval("Status")+")" %>' class="BillActiveGrid">
                                <%# Eval("FlatNumber") %>
                            </label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="SocietyName" HeaderStyle-Width="100px" HeaderText="Society" />
                    <asp:BoundField DataField="FlatNumber" HeaderStyle-Width="40px" HeaderText="Flat" ItemStyle-Width="40px" />
                    <asp:BoundField DataField="ActiveDate" DataFormatString="{0:dd/MMM/yy}" HeaderStyle-Width="100px" HeaderText="Active From" />
                    <asp:BoundField DataField="DeActiveDate" DataFormatString="{0:dd/MMM/yy}" HeaderStyle-Width="100px" HeaderText="Active Till" />
                    <asp:BoundField DataField="Status" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hiddencol" />
                    <asp:BoundField DataField="Status" HeaderStyle-Width="100px" HeaderText="Status" />
                </Columns>
                <EmptyDataRowStyle BackColor="#EEEEEE" />
                <HeaderStyle BackColor="#0065A8" Font-Bold="false" Font-Names="Modern" Font-Size="Small" ForeColor="White" Height="30px" />

            </asp:GridView>

        </div>

    </form>

</body>
</html>
