$(function () {

  var blinkOff = function (cursor) {
    cursor.removeClass('blink');
    cursor.children().first().removeClass('invisible').addClass('visible');
    setTimeout(function () { blinkOn(cursor); }, 500);
  }

  var blinkOn = function (cursor) {
    cursor.addClass('blink');
    cursor.children().first().removeClass('visible').addClass('invisible');
    setTimeout(function () { blinkOff(cursor); }, 500);
  }

  var cursor = $('#cursor');
  blinkOn(cursor);

  var timestamp = function () {
    return '[' + new Date().toLocaleTimeString() + ']';
  }

  $('#terminalInput').focus();
  $('.timestamp').html(timestamp());

  lineBreak = function (textField) {
    old_line = $('.line').last();
    line_num = old_line.data('line');
    new_line = old_line.clone();
    new_line.attr('data-line', line_num += 1);
    text = new_line.find('.textOutput');
    new_line.find('.timestamp').html(timestamp());
    text.html('');
    $('.miniterm').append(new_line)
    new_cursor = old_line.find('#cursor').clone();
    $('.cursor').map(function () { $(this).remove(); });
    new_cursor.insertAfter(text);
    blinkOn(new_cursor);
    textField.value = '';
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

  var listDirectory = function () {

  }

  KeyBindings = {
    13: lineBreak,
    32: space,
  }

  // Can we somehow get the --comands in?
  Commands = {
    'cd': changeDirectory,
    'ls': listDirectory,
    // 'sudo': superDo,
    // 'cat': cat,
    // 'rm': remove,
    // 'mkdir': makeDirectory,
    // 'rmdir': removeDirectory,
  }

  TerminalCommandsController = {
    'cd': function (directory) {
      $.post('/directories', {
        data: { directory: directory }
      }).done(function (response) {

      });
    },
    'ls': function (directory) {
      $.get('/directories', {
        data: { directory: directory }
      }).done(function (response) {

      });
    },
    'rm': function (directory) {
      $.ajax({
        type: 'DELETE',
        url: '/directories'
      }).done(function (response) {

      });
    },
    'mkdir': function (directory) {
      $.post('/directories', {
        data: {
          task: 'mkdir',
          directory: directory
        }
      }).done(function (response) {

      });
    }
  }

  $('#terminalInput').on('keyup', function (e) {
    callback = KeyBindings[e.keyCode];
    if (callback) { callback(this); } else { $('.textOutput').last().html(this.value); }
  });

  $(document).on('click', function () {
    $('#terminalInput').focus();
  })

});
