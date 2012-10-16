$(document).ready ->

    toPixels = (location) ->
        mapType = map.mapTypes[map.getMapTypeId()]
        mapPixel = mapType.projection.fromLatLngToPoint(location)
        containerPixel = overlay.getProjection().fromLatLngToContainerPixel(location)
        divPixel = overlay.getProjection().fromLatLngToDivPixel(location)

    triggerSubmit = ->
        $("#submit").trigger "click"

    val = 0
    markersArray = []
    markerOpened = false
    pos = null
    marker = null
    infowindow = new google.maps.InfoWindow()

    $("#submit").bind "click", (e) ->
        e.preventDefault()
        code = $("#code").val()
        trainLocator.findTrain code  if code.length > 0

    $("#add-train").bind "click", (e) ->
        e.preventDefault()

        trainList.addTrain $('#selected-train').val(), $('#code').val()
