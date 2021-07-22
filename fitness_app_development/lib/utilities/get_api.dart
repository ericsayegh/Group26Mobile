
import '../main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;




class GetAPI{


  static Future<String> login(String login, String password) async {
    String outgoing = '{"login":"' + login.trim() + '","password":"' + password.trim() + '"}';
    var res = await http.post(
        Uri.parse('$SERVER_IP/login'),
        body: utf8.encode(outgoing),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },

        encoding: Encoding.getByName("utf-8")
    );
    if(res.statusCode == 200) return res.body;
    return 'null';
  }


  // in: email, firstname, lastname, login, password
  // out: 'error' or 'all good'
  static Future<int> register(String email, String firstname, String lastname, String login, String password) async {
    var res = await http.post(
        Uri.parse('$SERVER_IP/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': '$email',
          'firstname': '$firstname',
          'lastname': '$lastname',
          'login': '$login',
          'password': '$password'})

    );
    return res.statusCode;
  }



  // not working
  static Future<void> verify (int userId, String pin) async {
    var res = await http.post(
        Uri.parse('$SERVER_IP/verifyuser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId': '$userId',
          'text': '$pin',
          })

    );
  }


  // in: userId, search or -1, search
  static Future<http.Response> searchUsers(String search) async {
    var jwt = await storage.read(key: "jwt");
    var res;

      res = await http.post(
          Uri.parse('$SERVER_IP/searchusers'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'search' : '$search',
            'jwtToken' : '$jwt',
          })
      );

    if(res.statusCode == 200){
      print(res.statusCode);
      return res;

    }
    return res;
  }

}



