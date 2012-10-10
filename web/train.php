<?php
// http://www.vr.fi/fi/index/palvelut/avoin_data/Junatkartalla-rajapinta/junasyote.html

$trainId = $_REQUEST['code'];

$url = "http://188.117.35.14/TrainRSS/TrainService.svc/trainInfo?train=" . $trainId;

$response = file_get_contents($url);

$trainData = new SimpleXMLElement($response);


$posString = (string)$trainData->channel->children('georss', true)->point;

$point = explode(' ', $posString);


$data = array(
    'point' => $point,
    'train' => (string)$trainData->channel->title,
    'speed' => (string)$trainData->channel->speed,
    'lateness' => (string)$trainData->channel->lateness,
);


die(json_encode($data) );