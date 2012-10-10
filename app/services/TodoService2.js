TodoService = (function() {
    function TodoService(db) {
        this.db = db;
    }

    TodoService.prototype.lus = function() {
        console.log("HAhaa");
    };

    TodoService.prototype.getAll = function(callback) {

        this.db.collection('todos', function(err, collection) {
            var result = collection.find().sort({"order": 1, "priority": 1}).toArray(function(err, items) {

                for(i = 0; i < items.length; i++) {
                    items[i].id = items[i]._id;
                }

                callback(null, items);
            });
        });
    };

    TodoService.prototype.save = function(data, callback) {

        if(!this.validate(data) ) {
            callback({'err': 'No title provided'});
        }
        else {
            this.db.collection('todos', function(err, collection) {
                collection.insert({
                        'title': data.title
                    },
                    {safe: true},
                    function(err, result) {
                        result[0].id = result[0]._id;
                        callback(err, result[0]);
                    });
            });
        }
    };

    TodoService.prototype.update = function(data, callback) {
        var self = this;

        if(!this.validate(data) ) {
            callback({'err': 'No title provided'});
        }
        else {
            this.db.collection('todos', function(err, collection) {
                collection.update({
                        _id: self.oid(data.id)
                    },
                    {
                        $set:{title: data.title}
                    },
                    {safe: true},
                    function(err, result) {
                        callback(err, result[0]);
                    });
            });
        }
    };

    TodoService.prototype.remove = function(id, callback) {
        var self = this;
        this.db.collection('todos', function(err, collection) {
            collection.remove({_id: self.oid(id)});
            callback(null);
        });
    };

    TodoService.prototype.updateOrder = function(order, callback) {
        var orders = order.split(',');
        var self = this;
        var order = 1;
        var i = 0;

        this.db.collection('todos', function(err, collection) {
            for(i = 0; i < orders.length; i++) {
                collection.update({
                        _id: self.oid(orders[i])
                    },
                    {
                        $set: {'order': order++}
                    });
            }
            callback(err, null);
        });
    }

    TodoService.prototype.validate = function(data) {

        valid = function(value) {
            return value != "undefined" && value.length > 0;
        };

        return valid(data.title);
    };

    TodoService.prototype.changePriority = function(id, priority, callback) {
        var self = this;

        this.db.collection("todos", function(err, collection) {
            collection.update({
                    _id: self.oid(id)
                },
                {
                    $set: {'priority': priority}
                });

            callback(err, null);
        });
    };

    TodoService.prototype.oid = function(id) {
        // butt-ugly
        var mongo = require('mongodb');
        var BSON = mongo.BSONPure;
        return new BSON.ObjectID(id);
    }

    return TodoService;
})();

exports.TodoService = TodoService;