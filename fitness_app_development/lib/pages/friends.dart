import 'dart:async';

import 'package:fitness_app_development/friends_util/search_friend_response.dart';
import 'package:fitness_app_development/friends_util/searchBar.dart';
import 'package:fitness_app_development/friends_util/friends_provider.dart';
import 'package:fitness_app_development/pages/run_sequence/start_run.dart';
import 'package:fitness_app_development/pages/user_profile.dart';
import 'package:fitness_app_development/pages/users_page.dart';
import 'package:fitness_app_development/utilities/get_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({Key? key}) : super(key: key);

  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  Timer? timeHandle;
  Future<List<Result>>? list;
  var viewModel = MainViewModel();

  void textChanged(String val) {
    if (timeHandle != null) {
      timeHandle?.cancel();
    }
    timeHandle = Timer(Duration(milliseconds: 10000), () {
      print("Calling now the API: $val");
      viewModel.searchFriendApi(val);
    });
  }

  @override
  void initState() {
    //final mainViewModel = Provider.of<MainViewModel>(co, listen: false);
    viewModel.searchFriendApi('');
    super.initState();
  }

  @override
  void dispose() {
    // dispose controller when page is disposed
    viewModel.dispose();
    super.dispose();
  }

  getUsers(String value) async {
    print("Calling now the API get user: $value");

    //SearchFriendResponse response = await viewModel.searchFriendApi(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Friends Page"),
        centerTitle: true,
        leading: new IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
          icon: new Icon(Icons.arrow_back, color: Colors.orange),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => viewModel,
        child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.5, 1],
                    colors: [Colors.cyan, Colors.blueAccent.shade700])),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: SearchBar(
                    hintText: 'Search Friends',
                    onChangeTextForSearch: (String val) {
                      print("value : $val");
                      if (val.isEmpty) {
                        viewModel.searchFriendApi('');
                      }
//                        if(val.length>0){
//                          textChanged(val);
//                        }else{
//                          print("is empty");
//                          viewModel.searchFriendApi('');
//
//                        }
                    },
                    onTextReadyForSearch: (String value) {
                      viewModel.searchFriendApi(value);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Consumer<MainViewModel>(
                  builder: (_, viewModel, __) => FutureBuilder<List<Result>>(
                      future: viewModel.list,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Text("${snapshot.error}",
                                style: TextStyle(color: Colors.red));
                          } else if (snapshot.hasData) {
                            print("data length L ${snapshot.data!.length}");
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext bc, int index) {
                                  return Row(
                                    children: [
                                      Expanded(
                                          child: RowView(
                                              "${snapshot.data![index].fullName}")),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text("Confirmation!"),
                                                content: Text(
                                                    "Are you sure you want to remove this friend?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      GetAPI.removefriend(snapshot.data![index].userId.toInt()).then((value){
                                                        viewModel.list!.then((value) => value.removeAt(index));
                                                        setState(() {});
                                                      });
                                                    },
                                                    child: Text(
                                                      'Yes',
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'No',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: Text("Remove"),
                                        ),
                                      ),
                                    ],
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
                          return Container();
                        } else {
                          return Center(
                              child: CircularProgressIndicator(
                            backgroundColor: Colors.red,
                          ));
                        }
                      }),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
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
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                              },
                              icon: Icon(Icons.home),
                              iconSize:
                                  (MediaQuery.of(context).size.height) * .06,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UsersScreen()));
                              },
                              icon: Icon(Icons.search),
                              iconSize:
                                  (MediaQuery.of(context).size.height) * .06,
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StartRun()));
                              },
                              child: Icon(Icons.add),
                              backgroundColor: Colors.green,
                              elevation: 10,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FriendsScreen()));
                              },
                              icon: Icon(Icons.contact_page_rounded),
                              iconSize:
                                  (MediaQuery.of(context).size.height) * .06,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => User()));
                              },
                              icon: Icon(Icons.portrait_rounded),
                              iconSize:
                                  (MediaQuery.of(context).size.height) * .06,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class RowView extends StatelessWidget {
  String name;

  RowView(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
