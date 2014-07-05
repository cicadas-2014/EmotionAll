linkEvents = {
    trendClick: function() {
        var self = this;
        $('#trending-topics ul li').on('click', function(event) {
            event.preventDefault();
            var trend = $(this).text();
            var trendId = $(this).attr('id').substring(6);
            self.fetchTweets(trend, trendId);
        })
    },
    fetchTweets: function(trend, trendId) {
        var self = this;
        var trendReq = $.get('/trends/' + trendId);
        trendReq.success(function(response) {
            createMapView.init(response);
            self.fetchMap();
        })
        trendReq.fail(function(response) {
            console.log('Fail! :(');
        })
    },
    fetchMap: function() {
        var mapReq = $.get('/map/show');
        mapReq.success(function(html) {
            $('#trend-menu').append(html);
        })
    }
}

