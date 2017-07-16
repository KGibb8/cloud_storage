var TerminalCommands = {

  'cd': function (directory) {
    var dir = $('.directory[data-name="' + directory + '"]')
    if (dir.length > 0) {
      dir.parent().click();
    } else if (/^(\.)\1+$/.test(directory)) {
      $('#currentDirectory').siblings('a.parent-link').click();
    } else {
      return function () {
        return 'cd: no such file or directory: ' + directory;
      }
    }
  },

  'ls': function (directory) {
    var directories = document.getElementsByClassName('directory');
    list = Array.prototype.map.call(directories, function (element) {
      return $(element).find('p').text();
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
