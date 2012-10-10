class TrainLocator
    constructor: (@element, @trainInfo, @client) ->

    findTrain: (trainCode) =>
        @client.findTrain trainCode, @processResult

    processResult: (data) =>
        lat = data.point[0]
        long = data.point[1]
        title = data.title
        pos = new google.maps.LatLng(lat, long)

        @setSelectedTrainId data.trainguid
        @setAddTrainButtonState true
        @trainInfo.updateInfo data

    setSelectedTrainId: (trainId) ->
        $("#selected-train", @element).attr "value", trainId

    setAddTrainButtonState: (state) ->
        if state
            $("#add-train", @element).removeAttr "disabled"
        else
            $("#add-train", @element).attr "attr", "disabled"