import 'dart:convert';
import 'package:get/get.dart';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:http/http.dart" as http;

class ServerAPIService {
  // getx singleton pattern
  static ServerAPIService get to => Get.find();
  String host = "http://129.154.214.178:3000";
  // String host = "http://172.20.112.1:3000";

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
    // return json.decode(utf8.decode(res.bodyBytes));
    return utf8.decode(res.bodyBytes);
  }

  Future<dynamic> post(String url, Map<String, String> data) async {
    http.Response res = await http.post(
      Uri.parse(host + url),
      body: json.encode(data),
      headers: headers,
    );
    // return json.decode(utf8.decode(res.bodyBytes));
    return utf8.decode(res.bodyBytes);
  }
}
