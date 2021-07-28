import 'dart:convert';

import 'package:fitness_app_development/main.dart';
import 'package:fitness_app_development/pages/home_page/home_screen.dart';
import 'package:fitness_app_development/pages/home_page2.dart';
import 'package:fitness_app_development/pages/login_screen/login_screen.dart';
import 'package:fitness_app_development/pages/pass_reset/forgot_password.dart';
import 'package:fitness_app_development/pages/register_page.dart';
import 'package:fitness_app_development/pages/register_screen/register_screen.dart';
import 'package:fitness_app_development/utilities/get_api.dart';
import 'package:fitness_app_development/utilities/global_data.dart';
import 'package:fitness_app_development/utilities/results.dart';
import 'package:fitness_app_development/utilities/results_runs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginScreenViewModel{
  LoginScreenState? state;

  LoginScreenViewModel(state){
    this.state = state;
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode pwdFocus = FocusNode();

  String message = '', newMessageText = '';
  String loginName = '', password = '';
  String firstName = '', lastName = '';
  late Map<String, dynamic> decodedToken;

  changeText() {
    state!.setState(() {
      message = newMessageText;
    });
  }

  Future<void> onLoginTap() async {


    loginName = nameController.text; // loginName = username textfield
    password = pwdController.text; // password = password textfield

    newMessageText = "";
    changeText();
    String payload = '{"login":"' + loginName.trim() + '","password":"' + password.trim() + '"}';  // login + password to be sent to api


    print(payload);

    var jsonObject;


    try
    {
      var ret = await GetAPI.login(loginName, password);
      jsonObject = json.decode(ret);
      print(ret);
      var accessToken = jsonObject["token"];
      var jwt = accessToken["accessToken"];
      await storage.write(key: "jwt", value: jwt);

      decodedToken = JwtDecoder.decode(ret);
      GlobalData.userId = decodedToken["userId"];
      GlobalData.firstName = decodedToken["firstName"];
      GlobalData.lastName = decodedToken["lastName"];
      firstName = GlobalData.firstName!;
      lastName = GlobalData.lastName!;

      getFullName(firstName, lastName);
      GlobalData.userName = loginName;


    }catch(e)
    {
      print(e);
      newMessageText = "Incorrect Login/Password";
      changeText();
      return;
    }

    try {
      nameController.clear();
      pwdController.clear();
      await getTotalData();
      await getRunData();
      await getLeaderboardData();

      Get.offAll(() => HomeScreen());

    }catch(e) {
      print(e);
    }
  }

  void onRegisterTap(){
    Get.offAll(() => RegisterScreen());
  }

  void onForgotPwdTap(){
    Get.to(() => Forgot());
  }

  void getFullName (String firstName, String lastName) {
    GlobalData.fullName = firstName + ' ' + lastName;

  }
  Future<void> getTotalData() async {
    var ret = await GetAPI.searchUsers(search: GlobalData.firstName!);
    var resultObjsJson = jsonDecode(ret.body)['results'] as List;
    List<GetResults> resultObjs = resultObjsJson.map((resultJson) => GetResults.fromJson(resultJson)).toList();

    try{
      GlobalData.totalDistance = resultObjs[0].TotalDistance;
      GlobalData.totalRuns = resultObjs[0].TotalRuns;
      GlobalData.totalTime = resultObjs[0].TotalTime;
      GlobalData.email = resultObjs[0].email;
    }catch(e){
      print(e);
    }
  }


  Future<void> getLeaderboardData() async {
    var ret = await GetAPI.searchUsers();
    GlobalData.distance = [];
    Map<int,double> userDistance = new Map();


    var resultObjsJson = jsonDecode(ret.body)['results'] as List;
    List<GetResults> resultObjs = resultObjsJson.map((resultJson) => GetResults.fromJson(resultJson)).toList();
    GlobalData.resultObjsBoo = List.from(resultObjs);
    try{
      for(int i =0; i<resultObjs.length;i++){
        GlobalData.distance.add(resultObjs[i].TotalDistance);
      }
      int i = 0;
      Map<int, double> map = Map.fromIterable(
          GlobalData.distance,
          key: (k) => resultObjs[i++].userId,
          value: (v) => v
      );

      var sortedEntries = map.entries.toList()..sort((e1, e2) {
        var diff = e2.value.compareTo(e1.value);
        if (diff == 0) diff = e2.key.compareTo(e1.key);
        return diff;
      });
      //print(map);


      GlobalData.userIdInOrder = [];
      GlobalData.orginalIndex = [];
      print(sortedEntries);
      for(int j=0; j<sortedEntries.length;j++){
        GlobalData.userIdInOrder.add(sortedEntries[j].key);
      }
      for(int j=0; j<GlobalData.userIdInOrder.length;j++){
        for(int i=0;i<resultObjs.length;i++){
          if(GlobalData.userIdInOrder[j] == resultObjs[i].userId){
            GlobalData.orginalIndex.add(i);
          }
        }
      }
      print('${GlobalData.userIdInOrder} ,${GlobalData.orginalIndex} ');
      print(GlobalData.resultObjsBoo[GlobalData.orginalIndex[0]].TotalDistance);

      //print(map);
      // print('this${GlobalData.distance}');

    }catch(e){
      print(e);
    }
  }



  Future<void> getRunData() async {
    var ret = await GetAPI.searchRun();
    var resultObjsJson = jsonDecode(ret.body)['results'] as List;
    GlobalData.resultObjs  = resultObjsJson.map((resultJson) => GetResults2.fromJson(resultJson)).toList();

    print('${GlobalData.resultObjs} this');

  }
}