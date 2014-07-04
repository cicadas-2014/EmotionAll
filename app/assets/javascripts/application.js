// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var positiveState = {
  color: '#FF0000',
  tweets: 120
}

var negativeState = {
  color: '#0000FF',
  tweets: 120
}

// var worldMap = function() {
//   Highcharts.setOptions({
//     chart: {
//       backgroundColor: '#FFF',
//       height: 600,
//       width: 1400
//     },
//     // title: {
//     //   style: {
//     //     color: '#A4DEF4'
//     //   }
//     // },
//     legend: {
//       title: {
//         style: {
//           color: '#161A59'
//         }
//       }
//     },
//     colorAxis: {
//       minColor: '#0000FF',
//       maxColor: '#FF0000'
//     }
//   });

//   $.getJSON('http://www.highcharts.com/samples/data/jsonp.php?filename=world-population-density.json&callback=?', function (data) {
//         // Initiate the chart
//         $('#container').highcharts('Map', {
//           mapNavigation: {
//             buttonOptions: {
//               verticalAlign: 'bottom'
//             },
//             enableDoubleClickZoomTo: true
//           },
//           legend: {
//             enabled: true
//           },
//           tooltip: {
//             style: {
//               backgroundColor: 'black',
//               opacity: '1.0',
//               color: 'black',
//               fontSize: '12px',
//               padding: '8px',
//               border: 'black'
//             }
//           },
//         //     chart: {
//         //     events: {
//         //         click: function(event) {
//         //             alert ('x: '+ event.xAxis[0].value +', y: '+
//         //                   event.yAxis[0].value);
//         //         }
//         //     }
//         // },
//         colorAxis: {
//           min: 1,
//           max: 1000,
//           type: 'logarithmic',
//           minColor: '#0000FF',
//           maxColor: '#FF0000',
//         },
//         plotOptions: {
//           series: {
//             cursor: 'pointer',
//             events: {
//               click: function(event) {
//                 $("#search").val(event.point.code);
//                 $("#searchbutton").click();
//               }
//             }
//           }
//         },
//         series : [{
//           data : data,
//           mapData: Highcharts.maps['custom/world'],
//           joinBy: ['iso-a2', 'code'],
//           borderColor: 'black',
//           name: 'Country',
//           states: {
//             select: {
//                         color: '#a4edba',
//                         borderColor: 'black',
//                         dashStyle: 'shortdot'
//                     }
//           },
//           tooltip: {
//             pointFormat: '{point.name}'
//           }
//         }]
//       });
// });
// };


$(document).ready(function() {

});
// $(document).on('page:load', ready);
