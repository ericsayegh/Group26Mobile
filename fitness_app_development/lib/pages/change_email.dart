import 'dart:convert';

import 'package:fitness_app_development/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app_development/utilities/global_data.dart';
import 'package:fitness_app_development/utilities/get_api.dart';


//WORK IN PROGRESS

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({Key? key}) : super(key: key);

  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  final emailController = TextEditingController();
  @override
  void dispose(){ // dispose controller when page is disposed
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Email'),
          leading: new IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
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
                      'Edit Email',
                      style: TextStyle(

                      ),
                    ),
                    SizedBox(height: 200),

                    Text(
                      'Enter New Email',
                      style: TextStyle(

                      ),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email Address',
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async { // connect to the reset email api or whatever here

                        String email = emailController.text;
                        GlobalData.email = email;

                        try{
                          var ret = await GetAPI.editUser(email: email);
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
