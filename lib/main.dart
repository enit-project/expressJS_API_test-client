import 'package:nestjs_test_flutter/app/routes/app_pages.dart';
import 'package:nestjs_test_flutter/service/auth_service.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:nestjs_test_flutter/firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nestjs_test_flutter/package/debug_console.dart';

Future<void> main() async {
  ///파이어베이스 연동
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  enableDebug();
  runApp(
    GetMaterialApp.router(
      initialBinding: BindingsBuilder(
        () async {
          // 초기화 하면서 서비스를 가져온다.
          Get.put(AuthService());
        },
      ),
      getPages: AppPages.routes,
    ),
  );
}
