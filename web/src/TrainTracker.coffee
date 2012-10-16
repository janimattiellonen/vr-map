class TrainTracker
    constructor: (@client, window) ->
        @isTracking     = false
        @markerArray    = []
        @intervalId     = null
        @window         = window
        @listeners      = []

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
        data = data.data

        pos = new google.maps.LatLng(data.point[0], data.point[1])

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

        for listener in @listeners
            listener data

        #@trainInfo.updateInfo data

    setMap: (map) ->
        @map = map

    # Add a callback that will be called when new train information is available
    addListener: (listenerCallback) ->
        @listeners.push listenerCallback
