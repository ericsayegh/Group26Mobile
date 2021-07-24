import 'package:fitness_app_development/friends_util/constants.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class Completed extends StatefulWidget {

  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 250,
                child:  MapboxMap(
                  accessToken: mapBoxApiKey,
                  initialCameraPosition: CameraPosition(
                    zoom: 8.0,
                    target: LatLng(34.052235,-118.243683),
                  ),
                ),
              ),
            ),
            Text('Run #'),
            SizedBox(height: 288),
            Divider(
              height: 20,
              thickness: 2,
              color: Colors.black,
            ),
            Text('Time'),
            Text('0:00'),
            SizedBox(height: 20),
            Divider(
              height: 20,
              thickness: 2,
              color: Colors.black,
            ),
            Text('Distance'),
            Text('0:00'),
            SizedBox(height: 20),
            Divider(
              height: 20,
              thickness: 2,
              color: Colors.black,
            ),
            Text('Pace'),
            Text('0:00'),
            SizedBox(height: 20),
            Divider(
              height: 20,
              thickness: 2,
              color: Colors.black,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // gotta be a better way to do this
                  Navigator.pop(context); // want to pop pages until home screen is reached
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                    'Return to home Page'
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
