import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:get/get.dart';
import 'package:nestjs_test_flutter/service/server_service.dart';

class RootController extends GetxController {
  @override
  void onInit() {
    BackButtonInterceptor.add(myInterceptor);
    super.onInit();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Get.back();
    return true;
  }
}
