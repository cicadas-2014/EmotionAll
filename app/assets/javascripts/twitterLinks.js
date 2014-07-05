var linkEvents = {
    trendClick: function() {
        var self = this;
        $('#trending-topics ul li').on('click', function(event) {
            event.preventDefault();
            errorEvents.Clear(self.trendId);
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
        errorEvents.Display(errorDiv, 'tweets');
    });
};

function fetchMap(trend, tweetData) {
    var mapReq = $.get('/map/show');
    mapReq.success(function(html) {
        $('#map-wrapper').html(html);
        createMapView.init(trend, tweetData);
    });
    mapReq.fail(function() {
        errorEvents.Display('#map-wrapper', 'map');
    });
};

var errorEvents = {
    Display: function(errorDiv, error) {
        $(errorDiv).html('<p class="error">Error fetching ' + error + '.</p>');
    },
    Clear: function(id) {
        var errorDiv = '#trend-' + id + ' .errors-txt';
        $(errorDiv).remove();
    }
}
