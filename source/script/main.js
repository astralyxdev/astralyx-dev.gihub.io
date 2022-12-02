
// burger menu //--//

$(".open-mob-menu").click(function(e) {
    $(this).toggleClass('active');
    $("header").toggleClass('active-mob-menu');
    $(".header-container .bottom-navigation-header").toggleClass('active');
})

$('a').click(function(){
    $(".open-mob-menu").removeClass('active');
    $("header").removeClass('active-mob-menu');
    $(".header-container .bottom-navigation-header").removeClass('active');
})


// scale header scroll //--//

$(window).on("scroll", function() {
    $("header").toggleClass("scroll", $(this).scrollTop() > $(window).height());
    $(".progress-bar-doc").toggleClass("scroll", $(this).scrollTop() > $(window).height());
});


