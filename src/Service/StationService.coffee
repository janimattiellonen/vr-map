class StationService
    constructor: (@db) ->
        @initIfNoStations()

    initIfNoStations: ->
        self = this

        @db.open (err, db) ->
            db.collection "stations", (err, collection) =>
                collection.find({}).toArray (err, results) ->
                    if results.length == 0
                        self.initStations()

    initStations: ->
        list = [
            {code: "EPO", name: "Espoo"},
            {code: "HPK", name: "Haapamäki"},
            {code: "HNK", name: "Hanko"},
            {code: "HKI", name: "Helsinki"},
            {code: "HL", name: "Hämeenlinna"},
            {code: "ILM", name: "Iisalmi"},
            {code: "IMR", name: "Imatra"},
            {code: "JNS", name: "Joensuu"},
            {code: "JY", name: "Jyväskylä"},
            {code: "JäS", name: "Jämsä"},
            {code: "KAJ", name: "Kajaani"},
            {code: "KR", name: "Karjaa"},
            {code: "KEM", name: "Kemi"},
            {code: "KJä", name: "Kemijärvi"},
            {code: "KKN", name: "Kirkkonummi"},
            {code: "KOK", name: "Kokkola"},
            {code: "KLI", name: "Kolari"},
            {code: "KON", name: "Kontiomäki"},
            {code: "KTS", name: "Kotkan satama"},
            {code: "KV", name: "Kouvola"},
            {code: "KUO", name: "Kuopio"},
            {code: "LH", name: "Lahti"},
            {code: "LR", name: "Lappeenranta"},
            {code: "LM", name: "Loimaa"},
            {code: "MI", name: "Mikkeli"},
            {code: "NRM", name: "Nurmes"},
            {code: "OL", name: "Oulu"},
            {code: "PAR", name: "Parikkala"},
            {code: "PKO", name: "Parkano"},
            {code: "PM", name: "Pieksämäki"},
            {code: "PRI", name: "Pori"},
            {code: "RI", name: "Riihimäki"},
            {code: "ROI", name: "Rovaniemi"},
            {code: "SLO", name: "Salo"},
            {code: "SL", name: "Savonlinna"},
            {code: "SK", name: "Seinäjoki"},
            {code: "TPE", name: "Tampere"},
            {code: "TKL", name: "Tikkurila"},
            {code: "TL", name: "Toijala"},
            {code: "TKU", name: "Turku"},
            {code: "TUS", name: "Turku satama"},
            {code: "VS", name: "Vaasa"},
            {code: "VNA", name: "Vainikkala"},
            {code: "YV", name: "Ylivieska"}
        ]

        @db.collection "stations", (err, collection) ->

            for station in list
                do (station) ->
                    collection.insert station, {safe: true} , (err) ->
                        console.log err

exports.StationService = StationService
