function printLocation(position) {
  $(".latitude").append(position.coords.latitude)
  $(".longitude").append(position.coords.longitude)
}

function getGeoLocation() {
  navigator.geolocation.getCurrentPosition(function(position) {
    var user_latitude = position.coords.latitude;
    var user_longitude = position.coords.longitude;

    $.ajax({
      type: 'POST',
      url: '/pages/post_random',
      data: { location: { latitude: user_latitude, longitude: user_longitude } },
      success: function(){
        location.href = "/pages/get_random";
      }
    });
  });
}
