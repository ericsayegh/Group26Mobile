import 'package:fitness_app_development/pages/run_sequence/start_run.dart';
import 'package:fitness_app_development/pages/search_user.dart';
import 'package:fitness_app_development/pages/settings.dart';
import 'package:fitness_app_development/pages/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app_development/utilities/global_data.dart';
import 'package:fitness_app_development/utilities/get_api.dart';
import 'package:fitness_app_development/pages/friends.dart';


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

  List<String> runs = [
    "run to the moon",
    "run to the sun",
    "dont run?",
    "something about running",
    "run to the moon",
    "run to the sun",
    "dont run?",
    "something about running",
    "run to the moon",
    "run to the sun",
    "dont run?",
    "something about running",
    "run to the moon",
    "run to the sun",
    "dont run?",
    "something about running",
    "run to the moon",
    "run to the sun",
    "dont run?",
    "something about running",
    "run to the moon",
    "run to the sun",
    "dont run?",
    "something about running",
    "run to the moon",
    "run to the sun",
    "dont run?",
    "something about running",

  ];


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
                                iconSize: (MediaQuery.of(context).size.height) * .05,
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
                                ),
                                iconSize: (MediaQuery.of(context).size.height) * .05,

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
                              height: (MediaQuery.of(context).size.height) * .09,
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
                              height: (MediaQuery.of(context).size.height) * .09,
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
                        FractionallySizedBox(
                          alignment: Alignment.topCenter,
                          widthFactor: 0.99,
                          child: Container(
                            height: (MediaQuery.of(context).size.height) * .7,
                            child: ListView.builder(
                                itemCount: runs.length,
                                itemBuilder: (context, index){
                                  return Card(
                                    child: ListTile(
                                      onTap: () {

                                      },
                                      title: Text(runs[index]),
                                      leading: Text('$index'),
                                      trailing: Icon(Icons.arrow_forward_ios),


                                    ),
                                  );

                                }
                            ),


                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment:  FractionalOffset.bottomCenter,
                            child: SizedBox(
                              height: (MediaQuery.of(context).size.height) * .077,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue[200],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).popUntil((route) => route.isFirst);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                                      },
                                      icon: Icon(Icons.home),
                                      iconSize: (MediaQuery.of(context).size.height) * .06,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).popUntil((route) => route.isFirst);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchUser()));
                                      },
                                      icon: Icon(Icons.search),
                                      iconSize: (MediaQuery.of(context).size.height) * .06,

                                    ),
                                    FloatingActionButton(
                                      onPressed: () {
                                        Navigator.of(context).popUntil((route) => route.isFirst);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => StartRun()));
                                      },
                                      child: Icon(Icons.add),
                                      backgroundColor: Colors.green,
                                      elevation: 10,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).popUntil((route) => route.isFirst);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => FriendsScreen()));
                                      },
                                      icon: Icon(Icons.contact_page_rounded),
                                      iconSize: (MediaQuery.of(context).size.height) * .06,

                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).popUntil((route) => route.isFirst);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => User()));
                                      },
                                      icon: Icon(Icons.portrait_rounded),
                                      iconSize: (MediaQuery.of(context).size.height) * .06,

                                    ),

                                  ],
                                ),
                              ),


                            ),
                          ),
                        )







                      ],
                    ),
                  ],
                ))),

      ),

    );


  }
  void changeText() {
    setState(() {
      userName = GlobalData.userName!;
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
