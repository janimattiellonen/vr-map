class TrainInfo
    constructor: (@element) ->


    updateInfo: (info) ->
        alert
        $("#train-id-col", @element).html info.title
        $("#train-speed-col", @element).html info.speed
        $("#train-lateness-col", @element).html info.lateness
        $("#train-from-col", @element).html info.startStation
        $("#train-to-col", @element).html info.endStation

        return null