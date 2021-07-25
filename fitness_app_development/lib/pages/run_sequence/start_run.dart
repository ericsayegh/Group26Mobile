import 'package:fitness_app_development/pages/run_sequence/run_in_progress.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app_development/friends_util/constants.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';


import '../home_page.dart';


class StartRun extends StatefulWidget {

  @override
  _StartRunState createState() => _StartRunState();
}

class _StartRunState extends State<StartRun> {

 // bool selected = true;
  String imgUrl = 'https://www.vippng.com/png/detail/111-1117124_green-play-button-png-green-play-button-icon.png';
  @override
  Widget build(BuildContext context) {
    //final StopWatchTimer _stopWatchTimer = StopWatchTimer();
    //final _isMinutes = true;
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
          },
          icon: new Icon(Icons.arrow_back, color: Colors.orange),
        ),
      ),
      body: SingleChildScrollView(
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
            Text('Time', style: const TextStyle(
              fontSize: 80.0,
              fontWeight: FontWeight.bold,
            ),),

           Text('0:00.00',style: const TextStyle(
             fontSize: 80.0,
             fontWeight: FontWeight.bold,
           ),),
           // StreamBuilder<int>(
               // stream: _stopWatchTimer.rawTime,
                //initialData: _stopWatchTimer.rawTime.value,
                //builder: (context, snapshot) {
             //final value = snapshot.data;
              //final displayTime = StopWatchTimer.getDisplayTime(value!, hours: false);
             // return Text(
               // displayTime,
              //  style: const TextStyle(
               //   fontSize: 40.0,
              //    fontWeight: FontWeight.bold,
              //  ),
              //);

           // }),


            SizedBox(height: 20),
            Divider(
              height: 20,
              thickness: 2,
              color: Colors.black,
            ),
            Text('Distance', style: const TextStyle(
              fontSize: 80.0,
              fontWeight: FontWeight.bold,
            ),),
            Text('0:00', style: const TextStyle(
              fontSize: 80.0,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 20),
            Divider(
              height: 20,
              thickness: 2,
              color: Colors.black,
            ),
            Text('Pace', style: const TextStyle(
              fontSize: 80.0,
              fontWeight: FontWeight.bold,
            ),),
            Text('0:00', style: const TextStyle(
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
                  backgroundImage: NetworkImage(
                      imgUrl,

                  ),
                  radius: 40,
                ),
                iconSize: 100,
                onPressed: () {

                  /*
                  _stopWatchTimer.onExecute.add(StopWatchExecute.start);

                  setState(() {
                    if(imgUrl.compareTo('https://www.vippng.com/png/detail/111-1117124_green-play-button-png-green-play-button-icon.png') == 0) {
                      imgUrl =
                      'https://www.pinclipart.com/picdir/middle/31-315907_red-stop-button-plain-icon-svg-clip-arts.png';

                    }
                    else {

                      imgUrl = 'https://www.vippng.com/png/detail/111-1117124_green-play-button-png-green-play-button-icon.png';
                    }


                  });

                  */


                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RunInProgress()));


                }
            ),

          ],
        ),
      ),
    );
  }
}
