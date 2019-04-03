<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Userprofile.aspx.cs" Inherits="Userprofile" %>

<!DOCTYPE html>
<!--  This Total  code  is  licenced
    Developed By Anvisys Technologies Pvt Ltd.
    
    Copyright © 2016 Anvisys Technologies Pvt. Ltd.All rights reserved.
    -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
   
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <script src="Scripts/jquery-1.12.0.js"></script>
    <link rel="Stylesheet" href="CSS/ApttTheme.css"/>
    <link rel="stylesheet" href="CSS/ApttLayout.css" />

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css"/>

     <!--Added by Aarshi on 22 aug 2017 for image crop code-->
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
    <!-- jQuery library -->
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
   
    
<%--    <script type="text/javascript" src="http://cdn.rawgit.com/tapmodo/Jcrop/master/js/jquery.Jcrop.min.js"></script>--%>

    <script  type="text/javascript" src="http://jcrop-cdn.tapmodo.com/v2.0.0-RC1/js/Jcrop.js"></script>
    <link  rel="stylesheet" href="http://jcrop-cdn.tapmodo.com/v2.0.0-RC1/css/Jcrop.css" type="text/css"/>
    <!--Ends here-->
 

    <script>   

        var FlatID = '';
        var ResiID = '';
        var UserID = '';
        var api_url = '';
       
                window.onload = function SetImage() {

                    document.getElementById("uploadPreview").src = "GetImages.ashx?UserID=" + UserID;
                };

                function LoadMainpage(ResiID) {
                 <%--   //ResiID = '<%=Session["ResiID"] %>';--%>

                    <%--  document.getElementById("uploadPreview").src = "GetImages.ashx?ResID=" + ResiID;--%>

                    window.parent.ProfileChange();
                    //alert("reload Whole Page");
                    //window.top.location.reload();
                };

                function PreviewImage() {         
                    var oFReader = new FileReader();
                    oFReader.readAsDataURL(document.getElementById('UserProfileUpload').files[0]);

                    oFReader.onload = function (oFREvent) {
                        document.getElementById("uploadPreview").src = oFREvent.target.result;
                    };
                };

                $(document).ready(function () {

                    window.parent.FrameSourceChanged();
                    api_url = '<%=Session["api_url"] %>';
                
                    FlatID = '<%=Session["FlatID"] %>';
                    ResiID = '<%=Session["ResiID"] %>';
                    UserID = '<%=UserID %>';



                    $("#update").click(function () {               
                        //  $("#uploadImage").trigger('click');
                        //$("#UserProfileUpload").toggle();
                        $("#UserProfileUpload").css('visibility', 'visible');
                        $("#btnupload").toggle();                            
                    });
                });


                $(document).ready(function () {
                    $("#update").click(function () {
                        
                    });

                    //Added by Aarshi on 22 aug 2017 for image crop code
                    $("#btnCancel").click(function () {
                        $("#image_modal_div").hide();
                      
                        $('#Image_crop').data("Jcrop").destroy();
                        // jcrop_api.destroy();

                        $('#Image_crop').removeAttr('style')
                    });

                    $(".close").click(function () {
                        $("#image_modal_div").hide();
                     
                        $('#Image_crop').data("Jcrop").destroy();
                     
                        $('#Image_crop').removeAttr('style')
                    });
                });



                    //Added by Aarshi on 22 aug 2017 for image crop code
                    var newHeight;
                    var newWidth;
                    var MAX_HEIGHT;
                    var MAX_WIDTH;
                    var box_dimen;
                    $(window).on('load', function(){

                        // $.Jcrop('#cropbox', { trueSize: [500, 370] });
                        MAX_HEIGHT = 0.7 * screen.height;
                        MAX_WIDTH = 0.4 * screen.width;
                     
                        $('#btnOK').click(function () {

                            var x1 = $('#imgX1').val();
                            var y1 = $('#imgY1').val();

                            var width = $('#imgWidth').val();
                            var height = $('#imgHeight').val();

                            var canvas = $("#canvas")[0];
                            var context = canvas.getContext('2d');
                            var img = new Image();
                            img.onload = function () {

                                canvas.height = height;
                                canvas.width = width;

                                context.drawImage(img, x1, y1, width, height, 0, 0, width, height);

                                $('#imgCropped').val(canvas.toDataURL());

                                $('[id*=uploadPreview]').attr('src', canvas.toDataURL());
                                $('#image_modal_div').hide();
                                // $('#UserProfileUpload').hide();
                                $("#UserProfileUpload").css('visibility', 'hidden');
                                $('[id*=btnupload]').show();
                            };
                            img.src = $('#Image_crop').attr("src");

                            $('#Image_crop').data("Jcrop").destroy();
                            // jcrop_api.destroy();

                            $('#Image_crop').removeAttr('style')

                        });
                    });

                    $(function () {
                        $('#UserProfileUpload').change(function () {
                       
                            var reader = new FileReader();
                            reader.onload = function (e) {
                               
                                setCropImage(e.target.result);
                                $('#image_modal_div').show();

                            }
                            reader.readAsDataURL($(this)[0].files[0]);
                        });
                    });

                    function setCropImage(src) {
                      
                        var image = new Image();
                        image.onload = function () {

                            var imageC = document.getElementById("Image_crop");

                            var iHeight = image.height;
                            var iWidth = image.width;

                            var sScale = MAX_HEIGHT / MAX_WIDTH;

                            var iScale = iHeight / iWidth;

                            if (iHeight < MAX_HEIGHT && iWidth < MAX_WIDTH) {
                                newHeight = iHeight;
                                newWidth = iWidth;
                                if (iHeight < iWidth) {
                                    box_dimen = iHeight;
                                }
                                else {
                                    box_dimen = iWidth;
                                }
                            }
                            else {
                                if (iScale > sScale) {
                                    // Fit the height
                                    newHeight = MAX_HEIGHT;
                                    newWidth = (MAX_HEIGHT / iHeight) * iWidth;
                                    box_dimen = MAX_WIDTH;

                                }
                                else {
                                    // Fit the width
                                    newWidth = MAX_WIDTH;
                                    newHeight = (MAX_WIDTH / iWidth) * iHeight;
                                    box_dimen = MAX_HEIGHT;

                                }
                            }

                            imageC.height = newHeight;
                            imageC.width = newWidth;
                            imageC.src = src;
                           
                            $('#image_modal_div').height(newHeight + 70);
                            $('#image_modal_div').width(newWidth +10);
                           
                            $('#Image_crop').Jcrop({
                                aspectRatio: 1,
                                setSelect: [60, 60, 100, 100],
                                boxWidth: box_dimen,
                                boxHeight: box_dimen,
                                onChange: SetCoordinates,
                                onSelect: SetCoordinates
                            });
                           
                        };
                        image.src = src;
                    }

                    function SetCoordinates(c) {
                                
                        $('#imgX1').val(c.x);
                        $('#imgY1').val(c.y);
                        $('#imgWidth').val(c.w);
                        $('#imgHeight').val(c.h);

                    };


                            //Code Ends here

  
    </script>

    <script>
        var res_id;

        window.onload = function GetData() {
        
            sessionStorage.clear();
            //  GetUserData(user_login);

            $("#progressBar").hide();
           
        }

        function GetUserData(user_login) {
          
            $.ajax({
                type: "POST",
                url: "Userprofile.aspx/GetUserData",
                data: '{userLogin:"' + user_login + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert(response.d);
                    sessionStorage.clear();
                }
            });
        }


        function OnSuccess(response) {
             var js = jQuery.parseJSON(response.d);
          
            if (js.length > 0) {
              
                var length = js.length;

                for (var i = 0; i < length; i++) {
                   
                    $('#<%=txtUFName.ClientID %>').val(js[i].FirstName);
                 
                    $('#<%=txtUMobile.ClientID %>').val(js[i].MobileNo);
                  
                    $('#<%=txtUMName.ClientID %>').val(js[i].MiddleName);
                   
                    $('#<%=txtULName.ClientID %>').val(js[i].LastName);
                   
                    $('#<%=txtUEmail.ClientID %>').val(js[i].EmailId);
                  
                    $('#<%=txtUAddress.ClientID %>').val(js[i].Address);
                   
                }
            
            }
            else {
                //alert("NoData")
            }

        }

        function DisableEditData()
        {
           
            $('#<%=txtUFName.ClientID %>').attr('disabled', true);
            $('#<%=txtUMobile.ClientID %>').attr('disabled', true);
            $('#<%=txtUMName.ClientID %>').attr('disabled', true);
            $('#<%=txtULName.ClientID %>').attr('disabled', true);
            $('#<%=txtUEmail.ClientID %>').attr('disabled', true);
            $('#<%=txtUAddress.ClientID %>').attr('disabled', true);
            //$('#<%=btnUsrPrfileSubmit.ClientID %>').hide();
            //$("#btnUsrEprofileCancel").hide();
            $('#btnEdit').hide();

            
        }

        function EnableEditData()
        {
            $('#<%=txtUFName.ClientID %>').attr('disabled', false);
            $('#<%=txtUMobile.ClientID %>').attr('disabled', false);
            $('#<%=txtUMName.ClientID %>').attr('disabled', false);
            $('#<%=txtULName.ClientID %>').attr('disabled', false);
            $('#<%=txtUEmail.ClientID %>').attr('disabled', true);
            $('#<%=txtUAddress.ClientID %>').attr('disabled', false);
            //$('#<%=btnUsrPrfileSubmit.ClientID %>').show();
            //$("#btnUsrEprofileCancel").show();
            $('#btnEdit').show();
            
        }

        $(document).ready(function () {

            $('#btnEditProfile').click(function () {
                EnableEditData();
            });

            $('#btnUsrEprofileCancel').click(function () {

                DisableEditData();
            });

            $("#btnEditSettings,#btnUpdateCancel").click(function () {
                DisableEditData();

                if ($('#divPassword').is(':visible')) {

                    $("#divPassword").hide();
                }
               
                if ($('#divSetting').is(':visible')) {
                  
                   // $("#divSetting").hide();
                } else {
                  
                    GetSettingData();
                   

                }
                $('#divSetting').toggle();
                //document.getElementById("divSetting").style.display = 'block';
            });
            $("#btnUprofilePasscancel").click(function () {
                $('#divPassword').hide();
            });

            $('#btnEditPassword').click(function () {
                DisableEditData();

                if ($('#divSetting').is(':visible')) {

                    $("#divSetting").hide();
                }


                if ($('#divPassword').is(':visible')) {

                    $("#divPassword").hide();
                } else {

                    $("#divPassword").show();

                }


            });


            $('#btnUpdateSetting').click(function(){
                UpdateSettingData();

            });


        });

        function UpdateSettingData() {

            var billNotice = $('#<%=chkBillingNotice.ClientID %>').prop('checked');
            var billMail = $('#<%=chkBillingMail.ClientID %>').prop('checked');
            var billSms  =   $('#<%=chkBillingSMS.ClientID %>').prop('checked');

            var compNotice=  $('#<%=chkComplaintNotice.ClientID %>').prop('checked');
            var compMail =   $('#<%=chkComplaintMail.ClientID %>').prop('checked');
            var compSms =    $('#<%=chkComplaintSMS.ClientID %>').prop('checked');

            var ForumNotice=    $('#<%=chkForumNotice.ClientID %>').prop('checked');
            var ForumMail  =    $('#<%=chkForumMail.ClientID %>').prop('checked');
            var ForumSms  =     $('#<%=chkForumSMS.ClientID %>').prop('checked');
                    
            var Notice    =    $('#<%=ChkNoticeNotification.ClientID %>').prop('checked');
            var noticeMail=    $('#<%=chkNoticeMail.ClientID %>').prop('checked');
            var noticeSms = $('#<%=chkNoticeSMS.ClientID %>').prop('checked');
            
            
            return;
               


            var settingData = "{\"UserId\":\""+UserID+ "\", \"BillingNotification\":\"" + billNotice + "\",\"BillingMail\":\"" + billMail + "\", \"BillingSMS\":\"" +billSms
                    + "\", \"ComplaintNotification\":\"" + compNotice + "\", \"ComplaintMail\":\"" + compMail + "\", \"ComplaintSMS\":\"" +compSms + "\", \"forumNotification\":\"" + ForumNotice
                + "\", \"forumMail\":" + ForumMail + ", \"forumSMS\":\"" + ForumSms + ", \"NoticeNotification\":\"" + Notice
                + ", \"NoticeMail\":\"" + noticeMail+ "\", \"NoticeSMS\":\"" + noticeSms+ "\"}";
            
             var updateUrl = api_url + "/api/User/Setting/" + UserID;
            
          
            $.ajax({
                type: "Post",
                url: updateUrl,
                data: settingData,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccessSetting,
                failure: function (response) {
                    alert(response.d);
                    sessionStorage.clear();
                }
            });

        };

        function GetSettingData() {
             
            var compUrl = api_url + "/api/User/Setting/" + UserID;
        
            $.ajax({
                type: "Get",
                url: compUrl,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccessSetting,
                failure: function (response) {
                    alert(response.d);
                    sessionStorage.clear();
                }
            });
        };


        function OnSuccessSetting(response) {
       
           var js = response;

                $('#<%=chkBillingNotice.ClientID %>').prop('checked', js.BillingNotification);
                $('#<%=chkBillingMail.ClientID %>').prop('checked', js.BillingMail);
                $('#<%=chkBillingSMS.ClientID %>').prop('checked', js.BillingSMS);

                $('#<%=chkComplaintNotice.ClientID %>').prop('checked', js.ComplaintNotification);
                $('#<%=chkComplaintMail.ClientID %>').prop('checked', js.ComplaintMail);
                $('#<%=chkComplaintSMS.ClientID %>').prop('checked', js.ComplaintSMS);

                $('#<%=chkForumNotice.ClientID %>').prop('checked', js.forumNotification);
                $('#<%=chkForumMail.ClientID %>').prop('checked', js.forumMail);
                $('#<%=chkForumSMS.ClientID %>').prop('checked', js.forumSMS);
                    
                $('#<%=ChkNoticeNotification.ClientID %>').prop('checked', js.NoticeNotification);
                $('#<%=chkNoticeMail.ClientID %>').prop('checked', js.NoticeMail);
                $('#<%=chkNoticeSMS.ClientID %>').prop('checked', js.NoticeSMS);

                $("#divSetting").show();
         
           
        };

    </script>


    <style type="text/css">

         /*Added by Aarshi on 22 aug 2017 for image crop code*/
        #image_modal_div{
            border:1px solid #818181;
            border-radius:3px;
             box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2), 0 5px 10px 0 rgba(0, 0, 0, 0.19);
            display: none;
            position:absolute; 
            top:50px;
            left:50px;
            background-color:gray;
        }

        .btnModal_style {
            background-color: rgb(51, 51, 51);
            color: white;
            width: 50px;
            font-weight: lighter;
            box-sizing: content-box;
            border-style: solid;
            border-color: white;
            border-radius: 12px;
            outline: 0px;
            /*padding: 1% 0%;*/
            margin-top:10px;

        }

        /*Ends here*/

 .edit{
    background-color:white;
    background-image:url('Images/Icon/edit_profile.png');
    background-repeat:no-repeat;
    border:1px solid white;
    outline:0;
    margin-top:5%;
    color:#808080;
}

.img{
    
    border-radius:50%;
    outline:0;
    text-align:center;
     transition: background-color 1s;
    background-position:center;
}
 
   .fileupload{
      /*display:none;*//*Commented by Aarshi on 22 aug 2017 for image crop code*/
     visibility:hidden;/*Added by Aarshi on 22 aug 2017 for image crop code*/
       width:90%;/*Changed by Aarshi on 22 aug 2017 for image crop code*/
       text-align:center;
      
   }
    .btnupload{
        display:none;
       color:white;
       border:1px solid #f2f2f2;
       background-color:#f3a56b;
       margin-top:7%;
       outline:0;
    }

    .lblname{
        text-align:center;
    }

    div.show-image {
    position: relative;
    margin:15px;
}

div.show-image:hover img{
    opacity:0.8;
}
div.show-image:hover #update  {
    display: block;
}
div.show-image #update  {
    position:absolute;
    display:none;
}
div.show-image #update {
    bottom:35%;
    left:20%;
    background-color:transparent;
    outline:0;
    width:0%;
    height:0;
}
#profile_section {
    padding-bottom:20px;
    margin-top:15px;
}
.rohit {
    margin-left: 343px;
    margin-top:15px;
}
    </style>


</head>
 <body style="width:100%;background-color:#f7f7f7;">
     <div class="container-fluid">
         <div class="row">
             <div class="col-xs-12">

                                    <div class="container-fluid hidden-xs">
                                       <div class="row layout_header" style="height:50px;">
                                         <div class="col-sm-3" >
                                           <h3 class="pull-left">My Profile:</h3>
                                         </div>
                                        <div class="col-sm-6 col-xs-12" style="padding:0px;">
                                      
                                           </div>
                                 <div class="col-sm-3 hidden-xs" style="vertical-align:middle;">
                                    <div>
                         
                                    </div>
                                 </div>
                                 </div>
                                     </div>
            
    
                        <form id="form1" runat="server">
   
                            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                            <div class="container-fluid">

                                <div class="row">
                                              <div class="col-sm-3 col-xs-12" style="text-align:center; margin-top:15px;">        
                                                <div class="layout_shadow_box">
                                                      <div class="show-image" >        
                                                       <img id="uploadPreview" class="img" src="GetImages.ashx?UserID=<% =UserID %>&Name=<% =UserNameFirstLetter %>&UserType=<% =UserType %>"  style="max-height:150px; min-height=100px; max-width:150px;min-width:100px; background-position:center;text-align:center;"/><br />                    
                                                          <canvas id="canvas" height="5" width="5" style="display:none;"></canvas>
                                                          <i class="fa fa-camera" id="update" style="font-size:16px; color:black;"></i>
                                                            <asp:Label ID="lbluser" runat="server" CssClass="lblname"   Font-Size="X-Large" ForeColor="#808080" Visible="false"></asp:Label>  
                                                               <asp:Label ID="lblProfileimgErr" runat="server" Font-Size="Small" ForeColor="#3E9EFF"></asp:Label>                  
                                                      </div>

                                                        <div>
                                                            <asp:FileUpload ID="UserProfileUpload" runat="server" style="margin-left:47px;" ForeColor="white" CssClass="fileupload"/>
                                                        </div>
                              
                                                        <div>
                                                            <input type="hidden" name="imgX1" id="imgX1" />
                                                            <input type="hidden" name="imgY1" id="imgY1" />
                                                            <input type="hidden" name="imgWidth" id="imgWidth" />
                                                            <input type="hidden" name="imgHeight" id="imgHeight" />
                                                            <input type="hidden" name="imgCropped" id="imgCropped" />
                                                        </div>

                                                          <asp:Button ID="btnupload" runat="server" OnClick="btnupload_Click" Text="Upload" Height="28px" CssClass="btnupload" /><br />              

                                                    </div>
                                                 
                                            </div>

                                            <div class="col-sm-9 col-xs-12 ">
                                                <div id="profile_section" class="container-fluid layout_shadow_box">
                                                    <div class="row">
                                                        <div class="col-xs-12">
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ValidationExpression="^[a-zA-Z0-9.@]{0,25}$"  runat="server" ErrorMessage="Enter valid Name" ControlToValidate="txtUFName" Font-Size="Small" ForeColor="Red"></asp:RegularExpressionValidator>
                                                           <asp:RegularExpressionValidator ID="RegularExpressionValidator6" ValidationExpression="^[a-zA-Z\s0-9.]{0,25}$"  runat="server" ErrorMessage="Enter valid Name" ControlToValidate="txtULName" Font-Size="Small" ForeColor="Red"></asp:RegularExpressionValidator>
                                                           <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationExpression="^[0-9]{10}" ErrorMessage="Enter valid no." Font-Size="Small" ForeColor="Red" ControlToValidate="txtUMobile"></asp:RegularExpressionValidator>
                                                           <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtUEmail" ErrorMessage="Enter valid Email" Font-Size="Small" ForeColor="Red"></asp:RegularExpressionValidator>
                                                           <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ValidationExpression="^[a-zA-Z\s0-9.@,-]{0,25}$" ControlToValidate="txtUAddress" ErrorMessage="Enter valid Address" Font-Size="Small" ForeColor="Red"></asp:RegularExpressionValidator>
                 
                                                        </div>
                                                    </div>
                                                    <div class="row" >
                                                    <div class="col-sm-6">
                                                        <table class="" style="border-collapse:collapse;color:#000; width:100%;text-align:left;">
                                                             <tr style="height:30px;">
                                                                 <td style=" width:40%;">
                                                                        First Name : </td>
                                                                    <td style="width:55%;" >
                                                                         <asp:TextBox ID="txtUFName" runat="server" CssClass="txtbox_style"></asp:TextBox>
                                    
                                                                    </td>
                                                                 <td style="width:5%;">
                                                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtUFName" ErrorMessage="*" ForeColor="Red" ValidationGroup="one"></asp:RequiredFieldValidator>
                                                                 </td>
                                                              </tr>
                                                             <tr style="height:30px;">
                                                                  <td  style="width:40%;">Middle Name :</td>
                                                                    <td style="width:55%;">
                                                                      <asp:TextBox ID="txtUMName" runat="server" CssClass="txtbox_style"></asp:TextBox>
                                                                    </td>
                                                                 <td style="width:5%;">

                                                                 </td>
                                                              </tr>
                                                             <tr style="height:30px;">
                                                                   <td style=" width:40%;">
                                                                        Last Name 
                                                                    </td>

                                                                    <td  style="width:55%;" >
                                                                         <asp:TextBox ID="txtULName" runat="server" CssClass="txtbox_style"></asp:TextBox>
                                                                    </td>
                                                                 <td style="width:5%;">

                                                                 </td>
                                                              </tr>
                                                             <tr style="height:30px;">
                                                                 <td style=" width:40%;" class="auto-style1">
                                                                    Mobile :</td>
                                                                <td style="width:55%;">
                                                                      <asp:TextBox ID="txtUMobile" runat="server" CssClass="txtbox_style" MaxLength="10"></asp:TextBox>
                                
                                                                </td>
                                                                 <td style="width:5%;">
                                                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtUMobile" ErrorMessage="*" ForeColor="Red" ValidationGroup="one"></asp:RequiredFieldValidator>
                                                                 </td>
                                                              </tr>
                                                             <tr style="height:30px;">
                                                                   <td style=" width:40%;">
                                                                        Email :</td>          
                                                                    <td style="width:55%;">
                                                                         <asp:TextBox ID="txtUEmail" runat="server" CssClass="txtbox_style"></asp:TextBox>
                                    
                                                                    </td>
                                                                 <td style="width:5%;">
                                                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtUEmail" ValidationGroup="one"></asp:RequiredFieldValidator>
                                                                 </td>
                                                              </tr>
                                                             <tr style="height:30px;">
                                                                      <td style=" width:40%;">
                                                                            Address :</td>          
                                                                        <td style=" width:55%;">
                                                                            <asp:TextBox ID="txtUAddress" runat="server" CssClass="txtbox_style"></asp:TextBox>
                                        
                                                                        </td> 
                                                                 <td style="width:5%;">
                                                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtUAddress" ErrorMessage="*" ForeColor="Red" ValidationGroup="one"></asp:RequiredFieldValidator>
                                                                 </td>
                                                              </tr>

                                                        </table>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <table class="" style="border-collapse:collapse;color:#000; width:100%;text-align:left;">
                                                              <tr style="height:30px;">
                                                                 <td style=" width:40%;"  >
                                                                   User Type:
                                                                 </td>
                                                                <td style="width:60%;" >
                                                                    <asp:Label ID="lblUsrResType" runat="server"></asp:Label>
                                                                </td>
                                                              </tr>
                                                             <tr style="height:30px;">
                                                                   <td style=" width:40%;"  >
                                                                        Society Name:
                                                                     </td>
                                                                    <td style="width:60%;" >
                                                                        <asp:Label ID="lblsocietyname" runat="server"></asp:Label>
                                                                    </td>
                                                              </tr>
                                                             <tr style="height:30px;">
                                                                  <td style=" width:40%;">             
                                                                  Active Date :
                                                                  </td>
                                                                <td style="width:60%;">
                                                                    <asp:Label ID="lblActivedate" runat="server"></asp:Label>
                                                                 </td> 
                                                              </tr>
                                                             <tr style="height:30px;">
                             
                                                                     <td style=" width:40%;">
                                                                  Flat Number 
                                                                         :</td>
                                                                     <td style="width:60%;">
                                                                        <asp:Label ID="lblFlatNo" runat="server"></asp:Label>
                                                                    </td>
                                                              </tr>
                                                           
                                                             <tr style="height:30px;">
                                                                  <td style=" width:40%;">
                                                                    Intercom No:
                                                                 </td>
                                                                 <td style="width:60%;">
                                                                    <asp:Label ID="lblIntercom" runat="server"></asp:Label>
                                                                </td>
                                                              </tr>

                                                        </table>
                                                    </div>
                                                     </div>
                                                    <div id="btnEdit" class="row" style="display:none;padding-top:10px;">
                                                        <div class="col-xs-12" >
                                                            <asp:Button ID="btnUsrPrfileSubmit" runat="server" CssClass="btn btn-primary" Text="Submit" OnClick="btnUsrPrfileSubmit_Click1" /><span style="width:10px;"></span>
                                                            <button type="button" style="margin-left:20px;" id="btnUsrEprofileCancel" class="btn btn-danger">Cancel</button>
                       
                                                        </div>
                                                    </div>
                                                </div>
           
                                                <div id="divSetting" class="layout_shadow_box container-fluid" style="padding:20px;display:none;">
                                                    <div class="row" style="margin-top:10px;">
                                                            <div class="col-sm-4" style="text-align:left; padding-left:10px; font-size:medium; color:rgb(51, 51, 51);">
                                                          <label><b>Send Notifications on :</b></label> <br />
                                                       
                                                                <asp:CheckBox runat="server" ID="chkComplaintNotice" Text=" Complaint Edit"/> <br />
                        
                                                                <asp:CheckBox runat="server" ID="chkForumNotice" Text=" Forum Update"/>  <br />
                        
                                                                <asp:CheckBox runat="server" ID="chkBillingNotice" Text=" Bill Update"/>  <br />

                                                                <asp:CheckBox runat="server" ID="ChkNoticeNotification" Text=" Notification Update"/>  <br />
                       
                                                         </div>
                                                        
                                                         
                                                            <div class="col-sm-4" style="text-align:left; padding-left:10px; font-size:medium; color:#000;">
                                                                <label><b>Send Mails on : </b></label><br />
                                                               
                                                                        <asp:CheckBox runat="server" ID="chkComplaintMail" Text=" Complaint Edit"/> <br />
                                   
                                                                        <asp:CheckBox runat="server" ID="chkForumMail" Text=" Forum Update"/> <br />
                                   
                                                                        <asp:CheckBox runat="server" ID="chkBillingMail" Text=" Bill Update"/> <br />

                                                                        <asp:CheckBox runat="server" ID="chkNoticeMail" Text=" Notification Update"/> <br />
                                   
                                                            </div>

                                                        <div class="col-sm-4" style="text-align:left; padding-left:10px; font-size:medium; color:#000;">
                                                                <label><b>Send Sms on :</b></label><br />
                                                               
                                                                        <asp:CheckBox runat="server" ID="chkComplaintSMS" Text=" Complaint Edit"/> <br />
                                   
                                                                        <asp:CheckBox runat="server" ID="chkForumSMS" Text=" Forum Update"/> <br />
                                   
                                                                        <asp:CheckBox runat="server" ID="chkBillingSMS" Text=" Bill Update"/> <br />

                                                                        <asp:CheckBox runat="server" ID="chkNoticeSMS" Text=" Notification Update"/> <br />
                                   
                                                            </div>
                                                         </div>
                                                    <div style="margin-top:10px; margin-bottom:10px;">
                                                        <asp:Button ID="btnUpdateSetting" runat="server" CssClass="btn btn-success" Text="Update" OnClick="btnUpdateSetting_Click" />
                                                        <button type="button" id="btnUpdateCancel" class="btn btn-danger ">cancel</button>
                                                        
                                                    </div>
                                                       </div>
           
                                                <div id="divPassword" class="layout_shadow_box container-fluid" style="margin-top:20px;display:none;">
                                                    <div class="row">
                                                        <div class="col-xs-12">
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" Display="Dynamic" ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}" ErrorMessage="Please enter a valid password <br> Ex : Password@123" Font-Size="Small" ForeColor="Red" ControlToValidate="txtUsrNwPass"></asp:RegularExpressionValidator>
                                                            <asp:CompareValidator ID="userprofilevalidator" runat="server" ControlToCompare="txtUsrConfirmPass" ControlToValidate="txtUsrNwPass" EnableClientScript="False" ErrorMessage="Password  Not Matching" Font-Size="Small" ForeColor="Red"></asp:CompareValidator>
                                                            <asp:Label ID="passstatus" runat="server" Font-Size="Small" ForeColor="Red"></asp:Label>
                                                        </div>
                                                        <div class="col-xs-6">
                                                            <label>New Password :</label>
                                        
                                                        </div>
                                                        <div class="col-xs-6">
                                                            <asp:TextBox ID="txtUsrNwPass" runat="server" CssClass="txtbox_style" style="margin:5px;" TextMode="Password" ></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"  ControlToValidate="txtUsrNwPass" ErrorMessage="*" ForeColor="Red" ValidationGroup="two"></asp:RequiredFieldValidator>
                                                        </div>
                                                        <div class="col-xs-6">
                                                            <label>Confirm Password :</label>
                                         
                                                        </div>
                                                        <div class="col-xs-6">
                                                            <asp:TextBox ID="txtUsrConfirmPass" runat="server" CssClass="txtbox_style" style="margin:5px;" TextMode ="Password"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"  ControlToValidate="txtUsrConfirmPass" ErrorMessage="*" ForeColor="Red" ValidationGroup="two"></asp:RequiredFieldValidator>
                                                        </div>
                                                          </div>
                                                        <div class="row" style="margin:10px;text-align:right;margin-right:38px;">
                                                            <div class="col-xs-12">
                                                               
                                                                <asp:Button ID="btnUsrPassSubmit" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="btnUsrPassSubmit_Click" ValidationGroup="two" />
                                                            
                                                                 <button id="btnUprofilePasscancel" type="button"  class="btn btn-danger" >Cancel</button>
                                                            </div>
                                                       </div>
                              
                                
                                                </div>
       
                                            </div>
                                  
                                    </div>
                                  <div class="rohit">
                                        <button type="button" class="btn btn-primary" id="btnEditProfile"> Edit Profile</button>
                                      <button type="button" id="btnEditSettings" class="btn btn-info ">Edit Settings</button>
                                      <button type="button" id="btnEditPassword" class="btn btn-danger">Change Password</button>
                                    </div>
                            </div>

                         <div id="progressBar" class="modal" style="align-content:center;">
                                        <img src="Images/Icon/ajax-loader.gif" style="width:15px;height:15px;align-self:center;" />
                                    </div>
                        </form>

                          <%--Added by Aarshi on 22 aug 2017 for image crop code--%>
                         <div id="image_modal_div" class="modal" style="height:auto; width:auto;" >
                             <div style="height:30px;width:auto;background-color:white;margin-top:0px;"><span id="close" class="close">&times;</span></div>
                              <div style="padding-left:5px; padding-right:5px;">
                              <img id="Image_crop" src="" alt="" style="background-color:white;margin:auto;"  />  
                            </div>
                             <div style="height:40px;width:auto;background-color:white;">
                                <button id="btnOK" value="OK" class="btnModal_style" style="margin-left:25px;">OK</button> 
                                <button type="button" id="btnCancel"  class="btnModal_style" style="margin-right:25px; float:right">Cancel</button>
                                   </div>
                            </div>
            </div>
     
    
         </div>
         </div>
</body>
</html>
