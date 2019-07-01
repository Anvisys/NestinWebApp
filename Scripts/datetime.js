function GetDateTimeinISO(datetime) {
    var dMonth = "00";
    var dDay = "00";
    var dHour = "00";
    var dMin = "00";
    var dSec = "00";
   // var datetime = new Date();

    var dYear = datetime.getFullYear();

    var month = datetime.getUTCMonth();
    if (month < 10) {

        dMonth = "0" + month;
    }
    else {
        dMonth = month;
    }
    var day = datetime.getUTCDay();

    if (day < 10) {
        dDay = "0" + day;
    }
    else {
        dDay = day;
    }

    var Hrs = datetime.getUTCHours();
    if (Hrs < 10) {
        dHour = "0" + Hrs;
    }
    else {
        dHour = Hrs;
    }

    var Min = datetime.getUTCMinutes();
    if (Min < 10) {
        dMin = "0" + Min;
    }
    else {
        dMin = Min;
    }

    var Sec = datetime.getUTCSeconds();
    if (Sec < 10) {
        dSec = "0" + Sec;
    }
    else {
        dSec = Sec;
    }
     
    return dYear + "-" + dMonth + "-" + dDay + " " + dHour + ":" + dMin + ":" + dSec+":000";   
}



function DisplayDateOnly(inputdate) {

    var date = new Date(inputdate);
    var day = date.getDate().toString();
    if (day.length == 1) { day = "0" + day; }

    var month = (date.getMonth() + 1).toString();
    if (month.length == 1) { month = "0" + month; }

    var strDate = day + "/" + month + "/" + date.getFullYear();
    return strDate;
}


function DisplayDateTime(inputdate) {
    var NewFormatDate;
    var date = new Date(inputdate);

    //alert(date);
    var Currentdate = new Date();

    if (date.getDate() == Currentdate.getDate()) {
        NewFormatDate = "today" +  ", " + date.getHours() + ": " + date.getMinutes();
    }
    else {
        NewFormatDate = date.toLocaleDateString() + ", " + date.toLocaleTimeString();

    }

    


    return NewFormatDate;
}
