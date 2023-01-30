import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class NetworkHelper {
  NetworkHelper();

  String baseUrl = "https://reqres.in/api/";

  //MARK:- Get Contact Data
  Future getContactData()async{

    String url = baseUrl + "users?page=2";
    print("test"+url);
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
      return 'failed';
    }
  }

  //MARK:- Update list
  Future updateList(String name, String jobTitle)async{

    String url = baseUrl + "users?page=2";
    Map params = {
      "name": name,
      "job": jobTitle
    };
    var body = json.encode(params);
    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
      return 'failed';
    }
  }

  }



