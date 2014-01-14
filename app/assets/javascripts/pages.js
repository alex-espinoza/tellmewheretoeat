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
