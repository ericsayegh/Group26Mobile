import 'package:flutter/material.dart';

import '../../main.dart';

//WORK IN PROGRESS

class Forgot3 extends StatefulWidget {
  const Forgot3({Key? key}) : super(key: key);

  @override
  _Forgot3State createState() => _Forgot3State();
}

class _Forgot3State extends State<Forgot3> {
  final passController = TextEditingController();

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
                      'Please enter your new password',
                      style: TextStyle(

                      ),
                    ),
                    TextField(
                      controller: passController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async { // connect to the reset password api or whatever here
                        String passkey = passController.text;
                        //await storage.write(key: "pass", value: '$passkey');
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePass()));
                      },
                      child: Text('Submit'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).popUntil((route) => route.isFirst);
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
