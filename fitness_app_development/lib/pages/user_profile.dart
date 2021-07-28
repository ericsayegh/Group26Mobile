
import 'dart:io';

import 'package:fitness_app_development/pages/home_page/home_screen.dart';
import 'package:fitness_app_development/pages/run_sequence/start_run.dart';
import 'package:fitness_app_development/pages/settings.dart';
import 'package:fitness_app_development/pages/users_page.dart';
import 'package:fitness_app_development/utilities/global_data.dart';
import 'package:fitness_app_development/utilities/get_api.dart';
import 'package:fitness_app_development/utilities/pref_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'friends.dart';
import 'home_page2.dart';

class User extends StatefulWidget {

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {

  int fitnessLevel = 0;
  String username = '';
  int runCompleted = 0;
  String email = 'placeholder@gmail.com';
  XFile? fileImg;


  @override
  void initState() {
    refreshImage();
    changeUsername();
    changeFitnessLevel();
    changeRunsCompleted();
    changeEmail();

    super.initState();
  }

  Future<void> refreshImage() async {
    String? imagePath = await PrefService.getProfileImage();
    if(imagePath != null){
      fileImg = XFile(imagePath);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        title: Text('MyFitnessApp',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));

          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Center(
                    child: CircleAvatar(
                      backgroundImage: getImage(),
                      radius: (MediaQuery.of(context).size.width) * .2,
                    ),
                  ),
                  Divider(
                    height: 30,
                    color: Colors.grey[800],


                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
                        },
                        child: Text("Edit User")
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.only(left: 30,right: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Text(
                                'USERNAME',
                                style: TextStyle(
                                  color: Color(0xFF5B5B5B),
                                  letterSpacing: 2.0,
                                )
                            ),
                            Text(
                                '${GlobalData.userName}',
                                style: TextStyle(
                                    color: Color(0xFF4395A1),
                                    letterSpacing: 2.0,
                                    fontSize: 28.0,

                                )
                            ),
                            SizedBox(height: 30),
                            Text(
                                'Full Name',
                                style: TextStyle(
                                  color: Color(0xFF5B5B5B),
                                  letterSpacing: 2.0,
                                )
                            ),
                            Text(
                                '${GlobalData.fullName}',
                                style: TextStyle(
                                    color: Color(0xFF4395A1),
                                    letterSpacing: 2.0,
                                    fontSize: 28.0,

                                )
                            ),
                            SizedBox(height: 30),
                            Text(
                                'Total Runs',
                                style: TextStyle(
                                  color: Color(0xFF5B5B5B),
                                  letterSpacing: 2.0,
                                )
                            ),
                            SizedBox(height: 10),
                            Text(
                                '${GlobalData.totalRuns}',
                                style: TextStyle(
                                    color: Color(0xFF4395A1),
                                    letterSpacing: 2.0,
                                    fontSize: 28.0,

                                )
                            ),
                            SizedBox(height: 30),
                            Text(
                                'Total Distance',
                                style: TextStyle(
                                  color: Color(0xFF5B5B5B),
                                  letterSpacing: 2.0,
                                )
                            ),
                            SizedBox(height: 10),
                            Text(
                                '${GlobalData.totalDistance!.toStringAsFixed(4)}',
                                style: TextStyle(
                                    color: Color(0xFF4395A1),
                                    letterSpacing: 2.0,
                                    fontSize: 28.0,

                                )
                            ),
                            SizedBox(height: 30),
                            Text(
                                'Total Time',
                                style: TextStyle(
                                  color: Color(0xFF5B5B5B),
                                  letterSpacing: 2.0,
                                )
                            ),
                            SizedBox(height: 10),
                            Text(
                                '${GlobalData.totalTime}',
                                style: TextStyle(
                                    color: Color(0xFF4395A1),
                                    letterSpacing: 2.0,
                                    fontSize: 28.0,

                                )
                            ),

                            SizedBox(height: 30),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.email,
                                  color: Color(0xFF5B5B5B),
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                    '${(GlobalData.email == '' ? "null" : "${GlobalData.email}")}',
                                    style: TextStyle(
                                      color: Color(0xFF4395A1),
                                      fontSize: 28,
                                      letterSpacing: 1.0,
                                    )
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height/15,
            decoration: BoxDecoration(
              color: Colors.blue[200],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
          )


        ],
      ),

    );
  }

  void changeUsername() {
    setState(() {
      username = GlobalData.firstName!;
    });
  }
  void changeFitnessLevel() {
    setState(() {
      fitnessLevel = 5;
    });
  }
  void changeRunsCompleted() {
    setState(() {
      runCompleted = 3;
    });
  }
  Future<void> changeEmail() async {

    String search = '';
    search = GlobalData.fullName;


    await GetAPI.searchUsers(search: search);



  }

  ImageProvider getImage(){
    if(fileImg == null){
      return AssetImage('assets/images/profile_picture.jpeg');
    }else{
      return FileImage(File(fileImg!.path));
    }
  }
}