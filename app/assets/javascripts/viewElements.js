var scrollEvents = {
    shrinkMenu: function() {
        $(window).scroll(function() {
            var height = 300,
                y = $(this).scrollTop();
            if( y > height ) {
                $('header').addClass('shrink');
            } else {
                $('header').removeClass('shrink');
            }
        })
    },
    showFooter: function() {
        $(window).scroll(function() {
            var height = 300,
                y = $(this).scrollTop();
            if( y > height ) {
                $('footer').show();
            } else {
                $('footer').hide();
            }
        })
    }
}
