var TrainApiClient;

TrainApiClient = (function() {

  function TrainApiClient(url) {
    this.url = url;
  }

  TrainApiClient.prototype.findTrain = function(trainCode, successCallback) {
    return $.ajax({
      url: this.url,
      dataType: "json",
      type: "POST",
      data: "code=" + trainCode,
      success: successCallback
    });
  };

  return TrainApiClient;

})();
