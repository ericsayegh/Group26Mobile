import 'dart:io';

import 'package:fitness_app_development/pages/change_email.dart';
import 'package:fitness_app_development/pages/change_name.dart';
import 'package:fitness_app_development/pages/change_pass.dart';
import 'package:fitness_app_development/pages/change_username.dart';
import 'package:fitness_app_development/pages/login_page.dart';
import 'package:fitness_app_development/pages/login_screen/login_screen.dart';
import 'package:fitness_app_development/pages/user_profile.dart';
import 'package:fitness_app_development/utilities/get_api.dart';
import 'package:fitness_app_development/utilities/global_data.dart';
import 'package:fitness_app_development/utilities/pref_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'home_page2.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String username = '';
  XFile? fileImg;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    refreshImage();
    changeUser();
    super.initState();
  }

  Future<void> refreshImage() async {
    String? imagePath = await PrefService.getProfileImage();
    if (imagePath != null) {
      fileImg = XFile(imagePath);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Edit Password'),
        backgroundColor: Color(0xFF4294A2),
        leading: new IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => User()));
          },
          icon: new Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.0),
                Center(
                  child: CircleAvatar(
                    // can add link to users profile pictures for this
                    radius: 40.0,
                    backgroundImage: getImage(),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () async {
                      /*XFile? file = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (file != null) {
                        PrefService.setProfileImage(file.path);
                        refreshImage();
                      }*/
                      openBottomSheet();
                    },
                    child: Text("Change Profile Picture",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ),
                ),
                Divider(),
                Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeEmail()));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.teal)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.email, size: 30),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              width: Get.width * 0.39,
                              child: Text(
                                "Change Email",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.chevron_right_outlined, size: 30)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeName()));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.teal)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.portrait, size: 30),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              width: Get.width * 0.39,
                              child: Text(
                                "Change Name",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.chevron_right_outlined, size: 30)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeUserName()));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.teal)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.portrait, size: 30),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              width: Get.width * 0.39,
                              child: Text(
                                "Change Username",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.chevron_right_outlined, size: 30)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangePass()));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.teal)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.lock, size: 30),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              width: Get.width * 0.39,
                              child: Text(
                                "Change Password",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.chevron_right_outlined, size: 30)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        GlobalData.userId = -1;
                        GlobalData.userName = '';
                        GlobalData.firstName = '';
                        GlobalData.lastName = '';
                        GlobalData.email = '';
                        GlobalData.totalDistance = 0;
                        GlobalData.totalTime = 0;
                        GlobalData.fullName = '';
                        GlobalData.totalRuns = 0;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.teal)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.logout, size: 30),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              width: Get.width * 0.39,
                              child: Text(
                                "Log Out",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.chevron_right_outlined, size: 30)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await GetAPI.deleteUsers();
                        GlobalData.userId = -1;
                        GlobalData.userName = '';
                        GlobalData.firstName = '';
                        GlobalData.lastName = '';
                        GlobalData.email = '';
                        GlobalData.totalDistance = 0;
                        GlobalData.totalTime = 0;
                        GlobalData.fullName = '';
                        GlobalData.totalRuns = 0;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.teal)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.clear, size: 30,color: Colors.white,),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              width: Get.width * 0.39,
                              child: Text(
                                "Delete User",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.chevron_right_outlined, size: 30,color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.clear, color: Colors.white),
                      tileColor: Colors.red,
                      title: Text('Delete User',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      trailing: Icon(Icons.keyboard_arrow_right,
                          color: Colors.white),
                      onTap: () async {
                        await GetAPI.deleteUsers();
                        GlobalData.userId = -1;
                        GlobalData.userName = '';
                        GlobalData.firstName = '';
                        GlobalData.lastName = '';
                        GlobalData.email = '';
                        GlobalData.totalDistance = 0;
                        GlobalData.totalTime = 0;
                        GlobalData.fullName = '';
                        GlobalData.totalRuns = 0;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                        //var jsonObject = json.decode(ret.body);
                        //print(jsonObject);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  changeUser() {
    setState(() {
      username = GlobalData.firstName!; // need to change to full name
    });
  }

  ImageProvider getImage() {
    if (fileImg == null) {
      return AssetImage('assets/images/profile_picture.jpeg');
    } else {
      return FileImage(File(fileImg!.path));
    }
  }

  void openBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 150,
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Camera"),
              onTap: () async {
                Navigator.pop(context);
                XFile? file =
                    await ImagePicker().pickImage(source: ImageSource.camera);

                if (file != null) {
                  PrefService.setProfileImage(file.path);
                  refreshImage();
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.attachment_sharp),
              title: Text("Gallery"),
              onTap: () async {
                Navigator.pop(context);
                XFile? file =
                    await ImagePicker().pickImage(source: ImageSource.gallery);

                if (file != null) {
                  PrefService.setProfileImage(file.path);
                  refreshImage();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
