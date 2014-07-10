var Emotionall = {
  init: function() {
    this.setupTrendList();
    this.setupScrollToMap();
    this.setupLogoLink();
    this.setupScrollToAbout();
    this.launchMapView();
  },
  setupTrendList: function() {
    var self = this;
    $('#outer-map-container').on('click', 'li', function(event) {
      event.preventDefault();
      var trend = $(this).text();
      var trendId = $(this).attr('id').substring(6);
      Tweets.fetchData(trend, trendId);
    });
  },
  setupScrollToMap: function() {
    $('.scroll-icon').on('click', function(event) {
      event.preventDefault();
      var $anchor = $('#outer-map-container h1');
      $('html, body').animate({ scrollTop: $anchor.offset().top}, 500);
    })
  },
  setupLogoLink: function() {
    $('#logo').on('click', function() {
      var $anchor = $('#outer-map-container');
      $('html, body').animate({ scrollTop: $anchor.offset().top}, 500);
    })
  },
  setupScrollToAbout: function() {
    $('#btn-for-about').on('click', function() {
      var $anchor = $('footer');
      $('html, body').animate({ scrollTop: $anchor.offset().top}, 700);
    })
  },
  launchMapView: function() {
    $trend = $('h2');
    var trend = $trend.text();
    var trendId = $trend.attr('id').substring(6);
    Tweets.fetchData(trend, trendId);
  }
};

var createMapView = {
  init: function(trend, tweetData) {
    var map = Highcharts.maps['custom/world'];
    var mapData = Highcharts.geojson(map);
    this.inputData(tweetData);
    this.layoutMap(mapData);
    this.addTrendTitle(trend);
  },
  inputData: function(data) {
    Map.dataInput = [];
    for (var i in data) {
      Map.dataInput.push(data[i]);
    }
  },
  layoutMap: function(mapData) {
    var deviceWidth = this.setMapWidth();
    Map.defaultView(mapData, deviceWidth);
  },
  setMapWidth: function() {
    var $width = $(document).width();
    var mapPadding = 100;
    return $width - (mapPadding * 2);
  },
  addTrendTitle: function(title) {
    $('h2').html(title);
  }
};

var mapErrorGenerator = {
  display: function(errorDiv, error) { // currently implemented for map only
    $(errorDiv).html('<p class="errors-txt">Error fetching ' + error + '.</p>');
  },
  clear: function(id) { // not currently implemented for trends
    var errorDiv = '#trend-' + id + '.errors-txt';
    $(errorDiv).remove();
  }
};
