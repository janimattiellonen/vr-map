express = require 'express'

#require './components/TrainDataParser'

#require './services/TodoService3'
TrainDataParser = require("./components/TrainDataParser").TrainDataParser
Foo = require("./services/Foo").Foo

pub = __dirname + '/web'

mongo = require 'mongodb'
Server = mongo.Server
Db = mongo.Db;

sys = require 'sys'
http = require 'http'

libxmljs = require "libxmljs"

xml =  '<rss version="2.0"><channel xmlns:georss="http://www.georss.org/georss"><title>S 60</title><description>Train information feed for train S 60</description><lastBuildDate>Tue, 02 Oct 2012 00:13:28 +0300</lastBuildDate><category>1</category><trainguid>S60</trainguid><georss:point>0 0</georss:point><speed>0</speed><heading/><startStation>ROI</startStation><endStation>HKI</endStation><status>1</status><reasonCode/><lateness>0</lateness><item><guid isPermaLink="false">ROI</guid><title>ROI</title><description>Summary</description><pubDate>Tue, 02 Oct 2012 00:13:28 +0300</pubDate><scheduledTime/><scheduledDepartTime>15:10</scheduledDepartTime><eta/><etd>15:10</etd><stationCode>ROI</stationCode><completed>0</completed><status>1</status><georss:point>0 0</georss:point></item></channel></rss>'


parser = new TrainDataParser(libxmljs)

result = parser.parse xml

#console.log result


server = new Server('localhost', 27017, {auto_reconnect: true});
db = new Db('vr-map_db', server);

db.open (err, db) ->
    unless err
        console.log "Connected to MongoDb"
        db.collection "todos", (err, collection) ->

app = express()
#app = express.createServer()
app.listen 3001

console.log 'Express app started on port 3001'

app.configure ->
    app.use express.methodOverride()
    app.use express.bodyParser()
    app.use express.static(process.cwd() + '/web')
    app.use express.errorHandler(
        dumpExceptions: true
        showStack: true
    )
    app.use app.router

app.set "view engine", "jade"
app.set "view options",
    layout: false

app.get "/", (req, res) ->
    res.render "index"

app.post "/find-train", (req, res) ->
    code =  req.body.code.replace(new RegExp(' ', 'g'), '');
    url = "188.117.35.14"

    options =
        host: url
        path: "/TrainRSS/TrainService.svc/trainInfo?train=" + code

    callback = (response) ->
        str = ""

        response.on "data", (chunk) ->
            str += chunk

        response.on "end", ->

            try
                data = parser.parse str
                status = true
            catch err
                data = {}
                status = false

            resultData = {
                status: status,
                data: data
            }

            res.contentType 'application/json'
            res.end(JSON.stringify resultData, 200 )

    http.request(options, callback).end()