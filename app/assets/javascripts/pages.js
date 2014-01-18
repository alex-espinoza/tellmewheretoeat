function getGeoLocation() {
  navigator.geolocation.getCurrentPosition(function(position) {
    var user_latitude = position.coords.latitude;
    var user_longitude = position.coords.longitude;

    $.ajax({
      type: 'POST',
      url: '/location',
      data: { location: { latitude: user_latitude, longitude: user_longitude } },
      success: function(){
        location.href = "/result";
      }
    });
  });
}

function randomLoadingText() {
  var text = ['Hold up...', 'Sit tight...', 'One sec...', 'Looking around...', 'Searching...', 'Finding restaurant...',
               'Hmm...', "Let's see...", 'How about...', 'Hold on...', "I'll find you something nice...", 'I got this...'];
  var randomText = text[Math.floor(Math.random() * text.length)];
  return randomText;
}
