import 'package:fitness_app_development/pages/run_sequence/start_run.dart';
import 'package:fitness_app_development/pages/settings.dart';
import 'package:fitness_app_development/pages/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app_development/services/global_data.dart';
import 'package:fitness_app_development/utilities/get_api.dart';
import 'package:fitness_app_development/pages/friends.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


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
    //changeTotalRuns();
   // changeTotalDistance();
    //changeTotalTime();
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => StartRun()));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.grey[850],
        ),
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
                        ElevatedButton( // temp button to get to friends page
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FriendsScreen()));
                          },
                          child: Text(
                            'GO TO FRIENDS PAGE (TEMP)'
                          ),
                        ),
                        ElevatedButton( // temp button to get to friends page
                          onPressed: () async {
                            int t = 0;
                            t = 701;
                            var ret = await GetAPI.searchUsers('adam1');
                            print(ret.body);


                          },
                          child: Text(
                              'search mm'
                          ),
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
