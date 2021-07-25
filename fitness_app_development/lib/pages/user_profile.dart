import 'dart:convert';
import 'package:fitness_app_development/main.dart';
import 'package:fitness_app_development/pages/run_sequence/start_run.dart';
import 'package:fitness_app_development/pages/search_user.dart';
import 'package:fitness_app_development/pages/settings.dart';
import 'package:fitness_app_development/utilities/global_data.dart';
import 'package:fitness_app_development/utilities/get_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'friends.dart';
import 'home_page.dart';

class User extends StatefulWidget {

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {

  int fitnessLevel = 0;
  String username = '';
  int runCompleted = 0;
  String email = 'placeholder@gmail.com';


  @override
  void initState() {
    changeUsername();
    changeFitnessLevel();
    changeRunsCompleted();
    changeEmail();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('MyFitnessApp'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));

          },
          icon: Icon(Icons.arrow_back, color: Colors.orange),
        ),
      ),

      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Center(
                  child: CircleAvatar(// can add link to users profile pictures for this
                    backgroundImage: NetworkImage(// PLACEHOLDER //
                        'https://post.greatist.com/wp-content/uploads/2020/01/Runner-training-on-running-track-732x549-thumbnail.jpg'),
                    radius: (MediaQuery.of(context).size.width) * .2,
                  ),
                ),
                Divider(
                  height: (MediaQuery.of(context).size.height) * .08,
                  color: Colors.grey[800],


                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
                    },
                    child: Text("Edit User")
                ),
                SizedBox(height: 10),
                
                Text(
                    'USERNAME',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                    )
                ),

                Text(
                    '$username',
                    style: TextStyle(
                        color: Colors.amberAccent[200],
                        letterSpacing: 2.0,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold

                    )
                ),
                SizedBox(height: 30),
                Text(
                    'Fitness Level',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                    )
                ),
                SizedBox(height: 10),
                Text(
                    '$fitnessLevel',
                    style: TextStyle(
                        color: Colors.amberAccent[200],
                        letterSpacing: 2.0,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold

                    )
                ),
                SizedBox(height: 30),

                Text(
                    'Runs Completed',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                    )
                ),
                SizedBox(height: 10),
                Text(
                    '$runCompleted',
                    style: TextStyle(
                        color: Colors.amberAccent[200],
                        letterSpacing: 2.0,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold

                    )
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.grey[400],
                    ),
                    SizedBox(width: 10.0),
                    Text(
                        '$email',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 18,
                          letterSpacing: 1.0,
                        )
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.grey[400],
                    ),
                    SizedBox(width: 10.0),
                    Text(
                        '954-954-9544',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 18,
                          letterSpacing: 1.0,
                        )
                    ),
                  ],
                )


              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment:  FractionalOffset.bottomCenter,
              child: SizedBox(
                height: (MediaQuery.of(context).size.height) * .077,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                        },
                        icon: Icon(Icons.home),
                        iconSize: (MediaQuery.of(context).size.height) * .06,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchUser()));
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
                ),


              ),
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

    int userId = 0;
    int index = 0;
    userId = GlobalData.userId!;
    String search = '';
    search = GlobalData.fullName!;


    var ret = await GetAPI.searchUsers(search);


    var jsonObject = json.decode(ret.body);
    //List<dynamic> obj = jsonObject != null ? List.from(jsonObject) : null;
    print(jsonObject);
    //List<dynamic> jsonList =
    //var resultsArray = jsonObject["results_array"];

    //print(jsonObject);
    //print(jsonObject["results_array"]);
    //print(resultsArray[0]);
    //print(resultsArray["Email"]);
   // Map<dynamic, String> results = resultsArray;
   // print(results);
    /*
    var userIdArray = jsonObject["userId"];
    var emailArray = jsonObject["email"];
    var refreshedJwt = jsonObject["jwtToken"];
    await storage.delete(key: "jwt");
    await storage.write(key: "jwt", value: '$refreshedJwt');
    var test = await storage.read(key: "jwt");
    print(test);

    for(int i=0; i < userIdArray.length; i++){
      if(userIdArray[i] == userId){
        index = i;
      }
    }

     */
   // GlobalData.email = emailArray[index];

    //setState(() {
     // email = emailArray[index];
    //});
  }

}

