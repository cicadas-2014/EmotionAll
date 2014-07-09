var Map = {
  dataInput: [],
  defaultView: function(topic, mapData, width) {
    var self = this,
        width = width,
        title = topic;
    $('#map-container').highcharts('Map', {
      chart: {
        width: width,
        height: 800,
        backgroundColor: '#FFFFFF'
      },
      title: {
        text: "",
        style: {
          color: '#0099CC',
          font: '36px "HelveticaNeue", Arial, sans-serif'
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
          [0.49999, '#efb2c1'],
          [0.5, '#FFFFFF'],
          [0.50001, '#b2efc1'],
          [1, '#00CC33']
        ],
      },
      colors: ['#0099CC'],
      tooltip: {
        animation: true,
        shadow: false,
        followPointer: true,
        headerFormat: '<span style="font-size:10px">{series.name}</span><br/>',
        pointFormat: '<span style="font-size:10px"><strong>{point.name}</strong></span><br/><span style="font-size:9.5px">S: {point.value} | TS: {point.overall} | TC: {point.tweet_count}</span><br/>',
        footerFormat: '<span style="font-size:8px">Source: AlchemyAPI</span>',
        hideDelay: 50
      },
      legend: {
        reversed: false,
        title: {
          text: '<span style="font-weight: bold">Sentiment Score</span>',
          style: {
            color: '#333',
            font: '13.5px "HelveticaNeue", Arial, sans-serif',
            fontWeight: 'normal'
          }
        }
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
        name: 'Sentiment Analysis',
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
    this.addMapTitle(topic);
  },
  setMapWidth: function() {
    var $width = $(document).width();
    var mapPadding = 50;
    return $width - (mapPadding * 2);
  },
  addMapTitle: function(title) {
    $('h2').html(title);
  }
};

