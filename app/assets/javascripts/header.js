function shrinkMenu() {
    window.addEventListener('scroll', function(event) {
        // var yDistance = window.pageYOffset || document.documentElement.scrollTop;
        var yDistance = 200;
        var y = $(this).scrollTop();
        console.log(y);
        if (y > yDistance) {
            $('header').addClass('shrink');
        } else {
            $('header').removeClass('shrink');
        }
    })
}
