<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewUser.aspx.cs" Inherits="NewUser" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
            <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <script>

        var UserName = "";
        $(document).ready(function () {
            var userName = '<%=UserName %>';
                

        var MobileNumber = '<% =MobileNumber%>';

        document.getElementById("#text").innerHTML = userName;


        });

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            User is not associated with any Flat or Society, Please add flat.
            <label id="text"></label>
        </div>
    </form>
</body>
</html>
