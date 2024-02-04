import 'package:nestjs_test_flutter/app/screen/Root/controller/root_controller.dart';
import 'package:get/get.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RootController>(RootController());
  }
}
