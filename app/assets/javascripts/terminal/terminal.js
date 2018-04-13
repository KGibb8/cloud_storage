$(function () {

  Blink($('#cursor'));

  $('.timestamp').html(timestamp());

  $('#terminalInput').on('keyup', function (e) {
    KeyBindings(e.keyCode, $(this));
  });

  $('.terminal-nav').on('click', function () {
    $('#terminalInput').focus();
  })

});
