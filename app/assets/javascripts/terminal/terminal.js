$(function () {

  Blink($('#cursor'));

  $('#terminalInput').focus();
  $('.timestamp').html(timestamp());

  $('#terminalInput').on('keyup', function (e) {
    KeyBindings(e.keyCode, $(this));
  });

  $(document).on('click', function () {
    $('#terminalInput').focus();
  })

});
