linkEvents = {
    onClick: function() {
        var self = this;
        $('#trending-topics ul li').on('click', function(event) {
            event.preventDefault();
            console.log('hi!');
        })
    }
}

