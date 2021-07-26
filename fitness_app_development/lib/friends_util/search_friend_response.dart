
import 'dart:convert';

//SearchFriendResponse searchFriendResponseFromJson(String str) => SearchFriendResponse.fromJson(json.decode(str));
//
//String searchFriendResponseToJson(SearchFriendResponse data) => json.encode(data.toJson());

class SearchFriendResponse {
  SearchFriendResponse({
    required this.results,
    required this.error,
  });

  List<Result> results;
  String error;

  factory SearchFriendResponse.fromJson(Map<String, dynamic> json) => SearchFriendResponse(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "error": error,
  };
}

class Result {
  Result({
    required this.id,
    required this.email,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.totalRuns,
  });

  String id;
  String email;
  num userId;
  String firstName;
  String lastName;
  String fullName;
  num totalRuns;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
      id: json["_id"],
      email: json["Email"],
      userId: json["UserId"],
      firstName: json["FirstName"],
      lastName: json["LastName"],
      fullName: json["FullName"],
      totalRuns:json['TotalRuns']
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "Email": email,
    "UserId": userId,
    "FirstName": firstName,
    "LastName": lastName,
    "FullName": fullName,
    'TotalRuns':totalRuns
  };
}
