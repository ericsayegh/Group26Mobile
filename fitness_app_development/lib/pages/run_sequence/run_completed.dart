import 'package:flutter/material.dart';
import 'package:fitness_app_development/main.dart';
import '../home_page.dart';

class Completed extends StatefulWidget {

  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            Text('Run #'),
            SizedBox(height: 288),
            Divider(
              height: 20,
              thickness: 2,
              color: Colors.black,
            ),
            Text('Time'),
            Text('0:00'),
            SizedBox(height: 20),
            Divider(
              height: 20,
              thickness: 2,
              color: Colors.black,
            ),
            Text('Distance'),
            Text('0:00'),
            SizedBox(height: 20),
            Divider(
              height: 20,
              thickness: 2,
              color: Colors.black,
            ),
            Text('Pace'),
            Text('0:00'),
            SizedBox(height: 20),
            Divider(
              height: 20,
              thickness: 2,
              color: Colors.black,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // gotta be a better way to do this
                  Navigator.pop(context); // want to pop pages until home screen is reached
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                    'Return to home Page'
                )
            ),
            // need to add button to get to home page
            // pop all the way to home page??

          ],
        ),
      ),
    );
  }
}
