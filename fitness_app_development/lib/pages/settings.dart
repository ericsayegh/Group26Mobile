import 'package:flutter/material.dart';

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        child: ElevatedButton(
          child: Text('LOGOUT'),
          onPressed: (){
            Navigator.of(context).popUntil((route) => route.isFirst);
          },


        ),
      ),
    );
  }
}
