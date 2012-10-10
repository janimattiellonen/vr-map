var TodoService;

TodoService = (function() {
  TodoService = function(db) {
    return this.db = db;
  };
  TodoService.prototype.lus = function() {
    return console.log("HAhaa");
  };
  TodoService.prototype.getAll = function(callback) {
    return this.db.collection("todos", function(err, collection) {
      var result;
      return result = collection.find().sort({
        order: 1,
        priority: 1
      }).toArray(function(err, items) {
        var i;
        i = 0;
        while (i < items.length) {
          items[i].id = items[i]._id;
          i++;
        }
        return callback(null, items);
      });
    });
  };
  TodoService.prototype.save = function(data, callback) {
    if (!this.validate(data)) {
      return callback({
        err: "No title provided"
      });
    } else {
      return this.db.collection("todos", function(err, collection) {
        return collection.insert({
          title: data.title
        }, {
          safe: true
        }, function(err, result) {
          result[0].id = result[0]._id;
          return callback(err, result[0]);
        });
      });
    }
  };
  TodoService.prototype.update = function(data, callback) {
    var self;
    self = this;
    if (!this.validate(data)) {
      return callback({
        err: "No title provided"
      });
    } else {
      return this.db.collection("todos", function(err, collection) {
        return collection.update({
          _id: self.oid(data.id)
        }, {
          $set: {
            title: data.title
          }
        }, {
          safe: true
        }, function(err, result) {
          return callback(err, result[0]);
        });
      });
    }
  };
  TodoService.prototype.remove = function(id, callback) {
    var self;
    self = this;
    return this.db.collection("todos", function(err, collection) {
      collection.remove({
        _id: self.oid(id)
      });
      return callback(null);
    });
  };
  TodoService.prototype.updateOrder = function(order, callback) {
    var i, orders, self;
    orders = order.split(",");
    self = this;
    order = 1;
    i = 0;
    return this.db.collection("todos", function(err, collection) {
      i = 0;
      while (i < orders.length) {
        collection.update({
          _id: self.oid(orders[i])
        }, {
          $set: {
            order: order++
          }
        });
        i++;
      }
      return callback(err, null);
    });
  };
  TodoService.prototype.validate = function(data) {
    var valid;
    valid = function(value) {
      return value !== "undefined" && value.length > 0;
    };
    return valid(data.title);
  };
  TodoService.prototype.changePriority = function(id, priority, callback) {
    var self;
    self = this;
    return this.db.collection("todos", function(err, collection) {
      collection.update({
        _id: self.oid(id)
      }, {
        $set: {
          priority: priority
        }
      });
      return callback(err, null);
    });
  };
  TodoService.prototype.oid = function(id) {
    var BSON, mongo;
    mongo = require("mongodb");
    BSON = mongo.BSONPure;
    return new BSON.ObjectID(id);
  };
  return TodoService;
})();

exports.TodoService = TodoService;