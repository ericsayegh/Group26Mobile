import 'package:fitness_app_development/friends_util/constants.dart';
import 'package:fitness_app_development/run_sequence_util/timer_data.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../home_page.dart';

class Completed extends StatefulWidget {

  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  String _displayTime = '';
  double totalDistance = TimerData.totalDistance!;
  @override
  void initState() {
    // TODO: implement initState
    _displayTime = TimerData.displayTime!;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: (MediaQuery.of(context).size.height) * .4,
              child: MapboxMap(
                accessToken: mapBoxApiKey,
                initialCameraPosition: CameraPosition(
                zoom: 15,
                target: LatLng(37.052235,-122.243683),
                ),
              ),
            ),

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
            Text('$totalDistance',style: const TextStyle(
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
            Text('0:00',style: const TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 20),
            Divider(
              height: 20,
              thickness: 2,
              color: Colors.black,
            ),
            ElevatedButton(
                onPressed: () {
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

          ],
        ),
      ),
    );
  }
}
