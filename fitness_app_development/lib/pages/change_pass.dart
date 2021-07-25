import 'package:fitness_app_development/pages/settings.dart';
import 'package:fitness_app_development/utilities/get_api.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';


////WORK IN PROGRESS

class ChangePass extends StatefulWidget {
  const ChangePass({Key? key}) : super(key: key);

  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();


  @override
  void dispose(){ // dispose controller when page is disposed
    oldPassController.dispose();
    newPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Password'),
          leading: new IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Settings()));
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
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.blue,
                    width: 8,
                  )
              ),
            ),
            Container(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Fitness APP',
                      style: TextStyle(

                      ),
                    ),
                    Text(
                      'Edit Password',
                      style: TextStyle(

                      ),
                    ),
                    SizedBox(height: 200),

                    TextField(
                      controller: oldPassController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Old Password',
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: newPassController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'New Password',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async { // connect to the reset email api or whatever here
                        String oldPass = oldPassController.text;
                        String newPass = newPassController.text;
                        if(oldPass != "" && newPass != ""){
                          await GetAPI.editPassword(oldPass, newPass);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                        }
                      },
                      child: Text('Change'),
                    ),

                  ],
                ),
              ),

            ),
          ],
        )
    );
  }
}
