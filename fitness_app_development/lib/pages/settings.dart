import 'dart:convert';

import 'package:fitness_app_development/pages/change_email.dart';
import 'package:fitness_app_development/pages/change_name.dart';
import 'package:fitness_app_development/pages/change_pass.dart';
import 'package:fitness_app_development/pages/change_username.dart';
import 'package:fitness_app_development/pages/login_page.dart';
import 'package:fitness_app_development/utilities/get_api.dart';
import 'package:fitness_app_development/utilities/global_data.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String username = '';


  @override
  void initState() {
    changeUser();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Password'),
        leading: new IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
          },
          icon: new Icon(Icons.arrow_back, color: Colors.orange),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.0),
            Center(
              child: CircleAvatar(// can add link to users profile pictures for this
                backgroundImage: NetworkImage(// PLACEHOLDER //
                    'https://post.greatist.com/wp-content/uploads/2020/01/Runner-training-on-running-track-732x549-thumbnail.jpg'),
                radius: 40.0,
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {

                },
                child: Text("Change Profile Picture"),
              ),
            ),

            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.mail),
                    title: Text('Change Email'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChangeEmail()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.portrait),
                    title: Text('Change Name'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChangeName()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.portrait),
                    title: Text('Change Username'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChangeUserName()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.lock),
                    title: Text('Change Password'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChangePass()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    //tileColor: ,
                    title: Text('Log out'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () async {
                      GlobalData.userId = -1;
                      GlobalData.userName = '';
                      GlobalData.firstName = '';
                      GlobalData.lastName = '';
                      GlobalData.email = '';
                      GlobalData.totalDistance = 0;
                      GlobalData.totalTime = 0;
                      GlobalData.fullName = '';
                      GlobalData.totalRuns = 0;
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.clear),
                    tileColor: Colors.red,
                    title: Text('Delete User'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () async {
                      var ret = await GetAPI.deleteUsers();
                      GlobalData.userId = -1;
                      GlobalData.userName = '';
                      GlobalData.firstName = '';
                      GlobalData.lastName = '';
                      GlobalData.email = '';
                      GlobalData.totalDistance = 0;
                      GlobalData.totalTime = 0;
                      GlobalData.fullName = '';
                      GlobalData.totalRuns = 0;
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                      //var jsonObject = json.decode(ret.body);
                      //print(jsonObject);
                    },
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
  changeUser(){
    setState(() {
      username = GlobalData.firstName!; // need to change to full name
    });
  }

}
