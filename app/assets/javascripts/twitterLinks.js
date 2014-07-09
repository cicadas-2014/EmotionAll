var linkEvents = {
    accessTrend: function() {
        var self = this;
        $('#outer-map-container').on('click', 'li', function(event) {
            event.preventDefault();
            errorHandler.Clear(self.trendId);
            var trend = $(this).text();
            self.trendId = $(this).attr('id').substring(6);
            fetchTweets(trend, self.trendId);
        });
    }
};

function fetchTweets(trend, trendId) {
    var trendReq = $.get('/trends/' + trendId);
    trendReq.success(function(tweetData) {
        fetchMap(trend, tweetData);
    });
    trendReq.fail(function() {
        var errorDiv = '#trend-' + trendId + ' .errors-txt';
        errorHandler.Display(errorDiv, 'tweets');
    });
};

function fetchMap(trend, tweetData) {
    var mapReq = $.get('/map/show');
    mapReq.success(function() {
        createMapView.init(trend, tweetData);
    });
    mapReq.fail(function() {
        errorHandler.Display('#map-wrapper', 'map');
    });
};
