var TrainLocator,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

TrainLocator = (function() {

  function TrainLocator(element, trainInfo, client) {
    this.element = element;
    this.trainInfo = trainInfo;
    this.client = client;
    this.processResult = __bind(this.processResult, this);
    this.findTrain = __bind(this.findTrain, this);
  }

  TrainLocator.prototype.findTrain = function(trainCode) {
    return this.client.findTrain(trainCode, this.processResult);
  };

  TrainLocator.prototype.processResult = function(data) {
    var lat, long, pos, title;
    lat = data.point[0];
    long = data.point[1];
    title = data.title;
    pos = new google.maps.LatLng(lat, long);
    this.setSelectedTrainId(data.trainguid);
    this.setAddTrainButtonState(true);
    return this.trainInfo.updateInfo(data);
  };

  TrainLocator.prototype.setSelectedTrainId = function(trainId) {
    return $("#selected-train", this.element).attr("value", trainId);
  };

  TrainLocator.prototype.setAddTrainButtonState = function(state) {
    if (state) {
      return $("#add-train", this.element).removeAttr("disabled");
    } else {
      return $("#add-train", this.element).attr("attr", "disabled");
    }
  };

  return TrainLocator;

})();
