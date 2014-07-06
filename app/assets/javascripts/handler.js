var errorHandler = {
    Display: function(errorDiv, error) {
        $(errorDiv).html('<p class="error">Error fetching ' + error + '.</p>');
    },
    Clear: function(id) {
        var errorDiv = '#trend-' + id + ' .errors-txt';
        $(errorDiv).remove();
    }
}

var eventHandler = function() {
    linkEvents.popularTrend();
    linkEvents.currentTrend();
    buttonEvents.allTrends();
    buttonEvents.lessTrends();
    fixedMap();
    scrollEvents.shrinkMenu();
    scrollEvents.showFooter();
}
