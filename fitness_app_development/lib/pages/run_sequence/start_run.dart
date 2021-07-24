import 'package:fitness_app_development/pages/run_sequence/run_in_progress.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app_development/friends_util/constants.dart';
import 'package:mapbox_gl/mapbox_gl.dart';


class StartRun extends StatefulWidget {

  @override
  _StartRunState createState() => _StartRunState();
}

class _StartRunState extends State<StartRun> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('run #'),

      ),
      body: SingleChildScrollView(
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
            IconButton(
                icon: CircleAvatar(
                  backgroundImage: NetworkImage( // START BUTTON //
                      'https://www.vippng.com/png/detail/111-1117124_green-play-button-png-green-play-button-icon.png'),
                  radius: 40,
                ),
                iconSize: 100,
                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => Pause()));


                }
            ),

          ],
        ),
      ),
    );
  }
}
