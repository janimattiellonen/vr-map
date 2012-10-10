class Foo
    constructor: (@name) ->


    bar: ->
        console.log @name

exports.Foo = Foo