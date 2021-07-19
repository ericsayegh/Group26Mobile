import 'package:fitness_app_development/pages/forgot_password.dart';
import 'package:fitness_app_development/pages/friends.dart';
import 'package:fitness_app_development/pages/home_page.dart';
import 'package:fitness_app_development/pages/run_sequence/resume_end_run.dart';
import 'package:fitness_app_development/pages/run_sequence/run_completed.dart';
import 'package:fitness_app_development/pages/run_sequence/run_in_progress.dart';
import 'package:fitness_app_development/pages/run_sequence/start_run.dart';
import 'package:fitness_app_development/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app_development/pages/login_page.dart';
import 'package:fitness_app_development/pages/register_page.dart';
import 'package:fitness_app_development/pages/user_profile.dart';
import 'package:fitness_app_development/pages/settings.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Login(),
    '/register': (context) => Register(),
    '/user_profile': (context) => User(),
    '/settings' : (context) => Settings(),
    '/forgot_password' : (context) => Forgot(),
    '/start_run' : (context) => StartRun(),
    '/pause_run' : (context) => Pause(),
    '/resumeOrEnd' : (context) => ResumeOrEnd(),
    '/run_completed' : (context) => Completed(),
    '/home_page' : (context) => Home(),
    '/friends_page' : (context) => FriendsScreen(),
  },

));

