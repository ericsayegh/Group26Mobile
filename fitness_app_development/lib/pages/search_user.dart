import 'package:fitness_app_development/pages/run_sequence/start_run.dart';
import 'package:fitness_app_development/pages/user_profile.dart';
import 'package:flutter/material.dart';

import 'friends.dart';
import 'home_page.dart';

class SearchUser extends StatefulWidget {

  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {

  final myController1 = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    myController1.dispose();


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
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
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      TextField( // username field
                        controller: myController1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Search',

                        ),
                      ),




                    ],
                  ),
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
          )

      ),
    );

  }
}
