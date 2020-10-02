$(document).on('turbolinks:load', function(){
  $('.main__announcement__pictures').slick({
    autoplay:true,
    infinite:true,
    dots:true,
    arrows:true,
    autoplaySpeed:5000,
  });
})