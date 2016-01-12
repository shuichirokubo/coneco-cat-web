$(function() {
  $("button").click(function() {
    var that = this;
    var cat_id = $(this).val();
    var favorite_url = "/api/v1/favorites";
    $.ajax({
      url: favorite_url,
      type: 'POST',
      dataType: 'jsonp',
      data: {cat_id: cat_id},
      timeout: 10000,
      success: function() {
        $(that).prop('disabled', true);
        $(that).html("ふぁぼった");
        $(that).toggleClass("btn-favorite");
      },
      error: function() {
      }
    });
  });
});
