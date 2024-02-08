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
        );
      },
    );
  }
}
