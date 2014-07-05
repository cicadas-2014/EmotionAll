linkEvents = {
    trendClick: function() {
        var self = this;
        $('#trending-topics ul li').on('click', function(event) {
            event.preventDefault();
            var trend = $(this).text();
            self.fetchTweets(trend);
        })
    },
    fetchTweets: function(trend) {
        $.get('/')
    }
}

