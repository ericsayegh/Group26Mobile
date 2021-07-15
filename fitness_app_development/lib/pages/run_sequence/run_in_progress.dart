import 'package:fitness_app_development/pages/run_sequence/resume_end_run.dart';
import 'package:flutter/material.dart';

class Pause extends StatefulWidget {
  const Pause({Key? key}) : super(key: key);

  @override
  _PauseState createState() => _PauseState();
}

class _PauseState extends State<Pause> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
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
            IconButton(
                icon: CircleAvatar(
                  backgroundImage: NetworkImage( // Pause button //
                      'https://megapng.com/images/bt/pause-button-1.png'),
                  radius: 40,
                ),
                iconSize: 100,
                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => ResumeOrEnd()));


                }
            ),

          ],
        ),
      ),
    );
  }
}
