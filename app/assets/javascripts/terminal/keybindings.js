var KeyBindings = function (keyCode, textField) {

  var $inputField = $('#terminalInput');
  var $activeOutput =  $('.active span.textOutput');

  var LineBreak = function () {

    var timestampSpan = function () {
      return "<span class=\"timestamp\" id=\"timestamp\">" + timestamp() + " </span>";
    }

    var accountSpan = function () {
      return "<span id=\"account\">" + $('.terminal').data('account') + ":</span>";
    }

    var userSpan = function () {
      return "<span id=\"user\">" + $('.terminal').data('user') + "</span>";
    }

    var directorySpan = function () {
      return "<span id=\"directory\">" + "</span>";
    }

    var dollarSpan = function () {
      return "<span class=\"dollar\">$ </span>";
    }

    var cursor = function () {
      return "<div class=\"cursor active\" id=\"cursor\"><span class=\"visible\">_</span></div>";
    }

    var textOutputSpan = function () {
      return "<span class=\"textOutput\"></span>";
    }

    var termOutputSpan = function () {
      return "<span class=\"termOutput\" style=\"display: none;\"></span>";
    }

    var rawNewLine = function () {
      return "<div class=\"line active\">" + timestampSpan() + accountSpan() + userSpan() +
        directorySpan() + dollarSpan() + textOutputSpan() + termOutputSpan() + cursor() + "</div>";
    }

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
      var $nextLine = $(rawNewLine());
      var $currentLine = $('.line.active');
      if ($currentLine) {
        var lineNumber = parseInt($currentLine.data('line'))
        $nextLine.attr('data-line', lineNumber += 1);
        $currentLine.removeClass('active');
        $currentLine.find('.cursor').removeClass('active');
      }
      $('.miniterm').append($nextLine);
      return $nextLine;
    }

    var newCursor = function (line) {
      $('.cursor').not('.active').map(function () { $(this).remove(); });
      $newCursor = $('.cursor.active');
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
    $inputField.val('');
  }

  var space = function () {
    $activeOutput.append('&nbsp;');
  }

  var appendText = function () {
    $activeOutput.html(textField.val());
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

