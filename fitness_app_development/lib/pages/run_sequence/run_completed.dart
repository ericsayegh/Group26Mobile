import 'dart:convert';

import 'package:fitness_app_development/friends_util/constants.dart';
import 'package:fitness_app_development/run_sequence_util/timer_data.dart';
import 'package:fitness_app_development/utilities/get_api.dart';
import 'package:fitness_app_development/utilities/global_data.dart';
import 'package:fitness_app_development/utilities/results.dart';
import 'package:fitness_app_development/utilities/results_runs.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../home_page.dart';

class Completed extends StatefulWidget {

  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {

  String _displayTime = '';
  double totalDistance = 0.0;
  double pace = 0.0;
 
  
  
  final Map<String, dynamic> coords = {
    "latitude" : TimerData.latitude,
    "longitude" : TimerData.longitude,
  };




  @override
  void initState() {
    // TODO: implement initState
    _displayTime = TimerData.displayTime!;
    pace = TimerData.pace!;
    totalDistance = TimerData.totalDistance!;



    print('$coords');

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    TimerData.stopWatchTimer!.dispose();
    TimerData.rawTime = 0;
    TimerData.secondTime = 0;
    TimerData.minuteTime = 0;
    TimerData.totalDistance = 0.0;
    TimerData.pace = 0;
    TimerData.displayTime = '';
    TimerData.hi='';
    TimerData.cordies = [];
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade600,
        title: Text('Back to home page', style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20
        )),
        leading: new IconButton(
          onPressed: () async {
            await getTotalData();
            await getRunData();
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
          },
          icon: new Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.5, 1],
                  colors: [Colors.cyan, Colors.blueAccent.shade700])
          ),
          child: Column(
            children: [
              SizedBox(
                height: (MediaQuery.of(context).size.height) * .45,
                child: MapboxMap(
                  accessToken: mapBoxApiKey,
                  initialCameraPosition: CameraPosition(
                  zoom: 5,
                  target: LatLng(TimerData.latitude[0], TimerData.longitude[0]),
                  ),
                  onMapCreated: (MapboxMapController controller) async {
                    // Acquire current location (returns the LatLng instance)
                    // You can either use the moveCamera or animateCamera, but the former
                    // causes a sudden movement from the initial to 'new' camera position,
                    // while animateCamera gives a smooth animated transition
                    await controller.animateCamera(

                      CameraUpdate.newLatLng(LatLng(TimerData.latitude[TimerData.latitude.length - 1], TimerData.longitude[TimerData.latitude.length - 1])),


                    );

                    controller.addLine(
                      LineOptions(
                        geometry: TimerData.cordies,

                          lineColor: "#ff0000",
                          lineWidth: 14.0,
                          lineOpacity: 0.5,
                          draggable: true,
                      ),

                    );

                    //Add a circle denoting current user location
                    await controller.addCircle(
                      CircleOptions(
                        circleRadius: 8.0,
                        circleColor: '#006992',
                        circleOpacity: 0.8,

                        // YOU NEED TO PROVIDE THIS FIELD!!!
                        // Otherwise, you'll get a silent exception somewhere in the stack
                        // trace, but the parameter is never marked as @required, so you'll
                        // never know unless you check the stack trace
                        geometry: LatLng(TimerData.latitude[0], TimerData.longitude[0]),
                        draggable: false,
                      ),

                    );


                    await controller.addCircle(
                      CircleOptions(
                        circleRadius: 8.0,
                        circleColor: '#006992',
                        circleOpacity: 0.8,

                        // YOU NEED TO PROVIDE THIS FIELD!!!
                        // Otherwise, you'll get a silent exception somewhere in the stack
                        // trace, but the parameter is never marked as @required, so you'll
                        // never know unless you check the stack trace
                        geometry: LatLng(TimerData.latitude[TimerData.latitude.length - 1], TimerData.longitude[TimerData.latitude.length - 1]),
                        draggable: false,
                      ),

                    );

                  }
                ),



              ),

              Text('${TimerData.runName}',style: const TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
              ),),
              Divider(
                height: 20,
                thickness: 2,
                color: Colors.black,
              ),
              Text('Time',style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),),
              Text(
                _displayTime,
                style: const TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Divider(
                height: 20,
                thickness: 2,
                color: Colors.black,
              ),
              Text('Distance',style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),),
              Text(totalDistance.toStringAsFixed(2),style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 20),
              Divider(
                height: 20,
                thickness: 2,
                color: Colors.black,
              ),
              Text('Pace',style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),),
              Text(pace.toStringAsFixed(2),style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),),



             /*
              Divider(
                height: 20,
                thickness: 2,
                color: Colors.black,
              ),




              ElevatedButton(
                  onPressed: () async {
                    await getTotalData();
                    await getRunData();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: Text(
                      'Return to home Page',
                    style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    ),
                  )
              ),
              // need to add button to get to home page
              // pop all the way to home page??
              */
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getTotalData() async {
    var ret = await GetAPI.searchUsers(search: GlobalData.firstName!);


    var resultObjsJson = jsonDecode(ret.body)['results'] as List;
    List<GetResults> resultObjs = resultObjsJson.map((resultJson) => GetResults.fromJson(resultJson)).toList();


    GlobalData.totalDistance = resultObjs[0].TotalDistance;
    GlobalData.totalRuns = resultObjs[0].TotalRuns;
    GlobalData.totalTime = resultObjs[0].TotalTime;




  }

  Future<void> getRunData() async {
    var ret = await GetAPI.searchRun();

    var resultObjsJson = jsonDecode(ret.body)['results'] as List;
    GlobalData.resultObjs  = resultObjsJson.map((resultJson) => GetResults2.fromJson(resultJson)).toList();

    print('${GlobalData.resultObjs} this');

  }
}
