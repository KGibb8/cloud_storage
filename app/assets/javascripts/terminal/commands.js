var TerminalCommands = {

  'cd': function (directory) {
    var dir = $('.directory[data-name="' + directory + '"]')
    if (dir) {
      $.get('/directories/' + dir.data('id')).done(function (response) {
        // Here we want to start think about rendering partials! Can we submit a remote:true form instead so we can render a partial?
      });
    } else {
      return function () {
        return directory + ' not found';
      }
    }
  },

  'ls': function (directory) {
    var directories = document.getElementsByClassName('directory');
    list = Array.prototype.map.call(directories, function (element) {
      return $(element).find('a').text();
    }).join(' ');
    return list;
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
