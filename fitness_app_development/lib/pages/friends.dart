import 'dart:async';

import 'package:fitness_app_development/friends_util/search_friend_response.dart';
import 'package:fitness_app_development/friends_util/searchBar.dart';
import 'package:fitness_app_development/friends_util/friends_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left:18.0,right: 18),
                  child: SearchBar(
                      onChangeTextForSearch: (String val){
                        print("value : $val");
                        if(val.isEmpty){
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
                    onTextReadyForSearch: (String value){
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
                                  return RowView("${snapshot.data![index].fullName}");
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
            )),
      ),
    );
  }
}

class RowView extends StatelessWidget {
  String name;

  RowView(this.name, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            name,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
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
