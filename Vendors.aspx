<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Vendors.aspx.cs" Inherits="Vendors" %>

<!DOCTYPE html>
<!--  This Total  code  is  licenced
    Developed By Anvisys Technologies Pvt Ltd.
    
    Copyright © 2016 Anvisys Technologies Pvt. Ltd.All rights reserved.
    -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
     
    <link rel="stylesheet" href="Scripts/jquery-1.11.1.min.js" />
    
    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css"/>  

   <!-- jQuery library -->
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    

    <!-- Latest compiled JavaScript -->
    
     <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
  <%--  <script type="text/javascript" src="http://cdn.rawgit.com/tapmodo/Jcrop/master/js/jquery.Jcrop.min.js"></script>--%>

    <script  type="text/javascript" src="http://jcrop-cdn.tapmodo.com/v2.0.0-RC1/js/Jcrop.js"></script>
    <link  rel="stylesheet" href="http://jcrop-cdn.tapmodo.com/v2.0.0-RC1/css/Jcrop.css" type="text/css"/>
      
  <link rel="stylesheet" href="CSS/NewAptt.css" />
      <link rel="stylesheet" href="CSS/ApttTheme.css" />
     <link rel="stylesheet" href="CSS/ApttLayout.css" />
    <%--<link rel ="stylesheet" href="CSS/Vendor.css" />--%>
   
    <link rel="stylesheet" href="CSS/mystylesheets.css" />

    <style>
 
        /*Added by Aarshi on 22 aug 2017 for image crop code*/
        #image_modal_div{
            border:1px solid #818181;
            border-radius:3px;
             box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2), 0 5px 10px 0 rgba(0, 0, 0, 0.19);
            display: none;
            position:absolute; 
            top:50px;
            left:50px;
            background-color:white;
            align-content:center;
        }

        .Image_crop{
            border:5px solid #faf9f9;
        }
       
        /* The Close Button */
        .close {
    color: #aaaaaa;
    float: right;
    margin-right:5px;
    font-size: 25px;
    font-weight: bold;
}

        .close:hover,
        .close:focus {
            color: #000;
            text-decoration: none;
            cursor: pointer;
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
      

.vendor_page_table {
    width:100%;
    padding:2% 0 5% 1%;
    border-collapse:collapse;
    margin-top:1%;
    min-height:300px;

}


       .modal {
            display: none;  /*  Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 2%; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto;  /*Enable scroll if needed  */
            background-color: #e6e2e2;
            background-color: rgba(0,0,0,0.4);
        }

       .offerbox-raised{
           background: #ebfaf3;
           border:1px solid lightgrey;
           width:100%;
           height:30px;
           color:#2eb877;
           font-size:18px;
           font-family:serif;
       }

       .offerbox-raised:hover{
           background-color:#009900;
           color:white;
       }
       
       
       .vl {
    border-left: 3px solid green;
    height: 150px;
}
       td {
          padding:2px;
       }
       .card {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
  max-width: 300px;
  margin: auto;
  text-align: center;
  font-family: arial;
  background-color:#fff;
}

.title {
  color: grey;
  font-size: 14px;
}



a {
  text-decoration: none;
  font-size: 18px;
  color: black;
}
hr {
    margin-top:5px;
    margin-bottom:5px;
}

    </style>

    <script>

        var userType;

        $(document).ready(function () {
            userType = '<%=Session["UserType"] %>';
            if (userType == "Admin") {
                alert("158");
                document.getElementById("Add_Vendor").style.visibility = 'visible';
                document.getElementById("Edit_Vendor").style.visibility = 'visible';
                document.getElementById("vendor_delete").style.visibility = 'visible';
                $('.Vendor_edit_icon').show();
            }
            else {
                 document.getElementById("Add_Vendor").style.visibility = 'none';
            }


        });

        $(document).ready(function () {

            window.parent.FrameSourceChanged();
        });

     
        $(document).ready(function () {
            $('.toggle-footer-btn').click(function () {
                $(this).html($(this).html() == '+' ? '-' : '+');
                $('#footer').slideToggle(2000);
                return false;
            });
        });


        $(document).ready(function () {
            $(".update").click(function () {          
                $("#FileVendorEdit").toggle();
               
            });

          
        });


        function CloseAddVendor()
        {

            $("#myVendorAddForm").hide();
        }

        function PreviewImage() {
            var oFReader = new FileReader();
            oFReader.readAsDataURL(document.getElementById('FileVendorEdit').files[0]);

            oFReader.onload = function (oFREvent) {
                document.getElementById("ImgVendor").src = oFREvent.target.result;
            };
        }

        function PreviewAddImage() {
            var image = document.getElementById("ImgPreview").style.display = "block";
            var oFReader = new FileReader();
            oFReader.readAsDataURL(document.getElementById('FileVendorImg').files[0]);

            oFReader.onload = function (oFREvent) {
               
               // document.getElementById("ImgPreview").src = oFREvent.target.result;
            };
        }

        var selectedCategory;
        var selectedName;
        var selectedNumber;
        var VenID;
        var selectedAddress;

        function ShowEditForm(VendorID, Name, Category, Number,ContantNumber2, Address,Address2, Element) {
         
              $("#myVendorAddForm").show();
                $("#FileVendorImg").hide();
                //Added by Amit on 2sep 2017 
                $('#headingAddEdit').text('Edit Vendor');
                $('#checkAddImage').html('Change Image');
                $('#checkAddImage').prop('checked', false);
                $("#HiddenVendorEditID").val(VendorID);
                $("#HiddenVendorName").val(Name);
                $('#<%=txtvendorname.ClientID %>').val(Name);
                $('#<%=drpVendorcategory.ClientID%> option:selected').text(Category);
            $('#<%=txtvendromobile.ClientID %>').val(Number);
            $('#<%=txtMobile2.ClientID %>').val(ContantNumber2);
            $('#<%=txtvendoraddress.ClientID %>').val(Address);
             $('#<%=txtvendoraddress2.ClientID %>').val(Address2);
                document.getElementById("htmlImage").src = "GetImages.ashx?VendorID=" + VendorID ;
        }


        function DeleteForm(VenID, VendorName, ShopCategory) {
             document.getElementById("ConfirmDelete").style.display = "block";
            $("#HiddenVendorID").val(VenID);
                $("#HiddenVendorEditID").val(VenID);
                $("#HiddenVendorName").val(VendorName);
            

        }

      $(document).ready(function () {
            $('html').click(function () {

            // $("#Vendors_dropdown").hide();
               // $("#vendor_dropdown").hide();
          });
          if (userType == 'Admin') {

          }
      });

     
        $(document).ready(function () {
            $("#Add_Vendor").click(function () {
               // alert(1);
                $("#myVendorAddForm").show();
                $('#headingAddEdit').text('Add Vendor');
                $('#checkAddImage').text('Add Image');
                $('#checkAddImage').prop('checked', false);
                $("#HiddenVendorEditID").val("");
                $("#HiddenVendorName").val("");
               //  alert(2);
                $('#<%=txtvendorname.ClientID %>').val("");
                $('#<%=txtMobile2.ClientID %>').val("");
                  $('#<%=txtMobile2.ClientID %>').val("");
                $('#<%=txtvendoraddress.ClientID %>').val("");
                $('#<%=txtvendoraddress2.ClientID %>').val("");
                //Added by Aarshi on 22 aug 2017 for image crop code
              //     alert(3);
                $("#FileVendorImg").hide();
                document.getElementById("htmlImage").src = "Images/Icon/downloadbg.png";
                $("#lblstatus").text = "";
               
            });

            $("#Edit_Vendor").click(function () {
                

                img.Attributes["onerror"] = "this.src='Images/Vendor/default.png'";
                document.getElementById("htmlImage").src = "GetImages.ashx?ImID=" + VenID;
               
            });


        

            $("#Cancel_Button").click(function () {
                $("#myVendorAddForm").hide();
                //$("input:text").val("");
                $("#lblstatus").html("");
                //Added by Aarshi on 22 aug 2017 for image crop code
                $("#FileVendorImg").val(null);
               
            });

            $("#Delete_Vendor").click(function () {
               
               


            });

            $('#checkAddImage').change(function () {

                $("#FileVendorImg").toggle();
            });

        });
       
        function Showpopup()
        {         
            document.getElementById("Add_Vendor").style.visibility = "visible";          
        }

        function  HideControls()
        {
            //alert("working");
            document.getElementById("edit_icon_button").style.visibility = "hidden";            
        }


        $(document).ready(function () {
            
        });


        $(document).ready(function () {
            $("#CancelEdit_Button").click(function () {
                $("#lblEditResult").html('');
                $("#myVendorEditModal").hide();             
                $("#HiddenVendorEditID").val("");
            });
        });

        $(document).ready(function () {
            $("#btnVendorDelCancel").click(function () {
                $("#ConfirmDelete").hide();
                $("#HiddenVendorDelID").val("");
            });
        });

        function ConfirmCancel() {
             $("#ConfirmDelete").hide();
                $("#HiddenVendorDelID").val("");
        }

        $(document).ready(function () {
            $("#btnVendorDelete").click(function () {
                $("#ConfirmDelete").hide();
                $("#HiddenVendorDelID").val("");
            });
        });

        function VendorDeleteConfirm()
        {
            setTimeout(function () {
                document.getElementById("ConfirmDelete").style.display = "block";
            }, 1000);
        }
            
            function VendorActionPopup() {
           

                setTimeout(function ()
                {
                    var VendorName = document.getElementById("txtvendorname").value;
              
                    if (VendorName != "")
                    {            
                        document.getElementById("myVendorAddForm").style.display = "block";
                        VendorName = "";
                    }
           
                    if (HiddenVendorEditID.value != "")
                    {               
                        document.getElementById("myVendorEditModal").style.display = "block";              
                    }

                    if (HiddenVendorDelID.value != "") {              
                        document.getElementById("ConfirmDelete").style.display = "block";
                    } 
                
                }, 1000);
            }

            function UpdateSuccess()
            {

                $("#myVendorAddForm").hide();
                alert("Updated Successfully");

            }

            function UpdateFail()
            {
                $("#lblstatus").text = "could not update, try again.";
            }


            function ToggleFileUpload()
            {
                //var checkbox = document.getElementById("chckAddVendor");
                var FileUpload = document.getElementById("FileVendorImg");
                if(checkbox.checked)
                {
                   
                    document.getElementById("FileVendorImg").style.visibility = "visible";
                }

                else {
                    //Added by Aarshi on 22 aug 2017 for image crop code
                    //FileUpload.style.display = "none";
                    document.getElementById("FileVendorImg").style.visibility = "hidden";
                    $("#FileVendorImg").val(null);
                    document.getElementById("ImgPreview").style.display = "none";
                }
            }


         


            $(document).ready(function () {
                $("#update_vendor_icon").click(function () {
                    $("#FileVendorEdit").toggle();

                });
            });
      

            //Added by Aarshi on 22 aug 2017 for image crop code

            var newHeight;
            var newWidth;
            var MAX_HEIGHT;
            var MAX_WIDTH;
            var box_dimen;
            var AddOrEdit;

            $(function () {
                $('#FileVendorImg').change(function () {
                    // $('#Image1').hide();
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        AddOrEdit = "ADD";
                        setCropImage(e.target.result);
                        $('#image_modal_div').show();

                    }
                    reader.readAsDataURL($(this)[0].files[0]);
                });


                $('#FileVendorEdit').change(function () {
                    // $('#Image1').hide();
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        AddOrEdit = "EDIT";
                        setCropImage(e.target.result);
                        $('#image_modal_div').show();

                    }
                    reader.readAsDataURL($(this)[0].files[0]);

                });
            })



            $(document).ready(function () {
                $("#btnCancel").click(function () {
                    $("#image_modal_div").hide();
                    $('#Image_crop').data("Jcrop").destroy();
                    $('#Image_crop').removeAttr('style');
                });



                $(".close").click(function () {
                      $("#image_modal_div").hide();
                      $('#Image_crop').data("Jcrop").destroy();
                      $('#Image_crop').removeAttr('style');
                
                });
            });

    
            //Added by Aarshi on 23 aug 2017 for image crop code
       
            $(window).load(function () {

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

                        if (AddOrEdit == "ADD")
                        {
                            
                            $('#htmlImage').attr('src', canvas.toDataURL());
                            //$('[id*=ImgPreview]').attr('src', canvas.toDataURL());
                        }
                        else if (AddOrEdit == "EDIT")
                        {
                            $('#htmlImage').attr('src', canvas.toDataURL());
                        }

                        $('#image_modal_div').hide();
                   
                    };
                    img.src = $('#Image_crop').attr("src");
              
                    $('#Image_crop').data("Jcrop").destroy();
               
                    $('#Image_crop').removeAttr('style');
               
                });
            });


        function visiblemang() {
             document.getElementById("Edit_Vendor").style.visibility = 'visible';
        }
   

            function setCropImage(src) {
                newHeight =0;
                newWidth =0;
                box_dimen = 0;
                
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
                    $('#image_modal_div').height(newHeight + 50);
                    $('#image_modal_div').width(newWidth+10);

                    $('#Image_crop').Jcrop({
                        aspectRatio: 1.5,
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
                //var txt = "X1 : " + c.x + " Y1 : " + c.y + " width : " + c.w + " height : " + c.h;
                //$('#lbl').html(txt);

            }


       function isNumberKey(evt)
      {
         var charCode = (evt.which) ? evt.which : evt.keyCode;
         if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;    
         return true;
      }

      
   </script>

 
    </head>
<body style="background-color: #fcfcfc;">

    <div class="container-fluid" style="background-color: #f7f7f7;">
        <div class="row" id="scroll_div">

         

                <form id="form1" runat="server" autocomplete="off">

                    <%-------------------------------------------------------------Vendor  Datalist  starts from here ------------------------------------------------------------------ --%>
                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                    <div class="container-fluid">
                        <div class="row" style="height: 60px;">
                            <div class="col-sm-3  hidden-xs">
                                <div>
                                    <h4 class="pull-left panel-heading">Vendors : </h4>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xs-12 from-control" style="text-align: center; margin-top: 18px;">
                                <asp:DropDownList ID="drpvendorfilter" CssClass="layout_ddl_filter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="drpvendorfilter_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                            <div class=" hidden-xs col-sm-3  " style="vertical-align: middle;">
                                <div>
                                    <a id="Add_Vendor" class="Add_Button pull-right btn btn-primary btn-sm fa fa-plus" style="visibility: hidden;margin-top:10px; cursor: pointer;">Add Vendor</a>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="container-fluid" style="margin-top: 10px;">
                        <div class="row zero-margin" >
                            <div class="col-xs-12" style="text-align: center; display: none;">
                                <label class="hidden-xs">Total Vendors :</label><asp:Label ID="lblTotalVendors" CssClass="hidden-xs" runat="server" ForeColor="#46A3FF"></asp:Label>
                            </div>


                            <asp:DataList ID="Datavendors" runat="server" RepeatDirection="Horizontal"
                                RepeatLayout="Flow" CellSpacing="5"
                                CellPadding="1"
                                HorizontalAlign="Center" BackColor="Transparent"
                                OnItemDataBound="Datavendors_ItemDataBound" OnItemCommand="Datavendors_ItemCommand">
                                <ItemStyle ForeColor="gray"></ItemStyle>
                                <ItemTemplate>
                                    <div class="col-xs-6 col-sm-3 col-md-3" style="margin-top: 10px;">

                                        <div class="card">
                                            <asp:ImageMap ID="ImageMap1" runat="server" Width="100%"
                                                ImageUrl='<%# "GetImages.ashx?VendorID=" + Eval("ID")  %>'>
                                            </asp:ImageMap>
                                            
                                                <h4 style="color: #000;"><%# Eval("VendorName") %></h4>
                                                <hr />
                                                <p class="title"><%# Eval("ShopCategory") %></p>
                                                <hr />
                                                <p><i class="fa fa-map-marker" aria-hidden="true"></i><%# Eval("Address") %>, <%# "" + Eval("Address2") %></p>
                                                <hr />
                                                <p><i class="fa fa-phone" aria-hidden="true"></i><%# " " + Eval("ContactNumber") %></p>
                                               <hr />
                                            <p><i class="fa fa-phone" aria-hidden="true"></i><%# " " + Eval("ContactNumber2") %></p>

                                             <!-- <p id="fotter_color" style="background-color: #dc3545;  padding-bottom: 20px; padding-top: 7px; padding-left: 5px; padding-right: 5px;">
                                                    <i class="fa fa-edit" id="Edit_Vendor" style="color: #fff;  cursor: pointer; float: left; visibility:hidden" 
                                                      onclick="ShowEditForm('<%# Eval("ID") %>','<%# Eval("VendorName") %>','<%# Eval("ShopCategory")%>','<%# Eval("ContactNumber") %>','<%# Eval("ContactNumber2") %>','<%# Eval("Address") %>',' <%# Eval("Address2") %>',this)">Edit
                                                    </i><i class="fa fa-trash" id="vendor_delete" onclick="DeleteForm('<%# Eval("ID")%>','<%# Eval("VendorName")%>','<%# Eval("ShopCategory")%>')" style="color: #fff; float: right; cursor: pointer; visibility:hidden;" aria-hidden="true">Delete</i>--> 

                                                <p id="fotter_color" style="background-color: #dc3545;  padding-bottom: 20px; padding-top: 7px; padding-left: 5px; padding-right: 5px;margin-bottom:0px;">
                                                    <i class="fa fa-edit" id="Edit_Vendor" style="color: #fff; cursor: pointer; float: left;" 
                                                        onclick="ShowEditForm('<%# Eval("ID") %>','<%# Eval("VendorName") %>','<%# Eval("ShopCategory")%>','<%# Eval("ContactNumber") %>','<%# Eval("ContactNumber2") %>','<%# Eval("Address") %>',' <%# Eval("Address2") %>',this)">Edit
                                                    </i><i class="fa fa-trash" id="vendor_delete" onclick="DeleteForm('<%# Eval("ID")%>','<%# Eval("VendorName")%>','<%# Eval("ShopCategory")%>')" style="color: #fff; float: right; cursor: pointer;" aria-hidden="true">Delete</i>
                                                </p>
                                          <%--  <p style="height:30px; width:100%; border:1px solid green;"></p>--%>

                                            <p id="offer_color" class="offerbox-raised">
                                                    Offers  <i class="fa fa-angle-right transit" style="float:right; padding-right:5px;font-size:25px; "></i>
                                                <i class="fa fa-angle-right transit" style="float:right; padding-right:5px; font-size:25px;"></i>

                                                </p>
                                        </div>



                                        <%--<div class="panel-group">
                                            <div class="panel panel-info layout_shadow_box">
                                                <div class="panel-heading">
                                                    <asp:Label ID="LinkButton2" runat="server" ForeColor="#000" Font-Size="Large" Font-Bold="true" Text='<%# Eval("VendorName") %>'>LinkButton</asp:Label>&nbsp;-&nbsp;<asp:Label ID="label" runat="server" ForeColor="#005cb9" Text='<%# Eval("ShopCategory") %>'>LinkButton</asp:Label></div>
                                                <div class="panel-body" style="background-color: #fff">
                                                    <div class="vendor-main">

                                                        <div class="vendor-top">
                                                            <div class="vendor-left">
                                                                <asp:ImageMap ID="ImageMap1" runat="server" CssClass="Vendor_Images" Height="100px" Width="100px"
                                                                    ImageUrl='<%# "GetImages.ashx?VendorID=" + Eval("ID")  %>'>
                                                                </asp:ImageMap>
                                                            </div>
                                                            <div class="vendor-right">
                                                                <div class="vendor-phone">
                                                                    <asp:Label ID="LinkButton3" runat="server" class="fa fa-mobile fa-1x" ForeColor="#000" Text='<%# " " + Eval("ContactNum") %>'>LinkButton</asp:Label><br>
                                                                    <asp:Label ID="Label1" runat="server" class="fa fa-mobile fa-1x" ForeColor="#000" Text='<%# " " + Eval("ContantNumber2") %>'>LinkButton</asp:Label>
                                                                </div>

                                                                <div class="vendor-address">
                                                                    <asp:Label ID="label3" runat="server" Class="fa fa-map-marker fa-1.3x" ForeColor="#000" Text='<%# " " + Eval("Address") %>'>LinkButton</asp:Label>
                                                                    <asp:Label ID="label5" runat="server" ForeColor="gray" Text='<%# "" + Eval("Address2") %>'>LinkButton</asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>                                                       

                                                    </div>
                                                     <div class="vendor-bottom" style="text-align:right;">
                                                     
                                                                <button class="btn btn-danger btn-sm"  id="edit_icon_button" type="button" 
                                                                    onclick="SetValues('<%# Eval("ID") %>','<%# Eval("VendorName") %>','<%# Eval("ShopCategory")%>','<%# Eval("ContactNum") %>','<%# Eval("Address") %>',this)">Edit
                                                                </button>
                                                        
                                                        </div>
                                                </div>
                                            </div>
                                        </div>--%>

                                        <%--<div style="height:30px; width:100%; border:1px solid green;"></div>--%>
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>
                            
                        </div>


                        <div class="row">

                            <asp:Label ID="lblVendrEmptyText" runat="server" ForeColor="#3e9eff" Text=""></asp:Label>

                        </div>

                        <input type="hidden" name="imgEditX1" id="imgEditX1" />
                        <input type="hidden" name="imgEditY1" id="imgEditY1" />
                        <input type="hidden" name="imgEditWidth" id="imgEditWidth" />
                        <input type="hidden" name="imgEditHeight" id="imgEditHeight" />
                        <input type="hidden" name="imgEditCropped" id="imgEditCropped" />
                        <asp:HiddenField ID="HiddenVendorID" runat="server" />
                        <asp:HiddenField ID="HiddenVendorName" runat="server" />
                        <asp:HiddenField ID="HiddenVendorEditID" runat="server" />
                        <asp:HiddenField ID="HiddenVendorDelID" runat="server" />

                    </div>



                    <%------------------------------------------------- Add Vendor Dialog starts from here ------------------------------------------------------------------------------------%>

                    <div id="myVendorAddForm" class="modal">

                        <div class="container-fluid" style="max-width: 600px;">

                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <label id="headingAddEdit"></label>

                                        <span class="fa fa-times" aria-hidden="true" onclick="CloseAddVendor()" style="cursor: pointer;float:right;"></span>

                                </div>

                                <div class="panel-body">

                                    <div class="row">
                                        <div class="col-xs-8">
                                            <table class="vendor_add_table" style="text-align: left; margin-top: 1px;">
                                                <tr>
                                                    <td style="width: 150px; padding-left: 5px;">
                                                        <label>Category :</label>
                                                    </td>
                                                    <td style="width: 150px;">
                                                        <asp:DropDownList ID="drpVendorcategory" runat="server" CssClass="ddl_style form-control" Width="150px">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td style="width: 5px;"></td>
                                                </tr>

                                                <tr>
                                                    <td style="width: 150px; padding-left: 5px;">
                                                        <label>Vendor Name :</label>
                                                    </td>
                                                    <td style="width: 150px;">
                                                        <asp:TextBox ID="txtvendorname" runat="server" CssClass="form-control" EnableViewState="false" Width="150px"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ValidationExpression="^[a-zA-Z\s0-9.]{0,25}$" ControlToValidate="txtvendorname" ErrorMessage="Enter valid Name" Font-Size="Small" ForeColor="#FF5050" ValidationGroup="Add_Vendor" Display="Dynamic"></asp:RegularExpressionValidator>
                                                    </td>
                                                    <td style="width: 5px;">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtvendorname" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Add_Vendor"></asp:RequiredFieldValidator>
                                                    </td>

                                                </tr>

                                                <tr>
                                                    <td style="width: 150px; padding-left: 5px;">
                                                        <label>Contact No.1 :</label>
                                                    </td>
                                                    <td style="width: 150px;">
                                                        <asp:TextBox onkeypress="return isNumberKey(event)"  ID="txtvendromobile" runat="server" CssClass="form-control" EnableViewState="false" Width="150px" MaxLength="10"></asp:TextBox>
                                                        
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3"  runat="server" ValidationExpression="^[0-9]+$" ControlToValidate="txtvendromobile" ErrorMessage="Enter valid No." Font-Size="Small" ForeColor="#FF5050" ValidationGroup="Add_Vendor" Display="Dynamic"></asp:RegularExpressionValidator>
                                                    </td>
                                                    <td style="width: 5px;">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7"  runat="server" ControlToValidate="txtvendromobile" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Add_Vendor"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 150px; padding-left: 5px;">
                                                        <label>Contact No.2 :</label>
                                                    </td>
                                                    <td style="width: 150px;">
                                                        <asp:TextBox  onkeypress="return isNumberKey(event)" ID="txtMobile2" runat="server" CssClass="txtbox_style form-control" EnableViewState="false"  Width="150px" MaxLength="10"></asp:TextBox>
                                                        
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationExpression="^[0-9]+$" ControlToValidate="txtvendromobile" ErrorMessage="Enter valid No." Font-Size="Small" ForeColor="#FF5050" ValidationGroup="Add_Vendor" Display="Dynamic"></asp:RegularExpressionValidator>
                                                    </td>
                                                    <td style="width: 5px;">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtvendromobile" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Add_Vendor"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>



                                                <tr>
                                                    <td style="width: 150px; padding-left: 5px;">
                                                        <label>Address-1 :</label>
                                                    </td>
                                                    <td style="width: 150px;">
                                                        <asp:TextBox ID="txtvendoraddress" runat="server" EnableViewState="false" Width="150px" CssClass="form-control txtbox_style"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 5px;">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtvendoraddress" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Add_Vendor"></asp:RequiredFieldValidator>
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td style="width: 150px; padding-left: 5px;">
                                                        <label>Address-2 :</label>
                                                    </td>
                                                    <td style="width: 150px;">
                                                        <asp:TextBox ID="txtvendoraddress2" runat="server" EnableViewState="false" Width="150px" CssClass="form-control txtbox_style"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 5px;">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtvendoraddress" ErrorMessage="*" ForeColor="#FF5050" ValidationGroup="Add_Vendor"></asp:RequiredFieldValidator>
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td style="width: 150px; padding: 5px 0 5px 0;"></td>
                                                    <td style="width: 150px; padding: 5px 0 5px 0; color: #535151;"></td>
                                                    <td style="width: 5px;"></td>
                                                </tr>


                                                <tr>
                                                    <td colspan="3" style="text-align: center; width: 350px;">
                                                        <asp:Label ID="lblstatus" runat="server" ForeColor="#3e9eff" Font-Size="Small"></asp:Label>
                                                    </td>
                                                </tr>

                                            </table>
                                        </div>

                                        <div class="col-sm-4" style="text-align: center;">
                                          
                                            <img id="htmlImage" style="width: 150px; height: 100px" src="Images/Icon/downloadbg.jpg" />
                                            <asp:ImageMap ID="ImgPreview" runat="server" Width="5px" Height="5px" CssClass="AddvendorimgPreview" Visible="false"></asp:ImageMap>
                                            <canvas id="canvas" height="5" width="5" style="display: none;"></canvas>
                                            <br />
                                            <input id="checkAddImage" type="checkbox" onclick="ToggleFileUpload(this)" />Upload a Image    
                                              <asp:FileUpload ID="FileVendorImg" runat="server" onchange="PreviewAddImage()" Width="150px" CssClass="AddvendorFileupload" /><br />

                 
                                        </div>
                                    </div>
                                 </div>
                                    <div class="panel-footer" style="text-align: right;">
                                        
                                            <button type="button" id="Cancel_Button"  class="btn btn-danger">Cancel</button>
                                            <asp:Button ID="btnNewvendor" runat="server" Text="Submit" CssClass="btn btn-success" OnClick="btnNewvendor_Click" ValidationGroup="Add_Vendor" />
                                     
                                    </div>
                              
                            </div>
                        </div>
                    </div>



                    <!-- Model box for Delete Confirmation -->
                    <div id="ConfirmDelete" class="modal">
                        <div class="container-fluid" style="width: 400px; height: 100px;">
                            <div id="confirmBox" class="panel panel-primary" >
                                <div class="panel-heading" style="text-align: left;">Delete Confirmation 
                                    <span class="fa fa-times" onclick="ConfirmCancel()" style="color:white; float:right;cursor:pointer;"></span>
                                </div>
                                <div class="panel-body">
                                   <div class="message_Below">
                                    <table style="width: 100%;">

                                        <tr>
                                            <td colspan="2" style="text-align: center;">You  are about  to  delete  Vendor,  it  will permanantly  delete from database Continue ?
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="height: 15px;"></td>
                                        </tr>
                                        
                                    </table>
                                </div>
                                 </div>
                                <div class="panel-footer" style="text-align:right;">
                                    <button type="button" id="btnVendorDelCancel" class="btn btn-danger">No</button>
                                     <asp:Button ID="btnVendorDelete" CausesValidation="false" CssClass="btn btn-success" runat="server" 
                                         OnClick="btnVendorDelete_Click" Text="Yes" />
                          
                                </div>
                            </div>
                        </div>
                    </div>

                    <%-- <div class="dvLoading_first">
        
                                </div>--%>

                    <input type="hidden" name="imgX1" id="imgX1" />
                    <input type="hidden" name="imgY1" id="imgY1" />
                    <input type="hidden" name="imgWidth" id="imgWidth" />
                    <input type="hidden" name="imgHeight" id="imgHeight" />
                    <input type="hidden" name="imgCropped" id="imgCropped" />
                </form>

                <%--Added by Aarshi on 22 aug 2017 for image crop code--%>
                <div id="image_modal_div" class="modal" style="height: auto; width: auto;">
                    <div style="height: 30px; width: auto; background-color: white; margin-top: 0px;"><span class="close">&times;</span></div>
                    <div style="padding-left: 5px; padding-right: 5px;">
                        <img id="Image_crop" src="" alt="" style="background-color: white; margin: auto;" />
                    </div>
                    <div style="height: 40px; width: auto; background-color: white;">
                        <button type="button" id="btnOK" value="OK" class="btnModal_style" style="margin-left: 25px;">OK</button>
                        <button type="button" id="btnCancel" value="CANCEL" class="btnModal_style" style="margin-right: 25px; float: right">Cancel</button>
                    </div>
                </div>


        </div>
    </div>
</body>
</html>
