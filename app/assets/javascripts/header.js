function shrinkMenu() {
    window.addEventListener('scroll', function(event) {
        var yDistance = 200;
        var y = $(this).scrollTop();
        if (y > yDistance) {
            $('header').addClass('shrink');
            $('footer').show();
        } else {
            $('header').removeClass('shrink');
            $('footer').hide();
        }
    })
}
