var Map = {
  dataInput: [],
  defaultView: function(topic, mapData) {
    var self = this;
    $('#map-container').highcharts('Map', {
      title: {
        text: topic,
        style: {
          color: '#0099CC',
          font: '24px "HelveticaNeue-Thin", "HelveticaNeue", Arial, sans-serif'
        }
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
        min: -1,
        max: 1,
        stops: [
          [0, '#DC381F'],
          [0.5, '#FFFFFF'],
          [1, '#32CD32']
        ],
      //   minColor: '#FF0000',
      //   maxColor: '#00FF00'
      },
      colors: ['#B4DA55'],
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
    Map.defaultView(topic, mapData);
  }
};

