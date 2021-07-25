import 'dart:convert';

import 'package:fitness_app_development/pages/settings.dart';
import 'package:fitness_app_development/utilities/global_data.dart';
import 'package:fitness_app_development/utilities/get_api.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class ChangeUserName extends StatefulWidget {
  const ChangeUserName({Key? key}) : super(key: key);

  @override
  _ChangeUserNameState createState() => _ChangeUserNameState();
}

class _ChangeUserNameState extends State<ChangeUserName> {
  final userController = TextEditingController();
  @override
  void dispose(){ // dispose controller when page is disposed
   userController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Username'),
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
                      'Edit Username',
                      style: TextStyle(

                      ),
                    ),
                    SizedBox(height: 200),

                    Text(
                      'Enter New Username',
                      style: TextStyle(

                      ),
                    ),
                    TextField(
                      controller:userController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async { // connect to the reset email api or whatever here

                        String username = userController.text;


                        try{
                          var ret = await GetAPI.editUser(username: username);
                          GlobalData.userName = username;
                          var jsonObject = json.decode(ret.body);
                          print(jsonObject);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                        } catch(e)
                        {
                          print(e);
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
