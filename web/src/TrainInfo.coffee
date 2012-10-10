class TrainInfo
    constructor: (@element) ->


    updateInfo: (info) ->

        $("#train-id-col", @element).html info.title
        $("#train-speed-col", @element).html info.speed
        $("#train-lateness-col", @element).html info.lateness
        $("#train-from-col", @element).html info.startStation
        $("#train-to-col", @element).html info.endStation

        return null

    clearInfo: ->
        data = {
            title: '',
            speed: '',
            lateness: '',
            startStation: '',
            endStation: ''
        }

        @updateInfo data