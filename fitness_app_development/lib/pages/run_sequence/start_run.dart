import 'package:fitness_app_development/pages/run_sequence/run_in_progress.dart';
import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          SizedBox(height: 250),
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
    );
  }
}
