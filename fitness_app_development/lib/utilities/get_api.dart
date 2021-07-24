
import 'package:fitness_app_development/utilities/global_data.dart';

import '../main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;




class GetAPI{

  //WORKING
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

  // WORKING
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


  //WORKING
  static Future<http.Response> editUser({String firstname = '', String lastname = '', String email = '', String username = ''}) async {
    var jwt = await storage.read(key: "jwt");
    int userId = GlobalData.userId!;

    print("$userId $firstname  $lastname  $email");

    var res = await http.post(
        Uri.parse('$SERVER_IP/editUser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId': '$userId',
          'firstname': '$firstname',
          'lastname': '$lastname',
          'username' : '$username',
          'email': '$email',
          'jwtToken': '$jwt'})

    );
    if(res.statusCode == 200){
      return res;

    }
    return res;
  }

  static Future<http.Response> editPassword( String oldPass, String newPass) async {
    var jwt = await storage.read(key: "jwt");
    int userId = -1;
    userId = GlobalData.userId!;




    var res = await http.post(
        Uri.parse('$SERVER_IP/editPassword'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId' : '$userId',
          'existing_password': '$oldPass',
          'new_password': '$newPass',
          'jwtToken': '$jwt'})

    );
    if(res.statusCode == 200){
      return res;

    }
    return res;
  }



  //working
  static Future<void> verify (String pin) async {
    var res = await http.post(
        Uri.parse('$SERVER_IP/verifyuser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'text': '$pin',
          })

    );
  }

  //WORKING
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
  //working
  static Future<http.Response> deleteUsers() async {
    var jwt = await storage.read(key: "jwt");
    var res;
    int userId = -1;
    userId = GlobalData.userId!;
    res = await http.post(
        Uri.parse('$SERVER_IP/deleteuser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId' : '$userId',
          'jwtToken' : '$jwt',
        })
    );

    if(res.statusCode == 200){
      print(res.statusCode);
      return res;

    }
    return res;
  }


  //WORKING
  static Future<http.Response> sendPasswordEmail(String email) async {
    var res;

    res = await http.post(
        Uri.parse('$SERVER_IP/sendpasswordemail'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email' : '$email',
        })
    );

    if(res.statusCode == 200){
      print(res.statusCode);
      return res;

    }
    return res;
  }
  //NOT WORKING
  static Future<http.Response> passwordreset(String passkey, String pass) async {
    var res;

    res = await http.post(
        Uri.parse('$SERVER_IP/passwordreset'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'passkey' : '$passkey',
          'newPass' : '$pass',
        })
    );

    if(res.statusCode == 200){
      print(res.statusCode);
      return res;

    }
    return res;
  }

  static Future<http.Response> addRun(int runNumber) async { // need to grab refreshed jwt token
    var res;
    var jwt = await storage.read(key: "jwt");
    String run = 'Run $runNumber';
    int userId = GlobalData.userId!;
    res = await http.post(
        Uri.parse('$SERVER_IP/addrun'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId' : '$userId',
          'run' : '$run',
          'jwtToken' : '$jwt',
        })
    );

    if(res.statusCode == 200){
      print(res.statusCode);
      return res;

    }
    return res;
  }
  static Future<http.Response> deleteRun(int runNumber) async {
    var res;
    var jwt = await storage.read(key: "jwt");
    String run = 'Run $runNumber';

    res = await http.post(
        Uri.parse('$SERVER_IP/deleterun'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'run' : '$run',
          'jwtToken' : '$jwt',
        })
    );

    if(res.statusCode == 200){
      print(res.statusCode);
      return res;

    }
    return res;
  }

  static Future<http.Response> searchRun(String search) async {
    var res;
    var jwt = await storage.read(key: "jwt");
    int userId = GlobalData.userId!;
    res = await http.post(
        Uri.parse('$SERVER_IP/addrun'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId' : '$userId',
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

  static Future<http.Response> addfriend(int userId_toadd) async {
    var res;
    var jwt = await storage.read(key: "jwt");
    int userId = GlobalData.userId!;


    res = await http.post(
        Uri.parse('$SERVER_IP/addfriend'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId' : '$userId',
          'userId_toadd' : '$userId_toadd',
          'jwtToken' : '$jwt',
        })
    );

    if(res.statusCode == 200){
      print(res.statusCode);
      return res;

    }
    return res;
  }

  static Future<http.Response> searchfriend(String name) async {
    var res;
    var jwt = await storage.read(key: "jwt");
    int userId = GlobalData.userId!;


    res = await http.post(
        Uri.parse('$SERVER_IP/searchfriends'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId' : '$userId',
          'search' : '$name',
        })
    );

    if(res.statusCode == 200){
      print(res.statusCode);
      return res;

    }
    return res;
  }

  static Future<http.Response> removefriend(int userId_toremove) async {
    var res;
    var jwt = await storage.read(key: "jwt");
    int userId = GlobalData.userId!;


    res = await http.post(
        Uri.parse('$SERVER_IP/removefriend'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId' : '$userId',
          'userId_toremove' : '$userId_toremove',
          'jwtToken' : '$jwt',
        })
    );

    if(res.statusCode == 200){
      print(res.statusCode);
      return res;

    }
    return res;
  }

  static Future<http.Response> listfriends() async {
    var res;
    var jwt = await storage.read(key: "jwt");
    int userId = GlobalData.userId!;


    res = await http.post(
        Uri.parse('$SERVER_IP/listfriends'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId' : '$userId',
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



