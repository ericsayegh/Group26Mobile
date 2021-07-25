import 'dart:async';
import 'dart:math'show cos, sqrt, asin;
import 'package:fitness_app_development/pages/run_sequence/resume_end_run.dart';
import 'package:fitness_app_development/pages/run_sequence/run_completed.dart';
import 'package:fitness_app_development/run_sequence_util/timer_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';


class RunInProgress extends StatefulWidget {
  const RunInProgress({Key? key}) : super(key: key);

  @override
  _RunInProgressState createState() => _RunInProgressState();
}

class _RunInProgressState extends State<RunInProgress> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final _isMinutes = true;

  late Position userLocation;


  late Map<String, double> currentLocation;
  Map<int, double> lat = new Map();
  Map<int, double> lon = new Map();
  double totalDistance = 0.0;
  String display = '';
  int i = 0;
  late StreamSubscription _getPositionSubscription;
  bool stop = false;
  int timeInMilli = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    _getPositionSubscription = Geolocator.getPositionStream(intervalDuration: Duration(seconds: 4), desiredAccuracy: LocationAccuracy.best).listen((position) {

      userLocation = position;
      lat[i] = 0.0;
      lon[i] = 0.0;

      if(i==0){
          lat[i] = userLocation.latitude;lon[i] = userLocation.longitude;
          i++;
      }
      else{

        totalDistance = Geolocator.distanceBetween(lat[i-1]!, lon[i-1]!, userLocation.latitude, userLocation.longitude);
        lat[i] = userLocation.latitude;
        lon[i] = userLocation.longitude;
        i++;
      }
      setState(() {
        display = lat[i].toString() + lon[i].toString();
      });



    });



    /* testing
    _getPositionSubscription = Geolocator.getPositionStream(intervalDuration: Duration(seconds: 4), desiredAccuracy: LocationAccuracy.best).listen((position) {

      userLocation = position;
      lat[i] = 0.0;
      lon[i] = 0.0;

      if(i==0){
        lat[i] = userLocation.latitude;
        lon[i] = userLocation.longitude;
        i++;
      }
      else{

        setState(() {
          totalDistance += Geolocator.distanceBetween(lat[i-1]!, lon[i-1]!  - .000001, userLocation.latitude+ i.toDouble(), userLocation.longitude+ i.toDouble() - .000001);
        });
        lat[i] = userLocation.latitude - .000001;
        lon[i] = userLocation.longitude  - .000001;
        i++;
      }

      print('hi');

      // Do something here
    });
  */
  }

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    _getPositionSubscription.cancel();
    super.dispose();
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
        child: Column(
          children: [
            Text('Run #',style: const TextStyle(
              fontSize: 50.0,
              fontWeight: FontWeight.bold,
            ),),
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
                  //if(compare == 0){

                  //print(lat[0]);
                  //updateDistance(count).asStream();
                  //count++;


                  // }

                  //print(value);

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
            Text('$totalDistance',style: const TextStyle(
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
            Text('0:00',style: const TextStyle(
              fontSize: 80.0,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 20),
            Divider(
              height: 20,
              thickness: 2,
              color: Colors.black,
            ),
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
                  TimerData.stopWatchTimer = _stopWatchTimer;
                  TimerData.rawTime = _stopWatchTimer.rawTime.value;
                  TimerData.secondTime = _stopWatchTimer.secondTime.value;
                  TimerData.minuteTime = _stopWatchTimer.minuteTime.value;

                  TimerData.totalDistance = totalDistance;

                  print('lat + $lat');
                  print('lon + $lon');
                  stop = true;
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Completed()));
                }
            ),


          ],
        ),
      ),
    );
  }

}