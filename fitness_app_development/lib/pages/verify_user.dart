import 'dart:convert';

import 'package:fitness_app_development/services/global_data.dart';
import 'package:fitness_app_development/utilities/get_api.dart';
import 'package:flutter/material.dart';

//NOT WORKING/////////////////////////////////////////////////////////////



class Verify extends StatefulWidget {


  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {



  final myController1 = TextEditingController();
  String email = '';
  int userId = -1;



  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage('https://www.verywellfit.com/thmb/LeBe7RNtzbJwyKRmH8ditmJ1NKg=/1500x1020/filters:no_upscale():max_bytes(150000):strip_icc()/Snapwire-Running-27-66babd0b2be44d9595f99d03fd5827fd.jpg'),
                    fit: BoxFit.cover,
                  ),
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
                      'Verify User',
                      style: TextStyle(

                      ),
                    ),
                    SizedBox(height: 200),

                    Text(
                      'Please enter the pin code that was sent to email@email.com',
                      style: TextStyle(

                      ),
                    ),
                    TextField(
                      controller: myController1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'PIN',
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async { // connect to the reset password api or whatever here

                        String pin = myController1.text;
                        changeUserId();
                        GetAPI.verify(userId, pin);
                      },
                      child: Text('Enter'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),

                  ],
                ),
              ),

            ),
          ],
        )
    );

  }


  Future<void> changeUserId() async {

    int index = 0;
    email = GlobalData.email!;


    var ret = await GetAPI.searchUsers(email);
    var jsonObject = json.decode(ret.body);

    var userIdArray = jsonObject["userId"];
    print(userIdArray);
    var emailArray = jsonObject["email"];

    for(int i=0; i < userIdArray.length; i++){
      if(emailArray[i] == email){
        index = i;
      }
    }


    setState(() {
      userId = userIdArray[index];
      GlobalData.userId = userId;
    });
  }

}
