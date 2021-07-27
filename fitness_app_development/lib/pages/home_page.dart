

import 'dart:io';

import 'package:fitness_app_development/pages/get_run_name.dart';
import 'package:fitness_app_development/pages/old_run.dart';
import 'package:fitness_app_development/pages/settings.dart';
import 'package:fitness_app_development/pages/user_profile.dart';
import 'package:fitness_app_development/pages/users_page.dart';
import 'package:fitness_app_development/utilities/personal_run_data.dart';
import 'package:fitness_app_development/utilities/pref_service.dart';
import 'package:fitness_app_development/utilities/results_runs.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app_development/utilities/global_data.dart';
import 'package:fitness_app_development/pages/friends.dart';
import 'package:image_picker/image_picker.dart';


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
  List<GetResults2> resultObjs = [];
  XFile? fileImg;

  @override
  void initState() {
    refreshImage();
    changeText();
    changeTotalRuns();
    changeTotalDistance();
    changeTotalTime();
    super.initState();
  }

  Future<void> refreshImage() async {
    String? imagePath = await PrefService.getProfileImage();
    if(imagePath != null){
      fileImg = XFile(imagePath);
      setState(() {});
    }
  }

  ImageProvider getImage(){
    if(fileImg == null){
      return AssetImage('assets/images/profile_picture.jpeg');
    }else{
      return FileImage(File(fileImg!.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.5, 1],
              colors: [Colors.cyan, Colors.blueAccent.shade700])
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
                            Center(
                              child: Text(

                                GlobalData.fullName,
                                style: TextStyle(
                                  fontSize: 70.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            IconButton(
                                icon: CircleAvatar( // can add link to users profile pictures for this
                                  backgroundImage: getImage(),
                                  radius: 40,
                                ),
                                iconSize: (MediaQuery.of(context).size.height) * .08,
                                onPressed: () {

                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => User()));


                                }
                            ),



                            /*IconButton(
                                icon: Icon(
                                  Icons.settings,
                                ),
                                iconSize: (MediaQuery.of(context).size.height) * .08,

                                onPressed: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Settings()));
                                }
                            ),*/

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
                                itemCount: GlobalData.resultObjs.length,
                                itemBuilder: (context, index){
                                  return Card(
                                    child: ListTile(
                                      onTap: () {
                                          RunData.index = index;
                                          print(index);

                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OldRun()));

                                      },
                                       tileColor: Colors.lightBlueAccent.shade700,
                                      minVerticalPadding: (MediaQuery.of(context).size.height) * .025,
                                      title: Text('${GlobalData.resultObjs[index].runName}           ${GlobalData.resultObjs[index].dateCreated}',style: const TextStyle(
                                        fontSize: 20.7,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      //leading: Text((index+1).toString(),style: const TextStyle(
                                       // fontSize: 30.0,
                                       // fontWeight: FontWeight.bold,
                                     // ),),
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
                                        print('${GlobalData.resultObjs[0].coordinates[0][0]},${GlobalData.resultObjs[0].coordinates[0][1]}');
                                        print('${GlobalData.resultObjs[0].coordinates[3][0]},${GlobalData.resultObjs[0].coordinates[3][1]}');
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
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GetRunName()));
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
