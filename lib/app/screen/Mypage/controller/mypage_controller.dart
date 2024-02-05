import 'package:nestjs_test_flutter/app/screen/Login/view/login_view.dart';
import 'package:nestjs_test_flutter/package/debug_console.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nestjs_test_flutter/service/auth_service.dart';
import 'package:nestjs_test_flutter/app/routes/app_pages.dart';

class MypageController extends GetxController {
  static MypageController get to => Get.find();

  final idTextControl = TextEditingController();

  @override
  void onInit() async {
    idTextControl.text = AuthService.to.getCurrentUser()?.uid??"";
    super.onInit();
  }


  Future<void> logout() async {
    await AuthService.to.logOut();
    Get.off(const LoginView());
  }

  Future<void> withDraw() async {
    String snackString = "새 신을 신 고 뛰어보자 퐐쫙";
    String title = "회원탈퇴에 실패하였습니다.";

    final status = await AuthService.to.withDrawUser();
    debugConsole(status);
    if (status == WithDrawStatus.success) {
      title = "회원탈퇴에 성공하였습니다.";
      snackString = "다음에 천국에서 뵈요!";
      Get.rootDelegate.offAndToNamed(Routes.LOGIN);
    } else if (status == WithDrawStatus.noLoginRecent) {
      snackString = "로그인 기록이 너무 오래 되었습니다. 재로그인을 해야 할 수 있습니다. (데이터는 삭제되었습니다.)";
    } else {
      snackString = "예상치 못한 동작입니다. 관리자에게 문의해 주시면 감사하겠습니다. (데이터는 삭제되었습니다.)";
    }

    final getSnackBar = GetSnackBar(
      title: title,
      message: snackString,
      duration: const Duration(seconds: 2),
    );
    Get.showSnackbar(getSnackBar);
  }
}
