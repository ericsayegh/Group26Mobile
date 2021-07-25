
import 'package:fitness_app_development/pages/login_page.dart';
import 'package:fitness_app_development/pages/pass_reset/forgot_password_2.dart';
import 'package:fitness_app_development/utilities/get_api.dart';
import 'package:flutter/material.dart';


//WORK IN PROGRESS

class Forgot extends StatefulWidget {

  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final emailController = TextEditingController();

  @override
  void dispose(){ // dispose controller when page is disposed
    emailController.dispose();
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
                      'Fitness APP',
                      style: TextStyle(

                      ),
                    ),
                    Text(
                      'Password Recovery',
                      style: TextStyle(

                      ),
                    ),
                    SizedBox(height: 200),

                    Text(
                      'Please enter the email associated with your account',
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
                      onPressed: () async { // connect to the reset password api or whatever here
                        String email = emailController.text;
                        GetAPI.sendPasswordEmail(email);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Forgot2()));
                      },
                      child: Text('Reset'),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
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
}
