var Map = {
  defaultView: function(mapData, width) {
    var self = this,
    width = width;
    $('#map-container').highcharts('Map', {
      chart: {
        width: width,
        height: 800,
        backgroundColor: '#FFFFFF'
      },
      title: {
        text: '' // leaves map header blank
      },
      mapNavigation: {
        enabled: true,
        buttonOptions: {
          align: 'right',
          verticalAlign: 'bottom'
        },
      enableMouseWheelZoom: false,
      enableDoubleClickZoom: false
      },
      colorAxis: {
        type: 'linear',
        endOnTick: false,
        startOnTick: false,
        min: -1,
        max: 1,
        stops: [
        [0, '#CC0033'],
        [0.49, '#efb2c1'],
        [0.5, '#FFFFFF'],
        [0.51, '#b2efc1'],
        [1, '#00CC33']
        ],
      },
      colors: ['#99d6ea'],
      tooltip: {
        animation: true,
        shadow: false,
        useHTML: true,
        followPointer: true,
        headerFormat: '', // leaves tooltip header blank
        pointFormat: '<span style="font-size:24px; line-height: 22px; font-weight: bold">{point.name}</span><br/>'
          + '<br/>' // line break for whitespace in tooltip
          + '<span style="font-size:13px; line-height:18px">{series.name}</span><br/>'
          + '<span style="font-size:16px; font-weight:bold; line-height: 24px">Trend Sentiment Score: </span>'
          + '<span style="font-weight:normal; font-size:16px">{point.value}</span><br/>'
          + '<span style="font-size:16px; font-weight:bold; line-height: 24px">Overall Sentiment Score: </span>'
          + '<span style="font-weight:normal; font-size:16px">{point.overall}</span><br/>'
          + '<span style="font-size:16px; font-weight:bold; line-height: 24px">Tweet Count: </span>'
          + '<span style="font-weight:normal; font-size:16px">{point.tweet_count}</span><br/>',
        footerFormat: '<span style="font-size:8px">Source: AlchemyAPI</span>',
        hideDelay: 10,
        style: {
          font: '"HelveticaNeue", Arial, sans-serif',
          padding: '24px'
        }
      },
      legend: {
        reversed: false,
        title: {
          text: '<span style="font-weight:bold">Sentiment Score</span>',
          style: {
            color: '#333333',
            font: '13.5px "HelveticaNeue", Arial, sans-serif',
            fontWeight: 'normal'
          },
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
