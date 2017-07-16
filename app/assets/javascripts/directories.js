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

  $('.directory-link').on('dblclick', function (e) {
  });
});

