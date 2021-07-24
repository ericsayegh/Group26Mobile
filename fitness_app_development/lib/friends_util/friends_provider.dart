import 'package:fitness_app_development/utilities/global_data.dart';
import 'package:fitness_app_development/friends_util/search_friend_response.dart';
import 'package:fitness_app_development/friends_util/network_service.dart';
import 'package:fitness_app_development/friends_util/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class MainViewModel with ChangeNotifier {



  NetworkService networkService = NetworkService();
  SearchFriendResponse? searchFriendResponse;
  Future<List<Result>>? list;
  //SearchFriendResponse? searchFriendResponse;



   searchFriendApi(String query) async {
    var queryParameters = {
      'userId': GlobalData.userId,
      'search': '$query',
    };

    searchFriendResponse  = await networkService.postApiRequest(searchFriendCall, queryParameters);

    if(searchFriendResponse?.results!=null){
      list = Future.value(searchFriendResponse?.results);
    }else{
      list = Future.value([]);
    }
    notifyListeners();
  }
}