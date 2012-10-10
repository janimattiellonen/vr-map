var TrainInfo;

TrainInfo = (function() {

  function TrainInfo(element) {
    this.element = element;
  }

  TrainInfo.prototype.updateInfo = function(info) {
    alert;    $("#train-id-col", this.element).html(info.title);
    $("#train-speed-col", this.element).html(info.speed);
    $("#train-lateness-col", this.element).html(info.lateness);
    $("#train-from-col", this.element).html(info.startStation);
    $("#train-to-col", this.element).html(info.endStation);
    return null;
  };

  return TrainInfo;

})();
