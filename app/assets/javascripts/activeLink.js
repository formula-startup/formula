$(window).bind("turbolinks:load", function(){
  $(".link").each(function(){
    var link = $(this).attr("href")
    if(document.URL.match(link)){
        $(this).addClass('active')
      return false;
    };
  });
});
