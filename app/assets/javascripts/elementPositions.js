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
    },
    stickMap: function() {
        var height = $('.padding-div').height() + $('#main').height(),
            $map = $('#map-wrapper');
        $(window).scroll(function() {
            var y = $(this).scrollTop();
            if( y > height ) {
              $map.addClass('fixed-map');
            } else {
              $map.removeClass('fixed-map');
            }
      })
    },
    stickTrendHeader: function() {
        var height = $('.padding-div').height() + $('#main').height(),
        $text = $('#trend-header');
        $(window).scroll(function() {
            var y = $(this).scrollTop();
            if( y > height ) {
                $text.addClass('fixed');
            } else {
                $text.removeClass('fixed');
            }
       })
    }
};
