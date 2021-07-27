import 'dart:convert';

import 'package:fitness_app_development/friends_util/constants.dart';
import 'package:fitness_app_development/utilities/get_api.dart';
import 'package:fitness_app_development/utilities/global_data.dart';
import 'package:fitness_app_development/utilities/personal_run_data.dart';
import 'package:fitness_app_development/utilities/results.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'home_page.dart';


class OldRun extends StatefulWidget {

  @override
  _OldRunState createState() => _OldRunState();
}

class _OldRunState extends State<OldRun> {

  String _displayTime = '';
  double totalDistance = 0.0;
  String pace = '';
  String runName = '';

  late List<LatLng> cordies = [];






  @override
  void initState() {
    // TODO: implement initState
    _displayTime = GlobalData.resultObjs[RunData.index].time.toString();
    pace = GlobalData.resultObjs[RunData.index].pace;
    totalDistance = GlobalData.resultObjs[RunData.index].distance;
    runName = GlobalData.resultObjs[RunData.index].runName;
    for(int i = 0; i<GlobalData.resultObjs[RunData.index].coordinates.length; i++){
      cordies.add(LatLng(GlobalData.resultObjs[RunData.index].coordinates[i][1], GlobalData.resultObjs[RunData.index].coordinates[i][0]));
    }

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade600,
        title: Text('$runName', style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20
        )),
        leading: new IconButton(
          onPressed: () async {
            await getTotalData();
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
          },
          icon: new Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: Container(

        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.5, 1],
                colors: [Colors.cyan, Colors.blueAccent.shade700])
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: (MediaQuery.of(context).size.height) * .5,
                child: MapboxMap(
                    accessToken: mapBoxApiKey,
                    initialCameraPosition: CameraPosition(
                      zoom: 15,
                      target: LatLng(GlobalData.resultObjs[RunData.index].coordinates[0][1], GlobalData.resultObjs[RunData.index].coordinates[0][0]),
                    ),
                    onMapCreated: (MapboxMapController controller) async {
                      // Acquire current location (returns the LatLng instance)
                      // You can either use the moveCamera or animateCamera, but the former
                      // causes a sudden movement from the initial to 'new' camera position,
                      // while animateCamera gives a smooth animated transition
                      await controller.animateCamera(

                        CameraUpdate.newLatLng(LatLng(GlobalData.resultObjs[RunData.index].coordinates[GlobalData.resultObjs[RunData.index].coordinates.length-1][1], GlobalData.resultObjs[RunData.index].coordinates[GlobalData.resultObjs[RunData.index].coordinates.length-1][0])),


                      );

                      controller.addLine(
                        LineOptions(
                          geometry: cordies,

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
                          geometry: LatLng(GlobalData.resultObjs[RunData.index].coordinates[0][1], GlobalData.resultObjs[RunData.index].coordinates[0][0]),
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
                          geometry: LatLng(GlobalData.resultObjs[RunData.index].coordinates[GlobalData.resultObjs[RunData.index].coordinates.length-1][1], GlobalData.resultObjs[RunData.index].coordinates[GlobalData.resultObjs[RunData.index].coordinates.length-1][0]),
                          draggable: false,
                        ),

                      );

                    }
                ),



              ),
              SizedBox(height: 10),
              /*Text('$runName',style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),),*/
              /*Divider(
                height: 20,
                thickness: 2,
                color: Colors.black,
              ),*/
              Text('Time',style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),),
              Text(
                '$_displayTime',
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
              Text('$pace',style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),),


              /*ElevatedButton(
                  onPressed: () async {
                    await getTotalData();
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
              ),*/
              // need to add button to get to home page


            ],
          ),
        ),
      ),
    );
  }

  Future<void> getTotalData() async {
    var ret = await GetAPI.searchUsers(GlobalData.firstName!);


    var resultObjsJson = jsonDecode(ret.body)['results'] as List;
    List<GetResults> resultObjs = resultObjsJson.map((resultJson) => GetResults.fromJson(resultJson)).toList();


    GlobalData.totalDistance = resultObjs[0].TotalDistance;
    GlobalData.totalRuns = resultObjs[0].TotalRuns;
    GlobalData.totalTime = resultObjs[0].TotalTime;




  }
}