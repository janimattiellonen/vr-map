<!DOCTYPE html>
<html>
<head><meta charset="utf-8" />

    <title>Vr Map - 0.0.1a</title>

    <link rel="stylesheet" type="text/css" href="/styles/styles.css" media="all" />

    <script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
    <script src="http://code.jquery.com/jquery.min.js"></script>


    <script>
        var map;
        var overlay;

        function initialize() {
            var mapOptions = {
                zoom: 8,
                center: new google.maps.LatLng(65.4911300000001, 28.3853900000001),
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            map = new google.maps.Map(document.getElementById('map_canvas'),
                    mapOptions);


            overlay = new google.maps.OverlayView();
            overlay.draw = function() {};
            overlay.setMap(map);

        }

        google.maps.event.addDomListener(window, 'load', initialize);
    </script>
</head>

<body id="foobar">
<div id="map_canvas"></div>
<div id="controls">

    <form method="post" action="/train.php">
        <label for="code">Train code</label>
        <input type="text" name="code" id="code" />
        <input id="submit" type="submit" value="Find train" />
        <input id="submit2" type="submit" value="Find train2" />
   </form>

</div>

<div id="train-info">

    <table>
        <tr>
            <td>Train id</td>
            <td id="train-id-col"></td>
        </tr>
        <tr>
            <td>Speed</td>
            <td id="train-speed-col"></td>
        </tr>

        <tr>
            <td>late (in seconds)</td>
            <td id="train-lateness-col"></td>
        </tr>

    </table>

    <div id="poss"></div>

</div>


<script src="/js/train.js"></script>
</body>
</html>
