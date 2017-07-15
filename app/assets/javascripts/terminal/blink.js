var Blink = function (cursor) {

  var blinkOff = function () {
    cursor.removeClass('blink');
    cursor.children().first().removeClass('invisible').addClass('visible');
    setTimeout(function () { blinkOn(cursor); }, 500);
  }

  var blinkOn = function () {
    cursor.addClass('blink');
    cursor.children().first().removeClass('visible').addClass('invisible');
    setTimeout(function () { blinkOff(cursor); }, 500);
  }

  blinkOn();
  return cursor;
};

