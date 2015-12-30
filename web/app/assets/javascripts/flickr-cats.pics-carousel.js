var get_flickr_pics = function() {
  // for flickr
  var textArray = ['ねこ','猫','kitty','ネコ','neko','cat'];
  var sortArray = ['date-posted-desc','date-taken-desc','interestingness-desc','interestingness-asc'];
  var flickrUrl = 'https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=4480c9059211841b6a5101941b2724df&extras=owner_name%2Curl_s%2Ctags&format=json&nojsoncallback=0';
  var text = textArray[0];
  flickrUrl += '&text=' + encodeURIComponent(text);
  var sort = sortArray[0];
  flickrUrl += '&sort=' + encodeURIComponent(sort);
  var deferred = $.ajax({
    url     : flickrUrl,
    type    : 'GET',
    dataType: 'jsonp',
    jsonpCallback: 'jsonFlickrApi',
  });
  return deferred.promise();
};

var set_flickr_pics = function() {
  get_flickr_pics()
    .then(function(pics) {
      $.each(pics.photos.photo, function(index, pic) {
        console.log(pic);
        var item = String();
        //var imageUrl = pic.Item.mediumImageUrls[0].imageUrl.replace(/128x128/g, '512x512');
        item += "<div class='item'>";
        item += "<a href='" + pic.url_s + "' data-lightbox-gallery='gallery1' target='_blank'>" + "<img src='" + pic.url_s + "' class='img-responsive' alt='img'></a></div>"
        $('#flickr-owl-works').append(item);
      });
    })
    .then(function() {
      $('#flickr-owl-works').owlCarousel({
        items : 4,
        itemsDesktop : [1199,5],
        itemsDesktopSmall : [980,5],
        itemsTablet: [768,5],
        itemsTabletSmall: [550,2],
        itemsMobile : [480,2],
      });
    });
};
