

import 'package:fitness_app_development/pages/change_email.dart';
import 'package:fitness_app_development/pages/change_name.dart';
import 'package:fitness_app_development/pages/change_pass.dart';
import 'package:fitness_app_development/pages/change_username.dart';
import 'package:fitness_app_development/pages/login_page.dart';
import 'package:fitness_app_development/pages/user_profile.dart';
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
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => User()));
          },
          icon: new Icon(Icons.arrow_back, color: Colors.orange),
        ),
      ),
      body: Stack(
        children: [

          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.5, 1],
                    colors: [Colors.cyan, Colors.blueAccent.shade700])
            ),
          ),

          SingleChildScrollView(
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
                  child: Text("Change Profile Picture", style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
                ),
              ),

              Card(
                color: Colors.blueAccent,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.mail, color: Colors.white),
                      title: Text('Change Email', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white),
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChangeEmail()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.portrait, color: Colors.white),
                      title: Text('Change Name', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white),
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChangeName()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.portrait, color: Colors.white),
                      title: Text('Change Username', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white),
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChangeUserName()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.lock, color: Colors.white),
                      title: Text('Change Password', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white),
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChangePass()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.white),
                      //tileColor: ,
                      title: Text('Log out', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white),
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
                      leading: Icon(Icons.clear, color: Colors.white),
                      tileColor: Colors.red,
                      title: Text('Delete User', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white),
                      onTap: () async {
                        await GetAPI.deleteUsers();
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
        ],
      ),
    );
  }
  changeUser(){
    setState(() {
      username = GlobalData.firstName!; // need to change to full name
    });
  }

}
