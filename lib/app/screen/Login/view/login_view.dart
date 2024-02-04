import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nestjs_test_flutter/app/screen/Login/controller/login_controller.dart';
import 'package:nestjs_test_flutter/app/screen/Join/view/join_view.dart';
import 'package:nestjs_test_flutter/app/screen/Join/binding/join_binding.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

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
                '로그인',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Center(
              child: Container(
                child: SizedBox(
                  width: 300,
                  child: ListView(
                    children: [
                      // TODO : implement the showable widget list.
                      // for example, like the CreateStory view.
                      ListViewIdField(),
                      ListViewPwField(),
                      ListViewLoginButton(),
                      ListViewAccountCreateButton(),
                    ],
                  ),
                ),
              ),
            )));
  }

  Widget ListViewIdField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 80,
            child: Text(
              "ID",
              textAlign: TextAlign.center,
            )),
        Expanded(child: TextField(controller: controller.idTextControl))
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
              "PW",
              textAlign: TextAlign.center,
            )),
        Expanded(child: TextField(controller: controller.pwTextControl))
      ],
    );
  }

  Widget ListViewLoginButton() {
    return Padding(
      padding: EdgeInsets.only(left: 75, right: 75, top: 15, bottom: 5),
      child: OutlinedButton(
        child: const Text("로그인"),
        onPressed: controller.fireAuthLogin,
      ),
    );
  }

  Widget ListViewAccountCreateButton() {
    return Padding(
      padding: EdgeInsets.only(left: 75, right: 75, top: 5, bottom: 5),
      child: ElevatedButton(
        child: const Text("회원 가입"),
        onPressed: () {
          Get.to(
            const JoinView(),
            binding: JoinBinding(),
          );
        },
      ),
    );
  }

}
