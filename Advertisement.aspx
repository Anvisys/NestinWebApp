<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Advertisement.aspx.cs" Inherits="Advertisement" %>

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

        

     
      <link rel="stylesheet" href="CSS/NewAptt.css"/>
              <link rel="stylesheet" href="CSS/ApttLayout.css"/>
              <link rel="stylesheet" href="CSS/ApttTheme.css" />

    <style>
        .form-group {
            margin-bottom: 10px;
    margin-top: 10px;
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


            .modal {
            display: none;  /*  Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 10; /* Sit on top */
             /* Location of the box */
            padding-left:140px;
            left: 0px;
            top:   0px;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto;  /*Enable scroll if needed  */
            background-color: #e6e2e2;
            background-color: rgba(0,0,0,0.4);
            padding-top:50px;
        }
            .form-control {
                margin-bottom:2px;
                margin-top:2px;
            }
        .fa-2x {
            font-size: 1em;
            color: #fff;
            float:right;
        }



        .img_ad {
            height:200px;
            
        }

        .ro {
            margin-top:5px;
           
        }
        .ro1 {
            
             background-color:#5DADE2;
            -moz-box-shadow: 0 0 5px #888;
-webkit-box-shadow: 0 0 5px#888;
box-shadow: 0 0 5px #888;
text-align:center;
        }
        .txtcolor {
            color:forestgreen;
        }
         .txtcolorwhite {
            color:#fff;
        }
    </style>

    <script>
        function CloseAddVendor() {

           $("#AddAdvertisementModal").hide();
        }

        $(document).ready(function () {
            $("#btnAddAdvertisement").click(function () {

           
                $("#AddAdvertisementModal").show();

            });


            $("#btnSubmit").click(function () {
               
                AddAdvertisement();
            });

            

            GetAdvertisementData();

        });
       


        function ReadImage(input)
        {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    imgStr = e.target.result;
                
                    document.getElementById('imgPreview').src = e.target.result;
                }

                reader.readAsDataURL(input.files[0]);
            }

        }


        function AddAdvertisement() {

            var title, name, offer, Image;

            Image = getBase64Image(document.getElementById("imgPreview"));

            title = document.getElementById("Title").value;
            owner = document.getElementById("Owner").value;
            description = document.getElementById("Description").value;
            offer = document.getElementById("Offer").value;
            startDate = document.getElementById("StartDate").value;
            endDate = document.getElementById("EndDate").value;

            document.getElementById("add_loading").style.display = "block";

           
          

            var strURL = "http://www.kevintech.in/GaurMahagun/api/Ads";

            var reqBody = "{\"Owner\":\"" + owner + "\",\"Title\":\"" + title + "\",\"Description\":\"" + description + " \",\"Offer\":\"" + offer + "\",\"AdImage\":\"" + Image + "\",\"StartDate\":\"" + startDate + "\",\"EndDate\":\"" + endDate + "\"}"
           // alert(reqBody);
            var user = {};
            user.owner = $("#Owner").val();
            user.Title = $("#Title").val();
            user.Description = $("#Description").val();
            user.Offer = $("#Offer").val();
            user.StartDate = $("#StartDate").val();
            user.EndDate = $("#EndDate").val();
            user.Image = "xyz";

                $.ajax({
                    dataType: "json",
                    url: strURL,
                    async: false,
                    data: reqBody,
                    type: 'post',
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        
                        document.getElementById("add_loading").style.display = "none";
                        $("#AddAdvertisementModal").hide();
                       // alert('Updated Successfully');
                        
                    },
                    error: function (data, errorThrown) {
                        document.getElementById("add_loading").style.display = "none";
                       
                        alert('Error Updating comment, try again');
                    }
                });
          
        }

        function GetAdvertisementData()
        {
            document.getElementById("data_loading").style.display= "block";
            var url = "http://www.kevintech.in/GaurMahagun/api/Ads";

            $.ajax({
                type: "Get",
                url: url,
               contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    document.getElementById("data_loading").style.display = "none";
                    SetData(data);
                },
                failure: function (response) {
                    document.getElementById("data_loading").style.display = "none";
                    alert(response.d);
                    sessionStorage.clear();
                }
            });

        }


        function SetData(data)
        {
            
            var jarray = data.$values;
            var length = jarray.length;
            var viewString = "";
            var con = document.getElementById("dataContainer");
                for (var i = 0; i < length; i++) {
                   
                    var Owner = jarray[i].Owner;
                    var Title = jarray[i].Title;
                    var Description = jarray[i].Description;
                    var Offer = jarray[i].Offer;
                    var StartDate = jarray[i].StartDate;
                    var EndDate = jarray[i].EndDate;
                    var base64Image = jarray[i].AdImage;


                    viewString += '<div class=\"col-sm-4 ro\">' +
                        '<div class=\"thumbnail ro1\">' +
                        '<h3 class=\"\">' + Owner + '</h3>' +
                         '<img class=\"img_ad\" src="data:image/png;base64,' + base64Image + '">' +
                        
                            '<p class=\"txtcolorwhite\">' + Description + '</p>' +
                            '<h4 class=\"txtcolor\">Offer- ' + Offer + '</h4>' +
                 
                              '</div>'+
                          '</div>';
                     
                }
             

                con.innerHTML += viewString;


          

        }

        function TitleChange(element)
        {
        
            var val = element.value;
            
            document.getElementById("titlepreview").innerHTML = val;
        
        }
      


        function getBase64Image(img) {
            var canvas = document.createElement("canvas");
            canvas.width = img.width;
            canvas.height = img.height;
            var ctx = canvas.getContext("2d",1.0);
            ctx.drawImage(img, 0, 0);
            var dataURL = canvas.toDataURL("image/png");
            return dataURL.replace(/^data:image\/(png|jpg);base64,/, "");
        }


    </script>
</head>
<body style="background-color:#f7f7f7;">
    <form id="form1" runat="server">
     <div class="container-fluid" >
                         <div class="row" style="margin-top:10px;">
                                 <div class="col-sm-5">
                                     <div><h4 class="pull-left ">Advertiesment </h4></div>
                                 </div>
                             <div class="col-sm-5">
                                     <button id="btnAddAdvertisement" class="btn_my pull-right btn btn-primary" type="button"><i class="fa fa-plus"></i> Add Advertiesment</button>
                                 </div>
                             </div>
                           <div id="dataContainer" class="container-fluid">
                           </div>
       

                        <div id="data_loading" class="layout-overlay" style="margin-top:50px; width:100%; text-align:center;vertical-align:middle;">
                                       <img src="Images/Icon/ajax-loader.gif" style="width:30px; height:30px;margin-top:35px;" />

                       </div>


        <div id="AddAdvertisementModal" class="modal">
            
              <div id="confirmBox" class="" style=" width:600px; top:100px;left:80px;">
                 

                <div class="container-fluid" style="position:relative;" >
    
                              <form class="form-inline" method="post" >
                                  <div class="panel panel-primary">

                                      <div class="panel-heading">
                                           <a onclick="CloseAddVendor()" style="cursor:pointer;">
            <span class="fa fa-times fa-2x" aria-hidden="true"></span></a> 
                                          Advertiesment

                                      </div>
                                  <div class="panel-body">
                                  <div class="row" style="margin:10px;">
                                      <div class="col-xs-6">

                                    <input type="text" class="form-control" id="Owner"  placeholder="Enter Name" name="Owner"/>
                                 
                                    <input type="text" class="form-control" id="Title" onkeyup="TitleChange(this)" placeholder="Enter Business name" name="Title"/>
    
                                    <textarea class="form-control" rows="2" id="Description"  name="Description" placeholder="Enter Business Description"></textarea>
                                            
                                   <textarea class="form-control" rows="2" id="Offer"  name="Offer" placeholder="Enter Offer Description"></textarea>
                                               
                              
      
                                    From:<input type="date" class="form-control" id="StartDate"  name="StartDate"/>
   
                               
      
                                      To:<input type="date" class="form-control col-xs-8" id="EndDate"  name="EndtDate"/>
      
                                   </div>
                                      <div class="col-xs-6">
                                           <div class="form-group" style="background-color:aliceblue;width:220px;height:220px;margin-left:40px;position:relative;">
                                        <img id="imgPreview" src="Images/Static/blue.jpg" style="width:200px; height:200px;position:absolute;left:10px;top:10px;"  />
                                      <div style="width:200px; height:200px;position:absolute;left:10px;top:10px;">
                                        <h3 id="titlepreview" style="color:#000;padding-top:3px;z-index:5;">Bussiness Name 3</h3><br />
                                        <p  style="color:#000;">Description</p>
                                        <p  style="color:#2ECC71;">Offer</p>
                                         <p style="color:#ff6a00;">Valid Upto</p>
                                      </div>
                                  </div>
                                           <label  for="Owner">Upload Image:</label>
                                     <input type="file" id="image"  onchange="ReadImage(this)" accept="image/*" style=""/>
                                          <hr  style="margin-top:10px;margin-bottom:10px;"/>
                                          <div class="row" style="float:right;">
                            
                                     <button type="button" id="btnSubmit"  style="margin-top:5px;" class="btn btn-success">Submit</button>
                                     <button type="button" id="btnCancel" onclick="CloseAddVendor()" style="margin-top:5px;" class="btn btn-danger">Cancel</button>
          </div>
                                      </div>
                                  </div>
                                      </div>
                               </div>
                              </form>
                          <div id="add_loading" class="layout-overlay" style= "width:96%; height:600px; text-align:center;vertical-align:middle;">
                               <img src="Images/Icon/ajax-loader.gif" style="width:30px; height:30px;margin-top:300px;" />
                                 <%--<div  class="small_loader" style="margin-left:45%; margin-top:10px; height:24px; width:24px;"></div>--%>
                           </div>
                </div>



                  </div>
                 
    
         

    </div>

         </div>

    </form>
 
</body>
</html>
