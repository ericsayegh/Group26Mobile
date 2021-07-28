import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:flutter_gravatar/utils.dart';

class ProfilePage extends StatefulWidget {
  final String? userName;
  final String? userEmail;
  final num? totalRun;

  ProfilePage(
      {@required this.userName,
        @required this.userEmail,
        @required this.totalRun});

  _UserState createState() => _UserState();
}

class _UserState extends State<ProfilePage> {
  String? _email;
  Gravatar? _gravatar;

  @override
  void initState() {
    /// default values to use in displaying
    _email = widget.userEmail;
    _gravatar = Gravatar(_email!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('User Profile'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_gravatar != null)
              Container(
                child: Column(
                  children: [
                    //TODO: Resize photo for gravatar

                    Image.network(_gravatar!.imageUrl(size: 150)),
                  ],
                ),
              ),
            Divider(
              height: 60.0,
              color: Colors.grey[800],
            ),
            Text('USERNAME',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                )),
            SizedBox(height: 10),
            Text('${widget.userName}',
                style: TextStyle(
                    color: Colors.amberAccent[200],
                    letterSpacing: 2.0,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            Text('Fitness Level',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                )),
            SizedBox(height: 10),
            Text('3',
                style: TextStyle(
                    color: Colors.amberAccent[200],
                    letterSpacing: 2.0,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            Text('Runs Completed',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                )),
            SizedBox(height: 10),
            Text('${widget.totalRun}',
                style: TextStyle(
                    color: Colors.amberAccent[200],
                    letterSpacing: 2.0,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            Row(
              children: [
                Icon(
                  Icons.email,
                  color: Colors.grey[400],
                ),
                SizedBox(width: 10.0),
                Text('${widget.userEmail}',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 18,
                      letterSpacing: 1.0,
                    )),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
