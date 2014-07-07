var linkEvents = {
    currentTrend: function() {
        var self = this;
        $('#main-content').on('click', 'li', function(event) {
            event.preventDefault();
            errorHandler.Clear(self.trendId);
            var trend = $(this).text();
            self.trendId = $(this).attr('id').substring(6);
            fetchTweets(trend, self.trendId);
        });
    },
    popularTrend: function() {
        $('#trends-content').on('click', 'li', function(event) {
            event.preventDefault();
            $('#main-content').show();
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
    mapReq.success(function(html) {
        $('#map-wrapper').html(html);
        createMapView.init(trend, tweetData);
    });
    mapReq.fail(function() {
        errorHandler.Display('#map-wrapper', 'map');
    });
};
