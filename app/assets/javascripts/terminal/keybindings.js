var KeyBindings = function (keyCode, textField) {

  var LineBreak = function () {

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

    $newLine = newLine();
    newCursor($newLine);
    clearInput();
    return $newLine;
  }

  var clearInput = function () {
    $('.active span.textOutput').empty();
    $('#terminalInput')[0].value = '';
  }

  var space = function () {
    $('.textOutput').last().append('&nbsp;');
  }

  var appendText = function () {
    $('.textOutput').last().html(textField.val());
  }

  var bindings = {
    13: LineBreak,
    32: space,
  }

  var callback = bindings[keyCode];

  if (callback) {
    callback();
  } else {
    appendText();
  }
}

