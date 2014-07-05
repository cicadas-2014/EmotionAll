var Map = {
  dataInput: [],
  defaultView: function(mapData) {
    var self = this;
    $('#map-container').highcharts('Map', {
      title : {
        text : 'Title'
      },
      subtitle: {
        text: 'Subtitle'
      },
      mapNavigation: {
        enabled: true,
        buttonOptions: {
          verticalAlign: 'bottom'
        }
      },
      colorAxis: {
        type: 'linear',
        endOnTick: false,
        startOnTick: false,
        min: 1,
        max: 100,
        minColor: '#FF3E44',
        maxColor: '#474CFF'
      },
      colors: ['#FFF9E4'],
      tooltip: { // add country names again
        animation: true,
        pointFormat: '{point.name}: {point.value}', // labelrank is converted sentiment score (1-100) .. eithe rpositive or negative
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
                data: self.dataInput, // data is array of objects with country info
                mapData: mapData, // default country objects that populate map
                name: 'Sentiment Index'
              }]
            })
},
}


var createMapView = {
  init: function(tweetData) {
    var self = this;
  // .on(click, function)
  // e.preventDefault
  // ajax request to trends#json, send up trend id
  // with response, send to createmapview
    // $.getJSON('http://www.highcharts.com/samples/data/jsonp.php?filename=world-population-density.json&callback=?', function(data) {
      var mapData = Highcharts.geojson(Highcharts.maps['custom/world']);
      self.inputData(tweetData);
      self.layoutMap(mapData);
    // })
  },
    inputData: function(data) { // may need to be refactor depending on response
        for (var i in data) { // loops through the array of objects from the get json request
          Map.dataInput.push(data[i]);
        }
      },
      layoutMap: function(mapData) {
        Map.defaultView(mapData);
    }
};
