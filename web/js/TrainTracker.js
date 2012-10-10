var TrainTracker,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

TrainTracker = (function() {

  function TrainTracker(client, window) {
    this.client = client;
    this.processResult = __bind(this.processResult, this);
    this.isTrackingTrain = __bind(this.isTrackingTrain, this);
    this.cancelTracking = __bind(this.cancelTracking, this);
    this.trackTrain = __bind(this.trackTrain, this);
    this.isTracking = false;
    this.markerArray = [];
    this.intervalId = null;
    this.window = window;
  }

  TrainTracker.prototype.trackTrain = function(trainCode) {
    return this._trackTrain(trainCode);
  };

  TrainTracker.prototype.cancelTracking = function() {
    if (this.isTrackingTrain()) {
      this.window.clearInterval(this.intervalId);
      this.isTracking = false;
      return this.intervalId = null;
    }
  };

  TrainTracker.prototype.isTrackingTrain = function() {
    return this.intervalId !== null && this.isTracking === true;
  };

  TrainTracker.prototype._trackTrain = function(trainCode) {
    var client, processResult;
    client = this.client;
    processResult = this.processResult;
    client.findTrain(trainCode, processResult);
    this.isTracking = true;
    return this.intervalId = setInterval((function() {
      return client.findTrain(trainCode, processResult);
    }), 3000);
  };

  TrainTracker.prototype.processResult = function(data) {
    var i, infowindow, lat, long, marker, pos, title;
    lat = data.point[0];
    long = data.point[1];
    title = data.title;
    pos = new google.maps.LatLng(lat, long);
    marker = new google.maps.Marker({
      map: this.map,
      position: pos
    });
    i = 0;
    while (i < this.markerArray.length) {
      this.markerArray[i].setMap(null);
      i++;
    }
    map.setCenter(pos);
    this.markerArray.push(marker);
    infowindow = new google.maps.InfoWindow();
    return infowindow.setContent(title);
  };

  TrainTracker.prototype.setMap = function(map) {
    return this.map = map;
  };

  return TrainTracker;

})();
