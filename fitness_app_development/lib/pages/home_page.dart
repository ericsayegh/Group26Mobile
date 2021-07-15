import 'package:fitness_app_development/pages/settings.dart';
import 'package:fitness_app_development/pages/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app_development/services/global_data.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userName = '';
  String newUserName = '';
  int totalRuns = 0, newRun = 0;
  double totalDistance = 0, newDistance = 0;
  int totalTIme = 0, newTime = 0;

  @override
  void initState() {
    changeText();
    changeTotalRuns();
    changeTotalDistance();
    changeTotalTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://st2.depositphotos.com/1464196/11719/v/950/depositphotos_117192392-stock-illustration-background-in-color-of-summer.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: LayoutBuilder(
                builder: (context, constraints) => Stack(
                  fit: StackFit.expand,

                  children: [

                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                icon: CircleAvatar( // can add link to users profile pictures for this
                                  backgroundImage: NetworkImage( // PLACEHOLDER //
                                      'https://post.greatist.com/wp-content/uploads/2020/01/Runner-training-on-running-track-732x549-thumbnail.jpg'),
                                  radius: 40,
                                ),
                                iconSize: 40,
                                onPressed: () {

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => User()));


                                }
                            ),

                            Center(
                              child: Text(

                                userName,
                                style: TextStyle(
                                  fontFamily: 'Hind',
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            IconButton(
                                icon: Icon(
                                  Icons.settings,
                                  size: 50,
                                ),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
                                }
                            ),

                          ],
                        ),
                        Divider(
                          height: 20,
                          thickness: 2,
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text('Total Runs'),
                                Text('$totalRuns'),
                              ],
                            ),
                            Container(
                              height: 80,
                              child: VerticalDivider(
                                width: 20,
                                thickness: 2,
                                color: Colors.black,
                              ),
                            ),
                            Column(
                              children: [
                                Text('Total Distance'),
                                Text('$totalDistance'),
                              ],
                            ),
                            Container(
                              height: 80,
                              child: VerticalDivider(
                                width: 20,
                                thickness: 2,
                                color: Colors.black,
                              ),
                            ),
                            Column(
                              children: [
                                Text('Total Time'),
                                Text('$totalTIme'),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          height: 20,
                          thickness: 2,
                          color: Colors.black,
                        ),

                      ],
                    ),
                  ],
                ))),

      ),

    );


  }
  void changeText() {
    setState(() {
      userName = GlobalData.firstName!;
    });
  }

  void changeTotalRuns() {
    setState(() {
      totalRuns = GlobalData.totalRuns!;
    });
  }
  void changeTotalDistance() {
    setState(() {
      totalDistance = GlobalData.totalDistance!;
    });
  }
  void changeTotalTime() {
    setState(() {
      totalTIme = GlobalData.totalTime!;
    });
  }
}
