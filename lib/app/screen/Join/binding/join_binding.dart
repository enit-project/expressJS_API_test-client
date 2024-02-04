import 'package:get/get.dart';
import 'package:nestjs_test_flutter/app/screen/Join/controller/join_controller.dart';

class JoinBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<JoinController>(JoinController());
  }
}
