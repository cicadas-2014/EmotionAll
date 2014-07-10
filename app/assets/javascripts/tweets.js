var Tweets = {
  fetchData: function(trend, trendId) {
    var self = this;
    var trendReq = $.get('/trends/' + trendId);
    trendReq.success(function(tweetData) {
        self.fetchMapData(trend, tweetData);
    });
    trendReq.fail(function() {
      var errorDiv = '#trend-' + trendId + ' .errors-txt';
      mapErrorGenerator.display(errorDiv, 'tweets');
    })
  },
  fetchMapData: function(trend, tweetData) {
    var mapReq = $.get('/map/show');
    mapReq.success(function() {
      createMapView.init(trend, tweetData);
    });
    mapReq.fail(function() {
      mapErrorGenerator.display('#map-wrapper', 'map');
    });
  }
};
