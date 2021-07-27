import 'dart:convert';

import 'package:fitness_app_development/pages/settings.dart';
import 'package:fitness_app_development/utilities/global_data.dart';
import 'package:fitness_app_development/utilities/get_api.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

//WORK IN PROGRESS

class ChangeName extends StatefulWidget {
  const ChangeName({Key? key}) : super(key: key);

  @override
  _ChangeNameState createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {

  final fnController = TextEditingController();
  final lnController = TextEditingController();

  @override
  void dispose(){ // dispose controller when page is disposed
    fnController.dispose();
    lnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Name'),
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
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.5, 1],
                      colors: [Colors.cyan, Colors.blueAccent.shade700])
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
                      'Fitness APP', style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 20)
                    ),
                    Text(
                      'Edit Name', style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 20)
                    ),
                    SizedBox(height: 200),


                    TextField(
                      controller: fnController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter First Name',
                          labelStyle: TextStyle(
                              color: Colors.blue[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 20)
                      ),
                    ),
                    SizedBox(height: 30.0),

                    TextField(
                      controller: lnController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Last Name',
                          labelStyle: TextStyle(
                              color: Colors.blue[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 20)
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {




                        String firstName = fnController.text;
                        String lastName = lnController.text;


                        if(GlobalData.firstName != null && GlobalData.lastName != null){
                          try{
                            var ret = await GetAPI.editUser(firstname: firstName, lastname: lastName);
                            var jsonObject = json.decode(ret.body);
                            if(ret.statusCode == 200){
                              GlobalData.firstName = firstName;
                              GlobalData.lastName = lastName;
                            }

                            print(jsonObject);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                          } catch(e)
                          {
                            print(e);
                          }
                        }





                      },
                      child: Text('Apply'),
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
