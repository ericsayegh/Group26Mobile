import 'dart:convert';

import 'package:fitness_app_development/services/global_data.dart';
import 'package:fitness_app_development/utilities/get_api.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Name'),
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
                      'Edit Name',
                      style: TextStyle(

                      ),
                    ),
                    SizedBox(height: 200),

                    Text(
                      'Enter First Name',
                      style: TextStyle(

                      ),
                    ),
                    TextField(
                      //controller: ,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First Name',
                      ),
                    ),
                    Text(
                      'Enter Last Name',
                      style: TextStyle(

                      ),
                    ),
                    TextField(
                      //controller: ,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Last Name',
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {




                        String firstName = fnController.text;
                        String lastName = lnController.text;
                        GlobalData.firstName = firstName;
                        GlobalData.lastName = lastName;


                        try{
                          var ret = await GetAPI.editUser();
                          var jsonObject = json.decode(ret.body);
                          print(jsonObject);
                        } catch(e)
                        {
                          print(e);
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
