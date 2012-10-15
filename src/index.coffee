express = require 'express'




#require './components/TrainDataParser'

#require './services/TodoService3'
TrainDataParser = require("./components/TrainDataParser").TrainDataParser

pub = __dirname + '/web'

mongo = require 'mongodb'
Server = mongo.Server
Db = mongo.Db;

sys = require 'sys'
http = require 'http'

libxmljs = require "libxmljs"

parser = new TrainDataParser(libxmljs)

Db = require("mongodb").Db
Server = require("mongodb").Server
client = new Db("vrmap", new Server("127.0.0.1", 22222, {auto_connect: false}))

client.open (err, client) ->
    unless err
        console.log "Connected to MongoDb"
        client.collection "stations", (err, collection) ->
            collection.insert
                dd: "ff",
                safe: true,
                (err, collection) ->

client.close()

StationService = require('./Service/StationService').StationService

stationService = new StationService(client)

app = express()
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
                console.log err
                data = {}
                status = false

            resultData = {
            status: status,
            data: data
            }

            res.contentType 'application/json'
            res.end(JSON.stringify resultData, 200 )

    http.request(options, callback).end()