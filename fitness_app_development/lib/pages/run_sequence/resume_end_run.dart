import 'package:fitness_app_development/pages/run_sequence/run_completed.dart';
import 'package:flutter/material.dart';

class ResumeOrEnd extends StatefulWidget {

  @override
  _ResumeOrEndState createState() => _ResumeOrEndState();
}

class _ResumeOrEndState extends State<ResumeOrEnd> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    icon: CircleAvatar(
                      backgroundImage: NetworkImage( // STOP BUTTON //
                          'https://thumbs.dreamstime.com/b/stop-button-flat-icon-symbol-hand-drawn-vector-illustration-91159889.jpg'),
                      radius: 40,
                    ),
                    iconSize: 100,
                    onPressed: () {

                      Navigator.push(context, MaterialPageRoute(builder: (context) => Completed()));


                    }
                ),
                IconButton(
                    icon: CircleAvatar(
                      backgroundImage: NetworkImage( // RESUME BUTTON //
                          'https://www.vippng.com/png/detail/111-1117124_green-play-button-png-green-play-button-icon.png'),
                      radius: 40,
                    ),
                    iconSize: 100,
                    onPressed: () {

                      Navigator.pop(context);


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
