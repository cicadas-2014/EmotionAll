// function Country(alchemizedCountry) {
//     this.code = alchemizedCountry.code;
//     this.sentiment = alchemizedCountry.sentiment;
//     this.name = alchemizedCountry.name;
// }

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
                type: 'logarithmic',
                endOnTick: false,
                startOnTick: false,
                min: 1,
                max: 100
            },
            tooltip: {
                animation: true,
                pointFormat: 'the sentiment index here'
            },
            series : [{
                data : self.dataInput, // data is array of objects with country info
                mapData: mapData, // default country objects that populate map
                joinBy: ['iso-a2', 'code'],
                name: 'TOPIC sentiment',
                allowPointSelect: false,
                states: {
                    select: {
                        borderColor: 'black',
                        dashStyle: 'shortdot',
                    }
                }
            }]
        })
    },
}


var createMapView = {
    init: function() {
        var self = this;
        $.getJSON('http://www.highcharts.com/samples/data/jsonp.php?filename=world-population-density.json&callback=?', function(data) {
            var mapData = Highcharts.geojson(Highcharts.maps['custom/world']);
            self.inputData(data);
            self.layoutMap(mapData);
        })
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