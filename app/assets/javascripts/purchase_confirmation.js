$(document).on('turbolinks:load', function(){
  $('.main-container__purchase-details__item__inner__purchase-details__use-points__top__title').click(function(){
    $('.fa-chevron-down').toggle();
    $('.fa-chevron-up').toggle();
    $('.main-container__purchase-details__item__inner__purchase-details__use-points__top__list').animate({ height: 'toggle' }, 'slow');
  });
})