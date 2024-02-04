import 'package:get/get.dart';
import 'package:nestjs_test_flutter/app/screen/Login/controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}
