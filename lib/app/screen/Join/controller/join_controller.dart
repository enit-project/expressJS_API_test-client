import 'package:nestjs_test_flutter/package/debug_console.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nestjs_test_flutter/service/auth_service.dart';
import 'package:nestjs_test_flutter/app/routes/app_pages.dart';
import 'package:nestjs_test_flutter/service/server_service.dart';
import 'dart:developer';
import 'dart:convert';

class JoinController extends GetxController {
  static JoinController get to => Get.find();

  final Map<String, TextEditingController> textFieldControllers = {
    'email_id': TextEditingController(text: "password@gmail.com"),
    'name': TextEditingController(text: "password"),
    'role': TextEditingController(text: "STUDENT"),
    'pw': TextEditingController(text: "password"),
    'pw_repeat': TextEditingController(text: "password"),
  };

  Future<void> userJoin() async {
    int emptyCount = 0;
    final textFieldMap = textFieldControllers.map((key, value) {
      if (value.text.isEmpty) {
        emptyCount++;
      }
      return MapEntry(key, value.text);
    });

    debugConsole(textFieldMap);

    if (emptyCount != 0) {
      return;
    }

    String snackString = "새 신을 신 고 뛰어보자 퐐쫙";
    String title = "회원가입에 실패하였습니다.";

    final status = await AuthService.to.joinWithEmailAndPassword(
        email: textFieldMap['email_id'] ?? "",
        password: textFieldMap['pw'] ?? "",
        passwordRepeat: textFieldMap['pw_repeat'] ?? "");
    switch (status) {
      case JoinStatus.success:
        snackString = "가입을 환영합니다, testuser 님!";
        break;
      case JoinStatus.weakPassword:
        snackString = "비밀번호가 서버에게 패배하였습니다... 더 강력한 비밀번호가 필요합니다!";
        break;
      case JoinStatus.alreadyExistsEmail:
        snackString = "중복되는 이메일입니다.";
        break;
      case JoinStatus.passwordRepeatWrong:
        snackString = "비밀번호 재입력 란이 잘못되었습니다.";
        break;
      default:
        snackString = "예상치 못한 동작입니다. 겪으신 문제점을 관리자에게 문의 드리면 감사하겠습니다.";
    }

    if (status == JoinStatus.success) {
      await ServerAPIService.to.firebaseTokenAdd();
      final serverStatus = await ServerAPIService.to.post(
          '/api/users/join',
          ({
            "name": textFieldMap['name'] ?? "",
            "email": textFieldMap['email_id'] ?? "",
            "role": textFieldMap['role'] ?? "",
          }));
      log(serverStatus.length.toString());
      // if server response body is not empty, this is the err code. so, delete the token and the account from the firebase Auth.
      if (serverStatus.length != 0) {
        await AuthService.to.withDrawUser();
        snackString = "이름, 이메일, 지위 (name, email, role) 중 하나가 잘못되어, 서버에서 회원등록을 거부하였습니다.";
      } else {
        title = "환영합니다!";
      }
    }

    final getSnackBar = GetSnackBar(
      title: title,
      message: snackString,
      duration: const Duration(seconds: 2),
    );

    log(snackString);
    log("request : " +
        {
          "name": textFieldMap['name'] ?? "",
          "email": textFieldMap['email_id'] ?? "",
          "role": textFieldMap['role'] ?? "",
        }.toString());

    if (status == JoinStatus.success) {
      Get.back();
      Get.rootDelegate.offAndToNamed(Routes.HOME);
      Get.showSnackbar(getSnackBar);
    } else {
      Get.showSnackbar(getSnackBar);
    }
  }
}
