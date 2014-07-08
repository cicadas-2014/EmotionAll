var Map = {
  dataInput: [],
  defaultView: function(topic, mapData, width) {
    var self = this,
        width = width;
    $('#map-container').highcharts('Map', {
      chart: {
        width: width,
        height: 800,
        backgroundColor: '#FFFFFF'
      },
      title: {
        text: topic,
        style: {
          color: '#0099CC',
          font: '44px "HelveticaNeue", Arial, sans-serif'
        }
      },
      mapNavigation: {
        enabled: true,
        buttonOptions: {
          align: 'right',
          verticalAlign: 'bottom'
        },
        enableMouseWheelZoom: false
      },
      colorAxis: {
        type: 'linear',
        endOnTick: false,
        startOnTick: false,
        min: -1,
        max: 1,
        stops: [
          [0, '#CC0033'],
          [0.5, '#FFFFFF'],
          [1, '#00CC33']
        ],
      },
      colors: ['#B4DA55'],
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
            color: '#B4DA55'
          }
        }
      },
      series: [{
        data: self.dataInput,
        mapData: mapData,
        name: 'Sentiment Index',
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
    var deviceWidth = this.setMapWidth();
    Map.defaultView(topic, mapData, deviceWidth);
  },
  setMapWidth: function() {
    $width = $(document).width();
    console.log($width);
    if ($width > 1280) {
      return 1200;
    } else if ($width > 1025) {
      return 850;
    } else if ($width > 960) {
      return 800;
    } else if ($width > 640) {
      return 640;
    } else if ($width > 480) {
      return 480;
    } else {
      return 300;
    };
  }
};

