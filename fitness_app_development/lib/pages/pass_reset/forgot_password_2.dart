
import 'package:fitness_app_development/pages/login_page.dart';
import 'package:fitness_app_development/utilities/get_api.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

//WORK IN PROGRESS

class Forgot2 extends StatefulWidget {

  @override
  _Forgot2State createState() => _Forgot2State();
}

class _Forgot2State extends State<Forgot2> {

  final keyController = TextEditingController();
  final passController = TextEditingController();
  String email = '';

  void changeEmail(){
    setState(() async {
      email = (await storage.read(key: "email"))!;
    });
  }


  @override
  void dispose(){ // dispose controller when page is disposed
    keyController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  void initState() {

    super.initState();
    //changeEmail();
    //print(email);
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
                      'Please enter the key that was sent to $email',
                      style: TextStyle(

                      ),
                    ),
                    TextField(
                      controller: keyController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Key',
                      ),
                    ),
                    Text(
                      'Please enter new password',
                      style: TextStyle(

                      ),
                    ),
                    TextField(
                      controller: passController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'password',
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async { // connect to the reset password api or whatever here
                        String passkey = keyController.text;
                        String pass = passController.text;
                        var ret = GetAPI.passwordreset(passkey, pass);
                        print(ret);
                        Navigator.of(context).popUntil((route) => route.isFirst);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text('Submit'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).popUntil((route) => route.isFirst);
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
