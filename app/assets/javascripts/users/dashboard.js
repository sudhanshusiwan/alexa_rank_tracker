function renderDashboardChart() {

    Highcharts.chart('container', {
        chart: {
            type: 'spline'
        },
        title: {
            text: "History of your site's Alexa Ranking"
        },
        subtitle: {
            text: 'Variation in Ranking across days'
        },
        xAxis: {
            type: 'datetime',
            dateTimeLabelFormats: {
                month: '%e. %b',
                year: '%b'
            },
            title: {
                text: 'Date'
            }
        },
        yAxis: {
            title: {
                text: 'Alexa Ranking'
            },
            min: 0
        },
        tooltip: {
            headerFormat: '<b>{series.name}</b><br>',
            pointFormat: '{point.x:%e. %b %Y}: {point.y:.0f}'
        },

        plotOptions: {
            spline: {
                marker: {
                    enabled: true
                }
            }
        },

        series: getChartData()
    });
}

function getChartData(){
    var website, ranking_history;

    var chart_array = $.map( chart_data, function( data, value ){
        website = { name: data.url };

        ranking_history = [];
        $.each( data.ranking_history, function( index, website_history ){
            ranking_history.push( [ Date.UTC.apply( this, website_history.date.split(',') ), website_history.rank ] );
        });

        website.data = ranking_history;

        return website;
    });

    return chart_array;
}

$( document ).ready(function() {
    if ( chart_data.length == 0 ){
        $('#container').html('<h2  class="no-site-notice" > No data to display </h2>' +
            '<h3 class="no-site-notice">Please add websites in settings to track</h3>')
    } else {
        renderDashboardChart();
    }
});