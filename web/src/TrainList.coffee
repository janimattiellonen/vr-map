class TrainList
    constructor: (@element, @trackTrainCallback, @cancelTrackingCallback) ->

    addTrain: (trainCode, train) ->

        $ul = @getListElement()

        $item = $ul.find 'li[data-id="' + trainCode + '"]'

        self = this

        if $item.length == 0
            $li = $('<li></li>').html train
            $li.attr 'data-id', trainCode

            $li.bind 'click', (e) =>

                $target = $(e.target)

                @cancelTrackingCallback()


                if $li.hasClass "active"
                    $li.removeClass "active"
                else
                    $('li.active', @element).removeClass "active"

                    $li.addClass "active"
                    @trackTrainCallback $target.attr 'data-id'

            $ul.append $li

    list: (trains) ->

        for train in trains
            $li = $('<li></li>').html train

            $('ul', @element).append $li

    getListElement: ->
        return $('ul', @element)