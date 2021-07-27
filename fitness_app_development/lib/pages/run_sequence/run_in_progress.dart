import 'dart:async';
import 'dart:convert';
import 'dart:math'show cos, sqrt, asin;
import 'package:fitness_app_development/pages/run_sequence/run_completed.dart';
import 'package:fitness_app_development/run_sequence_util/coordiantes.dart';
import 'package:fitness_app_development/run_sequence_util/timer_data.dart';
import 'package:fitness_app_development/utilities/get_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';


class RunInProgress extends StatefulWidget {
  const RunInProgress({Key? key}) : super(key: key);

  @override
  _RunInProgressState createState() => _RunInProgressState();
}

class _RunInProgressState extends State<RunInProgress> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  late Position userLocation;

  List<Coords> coords = [];
  List<LatLng> coordsForMap = [];
  late Map<String, double> currentLocation;

  Map<int, double> lat = new Map();
  Map<int, double> lon = new Map();
  double totalDistance = 0.0;
  double totalDistanceInMIles = 0.0;




  double pace = 0.0;
  String display = '';
  int i = 0;
  late StreamSubscription _getPositionSubscription;
  bool stop = false;
  int timeInMilli = 0;
  int minutesInt = 0;
  int secondsInt = 0;
  String paceT = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    _getPositionSubscription = Geolocator.getPositionStream(intervalDuration: Duration(seconds: 1), desiredAccuracy: LocationAccuracy.best).listen((position) {

      userLocation = position;
      lat[i] = 0.0;
      lon[i] = 0.0;

      if(i==0){
          lat[i] = userLocation.latitude;
          lon[i] = userLocation.longitude;
          coords.add(Coords(userLocation.latitude, userLocation.longitude));
          coordsForMap.add(LatLng(userLocation.latitude, userLocation.longitude));
          i++;
      }
      else{

        totalDistance = Geolocator.distanceBetween(lat[i-1]!, lon[i-1]!, userLocation.latitude - (i * .0001), userLocation.longitude);

        lat[i] = userLocation.latitude - (i * .0001);
        lon[i] = userLocation.longitude;
        coords.add(Coords(userLocation.latitude - (i * .0001), userLocation.longitude));
        coordsForMap.add(LatLng(userLocation.latitude - (i * .0001), userLocation.longitude));
        i++;
      }
      setState(() {
        totalDistanceInMIles += getDistanceInMiles(totalDistance);
        pace = _stopWatchTimer.rawTime.value / (totalDistanceInMIles*60000);


        double minutes = pace.floorToDouble();

        double deciSeconds = pace - minutes;

        double seconds = deciSeconds*60.0;

        minutesInt = minutes.toInt();
        secondsInt = seconds.toInt();

        if(secondsInt < 10){
          paceT ='$minutesInt:0$secondsInt';
        }
        else{
          paceT ='$minutesInt:$secondsInt';
        }


      });

    });
  }

  @override
  void dispose() {
    _stopWatchTimer.dispose();

    super.dispose();
  }
  double getDistanceInMiles(double distanceInMeters){

    double distanceInMiles = distanceInMeters/1609.34;

    return distanceInMiles;
  }
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Stack(
          children: [

            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.5, 1],
                      colors: [Colors.cyan, Colors.blueAccent.shade700])
              ),
            ),

            Column(
              children: [
                SizedBox(height: 20),
                Text('${TimerData.runName}',style: const TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 15),
                Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.black,
                ),
                Text('Time',style: const TextStyle(
                  fontSize: 80.0,
                  fontWeight: FontWeight.bold,
                ),),
                StreamBuilder<int>(
                    stream: _stopWatchTimer.rawTime.asBroadcastStream(),
                    initialData: _stopWatchTimer.rawTime.value,
                    builder: (context, snapshot) {
                      final value = snapshot.data;
                      final displayTime = StopWatchTimer.getDisplayTime(
                          value!, hours: false);
                      timeInMilli = value;
                      TimerData.displayTime = displayTime;
                      return Text(
                        displayTime,
                        style: const TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                SizedBox(height: 20),
                Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.black,
                ),
                Text('Distance',style: const TextStyle(
                  fontSize: 80.0,
                  fontWeight: FontWeight.bold,
                ),),
                Text(totalDistanceInMIles.toStringAsFixed(2),style: const TextStyle(
                  fontSize: 80.0,
                  fontWeight: FontWeight.bold,
                ),),
                //Text('Latitude: $lat'),
                // Text('Longitude: $lon'),
                SizedBox(height: 20),
                Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.black,
                ),
                Text('Pace',style: const TextStyle(
                  fontSize: 80.0,
                  fontWeight: FontWeight.bold,
                ),),
                Text(paceT,style: const TextStyle(
                  fontSize: 80.0,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 20),
                Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.black,
                ),
                SizedBox(height: 10),
                IconButton(
                    icon: CircleAvatar(
                      backgroundImage: NetworkImage( // Stop //
                          'https://www.pinclipart.com/picdir/middle/31-315907_red-stop-button-plain-icon-svg-clip-arts.png'
                      ),
                      radius: 40,
                    ),
                    iconSize: 100,
                    onPressed: () async {
                      _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                      _getPositionSubscription.cancel();

                      TimerData.stopWatchTimer = _stopWatchTimer;
                      TimerData.rawTime = _stopWatchTimer.rawTime.value;
                      TimerData.secondTime = _stopWatchTimer.secondTime.value;
                      TimerData.minuteTime = _stopWatchTimer.minuteTime.value;
                      TimerData.totalDistance = totalDistanceInMIles;
                      TimerData.latitude = lat;
                      TimerData.longitude = lon;
                      TimerData.pace = pace;

                      print('lat + $lat');
                      print('lon + $lon');
                      String hi = jsonEncode(coords);
                      print("hi");
                      print(hi);
                      TimerData.hi = hi;
                      TimerData.cordies = List.from(coordsForMap);

                      await GetAPI.addRun();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Completed()));
                    }
                ),


              ],
            ),
          ],
        ),
      ),
    );
  }

}