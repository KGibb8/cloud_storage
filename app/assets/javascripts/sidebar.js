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

  $.fn.Terminal = function () {
    var $terminal= $(this);

    var actions = {
      'show': function () {
        $terminal.addClass('close');
      },
      'hide': function () {
        $terminal.removeClass('close');
      }
    }

    if ($terminal.hasClass('close')) {
      actions['hide']();
    } else {
      actions['show']();
    }
  }

  $('.terminal-trigger').on('click', function(e) {
    $('.terminal-nav').Terminal();
  });

});
