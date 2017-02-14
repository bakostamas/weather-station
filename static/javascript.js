
function buildChartsPressure(chart_id, chart_title, params) { //params: [period, value] array
    var period = [];
    var values_pres = [];
    var values_min = [];
    var values_max = [];
    for (i=0; i<params.length; i++) {
        period.push(params[i][0]); //fill up the "period" array
        values_pres.push(params[i][1]); //fill up the "values_avg" array
        //values_min.push(params[i][2]); //fill up the "values_min" array
        //values_max.push(params[i][3]); //fill up the "values_max" array

        //console.log(params[i]); For debugging - puts the values to browser's console
    }

    var ctx = document.getElementById(chart_id);
    var myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: period,
            datasets: [{
                label: chart_title,
                data: values_pres,
                borderWidth: 2,
                backgroundColor: "#555", //"#77A0CE"
                borderColor: "#555", //"#77A0CE"
                fill: false
            }/*,{
                label: "Min. " + chart_title,
                data: values_min,
                borderWidth: 2,
                backgroundColor: "#33E", //"#77A0CE"
                borderColor: "#33E", //"#77A0CE"
                fill: false
            },{
                label: "Max. " + chart_title,
                data: values_max,
                borderWidth: 2,
                backgroundColor: "#E33", //"#77A0CE"
                borderColor: "#E33", //"#77A0CE"
                fill: false
            }*/
            ]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:false
                    }
                }]
            }
        }
    });
}



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

var panels = [
    "#temperature",
    "#humidity",
    "#pressure"
    // "#wind"
];
var count_panels = panels.length;
var active_panel = "#temperature";
var counter = 0;


function swapPanels() {

  $( active_panel ).slideUp( "fast", function() {  //unload weather data
    $( panels[counter+1] ).slideDown( "fast", function() {  //load weather data

      $( active_panel + "_in" ).slideUp( "fast", function() {  //unload indoor data
        $( panels[counter+1] + "_in" ).slideDown( "fast", function() {  //load indoor data

          active_panel = panels[counter+1];
          if (counter < count_panels-2) {
             counter++;
          } else {
             counter = -1;
          }
        })
      })
    })
  });

}


function startSwapPanels() {

    var x = setInterval(swapPanels, 5000);
}

