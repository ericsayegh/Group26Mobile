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
    print(GlobalData.totalDistance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: LayoutBuilder(
              builder: (context, constraints) => Stack(
                    fit: StackFit.expand,
                    children: [
                      Material(color: Colors.blue[100]),
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.portrait,
                                  size: 50,
                                ),
                                onPressed: () {}
                              ),


                              Text(
                                userName,
                                style: TextStyle(
                                  fontSize: 38.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.settings,
                                    size: 50,
                                  ),
                                  onPressed: () {}
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
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.grey[450],
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.search),
                title: new Text('Search'),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('Profile')
              )
            ]
        )
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
