var set_search_pics = function() {
  $(".fav_cat").infinitescroll({
    loading: {
      img: '/images/loading.gif',
      msgText: '',
      finishedMsg: "end",
    },
    dataType: 'js',
    maxPage: 20,
    navSelector: "nav.pagination",
    nextSelector: "nav.pagination a[rel=next]",
    itemSelector: "div.fav",
  })
}
