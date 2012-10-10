var TrainDataParser;

TrainDataParser = (function() {

  function TrainDataParser(libxmljs) {
    this.libxmljs = libxmljs;
  }

  TrainDataParser.prototype.parse = function(xml) {
    var data, obj;
    xml = this.filter(xml);
    obj = this.libxmljs.parseXml(xml);
    return data = {
      title: obj.get("//title").text(),
      description: obj.get("//description").text(),
      category: obj.get("//category").text(),
      trainguid: obj.get("//trainguid").text(),
      point: obj.get("//point").text().split(' '),
      speed: obj.get("//speed").text(),
      lateness: obj.get("//lateness").text(),
      startStation: obj.get("//startStation").text(),
      endStation: obj.get("//endStation").text()
    };
  };

  TrainDataParser.prototype.filter = function(xml) {
    return xml = xml.replace(new RegExp('georss:point', 'g'), 'point');
  };

  return TrainDataParser;

})();

exports.TrainDataParser = TrainDataParser;
