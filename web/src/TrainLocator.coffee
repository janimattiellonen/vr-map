class TrainLocator
    constructor: (@element, @trainInfo, @client) ->

    findTrain: (trainCode) =>
        @client.findTrain trainCode, @processResult

    processResult: (data) =>

        if data.status == true

            @clearErrorMessage()

            data = data.data

            pos = new google.maps.LatLng(data.point[0], data.point[1])

            @setSelectedTrainId data.trainguid
            @setAddTrainButtonState true
            @trainInfo.updateInfo data
        else
            @setErrorMessage "Bad data"
            @trainInfo.clearInfo()

    setSelectedTrainId: (trainId) ->
        $("#selected-train", @element).attr "value", trainId

    setAddTrainButtonState: (state) ->
        if state
            $("#add-train", @element).removeAttr "disabled"
        else
            $("#add-train", @element).attr "attr", "disabled"

    setErrorMessage: (message) ->
        $('div.status-box', @element).html message
        $('div.status-box', @element).removeClass 'hidden'

    clearErrorMessage: ->
        $('div.status-box', @element).html ""
        $('div.status-box', @element).addClass 'hidden'

