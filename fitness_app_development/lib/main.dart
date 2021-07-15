import 'package:fitness_app_development/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app_development/pages/login_page.dart';
import 'package:fitness_app_development/pages/register_page.dart';
import 'package:fitness_app_development/utilities/user_profile.dart';
import 'package:fitness_app_development/pages/settings.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Login(),
    '/register': (context) => Register(),
    '/user_profile': (context) => User(),
    '/settings' : (context) => Settings(),

  },

));

