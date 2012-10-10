
class TrainDataParser
    constructor: (@libxmljs) ->

    parse: (xml) ->

        xml = @filter xml

        obj = @libxmljs.parseXml xml

        data = {
            title: obj.get("//title").text()
            description: obj.get("//description").text()
            category: obj.get("//category").text()
            trainguid: obj.get("//trainguid").text()
            point: obj.get("//point").text() .split(' ')
            speed: obj.get("//speed").text()
            lateness: obj.get("//lateness").text(),
            startStation: obj.get("//startStation").text(),
            endStation: obj.get("//endStation").text()
        }

    filter: (xml) ->
        # Didn't find any way to access georss:point so I simply replaced it with 'point'
        xml = xml.replace(new RegExp('georss:point', 'g'), 'point');

exports.TrainDataParser = TrainDataParser