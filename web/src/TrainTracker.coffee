class TrainTracker
    constructor: (@client, window) ->
        @isTracking = false
        @markerArray = []
        @intervalId = null
        @window = window

    trackTrain: (trainCode) =>
        @_trackTrain trainCode

    cancelTracking: =>
        if @isTrackingTrain()
            @window.clearInterval @intervalId
            @isTracking = false
            @intervalId = null

    isTrackingTrain: =>
        return @intervalId != null and @isTracking == true

    _trackTrain: (trainCode) ->
        client = @client
        processResult = @processResult

        client.findTrain trainCode, processResult

        @isTracking = true

        @intervalId = setInterval (->
            client.findTrain trainCode, processResult
        ), 3000

    processResult: (data) =>
        lat = data.point[0]
        long = data.point[1]
        title = data.title
        pos = new google.maps.LatLng(lat, long)

        marker = new google.maps.Marker(
            map: @map
            position: pos
        )

        i = 0

        while i < @markerArray.length
            @markerArray[i].setMap null
            i++

        map.setCenter pos

        @markerArray.push marker

        infowindow = new google.maps.InfoWindow()
        infowindow.setContent title

    setMap: (map) ->
        @map = map

