var TerminalCommands = {

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
