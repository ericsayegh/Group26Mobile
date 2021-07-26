import 'dart:async';

import 'package:fitness_app_development/friends_util/friends_provider.dart';
import 'package:fitness_app_development/friends_util/screen_progress_loader.dart';
import 'package:fitness_app_development/friends_util/searchBar.dart';
import 'package:fitness_app_development/friends_util/search_friend_response.dart';
import 'package:fitness_app_development/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';



class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  Timer? timeHandle;
  Future<List<Result>>? list;
 var viewModel = MainViewModel();
  bool _isLoading = false;

  void textChanged(String val) {

    if (timeHandle != null) {
      timeHandle?.cancel();
    }
    timeHandle = Timer(Duration(milliseconds: 10000), () {
      print("Calling now the API: $val");
      viewModel.searchUsers(val);
    });
  }
  @override
  void initState() {
    //final mainViewModel = Provider.of<MainViewModel>(co, listen: false);
    viewModel.searchUsers('');
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Search'),
            leading: new IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
              },
              icon: new Icon(Icons.arrow_back, color: Colors.orange),
            ),
          ),
          body: ChangeNotifierProvider(
            create: (_) =>viewModel,
            child: Container(
                decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://www.verywellfit.com/thmb/LeBe7RNtzbJwyKRmH8ditmJ1NKg=/1500x1020/filters:no_upscale():max_bytes(150000):strip_icc()/Snapwire-Running-27-66babd0b2be44d9595f99d03fd5827fd.jpg'),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: Colors.blue,
                      width: 8,
                    )),
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:18.0,right: 18),
                        child: SearchBar(
                          hintText: "Search users",
                          onChangeTextForSearch: (String val){
                              print("value : $val");
                              if(val.isEmpty){
                                viewModel.searchUsers('');
                              }
//                        if(val.length>0){
//                          textChanged(val);
//                        }else{
//                          print("is empty");
//                          viewModel.searchFriendApi('');
//
//                        }

                            },
                          onTextReadyForSearch: (String value){
                            viewModel.searchUsers(value);
                          },

                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      Consumer<MainViewModel>(
                        builder: (_, viewModel, __) => FutureBuilder<List<Result>>(
                            future: viewModel.userslist,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return Text("${snapshot.error}",
                                      style: TextStyle(color: Colors.red));
                                } else if (snapshot.hasData) {
                                  print("data length L ${snapshot.data!.length}");
                                  return ListView.builder(
                                    shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (BuildContext bc, int index) {
                                        num userID = snapshot.data![index].userId;
                                        var userName = snapshot.data![index].fullName;
                                        var userEmail = snapshot.data![index].email;
                                        var totalRun = snapshot.data![index].totalRuns;

                                        return  Container(
                                          width: double.infinity,
                                          height: 50,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left:18.0,right: 18.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '$userName',
                                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _isLoading = true;
                                                    });
                                                    viewModel.addFriend(userID).then((value) {
                                                      if(value){
                                                       // snapshot.data!.removeAt(index);
                                                         print("SuccessFully added");
                                                      }else{
                                                      print("something went wrong");
                                                    }
                                                    setState(() {
                                                      _isLoading = false;
                                                    });
                                                    });
                                                  },
                                                  child: Text("Add"),
                                                ),
                                                SizedBox(width: 10,),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(userName:userName, userEmail:userEmail, totalRun:totalRun)));

                                                  },
                                                  child: Text("Profile"),
                                                ),

                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                } else {
                                  return Text(
                                    "No results",
                                    style: TextStyle(color: Colors.red),
                                  );
                                }
                              } else if (snapshot.connectionState ==
                                  ConnectionState.none) {
                                return Container(

                                );
                              } else {
                                return Center(child: CircularProgressIndicator(
                                  backgroundColor: Colors.red,
                                ));
                              }
                            }),
                      ),
                    ],
                  ),
                )),
          ),
        ),
        _isLoading?ScreenProgressLoader() : SizedBox(),
      ],
    );
  }
}

