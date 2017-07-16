var KeyBindings = function (keyCode, textField) {

  var inputField = $('#terminalInput');
  var activeOutput =  $('.active span.textOutput');

  var LineBreak = function () {

    // Next step, improve this, make extensible for more commands and recuse correctly
    // Should we be using vanilla instead of jquery?
    var parseEntry = function () {
      var commands = $('.active span.textOutput').text().split(' ');
      if (commands[0] != '') {
        var command = commands[0];
        var operator = commands[1];
        var operand = commands[2];
        output = TerminalCommands[command];
        termOutput = $('.line.active span.termOutput');
        try{
          termOutput.html(output(operator));
        }
        catch(e) {
          termOutput.html('blockades: command not found: ' + commands[0]);
        }
        termOutput.css('display', 'block');
      }
    }

    var validateCommands = function (commands) {
    }

    var newLine = function () {
      var $currentLine = $('.line.active');
      var lineNumber = parseInt($currentLine.data('line'))
      var $nextLine = $currentLine.clone().attr('data-line', lineNumber += 1);
      $nextLine.find('span.termOutput').css('display', 'none');
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

    parseEntry();
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

