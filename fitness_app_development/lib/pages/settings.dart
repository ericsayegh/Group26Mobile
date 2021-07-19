import 'package:fitness_app_development/pages/change_email.dart';
import 'package:fitness_app_development/pages/change_name.dart';
import 'package:fitness_app_development/pages/change_pass.dart';
import 'package:fitness_app_development/pages/forgot_password.dart';
import 'package:fitness_app_development/services/global_data.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app_development/services/global_data.dart';
import 'package:fitness_app_development/services/get_api.dart';

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
        title: Text('Settings'),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeEmail()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.portrait),
                    title: Text('Change Username'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeName()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.lock_outline),
                    title: Text('Change Password'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePass()));
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(
              child: Text('LOGOUT'),
              onPressed: (){

                Navigator.of(context).popUntil((route) => route.isFirst);
              },


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
