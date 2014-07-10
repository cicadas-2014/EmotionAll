

var errorHandler = {
    Display: function(errorDiv, error) {
        $(errorDiv).html('<p class="errors-txt">Error fetching ' + error + '.</p>');
    },
    Clear: function(id) {
        var errorDiv = '#trend-' + id + '.errors-txt';
        $(errorDiv).remove();
    }
};
