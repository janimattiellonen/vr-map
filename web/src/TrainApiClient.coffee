class TrainApiClient
    constructor: (@url) ->

    findTrain: (trainCode, successCallback) ->
        $.ajax
            url: @url
            dataType: "json"
            type: "POST"
            data: "code=" + trainCode
            success: successCallback