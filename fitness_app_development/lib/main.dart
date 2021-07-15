import 'package:flutter/material.dart';
import 'package:fitness_app_development/pages/login_page.dart';
import 'package:fitness_app_development/pages/register_page.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Login(),
    '/register': (context) => Register(),
  },

));

