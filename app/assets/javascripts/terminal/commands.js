var TerminalCommands = {

  'cd': function (directory) {
    var dir = $('.directory[data-name="' + directory + '"]')
    if (dir.length > 0) {
      dir.parent().click();
      return "";
    } else if (/^(\.)\1+$/.test(directory)) {
      $('#currentDirectory').siblings('a.parent-link').click();
      return "";
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
    var directory = $('.directory[data-name="' + directory + '"]');
    var id = directory.data('id');
    $.ajax({
      type: 'DELETE',
      url: '/directories/' + id
    }).done(function (response) {
      directory.fadeOut();
      setTimeout(function () { directory.remove(); }, 500);
    });
  },

  'mkdir': function (directory) {

    return 'new feature to come';
  },

  'clear': function () {
    $('.line').remove();
    newLine();
    return "";
  }

}
