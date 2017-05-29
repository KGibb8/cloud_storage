$(function () {
  $(".button-collapse").sideNav();
  $('.collapsible').collapsible();

  $('body').on('swiperight', function () {
    $('.button-collapse').sideNav('show');
  });

  $('.side-nav').on('swipeleft', function () {
    $('.button-collapse').sideNav('hide');
  });

  $('button.hamburger').on('click', function () {
    $('.button-collapse').sideNav('show');
  });

  $('#sidebar-close').on('click', function () {
    $('.button-collapse').sideNav('hide');
  });
});
