var Map = {
  dataInput: [],
  defaultView: function(topic, mapData) {
    var self = this;
    $('#map-container').highcharts('Map', {
      title: {
        text: topic
      },
      mapNavigation: {
        enabled: true,
        buttonOptions: {
          align: 'right',
          verticalAlign: 'bottom'
        }
      },
      colorAxis: {
        type: 'linear',
        endOnTick: false,
        startOnTick: false,
        min: 1,
        max: 100,
        minColor: '#474CFF',
        maxColor: '#FF3E44'
      },
      colors: ['#FFF9E4'],
      tooltip: {
        animation: true,
        pointFormat: '{point.name}: {point.value}',
        shadow: false
      },
      legend: {
        align: 'center',
        itemWidth: 200,
        reversed: false,
      },
      plotOptions: {
        series: {
          joinBy: ['iso-a2', 'code'],
        },
        states: {
          hover: {
            enabled: true
          },
          select: {
            borderColor: 'black',
            dashStyle: 'shortdot',
            color: '#FFF9E4'
          }
        }
      },
      series: [{
        data: self.dataInput,
        mapData: mapData,
        name: 'Sentiment Index'
      }]
    })
  }
};

var createMapView = {
  init: function(trend, tweetData) {
    var map = Highcharts.maps['custom/world'];
    var mapData = Highcharts.geojson(map);
    this.inputData(tweetData);
    this.layoutMap(trend, mapData);
  },
  inputData: function(data) {
    Map.dataInput = [];
    for (var i in data) {
      Map.dataInput.push(data[i]);
    }
  },
  layoutMap: function(topic, mapData) {
    Map.defaultView(topic, mapData);
  }
};

function fixedMap() {
  var yDistance = $('.padding-div').height() + $('#main').height();
  var $map = $('#map-wrapper');
  $(window).scroll(function() {
    var y = $(this).scrollTop();
    if ( y > yDistance ) {
      $map.addClass("fixed-map");
    } else {
      $map.removeClass("fixed-map");
    }
  })
};

