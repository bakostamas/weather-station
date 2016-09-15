function checkTime(i) {
    if (i < 10) {
        i = "0" + i;
    }
    return i;
}

function startTime() {
    var today = new Date();
    var h = today.getHours();
    var m = today.getMinutes();
    var s = today.getSeconds();
    var y = today.getFullYear();
    var mo = today.getMonth()+1;
    var d = today.getDate();

    // add a zero in front of numbers<10
    m = checkTime(m);
    s = checkTime(s);
    mo = checkTime(mo);
    d = checkTime(d);
    document.getElementById('time1').innerHTML = h + ":" + m;
    document.getElementById('sec1').innerHTML = s;
    document.getElementById('date1').innerHTML = y + "." + mo + "." + d;

    t = setTimeout(function () {
        startTime()
    }, 500);
}

