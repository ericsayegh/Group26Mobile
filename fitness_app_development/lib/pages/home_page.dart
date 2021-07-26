import 'dart:convert';

import 'package:fitness_app_development/pages/run_sequence/start_run.dart';
import 'package:fitness_app_development/pages/search_user.dart';
import 'package:fitness_app_development/pages/settings.dart';
import 'package:fitness_app_development/pages/user_profile.dart';
import 'package:fitness_app_development/pages/users_page.dart';
import 'package:fitness_app_development/utilities/get_api.dart';
import 'package:fitness_app_development/utilities/results.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app_development/utilities/global_data.dart';
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
    getTotalData();
    changeTotalRuns();
    changeTotalDistance();
    changeTotalTime();
    super.initState();
  }

  Future<void> getTotalData() async {
    var ret = await GetAPI.searchUsers(GlobalData.firstName!);
    //print(ret.body);
    var results = json.decode(ret.body)['results'];
    print(results);


    var resultObjsJson = jsonDecode(ret.body)['results'] as List;
    List<GetResults> resultObjs = resultObjsJson.map((resultJson) => GetResults.fromJson(resultJson)).toList();


    GlobalData.totalDistance = resultObjs[0].TotalDistance;
    GlobalData.totalRuns = resultObjs[0].TotalRuns;
    GlobalData.totalTime = resultObjs[0].TotalTime;
    print(resultObjs[0]);




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
                                iconSize: (MediaQuery.of(context).size.height) * .08,
                                onPressed: () {

                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => User()));


                                }
                            ),

                            Center(
                              child: Text(

                                userName,
                                style: TextStyle(
                                  fontSize: 80.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            IconButton(
                                icon: Icon(
                                  Icons.settings,
                                ),
                                iconSize: (MediaQuery.of(context).size.height) * .08,

                                onPressed: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Settings()));
                                }
                            ),

                          ],
                        ),
                        Divider(
                          height: 21,
                          thickness: 5,
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text('Total Runs',style: const TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                                Text('$totalRuns',style: const TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ],
                            ),
                            Container(
                              height: (MediaQuery.of(context).size.height) * .09,
                              child: VerticalDivider(
                                width: 20,
                                thickness: 5,
                                color: Colors.black,
                              ),
                            ),
                            Column(
                              children: [
                                Text('Total Distance',style: const TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                                Text(totalDistance.toStringAsFixed(2),style: const TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ],
                            ),
                            Container(
                              height: (MediaQuery.of(context).size.height) * .09,
                              child: VerticalDivider(
                                width: 20,
                                thickness: 5,
                                color: Colors.black,
                              ),
                            ),
                            Column(
                              children: [
                                Text('Total Time',style: const TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                                Text('$totalTIme',style: const TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          height: 20,
                          thickness: 5,
                          color: Colors.black,
                        ),
                        FractionallySizedBox(
                          alignment: Alignment.topCenter,
                          widthFactor: 0.99,
                          child: Container(
                            height: (MediaQuery.of(context).size.height) * .67,
                            child: ListView.builder(
                                itemCount: runs.length,
                                itemBuilder: (context, index){
                                  return Card(
                                    child: ListTile(
                                      onTap: () {

                                      },
                                       tileColor: Colors.lightBlueAccent[200],
                                      minVerticalPadding: (MediaQuery.of(context).size.height) * .02,
                                      title: Text(runs[index],style: const TextStyle(
                                        fontSize: 40.0,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      leading: Text((index+1).toString(),style: const TextStyle(
                                        fontSize: 40.0,
                                        fontWeight: FontWeight.bold,
                                      ),),
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
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                                      },
                                      icon: Icon(Icons.home),
                                      iconSize: (MediaQuery.of(context).size.height) * .06,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UsersScreen()));
                                      },
                                      icon: Icon(Icons.search),
                                      iconSize: (MediaQuery.of(context).size.height) * .06,

                                    ),
                                    FloatingActionButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StartRun()));
                                      },
                                      child: Icon(Icons.add),
                                      backgroundColor: Colors.green,
                                      elevation: 10,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FriendsScreen()));
                                      },
                                      icon: Icon(Icons.contact_page_rounded),
                                      iconSize: (MediaQuery.of(context).size.height) * .06,

                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => User()));
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
