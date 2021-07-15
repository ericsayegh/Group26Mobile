import 'dart:convert';

import 'package:fitness_app_development/services/get_api.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passController = TextEditingController();
  final fnController = TextEditingController();
  final lnController = TextEditingController();

  String email = '';
  String username = '';
  String password = '';
  String firstName = '';
  String lastName = '';



  late Map<String, dynamic> decodedToken;


  @override
  void dispose(){
    emailController.dispose();
    userNameController.dispose();
    passController.dispose();
    fnController.dispose();
    lnController.dispose();
    super.dispose();
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
                      'Register',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),

                    SizedBox(height: 30.0),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(height: 15.0),
                    TextField(
                      controller: userNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',

                      ),
                    ),

                    SizedBox(height: 15.0),
                    TextField(
                      controller: passController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                    SizedBox(height: 15.0),
                    TextField(
                      controller: fnController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First Name',
                      ),
                    ),
                    SizedBox(height: 15.0),
                    TextField(
                      controller: lnController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Last Name',
                      ),
                    ),
                    SizedBox(height: 15.0),

                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        ElevatedButton(

                          onPressed: () async {

                            email = emailController.text;
                            username = userNameController.text;
                            password = passController.text;
                            firstName = fnController.text;
                            lastName = lnController.text;
                            var jsonObject;

                            String payload = '{"email":"' + email.trim() + '","firstname":"'
                                            + firstName.trim() + '","lastname":"' + lastName.trim()
                                            + '","login":"' + username.trim()
                                            + '","password":"' + password.trim() + '"}';

                            try{
                            String url = 'http://cop4331-2021.herokuapp.com/api/register';
                            String ret = await CardsData.getJson(url, payload);

                            }
                            catch(e){
                              print(e);
                              return;
                            }



                            try {
                              Navigator.pop(context);
                            }catch(e){
                              print(e);
                            }

                          },
                          child: Text('Register'),
                        ),
                        TextButton(

                          onPressed: () {
                            /*showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(myController1.text),
                                );
                              },
                            );*/
                            try {
                              Navigator.pop(context);
                            }catch(e){
                              print(e);
                            }

                          },
                          child: Text('Cancel'),
                        ),
                      ],
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
