<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Notifications.aspx.cs" Inherits="Notifications" %>

<!DOCTYPE html>
<!--  This Total  code  is  licenced
    Developed By Anvisys Technologies Pvt Ltd.
    
    Copyright © 2016 Anvisys Technologies Pvt. Ltd.All rights reserved.
    -->
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
   <link rel="stylesheet" href="CSS/NewAptt.css" />

  <script>
      
  
      $(document).ready(function () {
        
          window.parent.FrameSourceChanged();
         // GetImage();
          var userType = '<%=Session["UserType"] %>';
      
          if (userType == "Admin") {
             
              document.getElementById("New_Notification").style.visibility = 'visible';

          }

          $("#initial_loading").hide();
      });


      //Added by aarshi on 21-Sept-2017 for bug fix
      function GetCount(text, oCount) {
          var maxlength = new Number(250); // Change number to your max length.
          if (text.value.length > maxlength) {
              text.value = text.value.substring(0, maxlength);
              oCount.innerText = (maxlength - parseInt(text.value.length)).toString();
              return false;
          }
          else {
              oCount.innerText = (maxlength - parseInt(text.value.length)).toString();
              return true;

          }
      }


      function Newfun(my) {
          document.getElementById("data_loading").style.display = "none";
          
          document.getElementById('<%=btnNotificationsSend.ClientID%>').style.display = "none";
      }


       function Opennewwindow(id)
       {
           document.getElementById("Attachment_Text").style.display = "block";

       }

       $(document).ready(function () {
           $("#New_Notification").click(function () {

              
               $("#myModalNewNotficationPopup").show();
           });

        
       });

       $(document).ready(function () {
           $("#CancelNotifications_Button").click(function () {
      
               $("#myModalNewNotficationPopup").hide();
               $("#txtNotificationText").val("");

           });
       });


       function CloseNew()
       {
           $("#myModalNewNotficationPopup").hide();
           $("#txtNotificationText").val("");

       }
    
     
      function ToggleFileUpload()
      {

          var checkbox = document.getElementById("chckNewNotifi");
          var Fileupload = document.getElementById("FileNotifications");
          if (checkbox.checked)
          {
              
              Fileupload.style.display = "inline";
          }
          else {
              Fileupload.style.display = "none";
          }        
      }
     

       window.onload = function ChaeckNotifiDialog()
       {
           if (HiddenNotificationSuccess.value == "Success")
           {
               document.getElementById("lblNotifistatus").innerText = "Sucess";
           }
           else if (HiddenNotificationSuccess.value == "Fail")
           {
               var dialog = document.getElementById("myModalNewNotficationPopup");
               dialog.style.display = "block";
               lblnotifResp.html = "Could Not Send Notification";
               lblNotifistatus.html = "Html Error";
               document.getElementById("lblNotifistatus").innerText = "Html Error";
           }
        
       }

       function CheckImageSize() {
          
           var aspFileUpload = document.getElementById("FileNotifications");
           var errorLabel = document.getElementById("lblNotifistatus");
           var img = document.getElementById("imgUploadThumbnail");
           var NotificationSubmit = document.getElementById("btnNotificationsSend");
           

           var fileSize = aspFileUpload.files[0].size / 1024 / 1024;

           var fileSizemb = aspFileUpload.files[0].size / 1024 / 1024;

           var FileSizeInMb = Math.floor(fileSize);

           if (FileSizeInMb > 2)
           {
               errorLabel.innerHTML = "File size is " + FileSizeInMb + "mb   please select  a file  less than 2mb";

               NotificationSubmit.style.display = "none";

               errorLabel.style.color = "Red";
           }

           else {
             
               if (FileSizeInMb == 0)
               {
                   var Newsize = 1000;
                   var fileSizemb = fileSizemb * Newsize;

                   fileSizemb = Math.floor(fileSizemb);
               }

               errorLabel.innerHTML = "File size is   " + fileSizemb + "kb";

               //NotificationSubmit.style.display = "block";
               //NotificationSubmit.style.textAlign = "center";

               errorLabel.style.color = "CornflowerBlue ";
           }

        
       }

       function GetImage() {
      
          
           var url = api_url + "/api/Image/Res/" + ResID + "/";
           //"http://www.kevintech.in/Test/api/Image/GetByResID/15";
           $.ajax({
               dataType: "json",
               url: url,
               success: function (data) {
                   if (data != null) {
                       var da = JSON.stringify(data);
                       var js = jQuery.parseJSON(da);
                       var ImageStr = js.ImageString;
                       var Source = "data:image/jpeg;charset=utf-8;base64," + ImageStr;
                       var x = document.getElementsByClassName("UserImage");
                       var i;
                       for (i = 0; i < x.length; i++) {
                            x[i].src = Source;
                       }


                   }
                   else {

                      
                   }

               },
               error: function (data, errorThrown) {
                   alert("Error getting Image");
               }

           });
       }

      
 function DisplayFullImage(ctrlimg) 
 { 
     txtCode = "<HTML><HEAD>" 
     +  "</HEAD><BODY TOPMARGIN=0 LEFTMARGIN=0 MARGINHEIGHT=0 MARGINWIDTH=0><CENTER>"   
     + "<IMG src='" + ctrlimg.src + "' BORDER=0 NAME=FullImage " 
     + "onload='window.resizeTo(document.FullImage.width,document.FullImage.height)'>"  
     + "</CENTER>"   
     + "</BODY></HTML>"; 
     mywindow= window.open  ('','image',  'toolbar=0,location=0,menuBar=0,scrollbars=0,resizable=0,width=1,height=1'); 
     mywindow.document.open(); 
     mywindow.document.write(txtCode); 
     mywindow.document.close();
 }

         function ShowLoader()
         {
             $("#data_loading").show();
         }

      function SetActiveClass(name) {
          //alert(name);
          if (name == "Open") {
              $('#showOpen').addClass('btn-primary');
              $("#showClose").removeClass('btn-primary');
              $("#showAll").removeClass('btn-primary');
          }
          else if (name == "Close") {
              $('#showOpen').removeClass('btn-primary');
              $("#showClose").addClass('btn-primary');
              $("#showAll").removeClass('btn-primary');
          }
          else if (name == "All") {
              $('#showOpen').removeClass('btn-primary');
              $("#showClose").removeClass('btn-primary');
              $("#showAll").addClass('btn-primary');
          }
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


/* Style the active class, and buttons on mouse-over */


    </style>

    </head>
     <body  style="margin:0px;padding:0px;">

     <div class="container-fluid">
        <div class="row" style="position:relative;">
            <div class="col-xs-12" style="background-color:#f7f7f7;">
                  <form id="form1" runat="server">
                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                      <div class="container-fluid">
                 
                          <div class="row">
                          <%--    <div class="col-xs-6 myclass1">
                                   <asp:DropDownList ID="drpNotifiFilter" ForeColor="Black" Font-Size="Small" runat="server" CssClass="layout_ddl_filter center-block" OnSelectedIndexChanged="drpNotifiFilter_SelectedIndexChanged" AutoPostBack="True">
                                      <asp:ListItem>All</asp:ListItem>
                                      <asp:ListItem>This Month</asp:ListItem>
                                      <asp:ListItem>Last Month</asp:ListItem> 
                                      <asp:ListItem>This Year</asp:ListItem>                           
                                     </asp:DropDownList>

                              </div>--%>

                              <%--<div class="col-xs-6 myclass1">
                                  <button id="New_Notification" type="button" class="btn btn-primary pull-right"> New Notification</button>

                              </div>--%>

                          </div>


                           <div class="row" style="height:50px;">
                                     <div class="col-sm-3  col-xs-3" >
                                         <div><p class="pull-left" style="margin-top:16px;font-size: 15px;color: #000;">Notice : </p></div>
                                     </div>
                               <div id="myDIV" class="col-sm-6  col-xs-7" style="margin-top:10px;text-align:center;">

                                   <ul class="nav nav-pills" style="margin:auto;width:170px;">
                                      <li role="presentation" class="active"><asp:Button runat="server" CssClass="btn" ID="showOpen" OnClick="showOpen_Click" Text="Open" CausesValidation="False"  /></li>
                                      <li role="presentation"><asp:Button runat="server" CssClass="btn" ID="showClose" OnClick="showClose_Click" Text="Close" CausesValidation="False"  /></li>
                                      <li role="presentation"><asp:Button runat="server" CssClass="btn" ID="showAll" OnClick="showAll_Click" Text="All" CausesValidation="False"  /></li>
                                    </ul>
                                 
                                
                                   </div>
                                   <div class="col-sm-6 hidden-xs myclass1" style="display:none;">
                                   <asp:DropDownList ID="drpNotifiFilter" ForeColor="Black" Font-Size="Small" runat="server" CssClass="layout_ddl_filter center-block" OnSelectedIndexChanged="drpNotifiFilter_SelectedIndexChanged" AutoPostBack="True">
                                      <asp:ListItem>All</asp:ListItem>
                                      <asp:ListItem>This Month</asp:ListItem>
                                      <asp:ListItem>Last Month</asp:ListItem> 
                                      <asp:ListItem>This Year</asp:ListItem>                           
                                     </asp:DropDownList>

                              </div>

                                       <div class="col-sm-3  col-xs-2" >
                                           
                                         <button id="New_Notification" type="button" class="btn btn-primary pull-right btn_my"><i class="fa fa-plus-square" aria-hidden="true"></i></button>
                                     </div>
                                     
                         </div>

                                                  
                          <div class ="row">
                              <div class="col-xs-12">
                                   <asp:Label ID="lblEmptyTitle" runat="server" ForeColor="#4FA7FF" Visible="false"></asp:Label>
                              </div>
                             
                          </div>

                    <div class ="row">
                              <div class="col-xs-12 col-sm-12">
             
                    <asp:HiddenField ID="HiddenNotificationSuccess" runat="server" />
                    <asp:DataList ID="DataNotifications" runat="server" cellpadding="0"    OnItemDataBound="DataNotifications_ItemDataBound"
                            width="100%"
                            headerstyle-font-name="Verdana"
                            headerstyle-font-size="12pt"
                            headerstyle-horizontalalign="center"
                            RepeatColumns="0"
                            HorizontalAlign="Center"
                            headerstyle-font-bold="True"
                            BackColor ="Transparent" 
                           
                            footerstyle-font-size="9pt"
                            footerstyle-font-italic="True"  Height="1px" ForeColor="#000" OnSelectedIndexChanged="DataNotifications_SelectedIndexChanged">
                                   
                               <ItemStyle ></ItemStyle>
                               <ItemTemplate>
                                     <div class="row layout_shadow_table">

                                                    <div class="col-sm-2 col-xs-2" >
                                       
                                                 <asp:Image  src='<%# "GetImages.ashx?UserID="+ Eval("UserID")+"&Name="+Eval("FirstName") +"&UserType=Admin"%>' CssClass="UserImage  profile-image" ID="user_image" runat="server" /> <br />

                                                    <%# Eval("FirstName") +" " + Eval("LastName")  %>
                                                </div>
                                                    <div class="col-sm-7 col-xs-6" >
                                                    <asp:Label ID="Label4" runat="server" ForeColor="#6699cc" Font-Size="medium"  Text='<%# Eval("Notification") %>'></asp:Label><br />     
                                                             <asp:Label ID="Label7" runat="server" Font-Names="Euphemia" Font-Size="small" ForeColor="green"  Text='<%# "Entry date: " + Eval("Date", "{0:dd MMM,yy}") %>'></asp:Label> &nbsp;&nbsp;
                                                        <asp:Label ID="Label8" runat="server" Font-Names="Euphemia" Font-Size="small" ForeColor="red"  Text='<%#"Valid Till: "+ Eval("EndDate", "{0:dd MMM,yy}") %>'></asp:Label> 
                                                        
                                                    </a>  
                                         </div>
                                                    <div class="col-sm-3 col-xs-4">                                                                                                                                                                     
                                                  <asp:Image ID="ImageFile" with="50" Height="50" CssClass="ImgAttach pull-right" ToolTip="Click to see" OnClientClick="DisplayFullImage(this)" CausesValidation="false" runat="server"  /> 
                                                   
                                                  
                                                        <asp:Label ID="lblFileName" runat="server" Text='<%# Eval("AttachName") %>' ></asp:Label>
                                                       <a href= "#" onclick="window.open('OpenFile.aspx?NoticeID=<%#Eval("ID") %> &FileName=<%#Eval("AttachName")%>','pagename','resizable,height=560,width=570'); return false;">
                                                <asp:ImageButton ID="ImageAttachemnt" runat="server"  Width="15" Height="15" CssClass="ImgAttach" CausesValidation="false" ToolTip="Click to see the attachment" ImageUrl="Images/attachment_icon.png" OnClientClick='<%# "NotificationImage.ashx?NotifFileID="+ Eval("ID") %>' /> 
                                                        <span class="fa fa-paperclip" title="Click to see the attachment" onclick='<%# "NotificationImage.ashx?NotifFileID="+ Eval("ID") %>' id="attachment" runat="server"></span>

                                                </div>
                                            
                                       </div> 
                                         
                              </ItemTemplate>
                              
                          <EditItemStyle Height="0px" BackColor="Transparent" />                       
                        <SeparatorStyle BackColor="Transparent" Height="50px" />
              </asp:DataList>
               
                    </div>
                      </div>
                          </div>
                           <div class ="row" style="margin-top:8px;">
                                     <div class="col-xs-4" style="text-align:center">
                                  <asp:Button ID="btnprevious" runat="server" Font-Bold="true" CssClass="btn btn-primary" CausesValidation="false" Text="Prev" Height="31px" Width="53px" onclick="btnprevious_Click" />
        
                              </div>
                              <div class="col-xs-4" style="text-align:center">
                                  <asp:Label ID="lblPage" runat="server" Font-Size="Small" ForeColor="#f9f9f9f"></asp:Label>
                              </div>
                                   <div class="col-xs-4"  style="text-align:center">
                                       <asp:Button ID="btnnext" runat="server" CssClass="btn btn-primary" CausesValidation="false" Font-Bold="true" Text="Next" Height="31px" Width="53px" onclick="btnnext_Click" />
                                   </div>
                          </div>

   <%------------------------------------------------------------------- New Notification Section Starts from here ----------------------------------------------------------------------------------------------------------   --%>         
                   
    
                           <div id="myModalNewNotficationPopup" class="modal" > 
                               <div class="container-fluid"  style="max-width:500px;">
                                <div class="panel panel-primary" style="position:relative;">
                    
                                        <div class="panel-heading">
                                           New Notification :
                                            <span class="fa fa-close" onclick="CloseNew()"  style="color:white;cursor:pointer;float:right;"></span>
                                        </div>
                                   
                                    <div class="panel-body">
                                           <table >   
                                                
                                     
                                        <tr>
                                          <td colspan="2">
                                                <asp:TextBox ID="txtNotificationText" runat="server" Width="95%" style="resize:none" AutoCompleteType="Disabled" CssClass="txtbox_notification" MaxLength="1200"  TextMode="MultiLine" ></asp:TextBox>
                                              Characters Left : <asp:Label ID="lblNotificationCount" runat="server" ForeColor="#999999" Text="250"></asp:Label>  
                                          </td>
                                      </tr>
                                       <tr>
                                          <td colspan="2" style="height:20px;">   <hr /> </td>
                            
                                      </tr>
                                  
                                  <tr>
                                      <td colspan="2" style="padding-right:5px;">
                                          <label style="padding-top:5px;">Valid Till <input runat="server" type="date" id="ValidTill" name="validTill" /></label>
                                         <%-- <asp:Label ID="lblNotificationChar" runat="server" ForeColor="#999999" Text="Characters Left :"></asp:Label>--%>
                                   
                                      </td>
                                  </tr> 
                                
                                                     
                             <tr>
                      
                                 <td style="height:50px;">
                                      <hr style="color: #f00; background-color: #f00; height: 1px;"/>
                                   <input id="chckNewNotifi" type="checkbox" onclick="ToggleFileUpload(this)" />Attach a file
                                                  
                                 </td>      
                                 <td style="height:50px;">         
                                      <hr style="color: #000; background-color: #000; height: 1px;"/>             
                                              <asp:FileUpload ID="FileNotifications" runat="server" CssClass="FileUploadNotifi" onchange="Javascript: return CheckImageSize();" />                                                                           
                                 </td>
                             </tr> 
                                  
                                      
                                
                                     <tr>
                                        <td style="width:50%;">
                                          <hr  style="color: #000; background-color: #000; height: 1px;"/>
                               
                                        </td>
                                          <td style="width:50%;"> 
                                                <hr style="color: #f00; background-color: #f00; height: 1px;"/>
                                          </td>
                                    </tr>   
                                           
                                      <tr>
                                          <td colspan="2" style="text-align:center;"> 
                                                <asp:Label ID="lblNotifistatus" runat="server" Font-Size="Small" ForeColor="#4AA5FF"></asp:Label>        
                                          </td>
                                      </tr>

                                      <tr>
                                          <td colspan="2" style="text-align:center;"> 
                                                 <asp:Label ID="lblnotifResp" runat="server" Font-Size="Small" ForeColor="#FF5050"></asp:Label>                 
                                          </td>
                                      </tr>
                              <tr>
                                <td colspan="2"> 
                                    <asp:RequiredFieldValidator ID="ReqNotifiText" runat="server" ControlToValidate="txtNotificationText" ErrorMessage="Please Write Something ..." Font-Size="Small" ForeColor="#FF5050" Font-Names="Century"></asp:RequiredFieldValidator>      
                                </td>
                            </tr>
                     
                        </table>
                                    </div>             
                                    <div class="panel-footer" style="text-align:right;">
                                         <asp:Button ID="btnNofificancel" runat="server" CssClass="btn_style" Text="Cancel" OnClick="btnNofificancel_Click" Visible="False" CausesValidation="False" />             
                                        <asp:Button class="btn btn-success"  ID="btnNotificationsSend" runat="server"  OnClick="btnNotificationsSend_Click" Text="Send" />

                                       <button type="button" class="btn btn-danger" id="CancelNotifications_Button" >Cancel</button>    
                                    </div>         


                                 </div>

                               </div>
                               <div id="data_loading" class="layout-overlay" style="background-color:#000; width:100%; height:100%;opacity: 0.5; filter: alpha(opacity=50); text-align:center;vertical-align:middle;">
                                       <img src="Images/Icon/ajax-loader.gif" style="width:20px; height:20px;margin-top:45px;" />                                 
                                                       </div>
                             </div>    
        
                          
          
                  </form>
                <div id="initial_loading" class="layout-overlay" style="margin-top:50px; width:100%; height:500px; background-color:aqua; text-align:center;vertical-align:middle;">
                                       <img src="Images/Icon/ajax-loader.gif" style="width:30px; height:30px;margin-top:35px;" />
             </div>
          
             

                 </div>
          
        </div>
        
    
  <script>
// Add active class to the current button (highlight it)
var header = document.getElementById("myDIV");
var btns = header.getElementsByClassName("btn");
for (var i = 0; i < btns.length; i++) {
  btns[i].addEventListener("click", function() {
    var current = document.getElementsByClassName("active");
    current[0].className = current[0].className.replace(" active", "");
    this.className += " active";
  });
}
</script>

</body>
</html>
