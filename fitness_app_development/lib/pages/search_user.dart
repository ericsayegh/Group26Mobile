import 'package:flutter/material.dart';

class SearchUser extends StatefulWidget {

  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {

  final myController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(

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
            ],
          )

      ),
    );

  }
}
