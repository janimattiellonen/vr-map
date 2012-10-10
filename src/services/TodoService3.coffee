TodoService3 = (->
    TodoService3 = (db) ->
        @db = db
    TodoService3::lus = ->
        console.log "HAhaa"

    TodoService3::getAll = (callback) ->
        @db.collection "todos", (err, collection) ->
            result = collection.find().sort(
                order: 1
                priority: 1
            ).toArray((err, items) ->
                i = 0
                while i < items.length
                    items[i].id = items[i]._id
                    i++
                callback null, items
            )


    TodoService3::save = (data, callback) ->
        unless @validate(data)
            callback err: "No title provided"
        else
            @db.collection "todos", (err, collection) ->
                collection.insert
                    title: data.title
                ,
                    safe: true
                , (err, result) ->
                    result[0].id = result[0]._id
                    callback err, result[0]



    TodoService3::update = (data, callback) ->
        self = this
        unless @validate(data)
            callback err: "No title provided"
        else
            @db.collection "todos", (err, collection) ->
                collection.update
                    _id: self.oid(data.id)
                ,
                    $set:
                        title: data.title
                ,
                    safe: true
                , (err, result) ->
                    callback err, result[0]



    TodoService3::remove = (id, callback) ->
        self = this
        @db.collection "todos", (err, collection) ->
            collection.remove _id: self.oid(id)
            callback null


    TodoService3::updateOrder = (order, callback) ->
        orders = order.split(",")
        self = this
        order = 1
        i = 0
        @db.collection "todos", (err, collection) ->
            i = 0
            while i < orders.length
                collection.update
                    _id: self.oid(orders[i])
                ,
                    $set:
                        order: order++

                i++
            callback err, null


    TodoService3::validate = (data) ->
        valid = (value) ->
            value isnt "undefined" and value.length > 0

        valid data.title

    TodoService3::changePriority = (id, priority, callback) ->
        self = this
        @db.collection "todos", (err, collection) ->
            collection.update
                _id: self.oid(id)
            ,
                $set:
                    priority: priority

            callback err, null


    TodoService3::oid = (id) ->

        # butt-ugly
        mongo = require("mongodb")
        BSON = mongo.BSONPure
        new BSON.ObjectID(id)

    TodoService3
)()

exports.TodoService3 = TodoService3