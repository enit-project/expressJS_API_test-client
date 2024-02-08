import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nestjs_test_flutter/app/screen/Join/controller/join_controller.dart';

class JoinView extends GetView<JoinController> {
  const JoinView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              centerTitle: true,
              title: const Text(
                '회원 가입',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Center(
              child: Container(
                child: SizedBox(
                  width: 300,
                  child: ListView(
                    children: [
                      ListViewEmailField(),
                      ListViewNameField(),
                      ListViewRoleField(),
                      ListViewPwField(),
                      ListViewPwRepeatField(),
                      ListViewAccountCreateButton(),
                    ],
                  ),
                ),
              ),
            )));
  }

  Widget ListViewEmailField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 80,
            child: Text(
              "이메일 (아이디)",
              textAlign: TextAlign.center,
            )),
        Expanded(child: TextField(controller: controller.textFieldControllers['email_id']))
      ],
    );
  }

  Widget ListViewNameField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 80,
            child: Text(
              "이름",
              textAlign: TextAlign.center,
            )),
        Expanded(child: TextField(controller: controller.textFieldControllers['name']))
      ],
    );
  }

  Widget ListViewRoleField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 80,
            child: Text(
              "역할 (STUDENT / PARENT / TEACHER)",
              textAlign: TextAlign.center,
            )),
        Expanded(child: TextField(controller: controller.textFieldControllers['role']))
      ],
    );
  }


  Widget ListViewPwField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 80,
            child: Text(
              "비밀번호",
              textAlign: TextAlign.center,
            )),
        Expanded(child: TextField(controller: controller.textFieldControllers['pw']))
      ],
    );
  }

  Widget ListViewPwRepeatField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 80,
            child: Text(
              "비밀번호 재입력",
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            )),
        Expanded(child: TextField(controller: controller.textFieldControllers['pw_repeat']))
      ],
    );
  }

  // Widget ListViewNicknameField() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       SizedBox(
  //           width: 80,
  //           child: Text(
  //             "닉네임",
  //             textAlign: TextAlign.center,
  //           )),
  //       Expanded(child: TextField(controller: controller.textFieldControllers['nickname']))
  //     ],
  //   );
  // }

  Widget ListViewAccountCreateButton() {
    return Padding(
      padding: EdgeInsets.only(left: 75, right: 75, top: 5, bottom: 5),
      child: ElevatedButton(
        child: const Text("회원 가입"),
        onPressed: () {
          controller.userJoin();
        },
      ),
    );
  }
}
