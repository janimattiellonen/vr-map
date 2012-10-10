var TrainList;

TrainList = (function() {

  function TrainList(element, trackTrainCallback, cancelTrackingCallback) {
    this.element = element;
    this.trackTrainCallback = trackTrainCallback;
    this.cancelTrackingCallback = cancelTrackingCallback;
  }

  TrainList.prototype.addTrain = function(trainCode, train) {
    var $item, $li, $ul, self,
      _this = this;
    $ul = this.getListElement();
    $item = $ul.find('li[data-id="' + trainCode + '"]');
    self = this;
    if ($item.length === 0) {
      $li = $('<li></li>').html(train);
      $li.attr('data-id', trainCode);
      $li.bind('click', function(e) {
        var $target;
        $target = $(e.target);
        _this.cancelTrackingCallback();
        if ($li.hasClass("active")) {
          return $li.removeClass("active");
        } else {
          $('li.active', _this.element).removeClass("active");
          $li.addClass("active");
          return _this.trackTrainCallback($target.attr('data-id'));
        }
      });
      return $ul.append($li);
    }
  };

  TrainList.prototype.list = function(trains) {
    var $li, train, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = trains.length; _i < _len; _i++) {
      train = trains[_i];
      $li = $('<li></li>').html(train);
      _results.push($('ul', this.element).append($li));
    }
    return _results;
  };

  TrainList.prototype.getListElement = function() {
    return $('ul', this.element);
  };

  return TrainList;

})();
