(function ($) {

  new WOW().init();

  $(window).load(function(){
    $("#navigation").sticky({ topSpacing: 0 });
    set_search_pics();
    set_ranking_pics();
    //set_instagram_pics();
    //set_rakuten_pics();
    //set_flickr_pics();
  });

  jQuery(window).load(function() {
    jQuery("#preloader").delay(100).fadeOut("slow");
    jQuery("#load").delay(100).fadeOut("slow");
  });

  //jQuery for page scrolling feature - requires jQuery Easing plugin
  $(function() {
    $('.navbar-nav li a').bind('click', function(event) {
      var $anchor = $(this);
      $('html, body').stop().animate({
        scrollTop: $($anchor.attr('href')).offset().top
      }, 1500, 'easeInOutExpo');
      event.preventDefault();
    });
    $('.page-scroll a').bind('click', function(event) {
      var $anchor = $(this);
      $('html, body').stop().animate({
        scrollTop: $($anchor.attr('href')).offset().top
      }, 1500, 'easeInOutExpo');
      event.preventDefault();
    });
  });

  //owl carousel
  //$('#owl-works').owlCarousel({
  //  items : 4,
  //  itemsDesktop : [1199,5],
  //  itemsDesktopSmall : [980,5],
  //  itemsTablet: [768,5],
  //  itemsTabletSmall: [550,2],
  //  itemsMobile : [480,2],
  //});

  //nivo lightbox
  $('.owl-carousel .item a').nivoLightbox({
    effect: 'fadeScale',// The effect to use when showing the lightbox
    theme: 'default',// The lightbox theme to use
    keyboardNav: true,// Enable/Disable keyboard navigation (left/right/escape)
    clickOverlayToClose: true,// If false clicking the "close" button will be the only way to close the lightbox
    onInit: function(){},// Callback when lightbox has loaded
    beforeShowLightbox: function(){},// Callback before the lightbox is shown
    afterShowLightbox: function(lightbox){},// Callback after the lightbox is shown
    beforeHideLightbox: function(){},// Callback before the lightbox is hidden
    afterHideLightbox: function(){},// Callback after the lightbox is hidden
    onPrev: function(element){},// Callback when the lightbox gallery goes to previous item
    onNext: function(element){},// Callback when the lightbox gallery goes to next item
    errorMessage: 'The requested content cannot be loaded. Please try again later.' // Error message when content can't be loaded
  });

  //parallax
  if ($('.parallax').length) {
    $(window).stellar({
      responsive:true,
      scrollProperty: 'scroll',
      parallaxElements: false,
      horizontalScrolling: false,
      horizontalOffset: 0,
      verticalOffset: 0
    });
  }

})(jQuery);

var shuffle_array = function(array) {
  var n = array.length, t, i;
  while(n) {
    i = Math.floor(Math.random() * n--);
    t = array[n];
    array[n] = array[i];
    array[i] = t;
  }
  return array;
};
