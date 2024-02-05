import 'dart:developer';

import 'package:nestjs_test_flutter/app/routes/app_pages.dart';
import 'package:nestjs_test_flutter/app/screen/Root/controller/root_controller.dart';
import 'package:nestjs_test_flutter/app/screen/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nestjs_test_flutter/service/server_service.dart';

class RootView extends GetView<RootController> {
  const RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          body: GetRouterOutlet(initialRoute: Routes.LOGIN),
          appBar: AppBar(
            actions: [
              // unsecure direct api call
              IconButton(
                  onPressed: () async {
                    final testResponse = await ServerAPIService.to.get("/unsecure/helloWorld");
                    log("response : ${testResponse.toString()}");
                    Get.defaultDialog(
                      title: "getTest",
                      content: Text(testResponse.toString()),
                    );
                  },
                  icon: const Icon(Icons.directions_walk)),
              // secured api call
              IconButton(
                  onPressed: () async {
                    final testResponse = await ServerAPIService.to.get("/secure/helloWorld");
                    log("response : ${testResponse.toString()}");
                    Get.defaultDialog(
                      title: "getTest",
                      content: Text(testResponse.toString()),
                    );
                  },
                  icon: const Icon(Icons.security_rounded)),
              // auth token injection
              IconButton(
                  onPressed: () {
                    ServerAPIService.to.firebaseTokenAdd();
                  },
                  icon: const Icon(Icons.login)),
            ],
          ),
        );
      },
    );
  }
}
