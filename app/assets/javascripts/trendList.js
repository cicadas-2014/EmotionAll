var buttonEvents = {
    allTrends: function() {
        $('#all-trends-container').on('click', '#all-trends-btn', function(event) {
            $('.past-trend').show();
            $('#less-trends-btn').show();
            $(this).hide();
        });
    },
    lessTrends: function() {
        $('#all-trends-container').on('click', '#less-trends-btn', function(event) {
            $('.past-trend').hide();
            $('#all-trends-btn').show();
            $(this).hide();
        })
    }
};
