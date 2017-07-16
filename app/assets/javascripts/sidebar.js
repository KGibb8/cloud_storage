$(function () {
  $('.button-collapse#left').sideNav({
    edge: 'left'
  });

  $('.button-collapse#right').sideNav({
    edge: 'right'
  });

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
