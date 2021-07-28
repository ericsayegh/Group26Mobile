import 'dart:io';

import 'package:fitness_app_development/pages/friends.dart';
import 'package:fitness_app_development/pages/get_run_name.dart';
import 'package:fitness_app_development/pages/old_run2.dart';
import 'package:fitness_app_development/pages/user_profile.dart';
import 'package:fitness_app_development/pages/users_page.dart';
import 'package:fitness_app_development/utilities/global_data.dart';
import 'package:fitness_app_development/utilities/personal_run_data.dart';
import 'package:fitness_app_development/utilities/pref_service.dart';
import 'package:fitness_app_development/utilities/results_runs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';
  String _displayTime = '0';
  String newUserName = '';
  int totalRuns = 0, newRun = 0;
  double totalDistance = 0, newDistance = 0;
  int totalTIme = 0, newTime = 0;
  List<GetResults2> resultObjs = [];
  XFile? fileImg;

  @override
  void initState() {
    refreshImage();
    changeText();
    changeTotalRuns();
    changeTotalDistance();
    changeTotalTime();
    changeTime();
    super.initState();
  }


  void changeTime(){

    var milli = totalTIme;
    var min = ((milli) / 60000).floor();
    var sec = ((milli % 60000) / 1000).toStringAsFixed(2);
    var st = '';
    if ((milli % 60000) / 1000 < 10) {
      st = '0';
    } else st = '';

    setState(() {
      _displayTime = '${min}:${st}${sec}';
    });

  }

  Future<void> refreshImage() async {
    String? imagePath = await PrefService.getProfileImage();
    if(imagePath != null){
      fileImg = XFile(imagePath);
      setState(() {});
    }
  }

  ImageProvider getImage(){
    if(fileImg == null){
      return AssetImage('assets/images/profile_picture.jpeg');
    }else{
      return FileImage(File(fileImg!.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(
            left: 5,
            top: 20,
            right: 5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topProfile(),
              SizedBox(height: 20),
              topActivity(),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Leader Board",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Divider(color: Colors.teal, thickness: 1.5),
              leaderBoard(),
              Divider(color: Colors.teal, thickness: 1.5),
              SizedBox(height: 15),
              userList(),
              Expanded(
                child: Align(
                  alignment:  FractionalOffset.bottomCenter,
                  child: SizedBox(
                    height: (MediaQuery.of(context).size.height) * .077,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[200],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              print('${GlobalData.resultObjs[0].coordinates[0][0]},${GlobalData.resultObjs[0].coordinates[0][1]}');
                              print('${GlobalData.resultObjs[0].coordinates[3][0]},${GlobalData.resultObjs[0].coordinates[3][1]}');
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                            },
                            icon: Icon(Icons.home),
                            iconSize: (MediaQuery.of(context).size.height) * .06,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UsersScreen()));
                            },
                            icon: Icon(Icons.search),
                            iconSize: (MediaQuery.of(context).size.height) * .06,

                          ),
                          FloatingActionButton(
                            onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GetRunName()));
                            },
                            child: Icon(Icons.add),
                            backgroundColor: Colors.green,
                            elevation: 10,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FriendsScreen()));
                            },
                            icon: Icon(Icons.contact_page_rounded),
                            iconSize: (MediaQuery.of(context).size.height) * .06,

                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => User()));
                            },
                            icon: Icon(Icons.portrait_rounded),
                            iconSize: (MediaQuery.of(context).size.height) * .06,

                          ),

                        ],
                      ),
                    ),


                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget topProfile() {
    return Row(
      children: [
        /*Icon(
          Icons.account_circle,
          size: 55,
        ),*/
        IconButton(
            icon: CircleAvatar( // can add link to users profile pictures for this
              backgroundImage: getImage(),
              radius: 40,
            ),
            iconSize: 55,
            onPressed: () {
              Get.off(() => User());

            }
        ),
        SizedBox(width: 5),
        Text(
          "${GlobalData.fullName}",
          style: TextStyle(
            color: Colors.teal,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }

  Widget topActivity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: EdgeInsets.only(right: 7, bottom: 5),
          padding: EdgeInsets.symmetric(vertical: 9, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.2),
                  offset: Offset(2, 2),
                  blurRadius: 2,
                )
              ],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.teal)),
          child: Column(
            children: [
              Text(
                "Total Runs",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${totalRuns}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 7, bottom: 5),
          padding: EdgeInsets.symmetric(vertical: 9, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.2),
                  offset: Offset(2, 2),
                  blurRadius: 2,
                )
              ],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.teal)),
          child: Column(
            children: [
              Text(
                "Total Distance",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${totalDistance.toStringAsFixed(2)} Mi',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 7, bottom: 5),
          padding: EdgeInsets.symmetric(vertical: 9, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.2),
                  offset: Offset(2, 2),
                  blurRadius: 2,
                )
              ],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.teal)),
          child: Column(
            children: [
              Text(
                "Total Time",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "$_displayTime",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget leaderBoard() {
    return Container(
      height: 30,
      child: ListView.builder(
        itemCount: GlobalData.resultObjsBoo.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          if(GlobalData.resultObjsBoo[GlobalData.orginalIndex[index]].TotalDistance > .01 ){
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${index+ 1}.',style: const TextStyle(
                      color: Colors.white,
                    ),),
                    SizedBox(width: 10),
                    Text('${GlobalData.resultObjsBoo[GlobalData.orginalIndex[index]].fullName}',style: const TextStyle(
                      color: Colors.white,
                    ),),
                    SizedBox(width: 10),
                    Text(GlobalData.resultObjsBoo[GlobalData.orginalIndex[index]].TotalDistance.toStringAsFixed(2) + ' Mi',style: const TextStyle(

                      color: Colors.white,
                    ),),
                  ]
              ),
            );
          }else{
            return Text('');
          }
        },
      ),
    );
  }

  Widget userList() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: GlobalData.resultObjs.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              RunData.index = index;
              print(index);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OldRun2()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.teal)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    width: Get.width * 0.39,
                    child: Text(
                      GlobalData.resultObjs[index].runName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width * 0.4,
                    child: Text(
                      GlobalData.resultObjs[index].dateCreated,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.chevron_right_outlined, size: 30)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  void changeText() {
    setState(() {
      userName = GlobalData.userName!;
    });
  }

  void changeTotalRuns() {
    setState(() {
      totalRuns = GlobalData.totalRuns!;
    });
  }
  void changeTotalDistance() {
    setState(() {
      totalDistance = GlobalData.totalDistance!;
    });
  }
  void changeTotalTime() {
    setState(() {
      totalTIme = GlobalData.totalTime!;
    });
  }
}
