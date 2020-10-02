$(document).on('turbolinks:load', function(){
  if(document.URL.match("/users/logout")) {
  } else if(document.URL.match("/users/") && !$(".box__lower__right__list__heart").length) {
    $('ul.box__lower__right__list').prepend(
      '<li class="box__lower__right__list__heart">' +
        '<a href="">' +
          '<i class="far fa-heart"></i>' +
          'いいね！一覧' +
        '</a>' +
      '</li>'
    );
  }
})