var Db, Foo, Server, TrainDataParser, app, db, express, http, libxmljs, mongo, parser, pub, result, server, sys, xml;

express = require('express');

TrainDataParser = require("./components/TrainDataParser").TrainDataParser;

Foo = require("./services/Foo").Foo;

pub = __dirname + '/web';

mongo = require('mongodb');

Server = mongo.Server;

Db = mongo.Db;

sys = require('sys');

http = require('http');

libxmljs = require("libxmljs");

xml = '<rss version="2.0"><channel xmlns:georss="http://www.georss.org/georss"><title>S 60</title><description>Train information feed for train S 60</description><lastBuildDate>Tue, 02 Oct 2012 00:13:28 +0300</lastBuildDate><category>1</category><trainguid>S60</trainguid><georss:point>0 0</georss:point><speed>0</speed><heading/><startStation>ROI</startStation><endStation>HKI</endStation><status>1</status><reasonCode/><lateness>0</lateness><item><guid isPermaLink="false">ROI</guid><title>ROI</title><description>Summary</description><pubDate>Tue, 02 Oct 2012 00:13:28 +0300</pubDate><scheduledTime/><scheduledDepartTime>15:10</scheduledDepartTime><eta/><etd>15:10</etd><stationCode>ROI</stationCode><completed>0</completed><status>1</status><georss:point>0 0</georss:point></item></channel></rss>';

parser = new TrainDataParser(libxmljs);

result = parser.parse(xml);

server = new Server('localhost', 27017, {
  auto_reconnect: true
});

db = new Db('vr-map_db', server);

db.open(function(err, db) {
  if (!err) {
    console.log("Connected to MongoDb");
    return db.collection("todos", function(err, collection) {});
  }
});

app = express();

app.listen(3001);

console.log('Express app started on port 3001');

app.configure(function() {
  app.use(express.methodOverride());
  app.use(express.bodyParser());
  app.use(express.static(process.cwd() + '/web'));
  app.use(express.errorHandler({
    dumpExceptions: true,
    showStack: true
  }));
  return app.use(app.router);
});

app.set("view engine", "jade");

app.set("view options", {
  layout: false
});

app.get("/", function(req, res) {
  return res.render("index");
});

app.post("/find-train", function(req, res) {
  var callback, code, options, url;
  code = req.body.code.replace(new RegExp(' ', 'g'), '');
  url = "188.117.35.14";
  options = {
    host: url,
    path: "/TrainRSS/TrainService.svc/trainInfo?train=" + code
  };
  callback = function(response) {
    var str;
    str = "";
    response.on("data", function(chunk) {
      return str += chunk;
    });
    return response.on("end", function() {
      var data;
      data = parser.parse(str);
      res.contentType('application/json');
      return res.end(JSON.stringify(data, 200));
    });
  };
  return http.request(options, callback).end();
});
