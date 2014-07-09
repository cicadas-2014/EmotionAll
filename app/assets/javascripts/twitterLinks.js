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
    },
    launchOnReady: function() {
        $trend = $('h2');
        var trendId = $trend.attr('id').substring(6);
        var trend = $trend.text();
        fetchTweets(trend, trendId);
    },
    scrollToMap: function() {
        $('#top-scroll-icon').on('click', function(event) {
            event.preventDefault();
            var $anchor = $('#outer-map-container');
            $('html, body').animate({ scrollTop: $anchor.offset().top}, 500);
        })
    },
    scrollToAbout: function() {
        $('#btn-for-about').on('click', function() {
            var $anchor = $('#about-container');
            $('html, body').animate({ scrollTop: $anchor.offset().top}, 500);
        })
    },
    logoClick: function() {
        $('#logo').on('click', function() {
            var $anchor = $('#outer-map-container');
            $('html, body').animate({ scrollTop: $anchor.offset().top}, 500);
        })
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
