$(function () {

  Blink($('#cursor'));

  var timestamp = function () {
    return '[' + new Date().toLocaleTimeString() + ']';
  }

  $('#terminalInput').focus();
  $('.timestamp').html(timestamp());

  var lineBreak = function (textField) {
    $newLine = newLine();
    newCursor($newLine);
    clearInput();
  }

  var newLine = function () {
    var $currentLine = $('.line.active');
    var lineNumber = parseInt($currentLine.data('line'))
    var $nextLine = $currentLine.clone().attr('data-line', lineNumber += 1);
    $nextLine.find('.timestamp').html(timestamp());
    $('.miniterm').append($nextLine);
    $currentLine.removeClass('active');
    return $nextLine;
  }

  var newCursor = function (line) {
    var $newCursor = $('#cursor').clone();
    $('.cursor').map(function () { $(this).remove(); });
    $newCursor.insertAfter(line.find('.textOutput'));
    Blink($newCursor);
    return $newCursor;
  }

  var clearInput = function () {
    $('.active span.textOutput').empty();
    $('#terminalInput')[0].value = '';
  }

  var space = function () {
    $('.textOutput').last().append('&nbsp;');
  }

  var changeDirectory = function () {
    $.post('/directories', {
      // do some ajaxy stuff
    }).done(function () {

    });
  }

  KeyBindings = {
    13: lineBreak,
    32: space,
  }

  $('#terminalInput').on('keyup', function (e) {
    callback = KeyBindings[e.keyCode];
    if (callback) { callback(this); } else { $('.textOutput').last().html(this.value); }
  });

  $(document).on('click', function () {
    $('#terminalInput').focus();
  })

});
