

import 'package:fitness_app_development/pages/pass_reset/forgot_password.dart';
import 'package:fitness_app_development/pages/friends.dart';
import 'package:fitness_app_development/pages/home_page.dart';
import 'package:fitness_app_development/pages/run_sequence/run_completed.dart';
import 'package:fitness_app_development/pages/run_sequence/run_in_progress.dart';
import 'package:fitness_app_development/pages/run_sequence/start_run.dart';
import 'package:fitness_app_development/pages/settings.dart';
import 'package:fitness_app_development/pages/verify_user.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app_development/pages/login_page.dart';
import 'package:fitness_app_development/pages/register_page.dart';
import 'package:fitness_app_development/pages/user_profile.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


const SERVER_IP = 'http://cop4331-2021.herokuapp.com/api';
final storage = FlutterSecureStorage();




void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Login(),
    '/register': (context) => Register(),
    '/user_profile': (context) => User(),
    '/settings' : (context) => Settings(),
    '/forgot_password' : (context) => Forgot(),
    '/start_run' : (context) => StartRun(),
    '/pause_run' : (context) => RunInProgress(),
    '/run_completed' : (context) => Completed(),
    '/home_page' : (context) => Home(),
    '/friends_page' : (context) => FriendsScreen(),
    '/verify_user' : (context) => Verify(),
  },

));

