import 'dart:convert';
import 'package:get/get.dart';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:http/http.dart" as http;
import 'package:nestjs_test_flutter/package/debug_console.dart';

class ServerAPIService {
  // getx singleton pattern
  static ServerAPIService get to => Get.find();
  String host = "http://129.154.214.178:3000"; // remote server
  // String host = "http://172.19.3.136:3000"; // library local

  Map<String, String> headers = {'authorization': 'Bearer unauthorized'};

  Future<void> firebaseTokenAdd() async {
    if (FirebaseAuth.instance.currentUser == null) {
      return;
    } else {
      return FirebaseAuth.instance.currentUser?.getIdToken().then((token) {
        headers['authorization'] = 'Bearer ' + (token ?? "unauthorized");
      });
    }
  }

  Future<dynamic> get(String url) async {
    http.Response res = await http.get(Uri.parse(host + url), headers: headers);
    return json.decode(utf8.decode(res.bodyBytes));
    // return utf8.decode(res.bodyBytes);
  }

  Future<dynamic> post(String url, Map<String, String> data) async {
    // debugConsole(json.encode(data));
    http.Response res = await http.post(
      Uri.parse(host + url),
      body: data, //////// VERY IMPORTANT : DO NOT PASS the map data like json.encode(data) !!!! /////////
      headers: headers,
    );
    return json.decode(utf8.decode(res.bodyBytes));
    // return utf8.decode(res.bodyBytes);
  }

  Future<dynamic> delete(String url) async {
    http.Response res = await http.delete(Uri.parse(host + url), headers: headers);
    return json.decode(utf8.decode(res.bodyBytes));
  }
}
