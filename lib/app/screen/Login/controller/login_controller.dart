import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nestjs_test_flutter/app/screen/Mypage/binding/mypage_binding.dart';
import 'package:nestjs_test_flutter/app/screen/Mypage/view/mypage_view.dart';
import 'package:nestjs_test_flutter/service/auth_service.dart';
import 'package:nestjs_test_flutter/app/routes/app_pages.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  final idTextControl = TextEditingController();
  final pwTextControl = TextEditingController();

  // @override
  // void onInit() {
  //   if (AuthService.to.getCurrentUser() != null) {
  //     Get.to(const MypageView(), binding: MypageBinding());
  //   }
  //   super.onInit();
  // }

  Future<void> fireAuthLogin() async {
    if (idTextControl.text.isEmpty == true || pwTextControl.text.isEmpty == true) {
      return;
    }

    final loginStatus = await AuthService.to.logInWithEmailAndPassword(email: idTextControl.text, password: pwTextControl.text);
    if (loginStatus == LoginStatus.success) {
      Get.to(const MypageView(), binding: MypageBinding());
      return;
    }

    String errString = "새 신을 신 고 뛰어보자 퐐쫙";
    switch (loginStatus) {
      case LoginStatus.invalidEmail:
        errString = "아이디는 이메일 형식이어야 합니다.";
        break;
      case LoginStatus.userDisabled:
        errString = "해당 유저는 차단되었습니다. 관리자에게 문의하세요.";
        break;
      case LoginStatus.userNotFound:
        errString = "비밀번호가 잘못되었거나, 해당 유저가 존재하지 않습니다.";
        break;
      default:
        errString = "예상치 못한 동작입니다. 겪으신 문제점을 관리자에게 문의 드리면 감사하겠습니다.";
    }

    Get.showSnackbar(GetSnackBar(
      title: "로그인에 실패하였습니다.",
      message: errString,
    ));
  }
}
