function Country(alchemizedCountry) {
    this.code = alchemizedCountry.code;
    this.sentiment = alchemizedCountry.sentiment;
    this.name = alchemizedCountry.name;
}


$(function () {

    $.getJSON('http://www.highcharts.com/samples/data/jsonp.php?filename=world-population-history.csv&callback=?', function (csv) {

        // Parse the CSV Data
        /*Highcharts.data({
            csv: data,
            switchRowsAndColumns: true,
            parsed: function () {
                console.log(this.columns);
            }
        });*/

        // Very simple and case-specific CSV string splitting
        function CSVtoArray(text) {
            return text.replace(/^"/, '')
                .replace(/",$/, '')
                .split('","');
        };

        csv = csv.split(/\n/);

        var countries = {},
            mapChart,
            // countryChart,
            numRegex = /^[0-9\.]+$/,
            quoteRegex = /\"/g,
            categories = CSVtoArray(csv[1]).slice(4);

        // Parse the CSV into arrays, one array each country
        $.each(csv.slice(2), function (j, line) {
            var row = CSVtoArray(line),
                data = row.slice(4);

            $.each(data, function (i, val) {

                val = val.replace(quoteRegex, '');
                if (numRegex.test(val)) {
                    val = parseInt(val);
                } else if (!val) {
                    val = null;
                }
                data[i] = val;
            });
            countries[row[1]] = {
                name: row[0],
                code3: row[1],
                data: data
            };
        });

        // For each country, use the latest value for current population
        var data = [];
        for (var code3 in countries) {
            var value = null,
                year,
                itemData = countries[code3].data,
                i = itemData.length;

            while (i--) {
                if (typeof itemData[i] === 'number') {
                    value = itemData[i];
                    year = categories[i];
                    break;
                }
            }
            data.push({
                name: countries[code3].name,
                code3: code3,
                value: value,
                year: year
            });
        }

        // Add lower case codes to the data set for inclusion in the tooltip.pointFormat
        var mapData = Highcharts.geojson(Highcharts.maps['custom/world']);
        $.each(mapData, function () {
            this.id = this.properties['hc-key']; // for Chart.get()
        });
        // Initiate the map chart
        mapChart = $('#container').highcharts('Map', {

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
                min: 50000
            },

            tooltip: {
                animation: true,
                pointFormat: 'the sentiment index here'
            },

            series : [{
                // data is array of objects with country info
                data : data,
                // default country objects that populate map
                mapData: mapData,
                joinBy: ['iso-a3', 'code3'],
                name: 'TOPIC sentiment',
                allowPointSelect: false,
                // cursor: 'pointer',
                states: {
                    select: {
                        // color: '#a4edba',
                        borderColor: 'black',
                        dashStyle: 'shortdot',

                    }
                }
            }]
            // may not need below method
        }).highcharts();
    });
});
