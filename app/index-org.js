var app, assets, express, port, stylus;

express = require('express');

stylus = require('stylus');

assets = require('connect-assets');

app = express();

app.use(assets());

app.use(express.static(process.cwd() + '/public'));

app.set('view engine', 'jade');

app.get('/', function(req, resp) {
  return resp.render('index');
});

port = 3004;

app.listen(port, function() {
  return console.log("Listening on " + port + "\nPress CTRL-C to stop server.");
});
