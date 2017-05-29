$(function () {

  function deselectFolder(folder) {
    $(folder).removeClass('bg-greygreen')
      $(folder).removeClass('border-light');
  }

  function selectFolder(folder) {
    $(folder).addClass('bg-greygreen');
    $(folder).addClass('border-light');
  }

  $('.folder').on('click', function () {
    $('.folder').map(function (){
      deselectFolder(this);
    });
    if ($(this).hasClass('bg-greygreen')) {
      deselectFolder(this);
    } else {
      selectFolder(this);
    }
  });

  $('.folder').on('click', function (e) {
    var id = this.id.match(/\d+/)[0];
    $.get('/directories/' + id).done(function (response) {
      console.log(response);
    });
  });
});

