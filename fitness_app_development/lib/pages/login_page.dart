
import 'package:fitness_app_development/utilities/get_api.dart';
import 'package:fitness_app_development/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app_development/pages/home_page.dart';
import 'dart:convert';
import 'package:fitness_app_development/utilities/global_data.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../main.dart';
import 'pass_reset/forgot_password.dart';


class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final myController1 = TextEditingController();  // controller for username textfield
  final myController2 = TextEditingController(); // controller for password textfield

  String message = '', newMessageText = '';
  String loginName = '', password = '';
  String firstName = '', lastName = '';





  late Map<String, dynamic> decodedToken; // use to decode jwt token from api

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose(){
    myController1.dispose(); // dispose controller when page is disposed
    myController2.dispose();
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
                padding: EdgeInsets.symmetric(vertical: (MediaQuery.of(context).size.height) * .2, horizontal: (MediaQuery.of(context).size.width) * .1),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'My Fitness App',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    SizedBox(height: 50.0),
                    TextField( // username field
                      controller: myController1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'username',

                      ),
                    ),

                    SizedBox(height: 15.0),
                    TextField( // password field
                      controller: myController2,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'password',

                      ),
                    ),
                    TextButton( // forgot password button
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Forgot()));
                      },
                      child: Text(
                          'Forgot Password',
                      ),
                    ),
                    SizedBox(height: 20.0), //spacer
                    Row(
                      children: [
                        ElevatedButton( // login button

                          onPressed: () async {

                            loginName = myController1.text; // loginName = username textfield
                            password = myController2.text; // password = password textfield

                            newMessageText = "";
                            changeText();
                            String payload = '{"login":"' + loginName.trim() + '","password":"' + password.trim() + '"}';  // login + password to be sent to api


                            print(payload);

                            var jsonObject;


                            try
                            {
                              var ret = await GetAPI.login(loginName, password);
                              jsonObject = json.decode(ret);
                              print(ret);
                              var accessToken = jsonObject["token"];
                              var jwt = accessToken["accessToken"];
                              await storage.write(key: "jwt", value: jwt);

                              decodedToken = JwtDecoder.decode(ret);
                              GlobalData.userId = decodedToken["userId"];
                              GlobalData.firstName = decodedToken["firstName"];
                              GlobalData.lastName = decodedToken["lastName"];
                              firstName = GlobalData.firstName!;
                              lastName = GlobalData.lastName!;

                              getFullName(firstName, lastName);
                              GlobalData.userName = loginName;


                            }catch(e)
                            {
                              print(e);
                              newMessageText = "Incorrect Login/Password";
                              changeText();
                              return;
                            }

                              try {
                                myController1.clear();
                                myController2.clear();
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));

                              }catch(e) {
                                print(e);
                              }

                            },
                          child: Text('Login'),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton( //register button

                          onPressed: () {
                            try {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Register()));
                            }catch(e){
                              print(e);
                            }

                          },
                          child: Text('Register'),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('$message',style: TextStyle(fontSize: 14 ,color:Colors.black)),
                      ],
                    )


                  ],
                ),
              ),

            ),
          ],
        )

    );
  }
  changeText() {
    setState(() {
      message = newMessageText;
    });
  }
  void getFullName (String firstName, String lastName) {
    GlobalData.fullName = firstName + lastName;

  }


}


