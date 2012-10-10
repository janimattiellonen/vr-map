
$(document).ready(function() {
  var infowindow, marker, markerOpened, markersArray, pos, toPixels, triggerSubmit, val;
  toPixels = function(location) {
    var containerPixel, divPixel, mapPixel, mapType;
    mapType = map.mapTypes[map.getMapTypeId()];
    mapPixel = mapType.projection.fromLatLngToPoint(location);
    containerPixel = overlay.getProjection().fromLatLngToContainerPixel(location);
    return divPixel = overlay.getProjection().fromLatLngToDivPixel(location);
  };
  triggerSubmit = function() {
    return $("#submit").trigger("click");
  };
  val = 0;
  markersArray = [];
  markerOpened = false;
  pos = null;
  marker = null;
  infowindow = new google.maps.InfoWindow();
  $("#submit").bind("click", function(e) {
    var code;
    e.preventDefault();
    code = $("#code").val();
    if (code.length > 0) return trainLocator.findTrain(code);
  });
  return $("#add-train").bind("click", function(e) {
    e.preventDefault();
    return trainList.addTrain($('#selected-train').val(), $('#code').val());
  });
});
